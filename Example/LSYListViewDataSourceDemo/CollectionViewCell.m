//
//  CollectionViewCell.m
//  LSYListViewDataSourceDemo
//
//  Created by liusiyang on 2023/8/15.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.lightGrayColor;
        self.textLabel = [UILabel new];
        _textLabel.textColor = UIColor.darkTextColor;
        [self addSubview:_textLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _textLabel.frame = CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height);
}

@end
