//
//  FlipsideViewController.m
//  Bibocard1
//
//  Created by Timofey Solonin on 10/5/14.
//  Copyright (c) 2014 Timofey Solonin. All rights reserved.
//

#import "FlipsideViewController.h"
#import "MainViewController.h"



@interface FlipsideViewController ()
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UILabel *StudentId;
@property (strong, nonatomic) IBOutlet UIView *flipside;

@end

@implementation FlipsideViewController
@synthesize str1, str2, str3, str4, studentImage, label, barcode, photo, flipside;


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

- (void)saveImage: (UIImage*)image
{
    if (image != nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          @"photo.png" ];
        NSData* data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
    }
}

- (void)saveBarcode: (UIImage*)image
{
    if (image != nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          @"barcode.png" ];
        NSData* data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    destination = [[UIScreen mainScreen] bounds].size.height;

    // Do any additional setup after loading the view, typically from a nib.
    NSMutableString *buffer = [[NSMutableString alloc] initWithString:@"ID #"];
    [buffer appendString:str3];
    _StudentId.text = buffer;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix *result = [writer encode:str3
                                  format:kBarcodeFormatCode39
                                   width:400
                                  height:50
                                   error:nil];
    
    CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
    UIImage *myIm = [[UIImage alloc] initWithCGImage: image];
    [barcode setImage: myIm];
    [photo setImage: studentImage];
    label.text = str4;
    
    [self saveImage: studentImage];
    [self saveBarcode: myIm];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}


- (IBAction)done:(id)sender
{
    
    [self performSegueWithIdentifier:@"2" sender:sender];

}

@end
