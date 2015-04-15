//
//  GlobalMethods.m
//  LearnToDrill
//
//  Created by saralsoft on 07/03/14.
//  Copyright (c) 2014 emedsim. All rights reserved.
//

#import "GlobalMethods.h"
#import <Security/Security.h>
#import "Reachability.h"
#import "LocalizationSystem.h"

static NSBundle *staticCustomBundle = nil;
static NSBundle *staticCacheBundle = nil;

@interface GlobalMethods ()

//@property (nonatomic, retain) id <GAITracker> tracker;

@end

@implementation GlobalMethods

//@synthesize tracker;

#pragma mark - Show Full Screen Background

+ (void)fullScreenBackground:(UIView *)backgroundView backgroundColor:(UIColor *)color {
    @try {
        if (color == nil) {
            color = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
        }
        GlobalModel *superModel = [[GlobalModel alloc] init];
        
        backgroundView.frame = CGRectMake(0, 0, superModel.deviceWidth, superModel.deviceHeight);
        backgroundView.backgroundColor = color;
        backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

#pragma mark - Get UIColor

+ (UIColor *)RGBColor:(NSMutableDictionary*)themeData ofObject:(NSString *)themeObject{
    @try {
        return [UIColor colorWithRed:[[[themeData objectForKey:themeObject] valueForKey:keyRed] floatValue]/255.0
                               green:[[[themeData objectForKey:themeObject] valueForKey:keyGreen]floatValue]/255.0
                                blue:[[[themeData objectForKey:themeObject] valueForKey:keyBlue]floatValue ]/255.0
                               alpha:[[[themeData objectForKey:themeObject] valueForKey:keyAlpha] floatValue]];
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

#pragma mark - Animate the View

+ (void)animateViewWithAlpha:(UIView *)view animationDuration:(double)duration{
    @try {
        [UIView transitionWithView:view
                          duration:duration
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{view.alpha = 1;}
                        completion:Nil];
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

#pragma mark - Get FilePath

+ (NSString *)getFilePathFromCompleteFileSystem:(NSString *)fileName {
    @try {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *filePath = [[NSString alloc] init];
        
        NSString *libraryDirectory = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)objectAtIndex:0];
        
        filePath = [libraryDirectory stringByAppendingPathComponent:fileName];
        
        if ([fileManager fileExistsAtPath:filePath]) { // Check in Library Directory
            return filePath;
        }
        else {
            NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES) objectAtIndex:0];
            filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
            
            if ([fileManager fileExistsAtPath:filePath]) { // Check in Document Directory
                return filePath;
            }
            else { // Check in Main Bundle
                filePath = [[NSBundle mainBundle] pathForResource:[[fileName lastPathComponent] stringByDeletingPathExtension]  ofType:[fileName pathExtension]];
                
                if ([fileManager fileExistsAtPath:filePath]) {
                    return filePath;
                }
                else {
                    return Nil;
                }
            }
        }
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

+ (NSString *)getFilePathFromFileSystemUsingFileName:(NSString *)strFileName strFolderNameOrPath:(NSString *)strFolderNameOrPath checkFileExistsIn:(CheckFileExistsIn)checkFileExistsIn {
    @try {
        NSString *strDirectory;
        
        NSMutableArray *arrFolderNamesWithFileName = [[NSMutableArray alloc] init];
        
        if (strFolderNameOrPath != Nil && ![strFolderNameOrPath isEqualToString:@""])
            arrFolderNamesWithFileName = [[strFolderNameOrPath componentsSeparatedByString:@"/"] mutableCopy];
        
        [arrFolderNamesWithFileName addObject:strFileName];
        
        switch (checkFileExistsIn) {
            case CheckFileExistsInDocumentDirectory:
            {
                strDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES) objectAtIndex:0];
                return [[self class] checkFileExistsUsingDriectory:strDirectory withArrFolderNamesAndFileName:arrFolderNamesWithFileName];
            }
                break;
            case CheckFileExistsInLibraryDirectory:
            {
                strDirectory = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                return [[self class] checkFileExistsUsingDriectory:strDirectory withArrFolderNamesAndFileName:arrFolderNamesWithFileName];
            }
                break;
            case CheckFileExistsInMainBundel:
            {
                strDirectory = [[NSBundle mainBundle] bundlePath];
                return [[self class] checkFileExistsUsingDriectory:strDirectory withArrFolderNamesAndFileName:arrFolderNamesWithFileName];
            }
                break;
            default:
            {
                NSString *strFilePath = @"";
                
                for (int i = 0; i < 3; i++) {
                    if (i == 0)
                        strFilePath = [[self class] getFilePathFromFileSystemUsingFileName:strFileName strFolderNameOrPath:strFolderNameOrPath checkFileExistsIn:CheckFileExistsInDocumentDirectory];
                    else if (i == 1)
                        strFilePath = [[self class] getFilePathFromFileSystemUsingFileName:strFileName strFolderNameOrPath:strFolderNameOrPath checkFileExistsIn:CheckFileExistsInLibraryDirectory];
                    else if (i == 2)
                        strFilePath = [[self class] getFilePathFromFileSystemUsingFileName:strFileName strFolderNameOrPath:strFolderNameOrPath checkFileExistsIn:CheckFileExistsInMainBundel];
                    
                    if (strFilePath != Nil && ![strFilePath isEqualToString:@""]) {
                        return strFilePath;
                    }
                }
                return Nil;
            }
                break;
        }
        
        return Nil;
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

+ (NSString *)checkFileExistsUsingDriectory:(NSString *)strDirectory withArrFolderNamesAndFileName:(NSArray *)withArrFolderNamesAndFileName {
    @try {
        BOOL isDir;
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *strFilePath = [[NSString alloc] init];
        
        for (int i = 0; i < [withArrFolderNamesAndFileName count]; i++) {
            if (i==0)
                strFilePath = [strDirectory stringByAppendingPathComponent:[withArrFolderNamesAndFileName objectAtIndex:i]];
            else
                strFilePath = [strFilePath stringByAppendingPathComponent:[withArrFolderNamesAndFileName objectAtIndex:i]];
            
            BOOL isPathExists = [fileManager fileExistsAtPath:strFilePath isDirectory:&isDir];
            
            if (isPathExists) {
                if (!isDir) {
                    return strFilePath;
                }
            }
            else {
                return Nil;
            }
        }
        return Nil;
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

#pragma mark - Add Skip Attribute to Not Sync Data on iTunes

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL {
    @try {
        NSError *error = nil;
        BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES] forKey: NSURLIsExcludedFromBackupKey error: &error];
        
        if (!success) {
            NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
        }
        return success;
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}


#pragma mark - Remove View From SuperView

+ (id)removeFromSuperView:(UIView *)view {
    @try {
        if (view != nil) {
            [view removeFromSuperview];
            view = nil;
        }
        return view;
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

#pragma mark - Load JSON Data From File Methods

+ (id)loadJSONDataFromFile:(NSString *)fileName {
    @try {
        NSString *filePath = [GlobalMethods getFilePathFromCompleteFileSystem:[NSString stringWithFormat:@"%@.json",fileName]];
        id elementData = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:kNilOptions error:nil];
        
        if ([elementData isKindOfClass:[NSMutableDictionary class]]) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            dict = [elementData copy];
            return dict;
        }
        else {
            NSArray *arr = [[NSArray alloc] init];
            arr = [elementData copy];
            return arr;
        }
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

- (id)loadJSONDataWithFilePath:(NSString *)withFilePath {
    @try {
        NSString *filePath = withFilePath;
        id elementData = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:kNilOptions error:nil];
        
        if ([elementData isKindOfClass:[NSMutableDictionary class]]) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            dict = [elementData copy];
            return dict;
        }
        else {
            NSArray *arr = [[NSArray alloc] init];
            arr = [elementData copy];
            return arr;
        }
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

#pragma mark - Create Bundle Methods

+ (NSBundle *)getStaticCustomBundle {
    @try {
        if (nil == staticCustomBundle) {
            [self createNewBundle];
        }
        return staticCustomBundle;
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

+ (void)createNewBundle {
    @try {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *libraryDirectory = [paths objectAtIndex:0]; // Get documents folder
        NSString *dataPath = [libraryDirectory stringByAppendingPathComponent:CUSTOM_BUNDLE_NAME]; // adapt this
        staticCustomBundle = [NSBundle bundleWithPath:dataPath];
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

+ (NSBundle *)getStaticCacheBundle {
    @try {
        if (nil == staticCacheBundle) {
            [self createNewCacheBundle];
        }
        return staticCacheBundle;
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

+ (void)createNewCacheBundle {
    @try {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *libraryDirectory = [paths objectAtIndex:0]; // Get documents folder
        NSString *dataPath = [libraryDirectory stringByAppendingPathComponent:cacheBundle]; // adapt this
        staticCacheBundle = [NSBundle bundleWithPath:dataPath];
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

#pragma mark - Google Analytics Methods

+ (NSString *)getLocalizedValueForKey:(NSString *)key {
    @try {
        GlobalModel *superModel = [[GlobalModel alloc] init];
        superModel.userDefaults = [NSUserDefaults standardUserDefaults];
        
        if ([superModel.userDefaults boolForKey:[@[[superModel.userDefaults objectForKey:keySelectedLanguageId], keyCheckForDownloadCourseContent] componentsJoinedByString:@""]]) {
            
            return [[[GlobalMethods getStaticCustomBundle] localizedStringForKey:key value:nil
                                                                           table:[DynamicCourseContentLocalizableFileName stringByDeletingPathExtension]] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        }
        else {
            return [AMLocalizedString(key, Nil) stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        }
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

//- (void)setInitialsOfGoogleTracking {
//    @try {
//        // Automatically send uncaught exceptions to Google Analytics.
//        [GAI sharedInstance].trackUncaughtExceptions = YES;
//        
//        // Set Google Analytics dispatch interval to e.g. 20 seconds.
//        [GAI sharedInstance].dispatchInterval = 20;
//        
//        // Optional: set Logger to VERBOSE for debug information.
//        [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelNone];
//        
////        self.tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-46624040-7"]; // Testing ID of google analytics tracking.
//        
////            self.tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-46624040-8"]; // Live ID
//    }
//    @catch (NSException *exception) {
//    }
//    @finally {
//    }
//}
//
//+ (void)GASendScreen:(NSString *)strScreenName{
//    @try {
//        GlobalModel *superModel = [[GlobalModel alloc] init];
//        superModel.userDefaults = [NSUserDefaults standardUserDefaults];
//        
//        if ([superModel.userDefaults objectForKey:keyUniqueDeviceIdentifierAsString]) {
////            [[GAI sharedInstance].defaultTracker set:[GAIFields customDimensionForIndex:1] value:[superModel.userDefaults objectForKey:keyUniqueDeviceIdentifierAsString]];
//        }
//        
//        if ([superModel.userDefaults objectForKey:keyStudentID] || [superModel.userDefaults objectForKey:keyCurrentCourseIdSelectedByUser]) {
////            [[GAI sharedInstance].defaultTracker set:[GAIFields customDimensionForIndex:2]
//                                               value:[@[[superModel.userDefaults objectForKey:keyStudentID],
//                                                        [superModel.userDefaults objectForKey:keyCurrentCourseIdSelectedByUser]]componentsJoinedByString:@"|"]];
//        }
//        
//        [[GAI sharedInstance].defaultTracker set:kGAIScreenName value:strScreenName];
//        [[GAI sharedInstance].defaultTracker send:[[GAIDictionaryBuilder createAppView] build]];
//    }
//    @catch (NSException *exception) {
//    }
//    @finally {
//    }
//}
//
//
//+ (void)GASendEventWithCategory:(NSString *)strCategory action:(NSString *)strAction label:(NSString *)strLabel value:(NSNumber *)Value{
//    @try {
//        GlobalModel *superModel = [[GlobalModel alloc] init];
//        
//        superModel.userDefaults = [NSUserDefaults standardUserDefaults];
//        
//        if ([superModel.userDefaults objectForKey:keyUniqueDeviceIdentifierAsString]) {
//            [[GAI sharedInstance].defaultTracker set:[GAIFields customDimensionForIndex:1] value:[superModel.userDefaults objectForKey:keyUniqueDeviceIdentifierAsString]];
//        }
//        
//        if ([superModel.userDefaults objectForKey:keyStudentID] || [superModel.userDefaults objectForKey:keyCurrentCourseIdSelectedByUser]) {
//            [[GAI sharedInstance].defaultTracker set:[GAIFields customDimensionForIndex:2]
//                                               value:[@[[superModel.userDefaults objectForKey:keyStudentID],
//                                                        [superModel.userDefaults objectForKey:keyCurrentCourseIdSelectedByUser]]componentsJoinedByString:@"|"]];
//        }
//        
//        [[GAI sharedInstance].defaultTracker send:[[GAIDictionaryBuilder createEventWithCategory:strCategory
//                                                                                          action:strAction
//                                                                                           label:strLabel
//                                                                                           value:Value] build]];
//    }
//    @catch (NSException *exception) {
//    }
//    @finally {
//    }
//}
//
//+ (void)GASendEcommerceProductWithName:(NSString *)strProductName price:(NSNumber *)Price productAction:(NSString *)IPproductAction transactionID:(NSString *)strTransactionID eventCategory:(NSString *)strCategory action:(NSString *)strAction label:(NSString *)strLabel value:(NSNumber *)Value {
//    @try {
//        GAIEcommerceProduct *product = [[GAIEcommerceProduct alloc] init];
//        [product setName:strProductName];
//        [product setPrice:Price];
//        
//        GAIEcommerceProductAction *productAction = [[GAIEcommerceProductAction alloc] init];
//        [productAction setAction:IPproductAction];
//        [productAction setTransactionId:strTransactionID];
//        
//        GlobalModel *superModel = [[GlobalModel alloc] init];
//        superModel.userDefaults = [NSUserDefaults standardUserDefaults];
//        
//        if ([superModel.userDefaults objectForKey:keyUniqueDeviceIdentifierAsString]) {
//            [[GAI sharedInstance].defaultTracker set:[GAIFields customDimensionForIndex:1] value:[superModel.userDefaults objectForKey:keyUniqueDeviceIdentifierAsString]];
//        }
//        
//        if ([superModel.userDefaults objectForKey:keyStudentID] || [superModel.userDefaults objectForKey:keyCurrentCourseIdSelectedByUser]) {
//            [[GAI sharedInstance].defaultTracker set:[GAIFields customDimensionForIndex:2]
//                                               value:[@[[superModel.userDefaults objectForKey:keyStudentID],
//                                                        [superModel.userDefaults objectForKey:keyCurrentCourseIdSelectedByUser]]componentsJoinedByString:@"|"]];
//        }
//        
//        GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createEventWithCategory:strCategory
//                                                                               action:strAction
//                                                                                label:strLabel
//                                                                                value:Value];
//        
//        // Add the transaction data to the event.
//        [builder setProductAction:productAction];
//        [builder addProduct:product];
//    }
//    @catch (NSException *exception) {
//    }
//    @finally {
//    }
//}

#pragma mark - KeyChain Methods

// Method to allocate and construct the dictionary, which defines the attributes of the keychain item we want to find, create, update or delete
+ (NSMutableDictionary *)newSearchDictionary:(NSString *)identifier {
    @try {
        NSMutableDictionary *searchDictionary = [[NSMutableDictionary alloc] init];
        
        [searchDictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
        
        NSData *encodedIdentifier = [identifier dataUsingEncoding:NSUTF8StringEncoding];
        [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrGeneric];
        [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrAccount];
        
        [searchDictionary setObject:[[NSBundle mainBundle] bundleIdentifier] forKey:(__bridge id)kSecAttrService];
        
        return searchDictionary;
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

+ (NSData *)searchKeychainCopyMatching:(NSString *)identifier {
    @try {
        NSMutableDictionary *searchDictionary = [self newSearchDictionary:identifier];
        
        // Add search attributes
        [searchDictionary setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
        
        // Add search return types
        [searchDictionary setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
        
        
        // Search.
        NSData *result = nil;
        CFTypeRef foundDict = NULL;
        OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)searchDictionary,&foundDict);
        
        if (status == noErr) {
            result = (__bridge_transfer NSData *)foundDict;
        } else {
            result = nil;
        }
        
        return result;
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

+ (BOOL)createKeychainValue:(NSString *)password forIdentifier:(NSString *)identifier {
    @try {
        NSMutableDictionary *dictionary = [self newSearchDictionary:identifier];
        
        NSData *passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
        [dictionary setObject:passwordData forKey:(__bridge id)kSecValueData];
        
        OSStatus status = SecItemAdd((__bridge CFDictionaryRef)dictionary, NULL);
        
        if (status == errSecSuccess) {
            return YES;
        }
        return NO;
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

+ (BOOL)updateKeychainValue:(NSString *)password forIdentifier:(NSString *)identifier {
    @try {
        NSMutableDictionary *searchDictionary = [self newSearchDictionary:identifier];
        NSMutableDictionary *updateDictionary = [[NSMutableDictionary alloc] init];
        NSData *passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
        [updateDictionary setObject:passwordData forKey:(__bridge id)kSecValueData];
        
        OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)searchDictionary,
                                        (__bridge CFDictionaryRef)updateDictionary);
        
        if (status == errSecSuccess) {
            return YES;
        }
        return NO;
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

#pragma mark - Invalidate Timer

+ (NSTimer *)invalidateTimer:(id)timer{
    @try {
        if ([timer isValid]) {
            [timer invalidate];
            timer = nil;
        }
        return timer;
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

#pragma mark - Get Language ID

+ (NSString *)getLangID:(NSInteger)index {
    @try {
        switch (index) {
            case 0:
                return @"en"; //English
                break;
                //        case 1:
                //            return @"es"; //Spanish
                //            break;
                //        case 2:
                //            return @"pl"; //Polish
                //            break;
                //        case 3:
                //            return @"pt"; //Protuguese
                //            break;
            default:
                return @"en";
                break;
                
        }
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

#pragma mark - Left Side Menu Setting

//+ (MFSideMenuContainerViewController *)getMFSideMenuContainerViewControllerInitializeBy:(UIViewController *)objVC {
//    @try {
//        LeftMenuViewController *leftMenuViewController = [[LeftMenuViewController alloc] init];
//        
//        MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController containerWithCenterViewController:objVC leftMenuViewController:leftMenuViewController rightMenuViewController:nil];
//        
//        return container;
//    }
//    @catch (NSException *exception) {
//        NSLog(@"NSException: %@", [exception reason]);
//    }
//    @finally {
//    }
//}

#pragma mark - Aadd Constraints To View

+ (void)addConstarintsToView:(UIView *)subView superView:(UIView *)superView top:(int)top bottom:(int)bottom left:(int)left right:(int)right {
    @try {
        // Center them all horizontally
        [subView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTop multiplier:1.0 constant:top]];
        
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:bottom]];
        
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:left]];
        
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:right]];
    }
    @catch (NSException *exception) {
        NSLog(@"NSException: %@", [exception reason]);
    }
    @finally {
    }
}

#pragma mark - Check Internet Connection Available

+ (BOOL)isInternetConnectionAvailable {
    @try {
        Reachability *reachablity = [Reachability reachabilityForInternetConnection];
        NetworkStatus status = [reachablity currentReachabilityStatus];
        
        if (status == kNotReachable) {
            return NO;
        }
        else if (status == kReachableViaWiFi) {
            return YES;
        }
        else if (status == kReachableViaWWAN) {
            return YES;
        }
        
        return YES;
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, (CGRect){.size = size});
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [GlobalMethods imageWithColor:color size:CGSizeMake(1, 1)];
}

@end