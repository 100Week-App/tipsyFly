//
//  verticalViewController.h
//  firstProject
//
//  Created by Mitesh Maheta on 26/03/15.
//  Copyright (c) 2015 tipsy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface verticalViewController : UIViewController<UIPageViewControllerDataSource>

@property(nonatomic)NSInteger currentIndex;
@property(nonatomic)NSMutableArray *arrayViewControllers;

-(void)moveDownToVertical;
@end
