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
   
    SKAnimals *temp;
    
    if (type == Animal_Herbivore){
        temp = [SKAnimals spriteNodeWithImageNamed:@"GroundOne.png"];
        temp.energy = 0.5;
        temp.energyValue = 1;
        temp.multiplyLimit = 2;
        temp.animalType = 0;
        temp.nextMeal = 3;
        temp.age = 0;
        temp.ageLimit = 30;
    }
    if (type == Animal_Carnivore){
        temp = [SKAnimals spriteNodeWithImageNamed:@"GroundTwo.png"];
        temp.energy = 0.5;
        temp.energyValue = 1;
        temp.multiplyLimit = 4;
        temp.animalType = 1;
        temp.nextMeal = 0;
        temp.age = 0;
        temp.ageLimit = 45;
    }
    if (type == Animal_Predator){
        temp = [SKAnimals spriteNodeWithImageNamed:@"GroundThree.png"];
        temp.energy = 0.3;
        temp.multiplyLimit = 4;
        temp.animalType = 2;
        temp.nextMeal = 5;
        temp.age = 0;
        temp.ageLimit = 60;
    }
    
    if (type == Animal_Water_Herbivore){
        int a = arc4random()%2;
        if (a)
            temp = [SKAnimals spriteNodeWithImageNamed:@"Peixe1"];
        else
            temp = [SKAnimals spriteNodeWithImageNamed:@"Peixe2"];
        temp.animalType = Animal_Water_Herbivore;
        temp.size = CGSizeMake(temp.frame.size.width * 0.5f, temp.frame.size.height * 0.5f);
        temp.energy = 0.5;
        temp.multiplyLimit = 3;
        temp.age = 0;
        temp.ageLimit = 60;
        temp.energyValue = 1;
    }
    if (type == Animal_Water_Predator){
        int a = arc4random()%2;
        if (a)
            temp = [SKAnimals spriteNodeWithImageNamed:@"Peixe3"];
        else
            temp = [SKAnimals spriteNodeWithImageNamed:@"Peixe4"];
        temp.animalType = Animal_Water_Predator;
        temp.size = CGSizeMake(temp.frame.size.width * 0.5f, temp.frame.size.height * 0.5f);
        temp.energy = 0.5;
        temp.age = 0;
        temp.ageLimit = 180;
        temp.multiplyLimit = 1;
        temp.nextMeal = 10;
    
    
    }
    
    temp.performingStopAction = NO;
    temp.zPosition = 0.5f;
    return temp;
}

@end
