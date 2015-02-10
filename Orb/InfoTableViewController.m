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

@implementation InfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prefersStatusBarHidden];
    self.view.backgroundColor = [UIColor colorWithRed:204/255.0 green:229/255.0 blue:180/255.0 alpha:1];
    
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 35, 5, 30, 30)];
    [backButton setImage:[UIImage imageNamed:@"InfoButton 2.png"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, self.view.frame.size.height - 175)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:204/255.0 green:229/255.0 blue:180/255.0 alpha:1];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];

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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.backgroundColor = [UIColor colorWithRed:204/255.0 green:229/255.0 blue:180/255.0 alpha:1];
    cell.userInteractionEnabled = NO;
    if (indexPath.row == 0){
        cell.textLabel.text = [[NSString alloc]initWithFormat:@"Temperature : %.f °C", self.temperature];
        cell.imageView.image = [UIImage imageNamed:@"Sol.png"];
    }
    if (indexPath.row == 1){
        cell.textLabel.text = [[NSString alloc]initWithFormat:@"Animals : %d", self.animals];
        cell.imageView.image = [UIImage imageNamed:@"GroundOne.png"];
    }
    if (indexPath.row == 2){
        cell.textLabel.text = [[NSString alloc]initWithFormat:@"Humidity : %.f %%", self.humidity];
        cell.imageView.image = [UIImage imageNamed:@"nuvem4.png"];

    }
    if (indexPath.row == 3){
        cell.textLabel.text = [[NSString alloc]initWithFormat:@"Pollution : %.f %%", self.pollution];
        cell.imageView.image = [UIImage imageNamed:@"industria.png"];
    }
    if (indexPath.row == 4){
        cell.textLabel.text = [[NSString alloc]initWithFormat:@"Vegetables : %f", self.vegetables];
        cell.imageView.image = [UIImage imageNamed:@"arvore3.png"];
    }


    return cell;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
