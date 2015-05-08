//
//  issuesParser.m
//  tipsyFly
//
//  Created by Mitesh Maheta on 23/04/15.
//  Copyright (c) 2015 tipsy. All rights reserved.
//

#import "issuesParser.h"
#import "GlobalMethods.h"
#import "horizontalViewController.h"
#import "verticalViewController.h"
#import "BaseContentViewController.h"

#define keypages @"pages"
#define keytype @"type"
#define keyhorizontal @"horizontal"
#define keyvertical @"vertical"
#define keysubPages @"subPages"
#define keyelements @"elements"
#define keycollectionID @"collectionID"
#define keyproducts @"products"

//Element Type
#define keyimage @"image"
#define keylabel @"label"
#define keybtnMoveToCollection @"btnMoveToCollection"
#define keybtnMoveToProduct @"btnMoveToProduct"
#define keyimageSlideShow @"imageSlideShow"
#define keybtnShowAllProduct @"btnShowAllProduct"

//Element options
#define keyid @"id"
#define keyparts @"parts"
#define keytext @"text"
#define keyfontSize @"fontSize"
#define keyfontStyle @"fontStyle"
#define keytitle @"title"
#define keyprice @"price"

#define keybold @"bold"
#define keyitalic @"italic"

@interface issuesParser(){
    
    NSMutableArray *issuePageData;
    
    UIViewController *parentController;

    BOOL isHorizontalController;
    
}

@end
@implementation issuesParser

-(instancetype)init{
    
    self = [super init];
    if (self) {
    
        [self loadIssuesData];
        
    }
    return self;
}
-(void)loadIssuesData{
    issuePageData = [[NSMutableArray alloc]init];
    issuePageData = [[GlobalMethods loadJSONDataFromFile:@"issue1"] objectForKey:keypages];
}
-(UIViewController *)buildPages{
    
    if ([[[[issuePageData objectAtIndex:0] objectForKey:keytype] lowercaseString] isEqualToString:[keyhorizontal lowercaseString]]) {
        
        isHorizontalController = YES;
        parentController = [[horizontalViewController alloc]init];
        
    }else if ([[[[issuePageData objectAtIndex:0] objectForKey:keytype] lowercaseString] isEqualToString:[keyvertical lowercaseString]]){
        
        isHorizontalController = NO;
        parentController = [[verticalViewController alloc]init];
        
    }
    
    [self addPagesData:[[issuePageData objectAtIndex:0] objectForKey:keysubPages] toParentController:parentController isHorizontal:isHorizontalController];
    
    return parentController;
    
}

-(void)addPagesData:(NSMutableArray *)arrayPageData toParentController:(UIViewController *)parentViewController isHorizontal:(BOOL)isHorizontal{
    UIViewController *viewController = Nil;

    for (int i=0; i < [arrayPageData count]; i++) {
        if ([[arrayPageData objectAtIndex:i] objectForKey:keytype]) {
            
            if ([[[[arrayPageData objectAtIndex:i] objectForKey:keytype] lowercaseString] isEqualToString:[keyhorizontal lowercaseString]]) {
                
                viewController = [[horizontalViewController alloc]init];
                [self addPagesData:[[arrayPageData objectAtIndex:i] objectForKey:keysubPages] toParentController:viewController isHorizontal:YES];
                
            }else if ([[[[arrayPageData objectAtIndex:i] objectForKey:keytype] lowercaseString] isEqualToString:[keyvertical lowercaseString]]){
                
                viewController = [[verticalViewController alloc]init];
                [self addPagesData:[[arrayPageData objectAtIndex:i] objectForKey:keysubPages] toParentController:viewController isHorizontal:NO];
            }
        }else{
            viewController = [[BaseContentViewController alloc]init];
            [self loadElementWithData:[[arrayPageData objectAtIndex:i] objectForKey:keyelements] toController:(BaseContentViewController *)viewController];
        }
        
        float randomRed = arc4random() % 255;
        float randomGreen = arc4random() % 255;
        float randomBlue = arc4random() % 255;
        
        viewController.view.backgroundColor = [UIColor colorWithRed:randomRed/255.0 green:randomGreen/255.0 blue:randomBlue/255.0 alpha:1.0];
        if (isHorizontal) {
            [((horizontalViewController *)parentViewController).arrayViewControllers addObject:viewController];
        }else{
            [((verticalViewController *)parentViewController).arrayViewControllers addObject:viewController];
        }
    }
}
-(void)loadElementWithData:(NSMutableArray *)elementData toController:(BaseContentViewController *)viewController{
    @try {
        for (int i=0; i < [elementData count]; i++) {
            
            if ([[[elementData objectAtIndex:i] objectForKey:keytype] isEqualToString:keyimage]) {
                
                UIImageView *image = [[UIImageView alloc]init];
                image.tag = [[[elementData objectAtIndex:i] objectForKey:keyid] integerValue];
                [viewController.view addSubview:image];
                [viewController.arrayElements addObject:image];
                
                [self setFrameOfElement:image elementData:elementData currentIndex:i ofViewController:viewController];
                
                [image setImage:[UIImage imageNamed:[[elementData objectAtIndex:i] objectForKey:keyImageName]]];
                
            }else if ([[[elementData objectAtIndex:i] objectForKey:keytype] isEqualToString:keylabel]){
                
                UILabel *label = [[UILabel alloc]init];
                label.tag = [[[elementData objectAtIndex:i] objectForKey:keyid] integerValue];
                [viewController.view addSubview:label];
                [viewController.arrayElements addObject:label];
                [self setFrameOfElement:label elementData:elementData currentIndex:i ofViewController:viewController];
                [self setLabelStyle:label elementData:elementData currentIndex:i];
                
                label.text = [[elementData objectAtIndex:i] objectForKey:keytext];
                [label sizeToFit];
            }
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"NSException issueParser loadElementWithData: %@", [exception reason]);
    }
    @finally {
        
    }
    
}

-(void)setFrameOfElement:(id)element elementData:(id)elementData currentIndex:(int)index ofViewController:(BaseContentViewController *)viewController{
    @try {
        CGFloat X,Y,Width,Height;
        
        if ([[[elementData objectAtIndex:index] objectForKey:keyX] containsString:@"%"]) {
            
            X = ([(id)element superview].frame.size.width - [[[elementData objectAtIndex:index] objectForKey:keyWidth] floatValue]) / 2;
            
        }else if ([[[elementData objectAtIndex:index] objectForKey:keyX] containsString:@"+"]){
            
            if (index > 0) {
        
                id prevElement = [viewController.view viewWithTag:[[[elementData objectAtIndex:index - 1] objectForKey:keyid] integerValue]];
                X = [(id)prevElement frame].origin.x + [(id)prevElement frame].size.width + [[[elementData objectAtIndex:index] objectForKey:keyX] floatValue];
                
            }else{
                
                X = [[[elementData objectAtIndex:index] objectForKey:keyX] floatValue];
            }
        }else{
            X = [[[elementData objectAtIndex:index] objectForKey:keyX] floatValue];
        }
        
        if ([[[elementData objectAtIndex:index] objectForKey:keyY] containsString:@"%"]) {
            
            Y = ([(id)element superview].frame.size.height * [[[elementData objectAtIndex:index] objectForKey:keyY] floatValue]) / 100;
            
        }else if ([[[elementData objectAtIndex:index] objectForKey:keyY] containsString:@"+"]){
            
            if (index > 0) {
                id prevElement = [viewController.view viewWithTag:[[[elementData objectAtIndex:index - 1] objectForKey:keyid] integerValue]];
                Y = [(id)prevElement frame].origin.y + [(id)prevElement frame].size.height + [[[elementData objectAtIndex:index] objectForKey:keyY] floatValue];
                
            }else{
                
                Y = [[[elementData objectAtIndex:index] objectForKey:keyY] floatValue];
            }
        }else if ([[[elementData objectAtIndex:index] objectForKey:keyY] containsString:@"-"]){
            Y = [(id)element superview].frame.size.height - [[[elementData objectAtIndex:index] objectForKey:keyHeight] floatValue] - [[[elementData objectAtIndex:index] objectForKey:keyY] floatValue];
        }else{
            Y = [[[elementData objectAtIndex:index] objectForKey:keyY] floatValue];
        }
        
        if ([[[elementData objectAtIndex:index] objectForKey:keyWidth] containsString:@"%"]) {
            
            Width = ([(id)element superview].frame.size.width * [[[elementData objectAtIndex:index] objectForKey:keyWidth] floatValue]) / 100;
            if (Width == [(id)element superview].frame.size.width && X > 0) {
                Width -= X;
            }
            
        }else{
            
            Width = [[[elementData objectAtIndex:index] objectForKey:keyWidth] floatValue];
        }
        
        if ([[[elementData objectAtIndex:index] objectForKey:keyHeight] containsString:@"%"]) {
            
            Height = ([(id)element superview].frame.size.height * [[[elementData objectAtIndex:index] objectForKey:keyHeight] floatValue]) / 100;
            
        }else{
            
            Height = [[[elementData objectAtIndex:index] objectForKey:keyHeight] floatValue];
        }
        
        [(id)element setFrame:CGRectMake(X, Y, Width, Height)];
    }
    @catch (NSException *exception) {
        NSLog(@"NSException issueParser setFrameOfElement:(id)element elementData:... %@", [exception reason]);
    }
    @finally {
        
    }
    
}

-(void)setLabelStyle:(UILabel *)label elementData:(id)elementData currentIndex:(int)index{
    
    label.numberOfLines =0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    if ([[elementData objectAtIndex:index] objectForKey:keyfontSize]) {
        if ([[[elementData objectAtIndex:index] objectForKey:keyfontStyle] isEqualToString:keybold]) {
            label.font = [UIFont boldSystemFontOfSize:[[[elementData objectAtIndex:index] objectForKey:keyfontSize] floatValue]];
        }else if ([[[elementData objectAtIndex:index] objectForKey:keyfontStyle] isEqualToString:keyitalic]){
            label.font = [UIFont italicSystemFontOfSize:[[[elementData objectAtIndex:index] objectForKey:keyfontSize] floatValue]];
        }else{
            label.font = [UIFont systemFontOfSize:[[[elementData objectAtIndex:index] objectForKey:keyfontSize] floatValue]];
        }
        
    }
}
@end
