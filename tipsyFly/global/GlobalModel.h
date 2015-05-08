//
//  GlobalModel.h
//  LearnToDrill
//
//  Created by saralsoft on 07/03/14.
//  Copyright (c) 2014 emedsim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//App Related Key & Value
#define keyAppVersion @"AppVersion"
#define keyAppBuild @"AppBuild"
#define keyAppBuildName @"AppBuildName"

#define defaultLanguage @"en"
#define keySelectedLanguageId @"selectedLanguageId"
#define keyCheckForDownloadCourseContent @"CheckForDownloadCourseContent"
#define DynamicCourseContentLocalizableFileName @"Localizable.strings"
#define keyUniqueDeviceIdentifierAsString @"uniqueDeviceIdentifier"

#define keyElementSizeAndPositionJSON (IS_IPAD ? @"elementSizeAndPositionIpad": @"elementSizeAndPosition")
#define keyReferralDetailsJSON @"referralDetails"

//Global Key
#define keyGlobalThemeJSON @"globalTheme"
#define keySupportedLanguagesJSON @"supportedLanguages"

#define keyRed @"red"
#define keyGreen @"green"
#define keyBlue @"blue"
#define keyAlpha @"alpha"

#define keyX @"x"
#define keyY @"y"
#define keyWidth @"width"
#define keyHeight @"height"

#define keyLX @"lx"
#define keyLY @"ly"
#define keyLWidth @"lwidth"
#define keyLHeight @"lheight"

#define keyFontName @"fontName"
#define keyFontNameBold @"fontNameBold"

#define keyFontExtraSmallSize (IS_IPAD ? @"fontExtraSmallSize" : @"fontExtraExtraSmallSize")
#define keyFontMediumSmallSize (IS_IPAD ? @"fontMediumSmallSize" : @"fontExtraSmallSize")
#define keyFontSmallSize (IS_IPAD ? @"fontSmallSize" : @"fontMediumSmallSize")
#define keyFontMediumSize (IS_IPAD ? @"fontMediumSize" : @"fontSmallSize")
#define keyFontLargeSize (IS_IPAD ? @"fontLargeSize" : @"fontMediumSize")
#define keyFontExtraLargeSize (IS_IPAD ? @"fontExtraLargeSize" : @"fontLargeSize")

#define themeStageBackgroundColor @"stageBackgroundColor"
#define themeElementBackgroundColor @"elementBackgroundColor"
#define themeElementForegroundColor @"elementForegroundColor"
#define themeContentTextColor @"contentTextColor"
#define themeGrayElementBackgroundColor @"grayElementBackgroundColor"
#define themeBlueActiveElementColor @"blueActiveElementColor"
#define themeOrangeElementBackgroundColor @"orangeElementBackgroundColor"
#define themeElementCornerRadius @"elementCornerRadius"

#define keyImageName (IS_IPAD ? @"ipadImageName": @"imageName")

typedef enum CheckFileExistsIn {
    CheckFileExistsInDocumentDirectory,
    CheckFileExistsInLibraryDirectory,
    CheckFileExistsInMainBundel,
    CheckFileExistsInAll
} CheckFileExistsIn;

@interface GlobalModel : NSObject

@property (nonatomic) float deviceHeight;
@property (nonatomic) float deviceWidth;
@property (assign,nonatomic) NSUserDefaults *userDefaults;

+ (BOOL)isDeviceIpad; // Direct returns value about Device.
+ (BOOL)isDeviceOrientationLandscape; // Return YES if device Orientation is Landscpae otherwise NO.
- (void)setDeviceSize; // Sets device's height and width

@end