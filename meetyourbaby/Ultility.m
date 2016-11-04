//
//  Ultility.m
//  meetyourbaby
//
//  Created by Quang Phuong on 11/3/16.
//  Copyright © 2016 QP. All rights reserved.
//

#import "Ultility.h"

@implementation Ultility

- (UIView*)createViewWithFrame:(CGRect)frame {
    UIView *view = [[UIView alloc]initWithFrame:frame];
    
    [view setBackgroundColor: [UIColor whiteColor]];
    
    // border radius
    [view.layer setCornerRadius:7.0f];
    
    // border
    [view.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [view.layer setBorderWidth:0.5f];
    
    // drop shadow
    [view.layer setShadowColor:[UIColor blackColor].CGColor];
    [view.layer setShadowOpacity:0.5];
    [view.layer setShadowRadius:4.0];
    [view.layer setShadowOffset:CGSizeMake(2.5, 2.5)];
    return view;
}

- (void)addText:(NSString *)text toLayout:(UIView *)layout withTextColor:(UIColor *)color {
    CGRect frame = layout.frame;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [label setFont:[UIFont systemFontOfSize:13]];
    [label setText:text];
    [label setTextColor:color];
    
    [label sizeToFit];
    [label layoutIfNeeded];
    label.center = CGPointMake(layout.frame.size.width/2, frame.size.height / 2);
    [layout addSubview:label];
}

- (UIColor *)colorWithHexString:(NSString *)str {
    const char *cStr = [str cStringUsingEncoding:NSASCIIStringEncoding];
    long x = strtol(cStr+1, NULL, 16);
    return [self colorWithHex:x];
}

- (UIColor *)colorWithHex:(UInt32)col {
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1];
}

- (NSDictionary *)createCountryDictionary {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"54" forKey:@"Argentina"];
    [dic setObject:@"374" forKey:@"Armenia"];
    [dic setObject:@"61" forKey:@"Australia"];
    [dic setObject:@"86" forKey:@"China"];
    [dic setObject:@"91" forKey:@"India"];
    [dic setObject:@"1" forKey:@"United States"];
    
    return [dic mutableCopy];
}

- (UIColor *)blueTintColor {
    return [self colorWithHexString:@"#47C2E6"];
}

- (UIImage *)fixImageWithImageNamed: (NSString *)imageName withRect:(CGRect)rect withTintColor:(UIColor *)color {
    UIImage *image = [UIImage imageNamed:imageName];
    
    if (color != nil) {
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextClipToMask(context, rect, image.CGImage);
        
        CGContextSetFillColorWithColor(context, [color CGColor]);
        
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                    scale:1.0 orientation: UIImageOrientationDownMirrored];
        return flippedImage;
    } else {
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
        [image drawInRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return [UIImage imageWithCGImage:img.CGImage
                                   scale:1.0 orientation: UIImageOrientationUp];
    }
    
    
}

- (UIImage *)fixImageWithImage: (UIImage *)image withRect:(CGRect)rect withTintColor:(UIColor *)color {
    if (color != nil) {
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextClipToMask(context, rect, image.CGImage);
        
        CGContextSetFillColorWithColor(context, [color CGColor]);
        
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                    scale:1.0 orientation: UIImageOrientationDownMirrored];
        return flippedImage;
    } else {
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
        [image drawInRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return [UIImage imageWithCGImage:img.CGImage
                                   scale:1.0 orientation: UIImageOrientationUp];
    }
    
}

- (void)showDatePickerWithTitle:(NSString *)title onTextField:(UITextField *)textfield {
    LSLDatePickerDialog *dpDialog = [[LSLDatePickerDialog alloc] init];
    [dpDialog showWithTitle:title doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel"
                defaultDate:[NSDate date] minimumDate:nil maximumDate:nil datePickerMode:UIDatePickerModeDate
                   callback:^(NSDate * _Nullable date){
                       if(date)
                       {
                           NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                           [formatter setDateFormat:@"dd/MM/YYYY"];
                           [textfield setText: [formatter stringFromDate:date]];
                       }
                   }
     ];
    dpDialog= nil;
}

@end
