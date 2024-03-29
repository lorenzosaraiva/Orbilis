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
    Animal_Water_Herbivore = 3,
    Animal_Water_Predator = 4,
    Animal_Sky_Herbivore = 5,
    Animal_Sky_Carnivore = 6
    
} AnimalType;

+(SKAnimals*)createAnimalofType:(AnimalType)type;

@property AnimalType animalType;

@property int strenght;
@property float energy;
@property int defense;
@property int idealTemp;
@property int idealHumidity;
@property int energyValue;
@property int multiplyLimit;
@property int nextMeal;
@property int growth;
@property int ageLimit;
@property int age;

@property BOOL isChild;
@property BOOL performingStopAction;

@end
