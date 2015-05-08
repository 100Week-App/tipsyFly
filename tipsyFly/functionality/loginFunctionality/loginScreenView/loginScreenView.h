//
//  loginScreenView.h
//  firstProject
//
//  Created by Mitesh Maheta on 08/04/15.
//  Copyright (c) 2015 tipsy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalMethods.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#define keyReferralSelectionSuccessAlertTitle @"referralSelectionSuccessAlertTitle"
#define keyReferralSelectionSuccessAlertDescription @"referralSelectionSuccessAlertDescription"
#define keyReferralSelectionSuccessAlertBtnOk @"referralSelectionSuccessAlertBtnOk"

#define keyReferralSelectionInternetfailedAlertTitle @"referralSelectionInternetfailedAlertTitle"
#define keyReferralSelectionInternetfailedAlertDescription @"referralSelectionInternetfailedAlertDescription"
#define keyReferralSelectionInternetfailedAlertBtnOk @"referralSelectionInternetfailedAlertBtnOk"

#define keyRegistrationScreenBtnForgotPassword @"registrationScreenBtnForgotPassword"
#define keyRegistrationScreenBtnForgotPasswordAlternateText @"registrationScreenBtnForgotPasswordAlternateText"
#define keyRegistrationScreenBtnCancel @"registrationScreenBtnCancel"

@interface loginScreenView : UIView
@property (strong, nonatomic) IBOutlet UITextField *txtEmailID;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet FBSDKLoginButton *btnFacebookLogin;
@property (strong, nonatomic) IBOutlet UIButton *btnForgotPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;

@property(retain,nonatomic) UIActivityIndicatorView *activityIndicator;

@end
