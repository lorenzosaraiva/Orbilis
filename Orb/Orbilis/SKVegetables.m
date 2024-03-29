//
//  SKVegetables.m
//  Orbilis
//
//  Created by Lorenzo Saraiva on 1/16/15.
//  Copyright (c) 2015 BEPID-PucRJ. All rights reserved.
//

#import "SKVegetables.h"

@implementation SKVegetables

+(SKVegetables*)createVegetableOfType:(VegetableType)type {
    
    SKVegetables *new;

    if (type == Vegetable_Tree) {

        int treeImage = arc4random()%2;

        if (treeImage){
            new = [SKVegetables spriteNodeWithImageNamed:@"arvore1.png"];
            new.size = CGSizeMake(new.frame.size.width * 0.5f, new.frame.size.height * 0.5f);
        }
        else{
            new = [SKVegetables spriteNodeWithImageNamed:@"arvore2.png"];
            new.size = CGSizeMake(new.frame.size.width * 0.4f, new.frame.size.height * 0.4f);
        }
        new.energyValue = 1;
        new.leaves = 1;
        new.energy = 720;
        new.leavesCounter = 0;
        new.growthCounter = 0;
        new.leavesGrowth = 5;
        new.growthTime = 0;
        new.maxGrowth = getRandomN(5, 9);
        new.isNew = true;
        new.multiplyRate = 400;
        new.vegetableType = Vegetable_Tree;
    }
    
    if (type == Vegetable_Grass){
        
        new = [SKVegetables spriteNodeWithImageNamed:@"MiniTree.png"];
        new.energyValue = 1;
        new.energy = 60;
        new.leaves = 1;
        new.multiplyRate = 40;
        new.vegetableType = Vegetable_Grass;

    }

    new.poisonLevel = 0;
    new.zPosition = 0.4f;
    return new;
}

float getRandomN(float minimum, float maximum) {
    return arc4random_uniform((maximum - minimum) + 1.0) + minimum;
}

@end
