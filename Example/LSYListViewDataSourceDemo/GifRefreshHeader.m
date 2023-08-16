//
//  GifRefreshHeader.m
//  LSYListViewDataSourceDemo
//
//  Created by liusiyang on 2023/8/16.
//

#import "GifRefreshHeader.h"

@implementation GifRefreshHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.gifView.animationImages = nil;
    }
    return self;
}

@end
