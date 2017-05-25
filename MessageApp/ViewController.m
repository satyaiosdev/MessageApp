//
//  ViewController.m
//  MessageApp
//
//  Created by Satya Venkata Krishna Achanta on 5/19/17.
//  Copyright © 2017 Satya Venkata Krishna Achanta. All rights reserved.
//

#import "ViewController.h"
//#import "SecondViewController.h"
#import "MessageApp-Swift.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.navigationItem setTitle:@"Message App Login Page"];
    
    [self loginLabels];
    [self submitButton];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void) loginLabels{
    userName = [[UITextField alloc] initWithFrame:CGRectMake(80, 100, 250, 30)];//Textfield For Username
    userName.placeholder = @"Enter your name here";
    userName.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:userName];
    
    passWord = [[UITextField alloc] initWithFrame:CGRectMake(80, 200, 250, 30)];//Textfield For Password
    passWord.placeholder = @"Enter password";
    passWord.secureTextEntry = YES;
    passWord.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:passWord];
    
}

-(void) submitButton{
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [submitButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [submitButton setFrame:CGRectMake(150, 300, 50, 30)];
    [submitButton setTitle:@"Login" forState:UIControlStateNormal];
    [submitButton setExclusiveTouch:YES];
    submitButton.backgroundColor = [UIColor lightGrayColor];
    
    
    [self.view addSubview:submitButton];
    
    
}
-(void) buttonClicked:(UIButton*)sender
{
//    nameOfTheUser = userName.text;
    [self performSegueWithIdentifier:@"ToChatView" sender:self];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if([segue.identifier isEqualToString:@"ToChatView"])
    {
        SecondViewController *SVC = [segue destinationViewController];
        SVC.nameOfTheUser = userName.text;
    }
    
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
