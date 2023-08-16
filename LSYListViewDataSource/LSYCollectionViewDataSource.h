//
//  LSYCollectionViewDataSource.h
//  LSYListViewDataSourceDemo
//
//  Created by liusiyang on 2023/8/15.
//

#import "LSYListViewDataSource.h"
@class LSYCollectionViewDataSource;

NS_ASSUME_NONNULL_BEGIN

typedef UICollectionViewCell * _Nonnull (^ LSYCollectionViewGetCellBlock)(LSYCollectionViewDataSource *dataSource, id data, NSIndexPath *indexPath);

@interface LSYCollectionViewDataSource : LSYListViewDataSource

@property (weak, nonatomic, readonly) UICollectionView *collectionView;

/** block会引起循环引用 */
@property (copy, nonatomic) LSYCollectionViewGetCellBlock getCellCallback;

@end

@interface UICollectionView (LSYDataSource)

@property (strong, nonatomic) LSYCollectionViewDataSource *lsy_dataSource;

/** 添加dataSource,block会引起循环引用 */
- (void)lsy_addDataSourceWithConfigBlock:(LSYListViewConfigBlock)configBlock
                                loadData:(LSYListViewLoadDataBlock)loadData
                                 getCell:(LSYCollectionViewGetCellBlock)getCell;

@end

NS_ASSUME_NONNULL_END
