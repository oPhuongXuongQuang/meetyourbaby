//
//  LoginViewController.m
//  meetyourbaby
//
//  Created by Quang Phuong on 11/2/16.
//  Copyright © 2016 QP. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface LoginViewController ()

@property NSDictionary *countryDictionary;
@property UIColor *tintColor;
@property UIView *loginView;
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

@end

@implementation LoginViewController {
    bool isOnValidScreen;
}

#pragma mark - UIView delegate
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tintColor = [self colorWithHexString:@"#47C2E6"];
    [self createCountryDictionary];
    [self initBackground];
    [self initLogo];
    [self initLoginView];
    [self initButtons];
    [self initSeperators];
    [self initLabel];
    [self initInputs];
    [self initSelect];
    [self initErrorLabel];
    [self initDownArrow];
    
    isOnValidScreen = false;
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

- (void)initLoginView {
    CGRect bounds = self.view.bounds;
    
    self.loginView = [self createViewWithFrame:CGRectMake(bounds.size.width * 0.075, bounds.size.height * 0.48, bounds.size.width * 0.85, bounds.size.height * 0.23)];
    [self.view addSubview:self.loginView];
}

- (void)initSeperators {
    CGSize loginSize = self.loginView.frame.size;
    UIColor *separatorClolor = [UIColor colorWithWhite:0.8 alpha:0.9];
    
    UIView *separator1 = [[UIView alloc] initWithFrame:CGRectMake(0, loginSize.height /3, loginSize.width, 0.5)];
    separator1.backgroundColor = separatorClolor;
    
    UIView *separator2 = [[UIView alloc] initWithFrame:CGRectMake(0, loginSize.height*2/3, loginSize.width, 0.5)];
    separator2.backgroundColor = separatorClolor;
    
    self.verticalSeparator = [[UIView alloc] initWithFrame:CGRectMake(loginSize.width/3, loginSize.height/3, 0.5, loginSize.height*2/3)];
    _verticalSeparator.backgroundColor = separatorClolor;
    
    [self.loginView addSubview:separator1];
    [self.loginView addSubview:separator2];
    [self.loginView addSubview:self.verticalSeparator];
}

- (void)initLabel {
    CGSize loginSize = self.loginView.frame.size;
    
    self.passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, loginSize.height/3*2 + [self marginValueY], 10, 10)];
    [_passwordLabel setText:@"Password"];
    [_passwordLabel setTextColor:self.tintColor];
    [_passwordLabel setFont:[UIFont systemFontOfSize:13]];
    [_passwordLabel sizeToFit];
    [_passwordLabel layoutIfNeeded];
    [self.loginView addSubview:_passwordLabel];
    
    self.phoneCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, loginSize.height/3 + [self marginValueY], 10, 10)];
    [_phoneCodeLabel setText:@"+84"];
    [_phoneCodeLabel setTextColor:self.tintColor];
    [_phoneCodeLabel setFont:[UIFont systemFontOfSize:13]];
    [_phoneCodeLabel sizeToFit];
    [_phoneCodeLabel layoutIfNeeded];
    [self.loginView addSubview:self.phoneCodeLabel];
    
    self.countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, [self marginValueY], 10, 10)];
    [_countryLabel setText:@"Country: Vietnam"];
    [_countryLabel setTextColor:self.tintColor];
    [_countryLabel setFont:[UIFont systemFontOfSize:13]];
    [_countryLabel sizeToFit];
    [_countryLabel layoutIfNeeded];
    [self.loginView addSubview:self.countryLabel];
    
    CGRect forgotFrame = CGRectMake(0, self.view.frame.size.height * 0.95, self.view.frame.size.width, 20);
    UILabel *forgotLabel = [[UILabel alloc] initWithFrame:forgotFrame];
    [forgotLabel setText:@"Forgot Password ?"];
    [forgotLabel setTextColor:[UIColor whiteColor]];
    [forgotLabel setFont:[UIFont systemFontOfSize:13]];
    [forgotLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:forgotLabel];
}

- (void)initButtons {
    CGRect bounds = self.view.bounds;
    // Login button
    CGRect loginFrame = CGRectMake(bounds.size.width * 0.075, bounds.size.height * 0.78, bounds.size.width * 0.85, bounds.size.height * 0.05);
    UIView *loginLayout = [self createViewWithFrame:loginFrame];
    [self addText:@"ALREADY A MEMEBER? LOGIN" toLayout:loginLayout];
    [self.view addSubview:loginLayout];
    UITapGestureRecognizer *loginTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(loginAction:)];
    [loginLayout addGestureRecognizer:loginTap];
    loginLayout.layer.zPosition = 1;
    
    // Register button
    CGRect registerFrame = CGRectMake(bounds.size.width * 0.075, bounds.size.height * 0.85, bounds.size.width * 0.85, bounds.size.height * 0.05);
    UIView *registerLayout = [self createViewWithFrame:registerFrame];
    [self addText:@"REGISTER" toLayout:registerLayout];
    [self.view addSubview:registerLayout];
    UITapGestureRecognizer *registerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(registerAction:)];
    [registerLayout addGestureRecognizer:registerTap];
    registerLayout.layer.zPosition = 1;
}

- (void)initInputs {
    CGSize loginSize = self.loginView.frame.size;
    UIColor *placeholderColor = [self colorWithHexString:@"#B6E0ED"];
    
    self.phoneNUmber = [[UITextField alloc] initWithFrame:CGRectMake(loginSize.width /3 + 20, loginSize.height/3, loginSize.width /3*2 - 30, loginSize.height /3)];
    [self.phoneNUmber setFont:[UIFont systemFontOfSize:13]];
    [self.phoneNUmber setTextContentType:UITextContentTypeTelephoneNumber];
    [self.phoneNUmber setKeyboardType:UIKeyboardTypePhonePad];
    self.phoneNUmber.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Mobile number" attributes:@{NSForegroundColorAttributeName: placeholderColor}];
    [self.loginView addSubview:self.phoneNUmber];
    self.phoneNUmber.tag = 0;
    self.phoneNUmber.delegate = self;
    
    self.password = [[UITextField alloc] initWithFrame:CGRectMake(loginSize.width /3 + 20, loginSize.height/3*2, loginSize.width /3*2 - 30, loginSize.height /3)];
    [self.password setSecureTextEntry:YES];
    self.password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Password" attributes:@{NSForegroundColorAttributeName: placeholderColor}];
    [self.password setFont:[UIFont systemFontOfSize:13]];
    self.password.tag = 1;
    self.password.delegate = self;
    [self.loginView addSubview:self.password];
    _phoneNUmber.rightViewMode = UITextFieldViewModeAlways;
    _password.rightViewMode = UITextFieldViewModeAlways;;
}

- (void)initSelect {
    CGRect loginRect = self.loginView.frame;
    self.countrySelect = [[UIButton alloc] initWithFrame:CGRectMake(loginRect.origin.x, loginRect.origin.y, loginRect.size.width, loginRect.size.height /3)];
    [self.view addSubview:self.countrySelect];
    self.countrySelect.layer.zPosition = -1;
    [self.countrySelect addTarget:self action:@selector(countrySelect:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initErrorLabel {
    CGSize loginViewSize = self.loginView.frame.size;
    _phoneErrorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, loginViewSize.height /3, loginViewSize.width, loginViewSize.height/3)];
    _passwordErrorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, loginViewSize.height /3*2, loginViewSize.width, loginViewSize.height/3)];
    
    [_phoneErrorLabel setTextAlignment:NSTextAlignmentRight];
    [_phoneErrorLabel setTextColor:[UIColor redColor]];
    [_phoneErrorLabel setText:@"Minimum 10 Number"];
    [_phoneErrorLabel setFont:[UIFont systemFontOfSize:9]];
    [_passwordErrorLabel setText:@"Minimum 8 Characters"];
    [_passwordErrorLabel setFont:[UIFont systemFontOfSize:9]];
    [_passwordErrorLabel setTextAlignment:NSTextAlignmentRight];
    [_passwordErrorLabel setTextColor:[UIColor redColor]];
    
    [_phoneErrorLabel sizeToFit];
    [_passwordErrorLabel sizeToFit];
    CGRect phoneFrame = _phoneErrorLabel.frame;
    CGRect passFrame = _passwordErrorLabel.frame;
    phoneFrame.origin.x = loginViewSize.width - _phoneErrorLabel.frame.size.width;
    passFrame.origin.x = loginViewSize.width - _passwordErrorLabel.frame.size.width;
    _passwordErrorLabel.frame = passFrame;
    _phoneErrorLabel.frame = phoneFrame;
    
    [self.loginView addSubview:self.phoneErrorLabel];
    [self.loginView addSubview:self.passwordErrorLabel];
    
    [_phoneErrorLabel setHidden:YES];
    [_passwordErrorLabel setHidden:YES];
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
    CGFloat xPos = self.loginView.frame.size.width - downArrow.frame.size.width;
    downArrow.frame = CGRectMake(xPos, self.loginView.frame.size.height*0.075, downArrow.frame.size.width, downArrow.frame.size.height);
    
    
    [self.loginView addSubview:downArrow];
}

#pragma mark - Button Action
- (void)loginAction:(UITapGestureRecognizer *)recognizer {
    if ([self validatePhone] && [self validatePassword]) {
        
    }
}

- (void)registerAction:(UITapGestureRecognizer *)recognizer {
    
}

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

#pragma mark - NIDropDown delegate
- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    self.dropDown = nil;
    
    NSString *country = self.countrySelect.titleLabel.text;
    [_countryLabel setText:[NSString stringWithFormat:@"Country: %@", country]];
    [_countryLabel sizeToFit];
    [_countryLabel layoutIfNeeded];
    NSString *code = [self.countryDictionary valueForKey:country];
    if (isOnValidScreen) {
        [self.phoneNUmber setText:[self.phoneNUmber.text stringByReplacingOccurrencesOfString:_phoneCodeLabel.text withString:[NSString stringWithFormat:@"+%@", code]]];
    }
    [_phoneCodeLabel setText:[NSString stringWithFormat:@"+%@", code]];
    [_phoneCodeLabel sizeToFit];
    [_phoneCodeLabel layoutIfNeeded];
    
    
}

#pragma mark - Textfield delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 0) {
        if ([self validatePhone]) {
            _phoneNUmber.rightViewMode = UITextFieldViewModeAlways;
            _phoneNUmber.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ok.png"]];
            [_phoneErrorLabel setHidden:YES];
        } else {
            [_phoneErrorLabel setHidden:NO];
            _phoneNUmber.rightViewMode = UITextFieldViewModeNever;
        }
    }
    if (textField.tag == 1) {
        if ([self validatePassword]) {
            _password.rightViewMode = UITextFieldViewModeAlways;
            _password.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ok.png"]];
            [_passwordErrorLabel setHidden:YES];
        } else {
            [_passwordErrorLabel setHidden:NO];
            _password.rightViewMode = UITextFieldViewModeNever;
        }
    }
    if ([self validatePhone] && [self validatePassword]) {
        if (!isOnValidScreen) {
            [self validScreen];
        }
    } else {
        if (isOnValidScreen) {
            [self inValidScreen];
        }
    }
}

#pragma mark - Common function
- (bool)validatePhone {
    NSString *phone;
    if (isOnValidScreen) {
        phone = _phoneNUmber.text;
    } else {
        phone = [[_phoneCodeLabel.text substringFromIndex:1] stringByAppendingString:_phoneNUmber.text];
    }
    if ([phone length] < 10) {
        return false;
    }
    return true;
}

- (bool)validatePassword {
    if ([_password.text length] < 8) {
        return false;
    }
    return true;
}

- (void)validScreen {
    isOnValidScreen = true;
    [_verticalSeparator setHidden:YES];
    [_phoneCodeLabel setHidden:YES];
    [_passwordLabel setHidden:YES];
    _phoneNUmber.frame = CGRectMake(20, _phoneNUmber.frame.origin.y, self.loginView.frame.size.width  - 30, _phoneNUmber.frame.size.height);
    _password.frame = CGRectMake(20, _password.frame.origin.y, self.loginView.frame.size.width  - 30, _password.frame.size.height);
    NSString *phone = [_phoneCodeLabel.text stringByAppendingString:_phoneNUmber.text];
    [self.phoneNUmber setText:phone];
}

- (void)inValidScreen {
    isOnValidScreen = false;
    [_verticalSeparator setHidden:NO];
    [_phoneCodeLabel setHidden:NO];
    [_passwordLabel setHidden:NO];
    CGSize loginSize = self.loginView.frame.size;
    self.phoneNUmber.frame = CGRectMake(loginSize.width /3 + 20, loginSize.height/3, loginSize.width /3*2 - 30, loginSize.height /3);
    
    self.password.frame = CGRectMake(loginSize.width /3 + 20, loginSize.height/3*2, loginSize.width /3*2 - 30, loginSize.height /3);
    [self.phoneNUmber setText:[self.phoneNUmber.text stringByReplacingOccurrencesOfString:self.phoneCodeLabel.text withString:@""]];
}

#pragma mark - Ultility
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

- (void)addText:(NSString *)text toLayout:(UIView *)layout {
    CGRect frame = layout.frame;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [label setFont:[UIFont systemFontOfSize:13]];
    [label setText:text];
    [label setTextColor:self.tintColor];
    
    [label sizeToFit];
    [label layoutIfNeeded];
    label.center = CGPointMake(layout.frame.size.width/2, frame.size.height / 2);
    [layout addSubview:label];
}

- (CGFloat)marginValueY {
    return self.loginView.frame.size.height / 8;
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

- (void)createCountryDictionary {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"54" forKey:@"Argentina"];
    [dic setObject:@"374" forKey:@"Armenia"];
    [dic setObject:@"61" forKey:@"Australia"];
    [dic setObject:@"86" forKey:@"China"];
    [dic setObject:@"91" forKey:@"India"];
    [dic setObject:@"1" forKey:@"United States"];
    
    self.countryDictionary = [dic mutableCopy];
}

@end
