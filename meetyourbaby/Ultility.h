//
//  Ultility.h
//  meetyourbaby
//
//  Created by Quang Phuong on 11/3/16.
//  Copyright © 2016 QP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LSLDatePickerDialog.h"

@interface Ultility : NSObject

- (UIView*)createViewWithFrame:(CGRect)frame;

- (void)addText:(NSString *)text toLayout:(UIView *)layout withTextColor:(UIColor *)color;

- (UIColor *)colorWithHexString:(NSString *)str;

- (UIColor *)colorWithHex:(UInt32)col;

- (NSDictionary* )createCountryDictionary;

- (UIColor *)blueTintColor;

- (UIImage *)fixImageWithImageNamed: (NSString *)imageName withRect:(CGRect)rect withTintColor:(UIColor *)color;

- (UIImage *)fixImageWithImage: (UIImage *)image withRect:(CGRect)rect withTintColor:(UIColor *)color;

- (void)showDatePickerWithTitle:(NSString *)title onTextField:(UITextField *)textfield;

@end
