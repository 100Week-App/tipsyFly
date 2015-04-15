//
//  GlobalModel.h
//  LearnToDrill
//
//  Created by saralsoft on 07/03/14.
//  Copyright (c) 2014 emedsim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//App Related Key & Value
#define keyAppVersion @"AppVersion"
#define keyAppBuild @"AppBuild"
#define keyAppBuildName @"AppBuildName"
#define keyAppEnteredInBackgroundCount @"appEnteredInBackgroundCount"

#define defaultLanguage @"en"
#define keyCheckFreshRun @"checkFreshRun"
#define keyLastUpdatedOn @"lastUpdatedOn"
#define keySelectedLanguageId @"selectedLanguageId"
#define keyCheckForDownloadCourseContent @"CheckForDownloadCourseContent"
#define DynamicCourseContentLocalizableFileName @"Localizable.strings"
#define keyUniqueDeviceIdentifierAsString @"uniqueDeviceIdentifier"
#define keyUniqueDeviceIdentifierWithStudentAndCurrentCourseIdAsString @"uniqueDeviceIdentifierWithStudentAndCurrentCourseID"

//Global Values
#define viewAnimationDuration 0.5
#define ValueOfItunesAppUrl @"https://itunes.apple.com/app/id941703128"
#define CourseJsonFileName @"Manifest.json"
#define QuizCategoriesJsonFileName @"Quiz_Categories.json"

//Left Side Menu Width
#define CENTER_VIEW_CONTROLLER_VISIBLE_AREA_IN_IPAD_perctent 0.60
#define CENTER_VIEW_CONTROLLER_VISIBLE_AREA_IN_IPHONE_px 50

#define keyElementSizeAndPositionJSON (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad? @"elementSizeAndPositionIpad": @"elementSizeAndPosition")
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

#define keyViewWithWhiteBackground @"viewWithWhiteBackground"

#define keyFontName @"fontName"
#define keyFontNameBold @"fontNameBold"

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
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

#define keyLblInternetFailed @"lblInternetFailed"
#define keyImageName (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad? @"ipadImageName": @"imageName")
#define keylblNavigationHeading @"lblNavigationHeading"

//Partner Selection Keys
#define keyStudentID @"studentID"

//Universal Key
#define keyLblClose @"lblClose"
#define keyLblContinue @"lblContinue"
#define keyLblWarning @"lblWarning"
#define keyLblError @"lblError"
#define keyLblDone @"lblDone"
#define keyLblCancel @"lblCancel"

//REMINDERS PAGE KEY
#define keyLblSetReminder @"lblSetReminder"
#define keyLblEditReminder @"lblEditReminder"

//Course Related Key
#define keyCurrentCourseIdSelectedByUser @"currentCourseIdSelectedByUser"
#define keyCurrentCourseNameSelectedByUser @"currentCourseNameSelectedByUser"
#define keyID @"id"
#define keyName @"name"
#define keySmallIcon @"smallIcon"
#define keyBigIcon @"bigIcon"
#define keySection @"section"
#define keyChapter @"chapter"
#define keySectionColor @"sectionColor"
#define keyVideoFileName @"videoFileName"
#define keyQuizFileName @"quizFileName"

//Background Download
#define keyIsToDownloadAllVideo @"isToDownloadAllVideo"
#define NotificationBackgroundDownloadFileDidFinish @"backgroundDownloadFileDidFinish"
#define NotificationBackgroundUpdateDownloadProgress @"backgroundUpdateDownloadProgress"
#define NotificationBackgroundErrorWhileDownloadingFile @"backgroundErrorWhileDownloadingFile"

//
#define keyTotalBadgeCount @"totalBadgeCount"
#define NotificationTriggeredRefreshAllBadges @"triggeredRefreshAllBadges"
#define keyMyCourseRefreshBadgeCount @"myCourseRefreshBadgeCount"
#define NotificationRefreshBadgesOnCellTap @"refreshBadgesOnCellTap"

//Diaply Get Started
#define keyIsToDisplayGetStartedViewFirst @"isToDisplayGetStartedViewFirst"

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