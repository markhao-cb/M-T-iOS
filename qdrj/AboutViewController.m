//
//  AboutViewController.m
//  qdrj
//
//  Created by Yu Qi Hao on 12/9/14.
//  Copyright (c) 2014 Yu Qi Hao. All rights reserved.
//

#import "AboutViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "AppDelegate.h"
#import "ACETelPrompt.h"
@interface AboutViewController () {
    UIImage *_image;
}
@property (strong, nonatomic) IBOutlet UIImageView *ivBiaozhi;
@property (strong, nonatomic) IBOutlet UILabel *lblBiaoti;
@property (strong, nonatomic) IBOutlet UILabel *lblEmail;

@end

@implementation AboutViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    UIImageView *ivbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    ivbg.image = [UIImage imageNamed:@"qdrjbg.jpg"];
    ivbg.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:ivbg];
    [self.view sendSubviewToBack:ivbg];
    self.view.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"qdrjbg.jpg"]]];
    _image = [UIImage imageNamed:[NSString stringWithFormat:@"biaozhi1.png"]];
    //[_image drawInRect:CGRectMake(0, 0, screenWidth , _image.size.height * screenWidth/_image.size.width)];
    UIImageView *imageView = (id)[self.view viewWithTag:511];
    imageView.image = _image;
    imageView.frame = CGRectMake(0, 0, screenWidth, 1979 * screenWidth / 2800);
//    imageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"menu.png"]]];
    //self.lblBiaoti.frame = CGRectMake(0, _image.size.height +5, screenWidth, _image.size.height);
    [self.view bringSubviewToFront:self.lblBiaoti];
    UIButton *btemail = (id)[self.view viewWithTag:468];
//    CGRect buttonFrame = btemail.frame;
//    buttonFrame.size = CGSizeMake(150, 70);
//    btemail.frame = buttonFrame;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)emailTapped:(id)sender {
    
    if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@"M&T seafood village Feedback"];
        [mailer setToRecipients:@[@"laqdrj@gmail.com"]];
        mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentViewController:mailer animated:YES completion:NULL];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No mail account found"
                                                        message:@"Please create a mail account from your device's Settings first."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Feedback sent" message:@"Thank you!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
            break;
        }
        case MFMailComposeResultFailed:
            break;
        default:
            break;
    }
    
    // Remove the mail view
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)callNumber:(id)sender {
    NSString *number = @"6269137777";
    [ACETelPrompt callPhoneNumber: number
                             call:^(NSTimeInterval duration) {
                                 NSLog(@"User made a call of %.1f seconds", duration);
                                 
                             } cancel:^{
                                 NSLog(@"User cancelled the call");
                             }];

}


@end
