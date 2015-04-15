//
//  collectionViewController.m
//  firstProject
//
//  Created by Mitesh Maheta on 26/03/15.
//  Copyright (c) 2015 tipsy. All rights reserved.
//

#import "collectionViewController.h"
#import "collectionScreen.h"
@interface collectionViewController ()

@property(strong,nonatomic)collectionScreen *collectionScreenView;
@end

@implementation collectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _collectionScreenView = [[collectionScreen alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.view addSubview:_collectionScreenView];
    [GlobalMethods addConstarintsToView:_collectionScreenView superView:self.view top:0 bottom:0 left:0 right:0];
    
    
    [_collectionScreenView.btnShopHere addTarget:self action:@selector(showListOfProducts) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

-(void)showListOfProducts{
    
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
