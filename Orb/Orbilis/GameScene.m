//
//  GameScene.m
//  GameTest
//
//  Created by Lorenzo Saraiva on 12/11/14.
//  Copyright (c) 2014 Lorenzo Saraiva. All rights reserved.
//

#import "GameScene.h"



@implementation GameScene

int global = 0;

-(void)didMoveToView:(SKView *)view {
    
    // inicia e alloca as coisas iniciais
    
    self.isMenu = false;
    self.temperature = 27;
    self.animalArray = [[NSMutableArray alloc]init];
    self.menuArray = [[NSMutableArray alloc]init];
    self.vegetableArray = [[NSMutableArray alloc]init];
    self.sceneryArray = [[NSMutableArray alloc]init];
    // cria e define posicao dos elementos da tela
    
    
    SKSpriteNode *sea = [SKSpriteNode spriteNodeWithImageNamed:@"Sea.png"];
    sea.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame) - 70);
    sea.size = CGSizeMake(sea.frame.size.width * 0.67f, sea.frame.size.height * 0.67f);
    
    SKSpriteNode *water = [SKSpriteNode spriteNodeWithImageNamed:@"Water.png"];
    water.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame) - 70);
    water.size = CGSizeMake(water.frame.size.width * 0.67f, water.frame.size.height * 0.67f);
    
    self.sand = [SKSpriteNode spriteNodeWithImageNamed:@"Sand.png"];
    self.sand.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame) - 70);
    self.sand.size = CGSizeMake(self.sand.frame.size.width * 0.66f, self.sand.frame.size.height * 0.66f);
    
    self.island = [SKSpriteNode spriteNodeWithImageNamed:@"Island.png"];
    self.island.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 15);
    self.island.size = CGSizeMake(self.island.frame.size.width * 0.66f, self.island.frame.size.height * 0.66f);
    
    SKSpriteNode *sky = [SKSpriteNode spriteNodeWithImageNamed:@"Sky.png"];
    sky.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 31);
    sky.size = CGSizeMake(sky.frame.size.width * 0.68f, sky.frame.size.height * 0.7f);
    
    SKSpriteNode *cage = [SKSpriteNode spriteNodeWithImageNamed:@"Cage.png"];
    cage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    cage.size = CGSizeMake(cage.frame.size.width * 0.7f, cage.frame.size.height * 0.7f);
    
    self.sun = [SKSpriteNode spriteNodeWithImageNamed:@"sun.jpg"];
    self.sun.position = CGPointMake(170, 550);
    [self addChild:sky];
    [self addChild:sea];
    [self addChild:water];
    [self addChild:self.sand];
    [self addChild:self.island];
    [self addChild:cage];
    
    [self addChild:self.sun];
    
    
    
    
    // configura os gesture recognizer
    
    UISwipeGestureRecognizer *swipeLeftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    swipeLeftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer *swipeRightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    swipeLeftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeRightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightRecognizer];
    [self.view addGestureRecognizer:swipeLeftRecognizer];
    
    // mostra o termometro
    
    self.temperatureLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 50, 0, 50, 50)];
    self.temperatureLabel.text = [NSString stringWithFormat:@"%.f",self.temperature];
    [self.view addSubview:self.temperatureLabel];
    
}

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    
    touchLocation = [self convertPointFromView:touchLocation];
    
    if ([self.sun containsPoint:touchLocation]){
        if ([(UISwipeGestureRecognizer*)recognizer direction] == UISwipeGestureRecognizerDirectionLeft){
            self.sun.size = CGSizeMake(self.sun.frame.size.width * 0.8f, self.sun.frame.size.height * 0.8f);
            self.temperature--;
        }
        else if ([(UISwipeGestureRecognizer*)recognizer direction] == UISwipeGestureRecognizerDirectionRight ){
            self.sun.size = CGSizeMake(self.sun.frame.size.width * 1.2f, self.sun.frame.size.height * 1.2f);
            self.temperature++;
        }
        self.temperatureLabel.text = [NSString stringWithFormat:@"%.f",self.temperature];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    NSLog(@"TAP");
    
    // controla o sol
    
    if ([self.sun containsPoint:positionInScene]){
//        [self sunResize];
        return;
    }
    
    // adiciona o elemento correto do pop-up menu
    
    for (int i = 0; i < self.menuArray.count; i++){
        if ([[self.menuArray objectAtIndex:i] isKindOfClass: [SKAnimals class]]){
        SKAnimals *temp = self.menuArray[i];
        if ([temp containsPoint:positionInScene]){
            [self.menuArray removeObject:temp];
            [self removeChildrenInArray:self.menuArray];
            [self.menuArray removeAllObjects];
            [self.animalArray addObject:temp];
            self.isMenu = false;
            return;
            }
        }
        else if ([[self.menuArray objectAtIndex:i] isKindOfClass:[SKVegetables class]]){
            SKVegetables *temp = self.menuArray[i];
            if ([temp containsPoint:positionInScene]){
                [self.menuArray removeObject:temp];
                [self removeChildrenInArray:self.menuArray];
                [self.menuArray removeAllObjects];
                [self.vegetableArray addObject:temp];
                self.isMenu = false;
                return;
        
            }
        }
    }
    
    // remove o elemento clicado
    
    for (int i = 0; i < self.animalArray.count; i++){
        SKAnimals *temp = self.animalArray[i];
        if ([temp containsPoint:positionInScene]){
            [temp removeFromParent];
            return;
        }
    }

    // remove o resto do menu
    
    if (self.isMenu){
        [self removeChildrenInArray:self.menuArray];
        [self.menuArray removeAllObjects];
        self.isMenu = false;
        return;;
    }
    
    // cria os menu
    
    //menu da terra
    if ([self.island containsPoint:positionInScene]){
        SKAnimals *herb = [SKAnimals createAnimalofType:Animal_Herbivore];
        SKAnimals *carn = [SKAnimals createAnimalofType:Animal_Carnivore];
        SKAnimals *bigCarn = [SKAnimals createAnimalofType:Animal_Predator];
        SKVegetables *factory = [SKVegetables spriteNodeWithImageNamed:@"tree.png"];
        carn.size = CGSizeMake(herb.frame.size.width, herb.frame.size.height);
        bigCarn.size = CGSizeMake(herb.frame.size.width, herb.frame.size.height);
        factory.animalsToFeed = 10;
        factory.energyValue = 40;
        factory.nextFeed = 0;
        herb.position = CGPointMake(positionInScene.x, positionInScene.y + 30);
        carn.position = CGPointMake(positionInScene.x, positionInScene.y - 30);
        bigCarn.position = CGPointMake(positionInScene.x + 30, positionInScene.y);
        factory.position = CGPointMake(positionInScene.x - 30, positionInScene.y);
        [self.menuArray addObject:herb];
        [self.menuArray addObject:carn];
        [self.menuArray addObject:bigCarn];
        [self.menuArray addObject:factory];
        [self addChild:herb];
        [self addChild:carn];
        [self addChild:bigCarn];
        [self addChild:factory];
        self.isMenu = true;
        
        
    
    }
//    SKSpriteNode *nuvem  = [SKSpriteNode spriteNodeWithImageNamed:@"nuvem.png"];
//    SKAnimals *animal = [SKAnimals spriteNodeWithImageNamed:@"animal.png"];
//    animal.strenght = arc4random()%10;
//    nuvem.position = CGPointMake(positionInScene.x, positionInScene.y + 20);
//    animal.position = CGPointMake(positionInScene.x, positionInScene.y - 20);
//    [self.menuArray addObject:nuvem];
//    [self.menuArray addObject:animal];
//    [self addChild:animal];
//    [self addChild:nuvem];
//    self.isMenu = true;

}

-(void)sunResize{
    
    self.sun.size = CGSizeMake(self.sun.frame.size.width * 1.5f, self.sun.frame.size.height * 1.5f);
    
}


-(void)update:(CFTimeInterval)currentTime {
   
    for (int i = 0; i < self.animalArray.count; i++){
        
        // movimento
        int a = arc4random()%40;
        int b = arc4random()%40;
        int c = arc4random()%2;
        int d = arc4random()%2;
        if (!c)
            a = -a;
        if (!d)
            b = -b;
        a = a/10;
        b = b/10;
        SKAnimals *temp = self.animalArray[i];
        temp.position = CGPointMake(temp.position.x + a, temp.position.y + b);
        
        //checagem de temperatura
        
        if (self.temperature > 33){
            int a = arc4random()%(int)self.temperature;
            if (a > 32){
                [self.animalArray removeObject:temp];
                [temp removeFromParent];
            }
        }
        
        //update de energia
        
        temp.energy--;
        if (temp.energy <= 0)
            [temp removeFromParent];
        
        
        //multiplicacao
        
        if (temp.animalType == Animal_Herbivore){
        
            int divideChance = arc4random()%100;
            int c = arc4random()%2;
            int d = arc4random()%2;
            if (divideChance < 1){
                SKAnimals *herb = [SKAnimals spriteNodeWithImageNamed:@"animal.png"];
                herb.position = CGPointMake(temp.frame.origin.x + 40*c, temp.frame.origin.y + 40*d);
                [self.animalArray addObject:herb];
                herb.energyValue = 80;
                herb.energy = 160;
                herb.animalType = Animal_Herbivore;
                [self addChild:herb];
                return;
                
            }
            
        }
        
        //checa o contato com plantas
        
        if (temp.animalType == Animal_Herbivore){
    
            for (int k = 0; k < self.vegetableArray.count; k++){
                SKVegetables *temp2 = self.vegetableArray[k];
                if (temp2.nextFeed != 0)
                    temp2.nextFeed--;
                Boolean viewsOverlap = CGRectIntersectsRect(temp.frame, temp2.frame);
                
                if (viewsOverlap){
                    if (temp2.nextFeed == 0){
                    SKAction *shrinkTree = [SKAction scaleTo:0.8f duration:0.5];
                    [temp2 runAction:shrinkTree];
                    temp2.animalsToFeed--;
                    temp2.nextFeed = 10;
                        if (temp2.animalsToFeed <= 0){
                            SKAction *shrink = [SKAction scaleTo:0 duration:0.5];
                            SKAction *remove = [SKAction removeFromParent];
                            SKAction *sequence = [SKAction sequence:@[shrink,remove]];
                            [temp2 runAction:sequence];
                        }
                    }
                }
            }
        }
        
        //checa o contato dos animais
        
        for (int j = 0; j< self.animalArray.count; j++){
            SKAnimals *temp2 =self.animalArray[j];
            if (j == i)
                continue;
            if (temp.animalType == temp2.animalType)
                continue;
            
                Boolean viewsOverlap = CGRectIntersectsRect(temp.frame, temp2.frame);
                if (viewsOverlap){
                    SKAction *shrink = [SKAction scaleTo:0 duration:1];
                    SKAction *remove = [SKAction removeFromParent];
                    SKAction *sequence = [SKAction sequence:@[shrink,remove]];
                    if ([(SKAnimals*)temp strenght] > [(SKAnimals*)temp2 strenght]){
                        temp.energy += temp2.energyValue;
                        [temp2 runAction:sequence];
                        [self.animalArray removeObject:temp2];
                        NSLog(@"Foi removido o animal de forca %d e o que ficou tinha %d", [(SKAnimals*)temp strenght], [(SKAnimals*)temp2 strenght]);
                        break;
                    }
                    else{
                        temp2.energy += temp2.energyValue;
                        [temp runAction:sequence];
                        [self.animalArray removeObject:temp];
                        NSLog(@"Foi removido o animal de forca %d e o que ficou tinha %d", [(SKAnimals*)temp strenght], [(SKAnimals*)temp2 strenght]);
                        break;
                    }
                    
            }
        }

    }
    
}

//-(void)didBeginContact:(SKPhysicsContact *)contact{
//    
//    SKSpriteNode *firstNode, *secondNode;
//    
//    firstNode = (SKSpriteNode *)contact.bodyA.node;
//    secondNode = (SKSpriteNode *) contact.bodyB.node;
//    
//    if ((contact.bodyA.categoryBitMask == animalCategory)
//        && (contact.bodyB.categoryBitMask == animalCategory))
//    {
//            NSLog(@"aaaaaaaaaaaanimal collision!!!!");
//        firstNode.color = [UIColor redColor];
//    }
//    
//}

@end
