//
//  LSYTableViewDataSource.m
//  LSYListViewDataSourceDemo
//
//  Created by liusiyang on 2023/8/15.
//

#import "LSYTableViewDataSource.h"

@interface LSYTableViewDataSource ()<UITableViewDataSource>

@end

@implementation LSYTableViewDataSource

#pragma mark - override

- (void)reloadData{
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.getCellCallback(self,_dataList[indexPath.row],indexPath);
}

#pragma mark - setter & getter

-(UITableView *)tableView{
    return (UITableView *)self.listView;
}

- (void)setGetCellCallback:(LSYTableViewGetCellBlock)getCellCallback{
    if (_getCellCallback != getCellCallback) {
        _getCellCallback = [getCellCallback copy];
        if (getCellCallback) {
            self.tableView.dataSource = self;
        }
    }
}

@end

@implementation UITableView (LSYDataSource)

- (LSYTableViewDataSource *)lsy_addDataSourceWithOptions:(LSYListViewRefreshOption)options
                                                loadData:(LSYListViewLoadDataBlock)loadData
                                                 getCell:(LSYTableViewGetCellBlock)getCell{
    LSYTableViewDataSource *ds = [[LSYTableViewDataSource alloc] initWithListView:self options:options loadDataCallBack:loadData];
    ds.getCellCallback = getCell;
    self.lsy_dataSource = ds;
    return ds;
}

-(void)setLsy_dataSource:(LSYTableViewDataSource *)lsy_dataSource{
    if (self.lsy_dataSource != lsy_dataSource) {
        objc_setAssociatedObject(self, @selector(lsy_dataSource), lsy_dataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (LSYTableViewDataSource *)lsy_dataSource{
    return objc_getAssociatedObject(self, _cmd);
}

@end
