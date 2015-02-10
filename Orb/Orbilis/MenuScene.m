//
//  MenuScene.m
//  Orbilis
//
//  Created by Joao Nassar Galante Guedes on 09/02/15.
//  Copyright (c) 2015 BEPID-PucRJ. All rights reserved.
//

#import "MenuScene.h"
#import "GameScene.h"

@implementation MenuScene

-(void)didMoveToView:(SKView *)view {
    
    SKSpriteNode *back = [SKSpriteNode spriteNodeWithImageNamed:@"FirstScreen.png"];
    back.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    back.size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    [self addChild:back];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self runAction:[SKAction playSoundFileNamed:@"TheValidate.wav" waitForCompletion:YES]];
    [self beginGame];
    
}

-(void)beginGame {
    GameScene *scene = [GameScene sceneWithSize:self.view.bounds.size];
    [self.view presentScene:scene transition:[SKTransition fadeWithColor:[UIColor whiteColor] duration:1.5]];
}

@end
