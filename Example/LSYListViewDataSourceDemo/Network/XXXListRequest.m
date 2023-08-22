//
//  XXXFriendListRequest.m
//  LSYNetworkingDemo
//
//  Created by 刘思洋 on 2022/9/29.
//

#import "XXXListRequest.h"

@implementation XXXListRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.apiName = @"/xxx/xxx_list";
    }
    return self;
}

-(Class)resultClass{
    return XXXListResult.class;
}

-(id)responseDataSource{
    int total = 29;
    NSMutableArray *resultArr = [NSMutableArray arrayWithCapacity:_pageSize];
    for (int i = 0; i < _pageSize; i ++) {
        if (i >= total - _pageIndex * _pageSize) {
            break;
        }
        [resultArr addObject:[NSString stringWithFormat:@"第%ld页数据",_pageIndex]];
    }
    return @{
        @"resultcode":@(200),
        @"resultmsg":@"请求成功!",
        @"result":@{
            @"total":@(total),
            @"list":resultArr.copy
        }
    };
}

- (void)requestSuccessWithResponseObject:(id<LSYResponseProtocol>)response task:(nonnull NSURLSessionTask *)task{
    NSArray<XXXListResult *> *firendList = response.result;
    //这里可以对firendList进行一些处理,如排序操作,写在这里可以避免每次请求都需要在请求回调里写相同的排序逻辑
    response.result = firendList.copy;//假设这是排序操作
}

@end
