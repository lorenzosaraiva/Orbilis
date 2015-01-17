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
        temp.energy = 1500;
        temp.energyValue = 800;
        temp.multiplyLimit = 3000;
        temp.animalType = 0;
    }
    if (type == Animal_Carnivore){
        temp = [SKAnimals spriteNodeWithImageNamed:@"donkey.png"];
        temp.strenght = 10;
        temp.energy = 2000;
        temp.energyValue = 1200;
        temp.multiplyLimit = 4000;
        temp.animalType = 1;
    }
    if (type == Animal_Predator){
        temp = [SKAnimals spriteNodeWithImageNamed:@"croco.png"];
        temp.strenght = 100;
        temp.energy = 3000;
        temp.multiplyLimit = 6000;
        temp.animalType = 2;
    
    }
    return temp;
}

@end
