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
    int total = 8;
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

@end
