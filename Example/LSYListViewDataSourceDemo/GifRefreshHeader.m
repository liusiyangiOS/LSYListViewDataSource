//
//  GifRefreshHeader.m
//  LSYListViewDataSourceDemo
//
//  Created by liusiyang on 2023/8/16.
//

#import "GifRefreshHeader.h"

@implementation GifRefreshHeader

- (void)prepare{
    [super prepare];
    int count = 24;
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:count];
    for (int i = 1; i < count + 1; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"header%d.jpeg",i]];
        [images addObject:image];
    }
    [self setImages:images duration:1 forState:MJRefreshStateIdle];
    [self setImages:@[images.lastObject] duration:1 forState:MJRefreshStatePulling];
    [self setImages:images duration:1 forState:MJRefreshStateRefreshing];
    [self setImages:images duration:1 forState:MJRefreshStateWillRefresh];
}

-(void)placeSubviews{
    [super placeSubviews];
    self.stateLabel.hidden = YES;
    self.lastUpdatedTimeLabel.hidden = YES;
}

@end
