//
//  SocialLoginViewController.m
//  meetyourbaby
//
//  Created by Quang Phuong on 11/4/16.
//  Copyright © 2016 QP. All rights reserved.
//

#import "SocialLoginViewController.h"
#import "Ultility.h"

@interface SocialLoginViewController ()

@property UIImageView *appLogo;
@property UIView *facebookButton;
@property UIView *googleButton;
@property UIView *skipButton;
@property Ultility *utility;

@end

@implementation SocialLoginViewController

@synthesize utility;

# pragma mark - UIViewController delegate
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    utility = [Ultility new];
    [self initBackground];
    [self initLogo];
    [self initBackButton];
    [self initButtons];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Init layout
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

- (void)initButtons {
    CGRect bounds = self.view.bounds;
    // Facebook button
    CGRect fbFrame = CGRectMake(bounds.size.width * 0.075, bounds.size.height * 0.48, bounds.size.width * 0.85, bounds.size.height * 0.07);
    UIView *fbLayout = [utility createViewWithFrame:fbFrame];
    [utility addText:@"Facebook" toLayout:fbLayout withTextColor:[UIColor whiteColor]];
    [fbLayout setBackgroundColor:[utility colorWithHexString:@"#3b5998"]];
    UIImageView *fbImage = [[UIImageView alloc] initWithImage:[utility fixImageWithImageNamed:@"facebook.png" withRect:CGRectMake(0, 0, 20, 20) withTintColor:nil]];
    [fbLayout addSubview:fbImage];
    fbImage.frame = CGRectMake(20, (fbLayout.frame.size.height - fbImage.frame.size.height) /2, fbImage.frame.size.width, fbImage.frame.size.height);
    [self.view addSubview:fbLayout];
    UITapGestureRecognizer *fbTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(fbAction:)];
    [fbLayout addGestureRecognizer:fbTap];
    
    // Google button
    CGRect ggFrame = CGRectMake(bounds.size.width * 0.075, bounds.size.height * 0.58, bounds.size.width * 0.85, bounds.size.height * 0.07);
    UIView *ggLayout = [utility createViewWithFrame:ggFrame];
    [utility addText:@"Google" toLayout:ggLayout withTextColor:[UIColor whiteColor]];
    [ggLayout setBackgroundColor:[utility colorWithHexString:@"#d62d20"]];
    UIImageView *ggImage = [[UIImageView alloc] initWithImage:[utility fixImageWithImageNamed:@"googlePlus.png" withRect:CGRectMake(0, 0, 20, 20) withTintColor:nil]];
    [ggLayout addSubview:ggImage];
    ggImage.frame = CGRectMake(20, (ggLayout.frame.size.height - ggImage.frame.size.height) /2, ggImage.frame.size.width, ggImage.frame.size.height);
    
    [self.view addSubview:ggLayout];
    UITapGestureRecognizer *ggTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(ggAction:)];
    [ggLayout addGestureRecognizer:ggTap];
    
    // Skip button
    CGRect skipFrame = CGRectMake(bounds.size.width * 0.075, bounds.size.height * 0.68, bounds.size.width * 0.85, bounds.size.height * 0.07);
    UIView *skipLayout = [utility createViewWithFrame:skipFrame];
    [utility addText:@"SKIP" toLayout:skipLayout withTextColor:[UIColor whiteColor]];
    [self.view addSubview:skipLayout];
    
    [skipLayout setBackgroundColor:[utility blueTintColor]];
    skipLayout.layer.borderColor = [[UIColor blackColor] CGColor];
    UITapGestureRecognizer *skipTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(skipAction:)];
    [skipLayout addGestureRecognizer:skipTap];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - Button Action
- (void)fbAction:(UITapGestureRecognizer *)recognizer {
    
}

- (void)ggAction:(UITapGestureRecognizer *)recognizer {
    
}

- (void)skipAction:(UITapGestureRecognizer *)recognizer {
    
}

- (void)backAction:(UITapGestureRecognizer *)recognizer {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
