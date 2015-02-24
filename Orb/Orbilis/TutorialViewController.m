//
//  InfoTableViewController.m
//  Orbilis
//
//  Created by Lorenzo Saraiva on 2/10/15.
//  Copyright (c) 2015 BEPID-PucRJ. All rights reserved.
//

#import "InfoTableViewController.h"

@interface InfoTableViewController ()

@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prefersStatusBarHidden];
    self.view.backgroundColor = [UIColor colorWithRed:204/255.0 green:229/255.0 blue:180/255.0 alpha:1];
    
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 35, 5, 30, 30)];
    [backButton setImage:[UIImage imageNamed:@"InfoButton 2.png"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    
    // Do any additional setup after loading the view.
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
