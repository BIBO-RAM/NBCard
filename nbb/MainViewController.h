//
//  MainViewController.h
//  Bibocard1
//
//  Created by Timofey Solonin on 10/5/14.
//  Copyright (c) 2014 Timofey Solonin. All rights reserved.
//

#import "FlipsideViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <Security/Security.h>
#import "KeychainItemWrapper.h"
#import "SavedImgViewConroller.h"



@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *login;
@property (strong, nonatomic) IBOutlet UITextField *pass;
@property (weak, nonatomic) IBOutlet UIButton *checkBoxButton;
@property (strong, nonatomic) UIView *window;
- (IBAction)checkButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;

@end

