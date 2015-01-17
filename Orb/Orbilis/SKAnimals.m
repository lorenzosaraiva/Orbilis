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
        temp.energy = 180;
        temp.energyValue = 100;
        temp.multiplyLimit = 360;
        temp.animalType = 0;
    }
    if (type == Animal_Carnivore){
        temp = [SKAnimals spriteNodeWithImageNamed:@"donkey.png"];
        temp.strenght = 10;
        temp.energy = 180 * 2;
        temp.energyValue = 240;
        temp.multiplyLimit = 500;
        temp.animalType = 1;
    }
    if (type == Animal_Predator){
        temp = [SKAnimals spriteNodeWithImageNamed:@"croco.png"];
        temp.strenght = 100;
        temp.energy = 180 * 2;
        temp.multiplyLimit = 600;
        temp.animalType = 2;
    
    }
    return temp;
}

@end
