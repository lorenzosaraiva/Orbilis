//
//  InfoTableViewController.h
//  Orbilis
//
//  Created by Lorenzo Saraiva on 2/10/15.
//  Copyright (c) 2015 BEPID-PucRJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameScene.h"

@interface InfoTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property float temperature;
@property int animals;
@property int herbivores;
@property int carnivores;
@property int predators;
@property float humidity;
@property float pollution;
@property float vegetables;

@end
