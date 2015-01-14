//
//  SavedImgViewConroller.m
//  nbb
//
//  Created by Mike on 10/10/14.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import "SavedImgViewConroller.h"

@interface SavedImgViewConroller ()


@end

@implementation SavedImgViewConroller
@synthesize nameOfStudentString, numberOfStudentString;


- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    //	(iOS 5)
    //	Only allow rotation to portrait
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (BOOL)shouldAutorotate
{
    //	(iOS 6)
    //	No auto rotating
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    //	(iOS 6)
    //	Only allow rotation to portrait
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    //	(iOS 6)
    //	Force to portrait
    return UIInterfaceOrientationLandscapeLeft;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (UIImage*)loadImage
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:
                      @"photo.png" ];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
}

- (UIImage*)loadBarcode
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      @"barcode.png" ];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _photoOfStudent.image = [self loadImage];
    _photoOfBarcode.image = [self loadBarcode];
    _numberOfStudent.text = [@"ID #" stringByAppendingString: numberOfStudentString];
    _nameOfStudent.text = nameOfStudentString;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onTouch:(id)sender
{
    [self performSegueWithIdentifier:@"done1" sender:sender];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
