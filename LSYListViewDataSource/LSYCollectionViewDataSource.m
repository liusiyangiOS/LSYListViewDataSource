//
//  LSYCollectionViewDataSource.m
//  LSYListViewDataSourceDemo
//
//  Created by liusiyang on 2023/8/15.
//

#import "LSYCollectionViewDataSource.h"

@interface LSYCollectionViewDataSource ()<UICollectionViewDataSource>

@end

@implementation LSYCollectionViewDataSource

#pragma mark - override

- (void)reloadData{
    [self.collectionView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.getCellCallback(self,_dataList[indexPath.row],indexPath);
}

#pragma mark - setter & getter

- (UICollectionView *)collectionView{
    return (UICollectionView *)self.listView;
}

- (void)setGetCellCallback:(LSYCollectionViewGetCellBlock)getCellCallback{
    if (_getCellCallback != getCellCallback) {
        _getCellCallback = [getCellCallback copy];
        if (getCellCallback) {
            self.collectionView.dataSource = self;
        }
    }
}

@end

@implementation UICollectionView (LSYDataSource)

- (void)lsy_addDataSourceWithConfigBlock:(LSYListViewConfigBlock)configBlock
                                loadData:(LSYListViewLoadDataBlock)loadData
                                 getCell:(LSYCollectionViewGetCellBlock)getCell{
    LSYCollectionViewDataSource *ds = [[LSYCollectionViewDataSource alloc] initWithListView:self configBlock:configBlock loadDataCallBack:loadData];
    ds.getCellCallback = getCell;
    self.lsy_dataSource = ds;
}

-(void)setLsy_dataSource:(LSYCollectionViewDataSource *)lsy_dataSource{
    if (self.lsy_dataSource != lsy_dataSource) {
        objc_setAssociatedObject(self, @selector(lsy_dataSource), lsy_dataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (LSYCollectionViewDataSource *)lsy_dataSource{
    return objc_getAssociatedObject(self, _cmd);
}

@end
