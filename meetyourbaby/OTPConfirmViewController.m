//
//  OTPConfirmViewController.m
//  meetyourbaby
//
//  Created by Quang Phuong on 11/3/16.
//  Copyright © 2016 QP. All rights reserved.
//

#import "OTPConfirmViewController.h"

@interface OTPConfirmViewController ()

@property UIColor *tintColor;
@property UIView *otpView;
@property UILabel *otpLabel;
@property UIImageView *appLogo;
@property UITextField *otpNumber;
@property UIView *verticalSeparator;
@property Ultility *utility;

@end

@implementation OTPConfirmViewController {
}

@synthesize utility;

#pragma mark - UIView delegate
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    utility = [Ultility new];
    _tintColor = [utility colorWithHexString:@"#47C2E6"];
    [self initBackground];
    [self initLogo];
    [self initOTPView];
    [self initButtons];
    [self initSeperators];
    [self initLabel];
    [self initInputs];
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

- (void)initOTPView {
    CGRect bounds = self.view.bounds;
    
    self.otpView = [utility createViewWithFrame:CGRectMake(bounds.size.width * 0.075, bounds.size.height * 0.48, bounds.size.width * 0.85, bounds.size.height * 0.08)];
    [self.view addSubview:_otpView];
}

- (void)initSeperators {
    CGSize forgotSize = _otpView.frame.size;
    UIColor *separatorClolor = [UIColor colorWithWhite:0.8 alpha:0.9];
    
    self.verticalSeparator = [[UIView alloc] initWithFrame:CGRectMake(forgotSize.width/3, 0, 0.5, forgotSize.height)];
    _verticalSeparator.backgroundColor = separatorClolor;
    
    [self.otpView addSubview:self.verticalSeparator];
}

- (void)initLabel {
    CGSize loginSize = _otpView.frame.size;
    
    self.otpLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, [self marginValueY], 10, 10)];
    [_otpLabel setText:@"OTP Code"];
    [_otpLabel setTextColor:self.tintColor];
    [_otpLabel setFont:[UIFont systemFontOfSize:13]];
    [_otpLabel sizeToFit];
    [_otpLabel layoutIfNeeded];
    [self.otpView addSubview:self.otpLabel];
}

- (void)initButtons {
    CGRect bounds = self.view.bounds;
    // Submit button
    CGRect submitFrame = CGRectMake(bounds.size.width * 0.075, bounds.size.height * 0.58, bounds.size.width * 0.85, bounds.size.height * 0.07);
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
    CGSize loginSize = self.otpView.frame.size;
    UIColor *placeholderColor = [utility colorWithHexString:@"#B6E0ED"];
    
    self.otpNumber = [[UITextField alloc] initWithFrame:CGRectMake(loginSize.width /3 + 20, 0, loginSize.width /3*2 - 30, loginSize.height)];
    [self.otpNumber setFont:[UIFont systemFontOfSize:13]];
    [self.otpNumber setKeyboardType:UIKeyboardTypePhonePad];
    _otpNumber.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter your OTP Code" attributes:@{NSForegroundColorAttributeName: placeholderColor}];
    [self.otpView addSubview:self.otpNumber];
    _otpNumber.tag = 0;
    _otpNumber.delegate = self;
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
- (void)submitAction:(UITapGestureRecognizer *)recognizer {
    
}

- (void)backAction:(UITapGestureRecognizer *)recognizer {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Textfield delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

#pragma mark - Common function
- (CGFloat)marginValueY {
    return _otpView.frame.size.height / 3;
}

@end
