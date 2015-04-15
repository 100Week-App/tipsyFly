//
//  collectionScreen.m
//  firstProject
//
//  Created by Mitesh Maheta on 30/03/15.
//  Copyright (c) 2015 tipsy. All rights reserved.
//

#import "collectionScreen.h"

@interface collectionScreen ()

@property (strong, nonatomic) IBOutlet UIView *view;
@end
@implementation collectionScreen

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"collectionScreenView" owner:self options:nil];
        
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
