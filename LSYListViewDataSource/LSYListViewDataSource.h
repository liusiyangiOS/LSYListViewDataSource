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
typedef void (^ LSYListViewConfigBlock)(LSYListViewDataSource *dataSource);

@interface LSYListViewDataSource : NSObject{
    NSMutableArray *_dataList;
}
/** 需要使用的功能选项 */
@property (assign, nonatomic) LSYListViewRefreshOption options;
/** 自定义header类,默认是MJRefreshNormalHeader */
@property (assign, nonatomic) Class headerClass;
/** 自定义footer类,默认是MJRefreshAutoFooter */
@property (assign, nonatomic) Class footerClass;
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

@property (weak, nonatomic, readonly) UIScrollView *listView;

/** block会引起循环引用 */
- (instancetype)initWithListView:(UIScrollView *)listView
                     configBlock:(LSYListViewConfigBlock)configBlock
                loadDataCallBack:(LSYListViewLoadDataBlock)loadData;

/** 停止刷新,一般在请求失败的时候调用 */
- (void)endRefresh;
/** 添加新数据并结束刷新,请求成功后调用 */
- (void)endRefreshWithDataList:(NSArray *)list;

/** 不下拉,直接刷新 */
- (void)refresh;
/** 直接用给定的list作为第一屏数据刷新列表 */
- (void)refreshWithDataList:(NSArray *)list;

#pragma mark - override

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
