//
//  SSWViewController.m
//  SocialSinaWeibo-iOS
//
//  Created by James Chen on 10/2/12.
//  Copyright (c) 2012 ashchan.com. All rights reserved.
//

#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "SSWViewController.h"

@interface SSWViewController () <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *result;

@end

@implementation SSWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saySomething:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
        SLComposeViewController *composeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
        [composeViewController setInitialText:@"iOS 6 微博集成示例代码。"];
        [composeViewController addURL:[NSURL URLWithString:@"https://github.com/ashchan/SocialSinaWeibo"]];
        __block SLComposeViewController *weakComposeVC = composeViewController;
        [composeViewController setCompletionHandler:^(SLComposeViewControllerResult result) {
            self.result.text = SLComposeViewControllerResultDone == result ? @"Sent" : @"Canceled";
            [weakComposeVC dismissViewControllerAnimated:YES completion:nil];
        }];

        [self presentViewController:composeViewController animated:YES completion:nil];
    }
}

- (IBAction)postComment:(id)sender {
    UIAlertView *commentInput = [[UIAlertView alloc] initWithTitle:@"Input Comment"
                                                           message:@"Post comment to one of my status"
                                                          delegate:self
                                                 cancelButtonTitle:@"Cancel"
                                                 otherButtonTitles:@"Post", nil];
    commentInput.alertViewStyle = UIAlertViewStylePlainTextInput;
    [commentInput show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        ACAccountStore *accountStore = [[ACAccountStore alloc] init];
        ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierSinaWeibo];
        [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
            if (!granted) {
                self.result.text = @"Permission not granted";
                return;
            }

            NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/2/comments/create.json"];
            NSDictionary *params = @{
                @"id":          @"3496707910508896",
                @"comment":     [alertView textFieldAtIndex:0].text
            };

            SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeSinaWeibo requestMethod:SLRequestMethodPOST URL:url parameters:params];
            request.account = [[accountStore accountsWithAccountType:accountType] lastObject];

            [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *response = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
                    self.result.text = [@"Post comment result: " stringByAppendingString:response];
                });
            }];
        }];
    }
}

@end
