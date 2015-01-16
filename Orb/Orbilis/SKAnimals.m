//
//  SKAnimals.m
//  GameTest
//
//  Created by Lorenzo Saraiva on 1/15/15.
//  Copyright (c) 2015 Lorenzo Saraiva. All rights reserved.
//

#import "SKAnimals.h"

@implementation SKAnimals

+(SKAnimals*)createAnimalofType:(AnimalType)type{
    SKAnimals * temp;
    if (type == Animal_Herbivore){
        temp = [SKAnimals spriteNodeWithImageNamed:@"animal.png"];
        temp.strenght = 0;
        temp.energy = 160;
        temp.energyValue = 80;
        temp.multiplyLimit = 300;
        temp.animalType = 0;
    }
    if (type == Animal_Carnivore){
        temp = [SKAnimals spriteNodeWithImageNamed:@"donkey.png"];
        temp.strenght = 10;
        temp.energy = 200;
        temp.energyValue = 120;
        temp.multiplyLimit = 400;
        temp.animalType = 1;
    }
    if (type == Animal_Predator){
        temp = [SKAnimals spriteNodeWithImageNamed:@"croco.png"];
        temp.strenght = 100;
        temp.energy = 300;
        temp.multiplyLimit = 600;
        temp.animalType = 2;
    
    }
    return temp;
}

@end
