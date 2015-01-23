//
//  SKVegetables.h
//  Orbilis
//
//  Created by Lorenzo Saraiva on 1/16/15.
//  Copyright (c) 2015 BEPID-PucRJ. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKVegetables : SKSpriteNode

typedef enum SKVegetableType {
    
    Vegetable_Tree = 0,
    Vegetable_Grass  = 1
    
} VegetableType;

+(SKVegetables*)createVegetableOfType:(VegetableType)type;

@property VegetableType vegetableType;

@property int idealLight;

@property int idealTemperature;

@property int pollutionResistance;

@property int energyValue;

@property int energy;

@property int leavesCounter;
//numero de folhas

@property int leaves;

@property int growthCounter;

@property int growthTime;

@property int multiplyRate;

@property BOOL isNew;


@end
