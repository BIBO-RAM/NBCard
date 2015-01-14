//
//  FlipsideViewController.h
//  Bibocard1
//
//  Created by Timofey Solonin on 10/5/14.
//  Copyright (c) 2014 Timofey Solonin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZXingObjC/ZXingObjC.h>



static CGFloat destination;
@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;
@property (strong, nonatomic) NSString *str1;
@property (strong, nonatomic) NSString *str2;
@property (strong, nonatomic) NSString *str3;
@property (strong, nonatomic) NSString *str4;
@property (strong, nonatomic) UIImage *studentImage;
@property (strong, nonatomic) IBOutlet UIImageView *barcode;
@property (strong, nonatomic) IBOutlet UIImageView *photo;


- (IBAction)done:(id)sender;

@end
