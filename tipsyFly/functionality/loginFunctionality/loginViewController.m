//
//  loginViewController.m
//  firstProject
//
//  Created by Mitesh Maheta on 08/04/15.
//  Copyright (c) 2015 tipsy. All rights reserved.
//

#import "loginViewController.h"
#import "loginScreenView.h"
#import <Parse/Parse.h>
#import "ViewController.h"

@interface loginViewController ()<UIAlertViewDelegate>{
    NSString *strBtnDone;
}

@property(strong,nonatomic)loginScreenView *loginView;
@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadLoginView];
}

-(void)loadLoginView{
    
    _loginView= [[loginScreenView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.view addSubview:_loginView];
    [GlobalMethods addConstarintsToView:_loginView superView:self.view top:0 bottom:0 left:0 right:0];
    [_loginView.btnLogin addTarget:self action:@selector(btnSubmitTapped) forControlEvents:UIControlEventTouchUpInside];
    
    _loginView.btnFacebookLogin.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    
    [_loginView.btnForgotPassword addTarget:self action:@selector(btnForgotPasswordTaped) forControlEvents:UIControlEventTouchUpInside];
    
    [_loginView.btnCancel addTarget:self action:@selector(btnCancelTaped) forControlEvents:UIControlEventTouchUpInside];
}

-(void)btnSubmitTapped{
    
    if ([GlobalMethods isInternetConnectionAvailable]) {
        [self SubmitButtonProcessing:YES];
        
        PFUser *user = [PFUser user];
        user.username = [_loginView.txtEmailID.text lowercaseString];
        user.password = _loginView.txtPassword.text;
        user.email = [_loginView.txtEmailID.text lowercaseString];
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                
                PFUser *currentUser = [PFUser currentUser];
                if (currentUser) {
                    
                    //                if ([FMDBDatabaseAccess insertOrUpdateUserDetailsWithUserID:currentUser.objectId andEmail:currentUser.username] == RowInserted) {
                    [self showAlertForValidCode];
                    [self SubmitButtonProcessing:NO];
                    
                    //                }else{
                    
                    //                    NSLog(@"Error while inserting User details");
                    //                }
                    
                }else{
                    NSLog(@"Current User is not available");
                }
                
            }else{
                
                [PFUser logInWithUsernameInBackground:user.username password:user.password
                                                block:^(PFUser *user, NSError *error) {
                                                    if (user) {
                                                        
                                                        //                                                    if ([FMDBDatabaseAccess insertOrUpdateUserDetailsWithUserID:user.objectId andEmail:user.username] == RowInserted) {
                                                        
                                                        [self showAlertForValidCode];
                                                        [self SubmitButtonProcessing:NO];
                                                        
                                                        //                                                    }else{
                                                        //                                                        NSLog(@"Error while User details inserting");
                                                        //                                                    }
                                                        
                                                    } else {
                                                        
                                                        [self SubmitButtonProcessing:NO];
                                                    }
                                                }];
            }
        }];
        
    }else{
        
        [self ShowAlertInternetFailed];
        
    }
    
    
}

- (void)SubmitButtonProcessing:(BOOL)status{
    @try {
        if (status) {
            strBtnDone = _loginView.btnLogin.titleLabel.text;
            
            [_loginView.activityIndicator startAnimating];
            
            _loginView.btnLogin.enabled = FALSE;
            _loginView.btnLogin.userInteractionEnabled = FALSE;
            [_loginView.btnLogin setTitle:@"" forState:UIControlStateNormal];
            
            _loginView.btnForgotPassword.userInteractionEnabled = FALSE;
            
            _loginView.btnFacebookLogin.userInteractionEnabled = FALSE;
            
        }
        else {
            
            [_loginView.activityIndicator stopAnimating];
            
            _loginView.btnLogin.enabled = TRUE;
            _loginView.btnLogin.userInteractionEnabled = TRUE;
            [_loginView.btnLogin setTitle:strBtnDone forState:UIControlStateNormal];
            
            _loginView.btnForgotPassword.userInteractionEnabled = TRUE;
            
            _loginView.btnFacebookLogin.userInteractionEnabled = TRUE;
        }
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

- (void)showAlertForValidCode{
    
    UIAlertView *alertView = [[UIAlertView alloc] init];
    alertView.delegate = self;
    alertView.tag = tagValidIDAlert;
    
    [alertView setTitle:[GlobalMethods getLocalizedValueForKey:keyReferralSelectionSuccessAlertTitle]];
    
    [alertView setMessage:[GlobalMethods getLocalizedValueForKey:keyReferralSelectionSuccessAlertDescription]];
    
    [alertView addButtonWithTitle:[GlobalMethods getLocalizedValueForKey:keyReferralSelectionSuccessAlertBtnOk]];
    
    [alertView show];
    
}

- (void)ShowAlertInternetFailed{
    
    UIAlertView *alertView = [[UIAlertView alloc] init];
    
    [alertView setTitle:[GlobalMethods getLocalizedValueForKey:keyReferralSelectionInternetfailedAlertTitle]];
    
    [alertView setMessage:[GlobalMethods getLocalizedValueForKey:keyReferralSelectionInternetfailedAlertDescription]];
    
    [alertView addButtonWithTitle:[GlobalMethods getLocalizedValueForKey:keyReferralSelectionInternetfailedAlertBtnOk]];
    
    [alertView show];
    
}

-(void)btnForgotPasswordTaped{
    
    if ([_loginView.btnForgotPassword.titleLabel.text isEqualToString:[GlobalMethods getLocalizedValueForKey:keyRegistrationScreenBtnForgotPasswordAlternateText]]) {
        
        [PFUser requestPasswordResetForEmailInBackground:_loginView.txtEmailID.text];
        
        [self enableForgotPasswordUI:NO];
        
    }else{
        
        [self enableForgotPasswordUI:YES];
        
    }
}

-(void)btnCancelTaped{
    
    [self enableForgotPasswordUI:NO];
    
}

-(void)enableForgotPasswordUI:(BOOL)status{
    
    if (status) {
        
        [_loginView.btnForgotPassword setTitle:[GlobalMethods getLocalizedValueForKey:keyRegistrationScreenBtnForgotPasswordAlternateText] forState:UIControlStateNormal];
        _loginView.btnCancel.hidden = FALSE;
        
        _loginView.txtPassword.hidden = TRUE;
        _loginView.btnLogin.hidden = TRUE;
        _loginView.btnFacebookLogin.hidden = TRUE;
        
    }else{
        
        [_loginView.btnForgotPassword setTitle:[GlobalMethods getLocalizedValueForKey:keyRegistrationScreenBtnForgotPassword] forState:UIControlStateNormal];
        
        _loginView.btnCancel.hidden = TRUE;
        
        _loginView.txtPassword.hidden = FALSE;
        _loginView.btnLogin.hidden = FALSE;
        _loginView.btnFacebookLogin.hidden = FALSE;
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == tagValidIDAlert) {
    
        [self initializeMainScreen];
    }
    
}
- (void)initializeMainScreen{
    
//    [superModel.userDefaults setBool:YES forKey:keyShouldWelcomeScreenHide];
//    [superModel.userDefaults synchronize];
    
    [ViewController initializeMainscreenWithTabBarFromTarget:self];
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
