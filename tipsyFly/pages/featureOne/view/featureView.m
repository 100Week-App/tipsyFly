//
//  featureView.m
//  firstProject
//
//  Created by Mitesh Maheta on 26/03/15.
//  Copyright (c) 2015 tipsy. All rights reserved.
//

#import "featureView.h"

@interface featureView ()
@property (strong, nonatomic) IBOutlet UIView *view;

@end

@implementation featureView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"featureView" owner:self options:nil];
        
        CGRect rect = frame;
        rect.origin = CGPointZero;
        
        [self.view setFrame:rect];
        [self addSubview:self.view];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
