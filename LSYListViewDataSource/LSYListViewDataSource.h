//
//  LSYTableViewDataSource.h
//  LSYListViewDataSourceDemo
//
//  Created by liusiyang on 2023/8/15.
//

#import <Foundation/Foundation.h>
#import <MJRefresh/MJRefresh.h>
@class LSYListViewDataSource;

typedef NS_ENUM(NSInteger,LSYListViewRefreshOption){
    /** header管理 */
    LSYListViewRefreshOptionHeader   = 1 << 0,
    /** footer管理 */
    LSYListViewRefreshOptionFooter   = 1 << 1,
};

NS_ASSUME_NONNULL_BEGIN

typedef void (^ LSYListViewLoadDataBlock)(LSYListViewDataSource *dataSource, NSInteger pageIndex);

@interface LSYListViewDataSource : NSObject{
    NSMutableArray *_dataList;
}

@property (weak, nonatomic, readonly) UIScrollView *listView;

/** 数据列表,外界不需要管理 */
@property (copy, nonatomic, readonly) NSMutableArray *dataList;

/** 请求的数据的起始索引值,默认0 */
@property (assign, nonatomic) NSInteger startIndex;

/** 每次请求的数据量,默认10 */
@property (assign, nonatomic) NSInteger pageSize;

/** 后台总数据量,可不填写 */
@property (assign, nonatomic) NSInteger total;

/** 没有更多数据的时候是否移除Footer */
@property (assign, nonatomic) BOOL removeFooterWhenNoMoreData;

/** block会引起循环引用 */
- (instancetype)initWithListView:(UIScrollView *)listView
                         options:(LSYListViewRefreshOption)options
                loadDataCallBack:(LSYListViewLoadDataBlock)loadData;

/** 停止刷新 */
- (void)endRefresh;
/** 添加新数据并结束刷新 */
- (void)endRefreshWithDataList:(NSArray *)list;

/** 下拉刷新 */
- (void)refresh;
- (void)refreshWithDataList:(NSArray *)list;

#pragma mark - override

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
