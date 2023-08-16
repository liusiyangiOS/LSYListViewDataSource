//
//  LSYTableViewDataSource.m
//  LSYListViewDataSourceDemo
//
//  Created by liusiyang on 2023/8/15.
//

#import "LSYListViewDataSource.h"
#import <objc/runtime.h>

#define kRequestDefaultPageSize 10

@interface LSYListViewDataSource (){
    NSInteger _page;
    LSYListViewLoadDataBlock _loadData;
}
@end

@implementation LSYListViewDataSource

-(void)dealloc{
    NSLog(@"%@ dealloc",self.class);
}

- (instancetype)initWithListView:(UIScrollView *)listView
                     configBlock:(LSYListViewConfigBlock)configBlock
                loadDataCallBack:(LSYListViewLoadDataBlock)loadData{
    self = [super init];
    if (self) {
        _listView = listView;
        _loadData = [loadData copy];
        if (configBlock) {
            configBlock(self);
        }
        if (_options & LSYListViewRefreshOptionHeader &&
            [self.headerClass respondsToSelector:@selector(headerWithRefreshingBlock:)]) {
            _listView.mj_header = [self.headerClass performSelector:@selector(headerWithRefreshingBlock:) withObject:^{
                [self refresh];
            }];
        }
    }
    return self;
}

- (void)endRefreshWithDataList:(NSArray *)list{
    if (_page == _startIndex) {
        if (_options & LSYListViewRefreshOptionHeader) {
            [_listView.mj_header endRefreshing];
        }
        if (list && list.count) {
            _dataList = [NSMutableArray arrayWithArray:list];
            if (!_listView.mj_footer && _options & LSYListViewRefreshOptionFooter) {
                if ((_total && _dataList.count < _total) || list.count == self.pageSize) {
                    _listView.mj_footer = [self.footerClass performSelector:@selector(footerWithRefreshingBlock:) withObject:^{
                        _page++;
                        _loadData(self,_page);
                    }];
                }
            }
        }
    }else{
        [_listView.mj_footer endRefreshing];
        [_dataList addObjectsFromArray:list];
        if (_listView.mj_footer && (_dataList.count == _total || list.count < self.pageSize)) {
            if (_removeFooterWhenNoMoreData) {
                _listView.mj_footer = nil;
            } else {
                [_listView.mj_footer resetNoMoreData];
            }
        }
    }
    [self reloadData];
}

- (void)endRefresh{
    if (_page == _startIndex) {
        [_listView.mj_header endRefreshing];
    }else{
        [_listView.mj_footer endRefreshing];
    }
}

- (void)refresh{
    _page = _startIndex;
    _loadData(self,_page);
}

- (void)refreshWithDataList:(NSArray *)list{
    _page = _startIndex;
    [self endRefreshWithDataList:list];
}

#pragma mark - override

- (void)reloadData{}

#pragma mark - setter & getter

-(NSInteger)pageSize{
    if (_pageSize == 0) {
        _pageSize = kRequestDefaultPageSize;
    }
    return _pageSize;
}

-(Class)headerClass{
    if (!_headerClass) {
        _headerClass = MJRefreshNormalHeader.class;
    }
    return _headerClass;
}

-(Class)footerClass{
    if (!_footerClass) {
        _footerClass = MJRefreshAutoFooter.class;
    }
    return _footerClass;
}

@end


