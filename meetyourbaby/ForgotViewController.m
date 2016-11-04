//
//  ForgotViewController.m
//  meetyourbaby
//
//  Created by Quang Phuong on 11/3/16.
//  Copyright © 2016 QP. All rights reserved.
//

#import "ForgotViewController.h"
#import "OTPConfirmViewController.h"

@interface ForgotViewController ()

@property NSDictionary *countryDictionary;
@property UIColor *tintColor;
@property UIView *forgotView;
@property UILabel *phoneCodeLabel;
@property UILabel *countryLabel;
@property UIImageView *appLogo;
@property UIButton *countrySelect;
@property UITextField *phoneNUmber;
@property UITextField *password;
@property NIDropDown *dropDown;
@property UILabel *phoneErrorLabel;
@property UILabel *passwordErrorLabel;
@property UIView *verticalSeparator;
@property UILabel *passwordLabel;
@property UILabel *forgotLabel;
@property Ultility *utility;

@end

@implementation ForgotViewController {
}

@synthesize utility;

#pragma mark - UIView delegate
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    utility = [Ultility new];
    _tintColor = [utility colorWithHexString:@"#47C2E6"];
    self.countryDictionary = [utility createCountryDictionary];
    [self initBackground];
    [self initLogo];
    [self initForgotView];
    [self initButtons];
    [self initSeperators];
    [self initLabel];
    [self initInputs];
    [self initSelect];
    [self initErrorLabel];
    [self initDownArrow];
    [self initBackButton];
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED {
    return UIInterfaceOrientationMaskPortrait;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Init Layout
- (void)initBackground {
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"newBG.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
}

- (void)initLogo {
    CGRect bounds = self.view.bounds;
    UIImage *image = [UIImage imageNamed:@"appLogo.png"];
    CGSize newSize = CGSizeMake(bounds.size.width*0.55, bounds.size.height*0.12);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.appLogo = [[UIImageView alloc] initWithImage:newImage];
    self.appLogo.center = CGPointMake(CGRectGetMidX(bounds), bounds.size.height * 0.28);
    [self.view addSubview:self.appLogo];
}

- (void)initForgotView {
    CGRect bounds = self.view.bounds;
    
    self.forgotView = [utility createViewWithFrame:CGRectMake(bounds.size.width * 0.075, bounds.size.height * 0.48, bounds.size.width * 0.85, bounds.size.height * 0.153)];
    [self.view addSubview:self.forgotView];
}

- (void)initSeperators {
    CGSize forgotSize = self.forgotView.frame.size;
    UIColor *separatorClolor = [UIColor colorWithWhite:0.8 alpha:0.9];
    
    UIView *separator1 = [[UIView alloc] initWithFrame:CGRectMake(0, forgotSize.height /2, forgotSize.width, 0.5)];
    separator1.backgroundColor = separatorClolor;
    
    self.verticalSeparator = [[UIView alloc] initWithFrame:CGRectMake(forgotSize.width/3, forgotSize.height/2, 0.5, forgotSize.height/2)];
    _verticalSeparator.backgroundColor = separatorClolor;
    
    [self.forgotView addSubview:separator1];
    [self.forgotView addSubview:self.verticalSeparator];
}

- (void)initLabel {
    CGSize loginSize = self.forgotView.frame.size;
    
    self.phoneCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, loginSize.height/2 + [self marginValueY], 10, 10)];
    [_phoneCodeLabel setText:@"+61"];
    [_phoneCodeLabel setTextColor:self.tintColor];
    [_phoneCodeLabel setFont:[UIFont systemFontOfSize:13]];
    [_phoneCodeLabel sizeToFit];
    [_phoneCodeLabel layoutIfNeeded];
    [self.forgotView addSubview:self.phoneCodeLabel];
    
    self.countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, [self marginValueY], 10, 10)];
    [_countryLabel setText:@"Country: Australia"];
    [_countryLabel setTextColor:self.tintColor];
    [_countryLabel setFont:[UIFont systemFontOfSize:13]];
    [_countryLabel sizeToFit];
    [_countryLabel layoutIfNeeded];
    [self.forgotView addSubview:self.countryLabel];
}

- (void)initButtons {
    CGRect bounds = self.view.bounds;
    // Submit button
    CGRect submitFrame = CGRectMake(bounds.size.width * 0.075, bounds.size.height * 0.67, bounds.size.width * 0.85, bounds.size.height * 0.07);
    UIView *submitLayout = [utility createViewWithFrame:submitFrame];
    [utility addText:@"SUBMIT" toLayout:submitLayout withTextColor:[utility blueTintColor]];
    [self.view addSubview:submitLayout];
    UITapGestureRecognizer *submitTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(submitAction:)];
    [submitLayout addGestureRecognizer:submitTap];
    submitLayout.layer.zPosition = 1;
    
}

- (void)initInputs {
    CGSize loginSize = self.forgotView.frame.size;
    UIColor *placeholderColor = [utility colorWithHexString:@"#B6E0ED"];
    
    self.phoneNUmber = [[UITextField alloc] initWithFrame:CGRectMake(loginSize.width /3 + 20, loginSize.height/2 + [self marginValueY]/2, loginSize.width /3*2 - 30, loginSize.height /3)];
    [self.phoneNUmber setFont:[UIFont systemFontOfSize:13]];
    [self.phoneNUmber setKeyboardType:UIKeyboardTypePhonePad];
    self.phoneNUmber.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Mobile number" attributes:@{NSForegroundColorAttributeName: placeholderColor}];
    [self.forgotView addSubview:self.phoneNUmber];
    self.phoneNUmber.tag = 0;
    self.phoneNUmber.delegate = self;
}

- (void)initSelect {
    CGRect loginRect = self.forgotView.frame;
    self.countrySelect = [[UIButton alloc] initWithFrame:CGRectMake(loginRect.origin.x, loginRect.origin.y, loginRect.size.width, loginRect.size.height /3)];
    [self.view addSubview:self.countrySelect];
    self.countrySelect.layer.zPosition = -1;
    [self.countrySelect addTarget:self action:@selector(countrySelect:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initErrorLabel {
    CGSize loginViewSize = self.forgotView.frame.size;
    _phoneErrorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, loginViewSize.height /2, loginViewSize.width, loginViewSize.height/2)];
    
    [_phoneErrorLabel setTextAlignment:NSTextAlignmentRight];
    [_phoneErrorLabel setTextColor:[UIColor redColor]];
    [_phoneErrorLabel setText:@"Minimum 10 Number"];
    [_phoneErrorLabel setFont:[UIFont systemFontOfSize:9]];
    
    [_phoneErrorLabel sizeToFit];
    CGRect phoneFrame = _phoneErrorLabel.frame;
    phoneFrame.origin.x = loginViewSize.width - _phoneErrorLabel.frame.size.width;
    _phoneErrorLabel.frame = phoneFrame;
    
    [self.forgotView addSubview:self.phoneErrorLabel];
    
    [_phoneErrorLabel setHidden:YES];
}

- (void)initDownArrow {
    UIImage *image = [UIImage imageNamed:@"downArrow.png"];
    
    CGRect rect = CGRectMake(0, 0, 35, 25);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, [self.tintColor CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                scale:1.0 orientation: UIImageOrientationDownMirrored];
    UIImageView *downArrow = [[UIImageView alloc] initWithImage:flippedImage];
    CGFloat xPos = self.forgotView.frame.size.width - downArrow.frame.size.width;
    downArrow.frame = CGRectMake(xPos, self.forgotView.frame.size.height*0.075, downArrow.frame.size.width, downArrow.frame.size.height);
    
    
    [self.forgotView addSubview:downArrow];
}

- (void)initBackButton {
    UIImage *image = [UIImage imageNamed:@"back"];
    
    CGRect rect = CGRectMake(0, 0, 50, 50);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                scale:1.0 orientation: UIImageOrientationDownMirrored];
    UIImageView *back = [[UIImageView alloc] initWithImage:flippedImage];
    back.frame = CGRectMake(self.view.frame.size.width*0.05, self.view.frame.size.height*0.05, back.frame.size.width, back.frame.size.height);
    
    back.userInteractionEnabled = YES;
    [self.view addSubview:back];
    
    [back addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)]];
}

#pragma mark - Button Action
- (void)countrySelect:(id)sender {
    NSArray *data = [[NSArray alloc] init];
    data = [self.countryDictionary allKeys];
    if(self.dropDown == nil) {
        CGFloat f = 200;
        self.dropDown = [[NIDropDown alloc]showDropDown:sender :&f :data :nil :@"down"];
        self.dropDown.delegate = self;
    }
    else {
        [self.dropDown hideDropDown:sender];
        self.dropDown = nil;
    }
}

- (void)submitAction:(UITapGestureRecognizer *)recognizer {
    if ([self validatePhone]) {
        _phoneNUmber.rightViewMode = UITextFieldViewModeAlways;
        _phoneNUmber.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ok.png"]];
        [_phoneErrorLabel setHidden:YES];
        OTPConfirmViewController *otpViewCtrl = [[OTPConfirmViewController alloc] init];
        [self presentViewController:otpViewCtrl animated:YES completion:nil];
    } else {
        [_phoneErrorLabel setHidden:NO];
        _phoneNUmber.rightViewMode = UITextFieldViewModeNever;
    }
}

- (void)backAction:(UITapGestureRecognizer *)recognizer {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - NIDropDown delegate
- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    self.dropDown = nil;
    
    NSString *country = self.countrySelect.titleLabel.text;
    [_countryLabel setText:[NSString stringWithFormat:@"Country: %@", country]];
    [_countryLabel sizeToFit];
    [_countryLabel layoutIfNeeded];
    NSString *code = [self.countryDictionary valueForKey:country];
    [_phoneCodeLabel setText:[NSString stringWithFormat:@"+%@", code]];
    [_phoneCodeLabel sizeToFit];
    [_phoneCodeLabel layoutIfNeeded];
    
    
}

#pragma mark - Textfield delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

#pragma mark - Common function
- (CGFloat)marginValueY {
    return self.forgotView.frame.size.height / 6;
}

- (bool)validatePhone {
    NSString *phone = [[_phoneCodeLabel.text substringFromIndex:1] stringByAppendingString:_phoneNUmber.text];
    if ([phone length] < 10) {
        return false;
    }
    return true;
}


@end
