//
//  horizontalViewController.m
//  firstProject
//
//  Created by Mitesh Maheta on 26/03/15.
//  Copyright (c) 2015 tipsy. All rights reserved.
//

#import "horizontalViewController.h"
#import "BaseContentViewController.h"

@interface horizontalViewController ()

@property (strong, nonatomic) UIPageViewController *pageViewController;
@end

@implementation horizontalViewController

-(instancetype)init{
    self = [super init];
    if (self) {
        self.arrayViewControllers = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    self.pageViewController = (UIPageViewController*)[mainStoryboard
                                                      instantiateViewControllerWithIdentifier:@"horizontalPageViewController"];
    
    self.pageViewController.dataSource = self;
    
    UIViewController *startingViewController = [self viewControllerAtIndex:self.currentIndex];
    
    [self.pageViewController setViewControllers:@[startingViewController]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:Nil];
    

    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    // Do any additional setup after loading the view.
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSUInteger index = [viewController.restorationIdentifier integerValue];// [self.contentPageRestorationIDs indexOfObject:vcRestorationID];
    
    if (index == self.arrayViewControllers.count - 1) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index + 1];

}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSUInteger index = [viewController.restorationIdentifier integerValue]; //[self.arrayViewControllers indexOfObject:vcRestorationID];
    
    if (index == 0) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index - 1];
    
}

-(UIViewController *)viewControllerAtIndex:(NSInteger)index{
    
    if (index >= [_arrayViewControllers count]) {
        return Nil;
    }
    if (![[_arrayViewControllers objectAtIndex:index] isKindOfClass:[verticalViewController class]]) {
        BaseContentViewController *viewController = (BaseContentViewController *)[_arrayViewControllers objectAtIndex:index];
        viewController.restorationIdentifier = [@(index) stringValue];
        viewController.horizontalRootViewController = self;
        return viewController;
    }else{
        UIViewController *viewController = [_arrayViewControllers objectAtIndex:index];
        viewController.restorationIdentifier = [@(index) stringValue];
        return viewController;
    }
    
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
