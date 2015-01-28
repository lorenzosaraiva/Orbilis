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
@property (strong, nonatomic) SKSpriteNode *sky;
@property (strong, nonatomic) SKSpriteNode *orangeSky;
@property (strong, nonatomic) SKSpriteNode *lightOrangeSky;
@property (strong, nonatomic) NSMutableArray *animalArray;
@property (strong, nonatomic) NSMutableArray *sceneryArray;
@property (strong, nonatomic) NSMutableArray *vegetableArray;
@property (strong, nonatomic) NSMutableArray *menuArray;
@property (strong, nonatomic) NSMutableArray *pollutionArray;
@property (strong, nonatomic) UILabel *temperatureLabel;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval timeSinceLast;
@property (nonatomic) CGPoint lastTouch;

@property float temperature;
@property float humidity;
@property float luminosity;
@property float waterPollution;
@property float airPollution;
@property float earthPollution;
@property float pollution;
@property int global;
@property int tree;
@property int grass;
@property int herbivores;

@property BOOL isMenu;
@property BOOL clickedOnMenu;

@end
