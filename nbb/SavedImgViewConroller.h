//
//  SavedImgViewConroller.h
//  nbb
//
//  Created by Mike on 10/10/14.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SavedImgViewConroller : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *photoOfStudent;
@property (strong, nonatomic) IBOutlet UIImageView *photoOfBarcode;
@property (strong, nonatomic) IBOutlet UILabel *nameOfStudent;
@property (strong, nonatomic) IBOutlet UILabel *numberOfStudent;

@property (strong, nonatomic) NSString *nameOfStudentString;
@property (strong, nonatomic) NSString *numberOfStudentString;

@end
