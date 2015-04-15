//
//  coverPageViewController.m
//  firstProject
//
//  Created by Mitesh Maheta on 26/03/15.
//  Copyright (c) 2015 tipsy. All rights reserved.
//

#import "coverPageViewController.h"
#import "coverView.h"

@interface coverPageViewController ()

@property(strong,nonatomic)coverView *coverScreenView;
@end

@implementation coverPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _coverScreenView = [[coverView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.view addSubview:_coverScreenView];
    [GlobalMethods addConstarintsToView:_coverScreenView superView:self.view top:0 bottom:0 left:0 right:0];
    
    
    // Do any additional setup after loading the view.
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
