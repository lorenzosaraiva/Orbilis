//
//  GameScene.h
//  GameTest
//

//  Copyright (c) 2014 Lorenzo Saraiva. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKAnimals.h"
#import "SKVegetables.h"

@interface GameScene : SKScene <UIGestureRecognizerDelegate, SKPhysicsContactDelegate>

@property (strong, nonatomic) SKSpriteNode *sun;

@property (strong, nonatomic) SKSpriteNode *island;

@property (strong, nonatomic) SKSpriteNode *sand;

@property (strong ,nonatomic) NSMutableArray *animalArray;

@property (strong, nonatomic) NSMutableArray *sceneryArray;

@property (strong, nonatomic) NSMutableArray *vegetableArray;

@property (strong, nonatomic) NSMutableArray *menuArray;

@property (strong, nonatomic) UILabel *temperatureLabel;

@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;

@property (nonatomic) NSTimeInterval timeSinceLast;

@property float temperature;

@property BOOL isMenu;

@end
