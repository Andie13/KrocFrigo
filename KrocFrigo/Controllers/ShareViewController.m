//
//  ShareViewController.m
//  KrocFrigo
//
//  Created by Andie Perrault on 14/09/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
//
#import <MessageUI/MessageUI.h>
#import "ShareViewController.h"
#import <Social/Social.h>
#import "SWRevealViewController.h"


@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self customSetup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customSetup
{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
}

- (IBAction)showEmailAction:(id)sender {
    // Email Subject
    NSString *emailTitle = @"Découvrez l'application KrocFrigo";
    // Email Content
    NSString *messageBody = @"<p>Découvrez la nouvelle application KrocFigo. Parlez en autour de vous, elle va faire un malheur!<br></p>"; // Change the message body to HTML
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@""];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:YES];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    

}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}


- (IBAction)shareOnTwitter:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Découvrez la nouvelle application KrocFigo. Parlez en autour de vous, elle va faire un malheur!"];
        [tweetSheet addImage:[UIImage imageNamed:@"logoKroc.png"]];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }

}
- (IBAction)shareOnFaceBook:(id)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:@"Découvrez la nouvelle application KrocFigo. Parlez en autour de vous, elle va faire un malheur!"];
          [controller addImage:[UIImage imageNamed:@"logoKroc.png"]];
        [self presentViewController:controller animated:YES completion:Nil];
}
}


@end
