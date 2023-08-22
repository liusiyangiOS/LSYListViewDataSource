//
//  XXXFirendInfo.h
//  Pods
//
//  Created by 刘思洋 on 2022/9/30.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface XXXListResult : NSObject<YYModel>

@property (assign, nonatomic) int total;

@property (strong, nonatomic) NSArray<NSString *> *list;

@end

NS_ASSUME_NONNULL_END
