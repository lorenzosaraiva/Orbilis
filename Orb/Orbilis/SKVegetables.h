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

@property int idealLight;

@property int idealTemperature;

@property int pollutionResistance;

//quantos animais pode ainda alimentar

@property int animalsToFeed;

@property int energyValue;

@property int energy;

//numero de folhas

@property int leaves;

@property int nextFeed;

@end
