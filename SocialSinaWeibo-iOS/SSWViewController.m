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

@interface SSWViewController ()

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
        [composeViewController setInitialText:@"无痛呻吟几下吧。iOS 6 微博集成示例。"];
        [composeViewController addURL:[NSURL URLWithString:@"https://github.com/ashchan/SocialSinaWeibo"]];
        [composeViewController setCompletionHandler:^(SLComposeViewControllerResult result) {
            // check result
        }];

        [self presentViewController:composeViewController animated:YES completion:nil];
    }
}

//3496696657222748

@end
