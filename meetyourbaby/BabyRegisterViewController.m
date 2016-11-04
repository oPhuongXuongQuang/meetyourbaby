//
//  BabyRegisterViewController.m
//  meetyourbaby
//
//  Created by Quang Phuong on 11/4/16.
//  Copyright © 2016 QP. All rights reserved.
//

#import "BabyRegisterViewController.h"

@interface BabyRegisterViewController ()

@property NSDictionary *countryDictionary;
@property UIColor *tintColor;
@property UIView *babyInfoView;
@property UILabel *lastnameLabel;
@property UILabel *firstnameLabel;
@property UILabel *genderLabel;
@property UILabel *birthLabel;
@property UILabel *selectLabel;
@property UIImageView *babyLogo;
@property UITextField *firstname;
@property UITextField *lastname;
@property UITextField *birth;
@property UIView *girlLayout;
@property UIView *boyLayout;
@property UILabel *firstnameErrorLabel;
@property UILabel *lastnameErrorLabel;
@property UIView *verticalSeparator;
@property Ultility *utility;
@property BOOL isGirl;

@end

@implementation BabyRegisterViewController

@synthesize utility;
@synthesize isGirl;

#pragma mark - UIView delegate
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    utility = [Ultility new];
    _tintColor = [utility colorWithHexString:@"#47C2E6"];
    self.countryDictionary = [utility createCountryDictionary];
    [self initBackground];
    [self initLogo];
    [self initBabyInfoView];
    [self initButtons];
    [self initSeperators];
    [self initLabel];
    [self initInputs];
    [self initErrorLabel];
    [self initBackButton];
    
    isGirl = NO;
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
    UIImage *image = [UIImage imageNamed:@"babyLogo.png"];
    CGSize newSize = CGSizeMake(100, 100);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.babyLogo = [[UIImageView alloc] initWithImage:newImage];
    self.babyLogo.center = CGPointMake(CGRectGetMidX(bounds), bounds.size.height * 0.39);
    [self.view addSubview:self.babyLogo];
    [_babyLogo setUserInteractionEnabled:YES];
    UITapGestureRecognizer *photoTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(selectBabyImage:)];
    [_babyLogo addGestureRecognizer: photoTap];
}

- (void)initBabyInfoView {
    CGRect bounds = self.view.bounds;
    
    self.babyInfoView = [utility createViewWithFrame:CGRectMake(bounds.size.width * 0.075, bounds.size.height * 0.51, bounds.size.width * 0.85, bounds.size.height * 0.3)];
    [self.view addSubview:self.babyInfoView];
}

- (void)initSeperators {
    CGSize loginSize = self.babyInfoView.frame.size;
    UIColor *separatorClolor = [UIColor colorWithWhite:0.8 alpha:0.9];
    
    UIView *separator1 = [[UIView alloc] initWithFrame:CGRectMake(0, loginSize.height /4, loginSize.width, 0.5)];
    separator1.backgroundColor = separatorClolor;
    
    UIView *separator2 = [[UIView alloc] initWithFrame:CGRectMake(0, loginSize.height/2, loginSize.width, 0.5)];
    separator2.backgroundColor = separatorClolor;
    
    UIView *separator3 = [[UIView alloc] initWithFrame:CGRectMake(0, loginSize.height*3/4, loginSize.width, 0.5)];
    separator3.backgroundColor = separatorClolor;
    
    self.verticalSeparator = [[UIView alloc] initWithFrame:CGRectMake(loginSize.width/3, 0, 0.5, loginSize.height)];
    _verticalSeparator.backgroundColor = separatorClolor;
    
    [self.babyInfoView addSubview:separator1];
    [self.babyInfoView addSubview:separator2];
    [self.babyInfoView addSubview:separator3];
    [self.babyInfoView addSubview:self.verticalSeparator];
}

- (void)initLabel {
    CGSize loginSize = self.babyInfoView.frame.size;
    CGRect bounds = self.view.bounds;
    self.genderLabel = [[UILabel alloc] init];
    [_genderLabel setText:@"Gender"];
    [_genderLabel setTextColor:self.tintColor];
    [_genderLabel setFont:[UIFont systemFontOfSize:13]];
    [_genderLabel sizeToFit];
    [_genderLabel layoutIfNeeded];
    _genderLabel.frame = CGRectMake(20, loginSize.height/2 + [self marginValueYwithHeight:_genderLabel.frame.size.height], _genderLabel.frame.size.width, _genderLabel.frame.size.height);
    [self.babyInfoView addSubview:_genderLabel];
    
    self.lastnameLabel = [[UILabel alloc] init];
    [_lastnameLabel setText:@"Last Nane"];
    [_lastnameLabel setTextColor:self.tintColor];
    [_lastnameLabel setFont:[UIFont systemFontOfSize:13]];
    [_lastnameLabel sizeToFit];
    [_lastnameLabel layoutIfNeeded];
    _lastnameLabel.frame = CGRectMake(20, loginSize.height/4 + [self marginValueYwithHeight:_lastnameLabel.frame.size.height], _lastnameLabel.frame.size.width, _lastnameLabel.frame.size.height);
    [self.babyInfoView addSubview:self.lastnameLabel];
    
    self.firstnameLabel = [[UILabel alloc] init];
    [_firstnameLabel setText:@"First Name"];
    [_firstnameLabel setTextColor:self.tintColor];
    [_firstnameLabel setFont:[UIFont systemFontOfSize:13]];
    [_firstnameLabel sizeToFit];
    [_firstnameLabel layoutIfNeeded];
    _firstnameLabel.frame = CGRectMake(20, [self marginValueYwithHeight:_firstnameLabel.frame.size.height], _firstnameLabel.frame.size.width, _firstnameLabel.frame.size.height);
    [self.babyInfoView addSubview:self.firstnameLabel];
    
    self.birthLabel = [[UILabel alloc] init];
    [_birthLabel setText:@"Date of Birth"];
    [_birthLabel setTextColor:self.tintColor];
    [_birthLabel setFont:[UIFont systemFontOfSize:13]];
    [_birthLabel sizeToFit];
    [_birthLabel layoutIfNeeded];
    _birthLabel.frame = CGRectMake(20, loginSize.height/4*3 + [self marginValueYwithHeight:_birthLabel.frame.size.height], _birthLabel.frame.size.width, _birthLabel.frame.size.height);
    [self.babyInfoView addSubview:_birthLabel];
    
    self.selectLabel = [[UILabel alloc] init];
    [_selectLabel setText:@"Select Profile Picture"];
    [_selectLabel setTextColor:[UIColor whiteColor]];
    [_selectLabel setFont:[UIFont systemFontOfSize:15]];
    [_selectLabel sizeToFit];
    [_selectLabel layoutIfNeeded];
    _selectLabel.center = CGPointMake(CGRectGetMidX(bounds), bounds.size.height * 0.47);
    [self.view addSubview:_selectLabel];
}

- (void)initButtons {
    CGRect bounds = self.view.bounds;
    
    // Register button
    CGRect registerFrame = CGRectMake(bounds.size.width * 0.075, bounds.size.height * 0.85, bounds.size.width * 0.85, bounds.size.height * 0.07);
    UIView *registerLayout = [utility createViewWithFrame:registerFrame];
    [utility addText:@"REGISTER" toLayout:registerLayout withTextColor:[utility blueTintColor]];
    [self.view addSubview:registerLayout];
    UITapGestureRecognizer *registerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(registerAction:)];
    [registerLayout addGestureRecognizer:registerTap];
    
    // Boy button
    CGSize babyInfoSize = self.babyInfoView.frame.size;
    CGRect boyFrame = CGRectMake(babyInfoSize.width/3 + 20, babyInfoSize.height /2 + [self marginValueYwithHeight:babyInfoSize.height * 0.15], babyInfoSize.width * 0.25, babyInfoSize.height * 0.15);
    _boyLayout = [utility createViewWithFrame:boyFrame];
    [utility addText:@"Boy" toLayout:_boyLayout withTextColor:[UIColor whiteColor]];
    [self.babyInfoView addSubview:_boyLayout];
    [_boyLayout.layer setShadowOpacity:0];
    [_boyLayout.layer setBorderColor:[[utility blueTintColor] CGColor]];
    [_boyLayout setBackgroundColor:[utility blueTintColor]];
    UITapGestureRecognizer *boyTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(boyAction:)];
    [_boyLayout addGestureRecognizer:boyTap];
    
    // Girl button
    CGRect girlFrame = CGRectMake(babyInfoSize.width/3 + 20 + _boyLayout.frame.size.width + 20, babyInfoSize.height /2 + [self marginValueYwithHeight:babyInfoSize.height * 0.15], babyInfoSize.width * 0.25, babyInfoSize.height * 0.15);
    _girlLayout = [utility createViewWithFrame:girlFrame];
    [utility addText:@"Girl" toLayout:_girlLayout withTextColor:[utility blueTintColor]];
    [self.babyInfoView addSubview:_girlLayout];
    [_girlLayout.layer setShadowOpacity:0];
    [_girlLayout.layer setBorderColor:[[utility blueTintColor] CGColor]];
    UITapGestureRecognizer *girlTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(girlAction:)];
    [_girlLayout addGestureRecognizer:girlTap];
}

- (void)initInputs {
    CGSize loginSize = self.babyInfoView.frame.size;
    UIColor *placeholderColor = [utility colorWithHexString:@"#B6E0ED"];
    
    self.firstname = [[UITextField alloc] initWithFrame:CGRectMake(loginSize.width /3 + 20, 0, loginSize.width /3*2 - 30, loginSize.height /4)];
    [self.firstname setFont:[UIFont systemFontOfSize:13]];
    [self.firstname setKeyboardType:UIKeyboardTypePhonePad];
    self.firstname.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter First Name" attributes:@{NSForegroundColorAttributeName: placeholderColor}];
    [self.babyInfoView addSubview:self.firstname];
    self.firstname.tag = 0;
    self.firstname.delegate = self;
    
    
    self.lastname = [[UITextField alloc] initWithFrame:CGRectMake(loginSize.width /3 + 20, loginSize.height/4, loginSize.width /3*2 - 30, loginSize.height /4)];
    [self.lastname setFont:[UIFont systemFontOfSize:13]];
    [self.lastname setKeyboardType:UIKeyboardTypePhonePad];
    self.lastname.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Last Name" attributes:@{NSForegroundColorAttributeName: placeholderColor}];
    [self.babyInfoView addSubview:self.lastname];
    self.lastname.tag = 1;
    self.lastname.delegate = self;
    
    self.birth = [[UITextField alloc] initWithFrame:CGRectMake(loginSize.width /3 + 20, loginSize.height/4*3, loginSize.width /3*2 - 30, loginSize.height /4)];
    self.birth.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Date/ Month/ Year" attributes:@{NSForegroundColorAttributeName: placeholderColor}];
    [self.birth setFont:[UIFont systemFontOfSize:13]];
    UIImage *calendar = [utility fixImageWithImageNamed:@"calendar.png" withRect:CGRectMake(0, 0, 30, 30) withTintColor:[utility blueTintColor]];
    _birth.rightViewMode = UITextFieldViewModeAlways;
    _birth.rightView = [[UIImageView alloc] initWithImage:calendar];
    self.birth.tag = 2;
    self.birth.delegate = self;
    [self.babyInfoView addSubview:self.birth];
    
}

- (void)initErrorLabel {
    CGSize loginViewSize = self.babyInfoView.frame.size;
    _firstnameErrorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, loginViewSize.width, loginViewSize.height/4)];
    _lastnameErrorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, loginViewSize.height /4, loginViewSize.width, loginViewSize.height/4)];
    
    [_firstnameErrorLabel setTextAlignment:NSTextAlignmentRight];
    [_firstnameErrorLabel setTextColor:[UIColor redColor]];
    [_firstnameErrorLabel setText:@"First name is required"];
    [_firstnameErrorLabel setFont:[UIFont systemFontOfSize:9]];
    [_lastnameErrorLabel setText:@"Last name is required"];
    [_lastnameErrorLabel setFont:[UIFont systemFontOfSize:9]];
    [_lastnameErrorLabel setTextAlignment:NSTextAlignmentRight];
    [_lastnameErrorLabel setTextColor:[UIColor redColor]];
    
    [_firstnameErrorLabel sizeToFit];
    [_lastnameErrorLabel sizeToFit];
    CGRect phoneFrame = _firstnameErrorLabel.frame;
    CGRect passFrame = _lastnameErrorLabel.frame;
    phoneFrame.origin.x = loginViewSize.width - _firstnameErrorLabel.frame.size.width;
    passFrame.origin.x = loginViewSize.width - _lastnameErrorLabel.frame.size.width;
    _lastnameErrorLabel.frame = passFrame;
    _firstnameErrorLabel.frame = phoneFrame;
    
    [self.babyInfoView addSubview:self.firstnameErrorLabel];
    [self.babyInfoView addSubview:self.lastnameErrorLabel];
    
    [_firstnameErrorLabel setHidden:YES];
    [_lastnameErrorLabel setHidden:YES];
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
- (void)backAction:(UITapGestureRecognizer *)recognizer {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerAction:(UITapGestureRecognizer *)recognizer {
    if([self firstNameValid] && [self lastNameValid]) {
        
    }
}

- (void)boyAction:(UITapGestureRecognizer *)recognizer {
    [self toggleButton1:_boyLayout fromButton2:_girlLayout];
    isGirl = NO;
}

- (void)girlAction:(UITapGestureRecognizer *)recognizer {
    [self toggleButton1:_girlLayout fromButton2:_boyLayout];
    isGirl = YES;
}

- (void)selectBabyImage:(UITapGestureRecognizer *)recognizer {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - Textfield delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 0) {
        [self firstNameValid];
    }
    if (textField.tag == 1) {
        [self lastNameValid];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.tag == 2) {
        [textField resignFirstResponder];
        [utility showDatePickerWithTitle:@"Choose Date of Birth" onTextField:textField];
    }
}

#pragma mark - Textfield validate
-(bool)firstNameValid {
    if (_firstname.text.length != 0){
        [_firstnameErrorLabel setHidden:YES];
        return true;
    } else {
        [_firstnameErrorLabel setHidden:NO];
        return false;
    }
}

-(bool)lastNameValid {
    if (_lastname.text.length != 0){
        [_lastnameErrorLabel setHidden:YES];
        return true;
    } else {
        [_lastnameErrorLabel setHidden:NO];
        return false;
    }
}

#pragma ImagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
//    NSURL *path = [info valueForKey:UIImagePickerControllerReferenceURL];
    [_babyLogo setImage:[utility fixImageWithImage:image withRect:CGRectMake(0, 0, 100, 100) withTintColor:nil]];
    [_selectLabel setHidden:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Common function
- (CGFloat)marginValueYwithHeight:(CGFloat)height{
    CGFloat margin = (self.babyInfoView.frame.size.height/4 - height) /2;
    return margin;
}

- (void)toggleButton1:(UIView *)button1 fromButton2:(UIView *)button2 {
    [button1 setBackgroundColor:[utility blueTintColor]];
    NSArray *views = button1.subviews;
    for (UIView *subView in views) {
        if ([subView isKindOfClass:[UILabel class]]) {
            [(UILabel*)subView setTextColor:[UIColor whiteColor]];
        }
        
    }
    
    [button2 setBackgroundColor:[UIColor whiteColor]];
    NSArray *views2 = button2.subviews;
    for (UIView *subView in views2) {
        if ([subView isKindOfClass:[UILabel class]]) {
            [(UILabel*)subView setTextColor:[utility blueTintColor]];
        }

    }
}

@end
