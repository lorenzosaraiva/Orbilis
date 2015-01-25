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
        temp.energy = 90;
        temp.energyValue = 100;
        temp.multiplyLimit = 400;
        temp.animalType = 0;
        temp.growth = 0;
        temp.isChild = YES;
    }
    if (type == Animal_Carnivore){
        temp = [SKAnimals spriteNodeWithImageNamed:@"donkey.png"];
        temp.strenght = 10;
        temp.energy = 180 * 2;
        temp.energyValue = 240;
        temp.multiplyLimit = 800;
        temp.animalType = 1;
        temp.nextMeal = 10;
        temp.growth = 0;
        temp.isChild = YES;
    }
    if (type == Animal_Predator){
        temp = [SKAnimals spriteNodeWithImageNamed:@"croco.png"];
        temp.strenght = 100;
        temp.energy = 180 * 2;
        temp.multiplyLimit = 1200;
        temp.animalType = 2;
        temp.nextMeal = 15;
        temp.growth = 0;
        temp.isChild = YES;
    
    }
    if (type == Animal_Water_Herbivore){
        int a = arc4random()%2;
        if (a)
            temp = [SKAnimals spriteNodeWithImageNamed:@"Peixe1"];
        else
            temp = [SKAnimals spriteNodeWithImageNamed:@"Peixe2"];
        temp.animalType = Animal_Water_Herbivore;
        temp.size = CGSizeMake(temp.frame.size.width * 0.5f, temp.frame.size.height * 0.5f);
        temp.energy = 180;
        temp.multiplyLimit = 300;
        temp.strenght = 1;
        temp.energyValue = 50;
    }
    if (type == Animal_Water_Predator){
        int a = arc4random()%2;
        if (a)
            temp = [SKAnimals spriteNodeWithImageNamed:@"Peixe3"];
        else
            temp = [SKAnimals spriteNodeWithImageNamed:@"Peixe4"];
        temp.animalType = Animal_Water_Predator;
        temp.size = CGSizeMake(temp.frame.size.width * 0.5f, temp.frame.size.height * 0.5f);
        temp.energy = 180;
        temp.multiplyLimit = 300;
        temp.strenght = 10;
    
    }
    temp.zPosition = 0.5f;
    return temp;
}

@end
