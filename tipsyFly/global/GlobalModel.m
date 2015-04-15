//
//  GlobalModel.m
//  LearnToDrill
//
//  Created by saralsoft on 07/03/14.
//  Copyright (c) 2014 emedsim. All rights reserved.
//

#import "GlobalModel.h"

@implementation GlobalModel

@synthesize deviceHeight;
@synthesize deviceWidth;
@synthesize userDefaults;

- (id)init {
    self = [super init];
    if (self) {
        [self setDeviceSize];
    }
    return self;
}

+ (BOOL)isDeviceIpad {
    @try {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            return YES;
        else
            return NO;
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

+ (BOOL)isDeviceOrientationLandscape {
    @try {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        
        if (orientation == UIDeviceOrientationFaceUp | orientation == UIDeviceOrientationFaceDown) {
            UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
            
            if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
                return YES;
            }
            else {
                return NO;
            }
        }
        else if (UIDeviceOrientationIsLandscape(orientation)){
            return YES;
            
        }
        else {
            return NO;
        }
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

- (void)setDeviceSize {
    @try {
        deviceWidth = [[UIScreen mainScreen] bounds].size.width;
        deviceHeight = [[UIScreen mainScreen] bounds].size.height;
        
        if ([[self class] isDeviceOrientationLandscape]) {
            if (deviceWidth > deviceHeight) {
            
            }
            else {
                int temp = deviceWidth;
                deviceWidth = deviceHeight;
                deviceHeight = temp;
            }
        }
        else {
            if (deviceHeight > deviceWidth) {
                
            }
            else {
                int temp = deviceWidth;
                deviceWidth = deviceHeight;
                deviceHeight = temp;
            }
        }
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

@end
