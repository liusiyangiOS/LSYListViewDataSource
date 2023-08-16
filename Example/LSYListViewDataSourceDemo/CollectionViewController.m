//
//  CollectionViewController.m
//  LSYListViewDataSourceDemo
//
//  Created by liusiyang on 2023/8/15.
//

#import "CollectionViewController.h"
#import "LSYCollectionViewDataSource.h"
#import "CollectionViewCell.h"

@interface CollectionViewController (){
    __weak IBOutlet UICollectionView *_collectionView;
    NSInteger _total;
}
@property (assign, nonatomic) NSInteger pageSize;
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageSize = 5;
    _total = 29;
    
    [_collectionView registerClass:CollectionViewCell.class forCellWithReuseIdentifier:@"Cell"];
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.itemSize = CGSizeMake((UIScreen.mainScreen.bounds.size.width - 30) / 2, 200);
    
    __weak typeof(self) weakSelf = self;
    [_collectionView lsy_addDataSourceWithConfigBlock:^(LSYListViewDataSource * _Nonnull dataSource) {
        dataSource.options = LSYListViewRefreshOptionHeader|LSYListViewRefreshOptionFooter;
        dataSource.startIndex = 1;
        dataSource.pageSize = weakSelf.pageSize;
        dataSource.removeFooterWhenNoMoreData = YES;
    } loadData:^(LSYListViewDataSource * _Nonnull dataSource, NSInteger pageIndex) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf loadDataWithPageIndex:pageIndex];
        });
    } getCell:^UICollectionViewCell * _Nonnull(LSYCollectionViewDataSource * _Nonnull dataSource, id  _Nonnull data, NSIndexPath * _Nonnull indexPath) {
        CollectionViewCell *cell = [dataSource.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
        cell.textLabel.text = data;
        return cell;
    }];
    [_collectionView.mj_header beginRefreshing];
}

- (void)loadDataWithPageIndex:(NSInteger)pageIndex{
    NSMutableArray *resultArr = [NSMutableArray arrayWithCapacity:_pageSize];
    for (int i = 0; i < _pageSize; i ++) {
        if (i >= _total - pageIndex * _pageSize) {
            break;
        }
        [resultArr addObject:[NSString stringWithFormat:@"第%ld页数据",pageIndex]];
    }
    _collectionView.lsy_dataSource.total = _total;
    [_collectionView.lsy_dataSource endRefreshWithDataList:resultArr.copy];
}

@end
