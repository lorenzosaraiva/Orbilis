//
//  SKVegetables.h
//  Orbilis
//
//  Created by Lorenzo Saraiva on 1/16/15.
//  Copyright (c) 2015 BEPID-PucRJ. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKVegetables : SKSpriteNode

@property int idealLight;

@property int idealTemperature;

@property int pollutionResistance;

//quantos animais pode ainda alimentar

@property int animalsToFeed;

@property int energyValue;

//quanto falta para o proximo animal poder comer

@property int nextFeed;

@end
