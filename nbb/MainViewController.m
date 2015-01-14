//
//  MainViewController.m
//  Bibocard1
//
//  Created by Timofey Solonin on 10/5/14.
//  Copyright (c) 2014 Timofey Solonin. All rights reserved.
//



#import "MainViewController.h"
#import "FlipsideViewController.h"

@interface MainViewController ()
- (void) seg: (id) sender;
@property (strong, nonatomic) IBOutlet UILabel *error;
- (NSString *) connectToSky;
- (void) returnSkyw;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadingWheel;
@property (strong, nonatomic) IBOutlet UIButton *GetId;




@end

@implementation MainViewController
@synthesize login, pass, checkBoxButton, window, mainView, scroller;
static NSString *skyReturn;
static NSOperationQueue *q;
NSString *error1 = @"Error: No Internet Connection";
NSString *error2 = @"Error: Invalid login or password";
NSString *error3 = @"Error: Faculty account";
NSString *error4 = @"Error: No login and password";
NSString *error5 = @"Error: No login";
NSString *error6 = @"Error: No password";
NSString *error7 = @"Error: Faculty login attempt";
static NSString *name;
static NSString *checkpass;
static NSString *checklogin;
static NSString *checkskyreturn;
static NSString *checkname;
static UIImage *imageToPass;
static KeychainItemWrapper *keychainItem;

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    //	(iOS 5)
    //	Only allow rotation to portrait
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
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
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    //	(iOS 6)
    //	Force to portrait
    return UIInterfaceOrientationPortrait;
}



- (void) returnSkyw
{
    [self performSelector:@selector(seg:) withObject:nil afterDelay:1];
}
- (void) seg: (id) sender
{
    
    [q waitUntilAllOperationsAreFinished];
    [self performSegueWithIdentifier:@"new" sender:sender];
}
- (NSString *) connectToSky
{
    
    
    if ([login.text isEqualToString:checklogin] && [pass.text isEqualToString:checkpass] ) {
        [self performSegueWithIdentifier:@"new2" sender:nil];
        return 0;
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *serializerRequest = [AFHTTPRequestSerializer serializer];
    AFHTTPResponseSerializer *serializerResponse = [AFHTTPResponseSerializer serializer];
    
    [serializerResponse setAcceptableContentTypes: [NSSet setWithObject:@"text/xml"]];
    
    manager.requestSerializer = serializerRequest;
    manager.responseSerializer = serializerResponse;
    
    NSDictionary *parameters = @{
                                 @"requestAction":	@"eel",
                                 @"codeType":	@"tryLogin",
                                 @"login":	login.text,
                                 @"password":	pass.text,
                                 };
    [manager POST:@"https://skyward.iscorp.com/scripts/wsisa.dll/WService=wsedumeritasil/skyporthttp.w" parameters:parameters
     
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              @try {
                  NSString *mystring = [NSString new];
                  mystring = [NSString stringWithUTF8String:[responseObject bytes]];
                  NSString *newstring = [[mystring substringFromIndex:4] substringToIndex:(mystring.length - 9)];
                  NSArray *newArray = [newstring componentsSeparatedByString:@"^"];
                  
                  AFHTTPRequestOperationManager *manager2 = [AFHTTPRequestOperationManager manager];
                  AFHTTPRequestSerializer *serializerRequest2 = [AFHTTPRequestSerializer serializer];
                  AFHTTPResponseSerializer *serializerResponse2 = [AFHTTPResponseSerializer serializer];
                  [serializerResponse2 setAcceptableContentTypes: [NSSet setWithObject:@"text/html"]];
                  
                  manager2.requestSerializer = serializerRequest2;
                  manager2.responseSerializer = serializerResponse2;
                  
                  NSDictionary *parameters2 = @{
                                                @"dwd":	newArray[0],
                                                @"web-data-recid":	newArray[1],
                                                @"wfaacl-recid":	newArray[2],
                                                @"wfaacl":	newArray[3],
                                                @"duserid":	newArray[5],
                                                @"User-Type":	newArray[6],
                                                @"nameid":	newArray[4],
                                                @"enc": newArray[12],
                                                };
                  [manager2 POST:@"https://skyward.iscorp.com/scripts/wsisa.dll/WService=wsedumeritasil/sfhome01.w" parameters:parameters2
                   
                         success:^(AFHTTPRequestOperation *operation2, id responseObject2) {
                             @try {
                                 if (checkBoxButton.selected) {
                                     [keychainItem setObject:login.text forKey:(__bridge id)(kSecAttrAccount)];
                                     [keychainItem setObject:pass.text forKey:(__bridge id)(kSecValueData)];
                                 }

                                 NSString *mystring2 = [NSString new];
                                 mystring2 = [NSString stringWithUTF8String:[responseObject2 bytes]];
                                 NSArray *newArray2 = [NSArray new];
                                 NSArray *newArray3 = [NSArray new];
                                 
                                 newArray2 = [mystring2 componentsSeparatedByString:@"https://skystorage.iscorp.com/pictures/il/meritas//"];
                                 
                                 newArray3 = [newArray2[1] componentsSeparatedByString:@".jpg"];
                                 
                                 skyReturn = newArray3[0];
                                 
                                 checkskyreturn = skyReturn;
                                 
                                 NSString *urlstring = @"https://skystorage.iscorp.com/pictures/il/meritas//";
                                 NSString *endstring = [[NSString alloc]init];
                                 NSString *endstring2 = [[NSString alloc]init];
                                 endstring = [urlstring stringByAppendingString: skyReturn];
                                 endstring2 = [endstring stringByAppendingFormat: @".jpg"];
                                 NSURL *url = [NSURL URLWithString: endstring2];
                                 NSData *data = [NSData dataWithContentsOfURL: url];
                                 imageToPass = [UIImage imageWithData: data];
                                 
                                 newArray2 = [mystring2 componentsSeparatedByString:@"        </li>"];
                                 newArray3 = [newArray2[0] componentsSeparatedByString:@"<li class="];
                                 name = [newArray3[2] substringFromIndex:58];
                                 checkname = name;
                                 [keychainItem setObject:skyReturn forKey:(__bridge id)(kSecAttrComment)];
                                 [keychainItem setObject:name forKey:(__bridge id)(kSecAttrDescription)];
                                 [q waitUntilAllOperationsAreFinished];
                                 [self performSelectorOnMainThread:@selector(returnSkyw) withObject:nil waitUntilDone:NO];
                             }
                             @catch (NSException *exception) {
                                 
                                 
                                 [self performSelector:@selector(fadeInLabels:) withObject:error7 afterDelay:0.1f];
                                 
                             }
                         }
                   
                         failure:^(AFHTTPRequestOperation *operation2, NSError *error) {
                             
                             /* LEAVE EMPTY */
                             
                         }
                   ];
              }
              @catch (NSException *exception) {
                  pass.text = @"";
                  [pass becomeFirstResponder];
                  [self performSelector:@selector(fadeInLabels:) withObject:error2 afterDelay:0.1f];
              }
              
          }
     
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              if ([pass.text isEqualToString:checkpass] && [login.text isEqualToString:checklogin]) [self performSegueWithIdentifier:@"new2" sender:self];
              else [self performSelector:@selector(fadeInLabels:) withObject:error1 afterDelay:0.1f];
          }
     ];
    
    return skyReturn;
}

- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}

- (void)viewDidLoad
{
   
    
    
    [super viewDidLoad];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    [self.scroller setContentSize:CGSizeMake(screenBounds.size.width, screenBounds.size.height+1)];
    
    UIGestureRecognizer *tapper;
    
    
        tapper = [[UITapGestureRecognizer alloc]
                  initWithTarget:self action:@selector(handleSingleTap:)];
        tapper.cancelsTouchesInView = NO;
        [self.view addGestureRecognizer:tapper];
    
    
    login.autocorrectionType = UITextAutocorrectionTypeNo;
    
 
    self.scroller.scrollEnabled = YES;
    pass.secureTextEntry = YES;
    _GetId.hidden = NO;
    _loadingWheel.hidden = YES;
    [_loadingWheel startAnimating];
    keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"NBID" accessGroup:nil];
    
    /* Recieving login and password from keychain*/
    NSData *pwd = [[NSData alloc] initWithData:[keychainItem objectForKey:(__bridge id)(kSecValueData)]];
    checkpass = [[NSString alloc] initWithData:pwd encoding:NSUTF8StringEncoding];
    checklogin = [keychainItem objectForKey:(__bridge id)(kSecAttrAccount)];
    /* END */
    checkskyreturn = [keychainItem objectForKey:(__bridge id)(kSecAttrComment)];
    checkname = [keychainItem objectForKey:(__bridge id)(kSecAttrDescription)];
    if (checkpass.length != 0 && checklogin.length != 0) {
        [checkBoxButton setImage:[UIImage imageNamed:@"checkBoxMarked.png"] forState:UIControlStateNormal];
        checkBoxButton.selected = YES;
        login.text = checklogin;
        pass.text = checkpass;
    }
   
    
    
   

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)connect:(id)sender {
    
    
    
    
    if (pass.text.length==0 && login.text.length==0) {
        [login becomeFirstResponder];
        [self performSelector:@selector(fadeInLabels:) withObject:error4 afterDelay:0.1f];
        
        
    }
    else if (login.text.length==0) {
        [login becomeFirstResponder];
        [self performSelector:@selector(fadeInLabels:) withObject:error5 afterDelay:0.1f];
        
        
    }
    else if (pass.text.length==0)
    {
        [pass becomeFirstResponder];
        [self performSelector:@selector(fadeInLabels:) withObject:error6 afterDelay:0.1f];
        
        
        
        
    }
    else {

        _GetId.hidden = YES;
        _loadingWheel.hidden = NO;
        [login resignFirstResponder];
        [pass resignFirstResponder];
        
        [q setMaxConcurrentOperationCount:1];
        NSInvocationOperation *firstOp = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(connectToSky) object:nil];
        [q addOperation:firstOp];
        
        [firstOp start];
        if (!checkBoxButton.selected) {
            [keychainItem resetKeychainItem];
            
            
        }
    }
}


/* Beauty and Crutches */

-(void)fadeInLabels:(NSString *) error
{
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveLinear
                     animations:^ {
                         _GetId.hidden = NO;
                         _loadingWheel.hidden = YES;
                         _error.alpha = 0.0;
                         _error.alpha = 1.0;
                         _error.text = error;
                         _error.textColor = [UIColor redColor];
                         
                     }
                     completion:^(BOOL finished) {
                         
                         [self performSelector:@selector(fadeOutLabels) withObject:nil afterDelay:0.1f];
                         
                     }];
}

- (void)fadeOutLabels {
    
    [UIView animateWithDuration:1.0 delay:2.0 options:UIViewAnimationOptionCurveLinear
                     animations:^ {
                         
                         if ((_error.alpha = 1.0)) {
                             _error.alpha = 1.0;
                             _error.alpha = 0.0;
                             _error.textColor = [UIColor redColor];
                         }
                         else
                         {
                             _error.alpha = 0.0;
                             _error.alpha = 0.0;
                         }
                     }
                     completion:^(BOOL finished) {
                         
                         
                     }];
    
}
- (IBAction)loginAnimation:(id)sender {
    [pass becomeFirstResponder];
}
- (IBAction)crazyCrutchesForPass:(id)sender {
    if ([pass text].length == 0) pass.placeholder = @" ";
    if ([login text].length == 0) login.placeholder = @"Login";
    
}
- (IBAction)crazyCrutchesForLogin:(id)sender {
    if ([login text].length == 0) login.placeholder = @" ";
    if ([pass text].length == 0) pass.placeholder = @"Password";
    
}
- (IBAction)crazyCrutchesForLoginEnd:(id)sender {
    if ([login text].length == 0) login.placeholder = @"Login";
}
- (IBAction)crazyCrutchesForPassEnd:(id)sender {
    if ([pass text].length == 0) pass.placeholder = @"Password";
}
- (IBAction)checkButton:(id)sender {
    
    if (checkBoxButton.selected) {
        [checkBoxButton setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
        checkBoxButton.selected = NO;
    }
    else {
        [checkBoxButton setImage:[UIImage imageNamed:@"checkBoxMarked.png"] forState:UIControlStateNormal];
        checkBoxButton.selected = YES;
    }
}


#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString: @"new"]) {
    FlipsideViewController *VC = [segue destinationViewController];
    VC.str3 = skyReturn;
    VC.str4 = name;
    VC.studentImage = imageToPass;
    }
    else if ([[segue identifier] isEqualToString:@"new2"]) {
        SavedImgViewConroller *SC = [segue destinationViewController];
        SC.nameOfStudentString = [keychainItem objectForKey:(__bridge id)(kSecAttrDescription)];
        SC.numberOfStudentString = [keychainItem objectForKey:(__bridge id)(kSecAttrComment)];
    }

    
}

@end