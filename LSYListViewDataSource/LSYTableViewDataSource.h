//
//  LSYTableViewDataSource.h
//  LSYListViewDataSourceDemo
//
//  Created by liusiyang on 2023/8/15.
//

#import "LSYListViewDataSource.h"
@class LSYTableViewDataSource;

NS_ASSUME_NONNULL_BEGIN

typedef UITableViewCell * _Nonnull (^ LSYTableViewGetCellBlock)(LSYTableViewDataSource *dataSource, id data, NSIndexPath *indexPath);

@interface LSYTableViewDataSource : LSYListViewDataSource

@property (weak, nonatomic, readonly) UITableView *tableView;

/** block会引起循环引用 */
@property (copy, nonatomic) LSYTableViewGetCellBlock getCellCallback;

@end

@interface UITableView (LSYDataSource)

@property (strong, nonatomic) LSYTableViewDataSource *lsy_dataSource;

/** 添加dataSource,block会引起循环引用 */
- (void)lsy_addDataSourceWithConfigBlock:(LSYListViewConfigBlock)configBlock
                                loadData:(LSYListViewLoadDataBlock)loadData
                                 getCell:(LSYTableViewGetCellBlock)getCell;

@end

NS_ASSUME_NONNULL_END
