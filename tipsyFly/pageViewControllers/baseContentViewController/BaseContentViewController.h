//
//  BaseContentViewController.h
//  StoryboardPagingDemo
//
//  Created by Derek Lee on 2/6/15.
//  Copyright (c) 2015 Derek Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "horizontalViewController.h"
#import "verticalViewController.h"

@interface BaseContentViewController : UIViewController

#pragma mark - Properties
@property (nonatomic, strong) horizontalViewController *horizontalRootViewController;
@property (nonatomic, strong) verticalViewController *verticalRootViewController;
@end
