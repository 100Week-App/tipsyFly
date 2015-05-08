//
//  verticalViewController.m
//  firstProject
//
//  Created by Mitesh Maheta on 26/03/15.
//  Copyright (c) 2015 tipsy. All rights reserved.
//

#import "verticalViewController.h"
#import "BaseContentViewController.h"

@interface verticalViewController ()

@property (strong, nonatomic) UIPageViewController *pageViewController;
@end

@implementation verticalViewController

-(instancetype)init{
    self = [super init];
    if (self) {
        self.arrayViewControllers = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @try {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                 bundle: nil];
        
        self.pageViewController = (UIPageViewController*)[mainStoryboard
                                                          instantiateViewControllerWithIdentifier:@"verticalPageViewController"];
        
        self.pageViewController.dataSource = self;
        
        UIViewController *startingViewController = [self viewControllerAtIndex:self.currentIndex];
        
        [self.pageViewController setViewControllers:@[startingViewController]
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:NO
                                         completion:^(BOOL finished) {
                                             // Completion code
                                         }];
        
        [self addChildViewController:self.pageViewController];
        [self.view addSubview:self.pageViewController.view];
        [self.pageViewController didMoveToParentViewController:self];
    }
    @catch (NSException *exception) {
        NSLog(@"NSException setAppLanguage: %@", [exception reason]);
    }
    @finally {
        
    }
    
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index = [viewController.restorationIdentifier integerValue];
    
    if (index == self.arrayViewControllers.count - 1) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index + 1];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSUInteger index = [viewController.restorationIdentifier integerValue];
    
    if (index == 0) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index - 1];
    
}

-(UIViewController *)viewControllerAtIndex:(NSInteger)index{
    if (index >= [_arrayViewControllers count]) {
        return Nil;
    }
    
    if (![[_arrayViewControllers objectAtIndex:index] isKindOfClass:[horizontalViewController class]]) {
        BaseContentViewController *viewController = (BaseContentViewController *)[_arrayViewControllers objectAtIndex:index];
        viewController.restorationIdentifier = [@(index) stringValue];
        viewController.verticalRootViewController = self;
        return viewController;
    }else{
        UIViewController *viewController = [_arrayViewControllers objectAtIndex:index];
        viewController.restorationIdentifier = [@(index) stringValue];
        return viewController;
    }
}
-(void)moveDownToVertical{
    
    UIViewController *currentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
    NSUInteger index = [currentViewController.restorationIdentifier integerValue];
    
    UIViewController *nextViewController = [self viewControllerAtIndex:index + 1];
    
    [self.pageViewController setViewControllers:@[nextViewController]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:Nil];
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
