//
//  TableViewController.m
//  LSYListViewDataSourceDemo
//
//  Created by liusiyang on 2023/8/15.
//

#import "TableViewController.h"
#import "LSYTableViewDataSource.h"
#import "XXXListRequest.h"

@interface TableViewController (){
    __weak IBOutlet UITableView *_tableView;
}
@property (assign, nonatomic) NSInteger pageSize;
@end

@implementation TableViewController

-(void)dealloc{
    NSLog(@"%@ dealloc",self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageSize = 5;
    
    [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Cell"];
    
    __weak typeof(self) weakSelf = self;
    [_tableView lsy_addDataSourceWithConfigBlock:^(LSYListViewDataSource * _Nonnull dataSource) {
        dataSource.options = LSYListViewRefreshOptionHeader|LSYListViewRefreshOptionFooter;
        dataSource.startIndex = 1;
        dataSource.pageSize = weakSelf.pageSize;
        dataSource.removeFooterWhenNoMoreData = YES;
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
    request.pageSize = 5;
    [request startRequestWithSuccessBlock:^(XXXListResult *responseData) {
        _tableView.lsy_dataSource.total = responseData.total;
        [_tableView.lsy_dataSource endRefreshWithDataList:responseData.copy];
    } failureBlock:^(NSError *error) {
        //show fail toast
    }];
}

@end
