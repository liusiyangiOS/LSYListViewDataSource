//
//  TableViewController.m
//  LSYListViewDataSourceDemo
//
//  Created by liusiyang on 2023/8/15.
//

#import "TableViewController.h"
#import "LSYTableViewDataSource.h"
#import "GifRefreshHeader.h"
#import "GifRefreshFooter.h"
#import "XXXListRequest.h"

@interface TableViewController (){
    __weak IBOutlet UITableView *_tableView;
}
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Cell"];
    
    __weak typeof(self) weakSelf = self;
    [_tableView lsy_addDataSourceWithConfigBlock:^(LSYListViewDataSource * _Nonnull dataSource) {
//        dataSource.options = LSYListViewRefreshOptionHeader|LSYListViewRefreshOptionFooter;
        dataSource.pageSize = 4;
        dataSource.removeFooterWhenNoMoreData = YES;
        dataSource.headerClass = GifRefreshHeader.class;
        dataSource.footerClass = GifRefreshFooter.class;
    } loadData:^(LSYListViewDataSource * _Nonnull dataSource, NSInteger pageIndex) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf loadDataWithPageIndex:pageIndex];
        });
    } getCell:^UITableViewCell * _Nonnull(LSYTableViewDataSource * _Nonnull dataSource, id  _Nonnull data, NSIndexPath * _Nonnull indexPath) {
        UITableViewCell *cell = [dataSource.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        cell.textLabel.text = data;
        return cell;
    }];
    [_tableView.mj_header beginRefreshing];
}

- (void)loadDataWithPageIndex:(NSInteger)pageIndex{
    XXXListRequest *request = [[XXXListRequest alloc] init];
    request.pageIndex = pageIndex;
    request.pageSize = _tableView.lsy_dataSource.pageSize;
    [request startRequestWithSuccessBlock:^(XXXListResult *responseData) {
        _tableView.lsy_dataSource.total = responseData.total;
        [_tableView.lsy_dataSource endRefreshWithDataList:responseData.list];
    } failureBlock:^(NSError *error) {
        [_tableView.lsy_dataSource endRefresh];
        //show fail toast
    }];
}

@end
