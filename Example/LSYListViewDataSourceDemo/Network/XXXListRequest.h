//
//  XXXFriendListRequest.h
//  LSYNetworkingDemo
//
//  Created by 刘思洋 on 2022/9/29.
//

#import "YourBaseRequest.h"
#import "XXXListResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface XXXListRequest : YourBaseRequest

@property (assign, nonatomic) NSInteger pageIndex;

@property (assign, nonatomic) NSInteger pageSize;

@end

NS_ASSUME_NONNULL_END
