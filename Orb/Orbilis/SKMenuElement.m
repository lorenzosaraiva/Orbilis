//
//  SKMenuElement.m
//  Orbilis
//
//  Created by Lorenzo Saraiva on 2/9/15.
//  Copyright (c) 2015 BEPID-PucRJ. All rights reserved.
//

#import "SKMenuElement.h"

@implementation SKMenuElement

+(SKMenuElement*)createMenuElementOfType:(MenuElementType)type InPosition:(CGPoint)positionInScene{

    SKMenuElement *newElement;
    
    if (type == 0){
        newElement = [SKMenuElement spriteNodeWithImageNamed:@"MenuHerb.png"];
        newElement.size = CGSizeMake(newElement.size.width * 0.4f,newElement.size.height * 0.4f);
        newElement.position = CGPointMake(positionInScene.x + newElement.frame.size.width/2 + 10, positionInScene.y + newElement.frame.size.height/2 + 5);
        newElement.zPosition = 1.0f;
        newElement.elementType = 0;
    }
    
    if (type == 1){
        newElement = [SKMenuElement spriteNodeWithImageNamed:@"MenuCarn1.png"];
        newElement.size = CGSizeMake(newElement.size.width * 0.4f,newElement.size.height * 0.4f);
        newElement.position = CGPointMake(positionInScene.x, positionInScene.y - newElement.frame.size.height/2 - 10);
        newElement.zPosition = 1.0f;
        newElement.elementType = 1;
    }
    
    if (type == 2){
       newElement = [SKMenuElement spriteNodeWithImageNamed:@"MenuCarn2.png"];
        newElement.size = CGSizeMake(newElement.size.width * 0.4f,newElement.size.height * 0.4f);
        newElement.position = CGPointMake(positionInScene.x + newElement.frame.size.width/2 + 10, positionInScene.y - newElement.frame.size.height/2 - 5);
        newElement.zPosition = 1.0f;
        newElement.elementType = 2;

    }
    
    if (type == 3){
        newElement = [SKMenuElement spriteNodeWithImageNamed:@"MenuGrass.png"];
        newElement.size = CGSizeMake(newElement.size.width * 0.4f,newElement.size.height * 0.4f);
        newElement.position = CGPointMake(positionInScene.x - newElement.frame.size.width/2 - 10, positionInScene.y + newElement.frame.size.height/2 + 5);
        newElement.zPosition = 1.0f;
        newElement.elementType = 3;
    }
    
    if (type == 4){
    
        newElement = [SKMenuElement spriteNodeWithImageNamed:@"MenuTree.png"];
        newElement.size = CGSizeMake(newElement.size.width * 0.4f,newElement.size.height * 0.4f);
        newElement.position = CGPointMake(positionInScene.x - newElement.frame.size.width/2 - 10, positionInScene.y - newElement.frame.size.height/2 - 5);
        newElement.zPosition = 1.0f;
        newElement.elementType = 4;
    }
    
    if (type == 5){
        
        newElement = [SKMenuElement spriteNodeWithImageNamed:@"MenuInd.png"];
        newElement.size = CGSizeMake(newElement.size.width * 0.4f,newElement.size.height * 0.4f);
        newElement.position = CGPointMake(positionInScene.x - 1, positionInScene.y + newElement.frame.size.height/2 + 10);
        newElement.zPosition = 1.0f;
        newElement.elementType = 5;
    }
    
    if (type == 6){
        
        newElement = [SKMenuElement spriteNodeWithImageNamed:@"bird.png"];
        newElement.position = CGPointMake(positionInScene.x, positionInScene.y);
        newElement.zPosition = 1.0f;
        newElement.elementType = 6;
    }
    return newElement;
}

@end
