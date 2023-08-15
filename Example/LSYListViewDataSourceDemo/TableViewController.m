//
//  TableViewController.m
//  LSYListViewDataSourceDemo
//
//  Created by liusiyang on 2023/8/15.
//

#import "TableViewController.h"
#import "LSYTableViewDataSource.h"

@interface TableViewController (){
    __weak IBOutlet UITableView *_tableView;
    
    NSInteger _pageSize;
    NSInteger _total;
}

@end

@implementation TableViewController

-(void)dealloc{
    NSLog(@"%@ dealloc",self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageSize = 5;
    _total = 29;
    
    [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Cell"];
    
    __weak typeof(self) weakSelf = self;
    [_tableView lsy_addDataSourceWithOptions:LSYListViewRefreshOptionHeader|LSYListViewRefreshOptionFooter loadData:^(LSYListViewDataSource * _Nonnull dataSource, NSInteger pageIndex) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf loadDataWithPageIndex:pageIndex];
        });
    } getCell:^UITableViewCell * _Nonnull(LSYTableViewDataSource * _Nonnull dataSource, id  _Nonnull data, NSIndexPath * _Nonnull indexPath) {
        UITableViewCell *cell = [dataSource.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        cell.textLabel.text = data;
        return cell;
    }];
    _tableView.lsy_dataSource.pageSize = _pageSize;
    [_tableView.mj_header beginRefreshing];
}

- (void)loadDataWithPageIndex:(NSInteger)pageIndex{
    NSMutableArray *resultArr = [NSMutableArray arrayWithCapacity:_pageSize];
    for (int i = 0; i < _pageSize; i ++) {
        if (i >= _total - pageIndex * _pageSize) {
            break;
        }
        [resultArr addObject:[NSString stringWithFormat:@"第%ld页数据",pageIndex]];
    }
    _tableView.lsy_dataSource.total = _total;
    [_tableView.lsy_dataSource endRefreshWithDataList:resultArr.copy];
}

@end
