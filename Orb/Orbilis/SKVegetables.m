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
    
    SKVegetables *new;
    if (type == Vegetable_Tree){
    int a = arc4random()%2;
        if (a){
            new = [SKVegetables spriteNodeWithImageNamed:@"árvore1.png"];
            new.size = CGSizeMake(new.frame.size.width * 0.5f, new.frame.size.height * 0.5f);
        }
        else{
            new = [SKVegetables spriteNodeWithImageNamed:@"arvore2.png"];
            new.size = CGSizeMake(new.frame.size.width * 0.4f, new.frame.size.height * 0.4f);
        }
    }
    new.energyValue = 10;
    new.leaves = 10;
    new.energy = 720;
    new.leavesCounter = 18;
    new.growthCounter = 0;
    new.growthTime = 0;
    new.isNew = true;
    new.multiplyRate = 400;
    new.vegetableType = Vegetable_Tree;
    
    if (type == Vegetable_Grass){
        
        new = [SKVegetables spriteNodeWithImageNamed:@"arvore3.png"];
        new.energyValue = 5;
        new.energy = 30;
        new.leaves = 5;
        new.multiplyRate = 100;
        new.vegetableType = Vegetable_Grass;
    
    
    
    }
    return new;

}

@end
