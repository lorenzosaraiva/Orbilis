//
//  SKMenuElement.h
//  Orbilis
//
//  Created by Lorenzo Saraiva on 2/9/15.
//  Copyright (c) 2015 BEPID-PucRJ. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKMenuElement : SKSpriteNode

typedef enum SKMenuElementType {
    
    Animal_Herbivore_Menu = 0,
    Animal_Carnivore_Menu = 1,
    Animal_Predator_Menu = 2,
    Vegetable_Grass_Menu = 3,
    Vegetable_Tree_Menu = 4,
    Pollution_Factory_Menu = 5
    
} MenuElementType;

+(SKMenuElement*)createMenuElementOfType:(MenuElementType)type InPosition:(CGPoint)positionInScene;

@property MenuElementType elementType;

@end
