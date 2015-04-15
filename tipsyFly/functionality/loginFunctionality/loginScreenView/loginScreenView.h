//
//  loginScreenView.h
//  firstProject
//
//  Created by Mitesh Maheta on 08/04/15.
//  Copyright (c) 2015 tipsy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalMethods.h"

#define keyReferralSelectionSuccessAlertTitle @"referralSelectionSuccessAlertTitle"
#define keyReferralSelectionSuccessAlertDescription @"referralSelectionSuccessAlertDescription"
#define keyReferralSelectionSuccessAlertBtnOk @"referralSelectionSuccessAlertBtnOk"

#define keyReferralSelectionInternetfailedAlertTitle @"referralSelectionInternetfailedAlertTitle"
#define keyReferralSelectionInternetfailedAlertDescription @"referralSelectionInternetfailedAlertDescription"
#define keyReferralSelectionInternetfailedAlertBtnOk @"referralSelectionInternetfailedAlertBtnOk"

@interface loginScreenView : UIView
@property (strong, nonatomic) IBOutlet UITextField *txtEmailID;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UIButton *btnFacebook;
@property (strong, nonatomic) IBOutlet UIButton *btnForgotPassword;

@property(retain,nonatomic) UIActivityIndicatorView *activityIndicator;

@end
