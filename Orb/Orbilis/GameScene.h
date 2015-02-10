//
//  GameScene.h
//  GameTest
//

//  Copyright (c) 2014 Lorenzo Saraiva. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKAnimals.h"
#import "SKVegetables.h"
#import "SKMenuElement.h"
#import "InfoTableViewController.h"

@interface GameScene : SKScene <UIGestureRecognizerDelegate, SKPhysicsContactDelegate>

@property (strong, nonatomic) SKSpriteNode *light;
@property (strong, nonatomic) SKSpriteNode *dark;
@property BOOL lightDark;


@property (strong, nonatomic) SKShapeNode *islandShape;
@property (strong, nonatomic) SKSpriteNode *infoButton;
@property (strong, nonatomic) SKSpriteNode *removeButton;
@property (strong, nonatomic) SKSpriteNode *sun;
@property (strong, nonatomic) SKSpriteNode *moon;
@property (strong, nonatomic) SKSpriteNode *island;
@property (strong, nonatomic) SKSpriteNode *sand;
@property (strong, nonatomic) SKSpriteNode *sea;
@property (strong, nonatomic) SKSpriteNode *water;
@property (strong, nonatomic) SKSpriteNode *cage;
@property (strong, nonatomic) SKSpriteNode *sky;
@property (strong, nonatomic) SKSpriteNode *orangeSky;
@property (strong, nonatomic) SKSpriteNode *lightOrangeSky;
@property (strong, nonatomic) SKSpriteNode *lightBlueSky;
@property (strong, nonatomic) SKSpriteNode *nightSky;
@property (strong, nonatomic) SKSpriteNode *currentSky;
@property (strong, nonatomic) SKSpriteNode *lastSky;
@property (strong, nonatomic) NSMutableArray *animalArray;
@property (strong, nonatomic) NSMutableArray *sceneryArray;
@property (strong, nonatomic) NSMutableArray *vegetableArray;
@property (strong, nonatomic) NSMutableArray *menuArray;
@property (strong, nonatomic) NSMutableArray *pollutionArray;
@property (strong, nonatomic) NSMutableArray *waterPollutionArray;
@property (strong, nonatomic) UILabel *temperatureLabel;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval timeSinceLast;
@property (nonatomic) CGPoint lastTouch;



@property float temperature;
@property float pollution;
@property float humidity;
@property float secondsToNight;
@property float nightDuration;

@property float luminosity;
@property float waterPollution;
@property float airPollution;
@property float earthPollution;

@property int global;
@property int tree;
@property int grass;
@property int herbivores;

@property BOOL isMenu;
@property BOOL clickedOnMenu;
@property BOOL isNight;

@end
