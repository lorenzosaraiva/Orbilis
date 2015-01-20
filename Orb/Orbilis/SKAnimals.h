//
//  SKAnimals.h
//  GameTest
//
//  Created by Lorenzo Saraiva on 1/15/15.
//  Copyright (c) 2015 Lorenzo Saraiva. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKAnimals : SKSpriteNode

typedef enum SKAnimalType {
    
    Animal_Herbivore = 0,
    Animal_Carnivore  = 1,
    Animal_Predator  = 2,
    
} AnimalType;

+(SKAnimals*)createAnimalofType:(AnimalType)type;

@property AnimalType animalType;

@property int strenght;

@property int energy;

@property int defense;

@property int idealTemp;

@property int idealHumidity;

@property int energyValue;

@property int multiplyLimit;

@property int nextMeal;

@end
