//
//  AppDelegate.h
//  qdrj
//
//  Created by Yu Qi Hao on 12/8/14.
//  Copyright (c) 2014 Yu Qi Hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBAPI.h"

#define HEXCOLOR(c) [UIColor colorWithRed:((c>>24)&0xFF)/255.0 \


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) DBAPI *db;

@property (strong, nonatomic) UIWindow *window;


@end

@interface UIImage (Resize)
- (UIImage*)scaleToSize:(CGSize)size;
@end

// Put this in UIImageResizing.m
@implementation UIImage (Resizing)

- (UIImage*)scaleToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.CGImage);
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end
