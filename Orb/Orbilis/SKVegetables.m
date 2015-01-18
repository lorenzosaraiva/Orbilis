//
//  SKVegetables.m
//  Orbilis
//
//  Created by Lorenzo Saraiva on 1/16/15.
//  Copyright (c) 2015 BEPID-PucRJ. All rights reserved.
//

#import "SKVegetables.h"

@implementation SKVegetables

+(SKVegetables*)createVegetableOfType:(VegetableType)type{

    SKVegetables *new = [SKVegetables spriteNodeWithImageNamed:@"tree.png"];
    new.energyValue = 10;
    new.leaves = 10;
    new.energy = 720;
    new.leavesCounter = 18;
    new.growthCounter = 0;
    new.growthTime = 0;
    return new;

}

@end
