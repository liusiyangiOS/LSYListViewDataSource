//
//  CollectionViewController.m
//  LSYListViewDataSourceDemo
//
//  Created by liusiyang on 2023/8/15.
//

#import "CollectionViewController.h"
#import "LSYCollectionViewDataSource.h"
#import "CollectionViewCell.h"
#import "GifRefreshHeader.h"
#import "GifRefreshFooter.h"
#import "XXXListRequest.h"

@interface CollectionViewController (){
    __weak IBOutlet UICollectionView *_collectionView;
}
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_collectionView registerClass:CollectionViewCell.class forCellWithReuseIdentifier:@"Cell"];
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.itemSize = CGSizeMake((UIScreen.mainScreen.bounds.size.width - 30) / 2, 200);
    
    __weak typeof(self) weakSelf = self;
    [_collectionView lsy_addDataSourceWithConfigBlock:^(LSYListViewDataSource * _Nonnull dataSource) {
//        dataSource.options = LSYListViewRefreshOptionHeader|LSYListViewRefreshOptionFooter;
        dataSource.pageSize = 4;
        dataSource.removeFooterWhenNoMoreData = YES;
//        dataSource.headerClass = GifRefreshHeader.class;
//        dataSource.footerClass = GifRefreshFooter.class;
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
    XXXListRequest *request = [[XXXListRequest alloc] init];
    request.pageIndex = pageIndex;
    request.pageSize = _collectionView.lsy_dataSource.pageSize;
    [request startRequestWithSuccessBlock:^(XXXListResult *responseData) {
        _collectionView.lsy_dataSource.total = responseData.total;
        [_collectionView.lsy_dataSource endRefreshWithDataList:responseData.list];
    } failureBlock:^(NSError *error) {
        [_collectionView.lsy_dataSource endRefresh];
        //show fail toast
    }];
}

@end
