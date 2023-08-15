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
    LSYListViewRefreshOption _options;
}
@end

@implementation LSYListViewDataSource

-(void)dealloc{
    NSLog(@"%@ dealloc",self.class);
}

- (instancetype)initWithListView:(UIScrollView *)listView
                         options:(LSYListViewRefreshOption)options
                loadDataCallBack:(LSYListViewLoadDataBlock)loadData{
    self = [super init];
    if (self) {
        _listView = listView;
        _loadData = [loadData copy];
        _options = options;
        if (options & LSYListViewRefreshOptionHeader) {
            _listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
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
            if (_options & LSYListViewRefreshOptionFooter) {
                if ((_total && _dataList.count < _total) || list.count == self.pageSize) {
                    _listView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
                        _page++;
                        _loadData(self,_page);
                    }];
                }
            }
        }
    }else{
        [_listView.mj_footer endRefreshing];
        [_dataList addObjectsFromArray:list];
        if (_dataList.count == _total || list.count < self.pageSize) {
//            _tableView.mj_footer = nil;
            [_listView.mj_footer resetNoMoreData];
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

@end


