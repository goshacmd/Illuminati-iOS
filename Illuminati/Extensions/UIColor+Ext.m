//
//  UIColor+Ext.m
//  Illuminati
//
//  Created by Gosha Arinich on 7/16/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Ext.h"

@implementation UIColor (Ext)

- (UIColor *)oppositeBWColor {
    CGFloat white;
    
    [self getWhite:&white alpha:nil];
    
    if (white >= 0.6f) {
        return UIColor.blackColor;
    } else {
        return UIColor.whiteColor;
    }
}

@end