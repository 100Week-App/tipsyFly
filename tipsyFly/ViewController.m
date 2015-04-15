//
//  ViewController.m
//  tipsyFly
//
//  Created by Mitesh Maheta on 13/04/15.
//  Copyright (c) 2015 tipsy. All rights reserved.
//

#import "ViewController.h"
#import "loginViewController.h"
#import "GlobalMethods.h"
#import "coverPageViewController.h"
#import "featureOneViewController.h"
#import "featureTwoViewController.h"
#import "collectionViewController.h"
#import "collectionTwoViewController.h"
#import "horizontalViewController.h"
#import "verticalViewController.h"

@interface ViewController (){
    GlobalMethods *superMethods;
    GlobalModel *superModel;
    
    NSMutableDictionary *supportedLanguageData;
}

@end

@implementation ViewController

+ (void)initializeMainscreenWithTabBarFromTarget:(UIViewController *)target {
    
    coverPageViewController *coverViewController = [[coverPageViewController alloc]init];
    featureTwoViewController *feature2Controller = [[featureTwoViewController alloc]init];
    verticalViewController *verticalPageController = [[verticalViewController alloc]init];
    featureOneViewController *feature1Controller = [[featureOneViewController alloc]init];
    collectionViewController *collectionController = [[collectionViewController alloc]init];
    collectionTwoViewController *collection2Controller = [[collectionTwoViewController alloc]init];
    
    [verticalPageController.arrayViewControllers addObject:feature1Controller];
    [verticalPageController.arrayViewControllers addObject:collectionController];
    [verticalPageController.arrayViewControllers addObject:collection2Controller];
    
    horizontalViewController *horizontalController = [[horizontalViewController alloc]init];
    [horizontalController.arrayViewControllers addObject:coverViewController];
    [horizontalController.arrayViewControllers addObject:verticalPageController];
    [horizontalController.arrayViewControllers addObject:feature2Controller];
    
    [target presentViewController:horizontalController animated:YES completion:Nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeGlobal];
    [self loadSupportedLanguageData];
    [self setAppLanguage];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    loginViewController *loginController = [[loginViewController alloc]init];
    [self presentViewController:loginController animated:YES completion:Nil];
}

- (void)initializeGlobal {
    superMethods = [[GlobalMethods alloc] init];
    superModel = [[GlobalModel alloc] init];
    superModel.userDefaults = [NSUserDefaults standardUserDefaults];
}
- (void)loadSupportedLanguageData {
    supportedLanguageData = [[NSMutableDictionary alloc] init];
    supportedLanguageData = [GlobalMethods loadJSONDataFromFile:keySupportedLanguagesJSON];
}
- (void)setAppLanguage {
    @try {
        
        NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        NSString *appBuild = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
        NSString *appBuildName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey];
        
        [superModel.userDefaults setObject:appVersion forKey:keyAppVersion];
        [superModel.userDefaults setObject:appBuild forKey:keyAppBuild];
        [superModel.userDefaults setObject:appBuildName forKey:keyAppBuildName];
        
        NSString *currentLanguageID = [[NSLocale preferredLanguages] objectAtIndex:0];
        
        if ([supportedLanguageData objectForKey:currentLanguageID]) {
            [superModel.userDefaults setObject:currentLanguageID forKey:keySelectedLanguageId];
        }
        else {
            [superModel.userDefaults setObject:defaultLanguage forKey:keySelectedLanguageId];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"NSException setAppLanguage: %@", [exception reason]);
    }
    @finally {
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
