//
//  GlobalMethods.h
//  LearnToDrill
//
//  Created by saralsoft on 07/03/14.
//  Copyright (c) 2014 emedsim. All rights reserved.
//

/*-------------------------------*/
//This class is Globally Used for Global Functionallity in App
/*-------------------------------*/

#import <Foundation/Foundation.h>
#import "GlobalModel.h"

#define CUSTOM_BUNDLE_NAME @"MYBUNDLE.bundle"
#define cacheBundle @"MYCACHE.bundle"

@interface GlobalMethods : NSObject

// Sets view to whole screen. default color is black with 0.5 opacity
+ (void) fullScreenBackground:(UIView *)backgroundView backgroundColor:(UIColor *)color;

// Returns rgb color from key of globalTheme.json file.
+ (UIColor *)RGBColor:(NSMutableDictionary*)themeData ofObject:(NSString *)themeObject;

// Animate the View
+ (void)animateViewWithAlpha:(UIView *)view animationDuration:(double)duration;

// Get File path from any Directory in iOS App file system. Priority is Library Directory, Document Directory , Main Bundle.
+ (NSString *)getFilePathFromCompleteFileSystem:(NSString *)fileName;

// Get File path from any Directory in iOS App file system.
+ (NSString *)getFilePathFromFileSystemUsingFileName:(NSString *)strFileName strFolderNameOrPath:(NSString *)strFolderNameOrPath checkFileExistsIn:(CheckFileExistsIn)checkFileExistsIn;

// Add Skip Attribute to Content For not Uploading on iTunes Server
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

// Customized Method to remove uiview from its superview.
+ (id)removeFromSuperView:(UIView *)view;

// Get custom bundle
+ (NSBundle *)getStaticCustomBundle;
+ (NSBundle *)getStaticCacheBundle;
+ (NSString *)getLocalizedValueForKey:(NSString *)key;
+ (NSString *)getLangID:(NSInteger)index;

// Loads JSON data from file.
+ (id)loadJSONDataFromFile:(NSString *)fileName;
- (id)loadJSONDataWithFilePath:(NSString *)withFilePath;

// Set the initial values of the required elements,properties of the Google Tracking.
//- (void)setInitialsOfGoogleTracking;
//+ (void)GASendScreen:(NSString *)strScreenName;
//+ (void)GASendEventWithCategory:(NSString *)strCategory action:(NSString *)strAction label:(NSString *)strLabel value:(NSNumber *)Value;
//+ (void)GASendEcommerceProductWithName:(NSString *)strProductName price:(NSNumber *)Price productAction:(NSString *)IPproductAction transactionID:(NSString *)strTransactionID eventCategory:(NSString *)strCategory action:(NSString *)strAction label:(NSString *)strLabel value:(NSNumber *)Value;

// Keychain methods
+ (NSData *)searchKeychainCopyMatching:(NSString *)identifier ;
+ (BOOL)createKeychainValue:(NSString *)password forIdentifier:(NSString *)identifier;
+ (BOOL)updateKeychainValue:(NSString *)password forIdentifier:(NSString *)identifier;

// Invalidate Timer
+ (NSTimer *)invalidateTimer:(id)timer;

//Add Top Left Bottom Right Constraints
+ (void)addConstarintsToView:(UIView *)subView superView:(UIView *)superView top:(int)top bottom:(int)bottom left:(int)left right:(int)right;

//To Check Internect Connection
+ (BOOL)isInternetConnectionAvailable;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
