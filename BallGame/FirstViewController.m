//
//  FirstViewController.m
//  BallGame
//
//  Created by 武淅 段 on 16/5/25.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

#import "FirstViewController.h"
#import "ConstantManager.h"
#import "OpenGifyViewController.h"
#import "CustomToast.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)single:(id)sender {
    
    [self performSegueWithIdentifier:@"open" sender:@"single"];
}

- (IBAction)randomOpen:(id)sender {
    [self performSegueWithIdentifier:@"open" sender:@"random"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"open"]){
        OpenGifyViewController *vc = segue.destinationViewController;
        if([sender isEqualToString:@"single"]){
            vc.signleNum = YES;
        }
        else{
            vc.signleNum = NO;
        }
    }
}


@end
