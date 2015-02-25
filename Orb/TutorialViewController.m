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
    
    [self drawView];

    
    
    // Do any additional setup after loading the view.
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)drawView{

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/12)];
    [label setFrame:CGRectMake(self.view.frame.size.width/2 - label.frame.size.width/2, 0, label.frame.size.width, label.frame.size.height)];
    label.text = @" Hold anywhere to bring up the menu!";
    [self.view addSubview:label];
    
    UIImage *image = [UIImage imageNamed:@"Menu.png"];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, label.frame.size.height, self.view.frame.size.width, self.view.frame.size.height/4)];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.origin.y + imageView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height/12)];
    [label setFrame:CGRectMake(self.view.frame.size.width/2 - label2.frame.size.width/2, 0, label2.frame.size.width, label2.frame.size.height)];
    label2.text = @" Tap on what you want to add!";
    [self.view addSubview:label2];
    
    UIImage *image2 = [UIImage imageNamed:@"Clicked.png"];
    
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, label2.frame.origin.y + label2.frame.size.height, self.view.frame.size.width, self.view.frame.size.height/4)];
    imageView2.image = image2;
    [self.view addSubview:imageView2];
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end

