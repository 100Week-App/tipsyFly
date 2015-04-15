//
//  loginScreenView.m
//  firstProject
//
//  Created by Mitesh Maheta on 08/04/15.
//  Copyright (c) 2015 tipsy. All rights reserved.
//

#import "loginScreenView.h"

@interface loginScreenView(){
    
}
@property (strong, nonatomic) IBOutlet UIView *view;

@end
@implementation loginScreenView

@synthesize activityIndicator;

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"loginScreenView" owner:self options:nil];
        
        CGRect rect = frame;
        rect.origin = CGPointZero;
        
        [self.view setFrame:rect];
        [self addSubview:self.view];

        [self initialize];
    }
    return self;
}
-(void)initialize{
    
    if (!activityIndicator) {
        activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_btnLogin addSubview:activityIndicator];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
