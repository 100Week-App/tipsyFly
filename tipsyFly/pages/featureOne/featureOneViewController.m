//
//  featureOneViewController.m
//  firstProject
//
//  Created by Mitesh Maheta on 26/03/15.
//  Copyright (c) 2015 tipsy. All rights reserved.
//

#import "featureOneViewController.h"
#import "featureView.h"
#import "verticalViewController.h"

@interface featureOneViewController ()

@property(strong,nonatomic)featureView *featureScreenView;
@property(strong,nonatomic)verticalViewController *verticalController;
@end

@implementation featureOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    _featureScreenView = [[featureView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    [self.view addSubview:_featureScreenView];
    [GlobalMethods addConstarintsToView:_featureScreenView superView:self.view top:0 bottom:0 left:0 right:0];
    
    
    [_featureScreenView.btnExplorerNow addTarget:self action:@selector(nextViewController) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.

}
-(void)nextViewController{

    [self.verticalRootViewController moveDownToVertical];
    
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
