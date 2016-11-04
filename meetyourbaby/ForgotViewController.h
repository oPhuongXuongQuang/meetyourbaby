//
//  ForgotViewController.h
//  meetyourbaby
//
//  Created by Quang Phuong on 11/3/16.
//  Copyright © 2016 QP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
#import "Ultility.h"

@class ForgotViewController;
@protocol ForgotViewControllerDelegate

- (void)listCountry:(NSDictionary *)countries;

@end

@interface ForgotViewController : UIViewController<NIDropDownDelegate, UITextFieldDelegate>

@end
