//
//  GameScene.m
//  GameTest
//
//  Created by Lorenzo Saraiva on 12/11/14.
//  Copyright (c) 2014 Lorenzo Saraiva. All rights reserved.
//

#import "GameScene.h"



@implementation GameScene



-(void)didMoveToView:(SKView *)view {
    
    
    
    
    // inicia e alloca as coisas iniciais
    
    self.isMenu = false;
    self.temperature = 27;
    self.timeSinceLast = 0;
    self.global = 0;
    self.tree = 0;
    self.pollution = 0;
    self.humidity = 60;
    self.animalArray = [[NSMutableArray alloc]init];
    self.menuArray = [[NSMutableArray alloc]init];
    self.vegetableArray = [[NSMutableArray alloc]init];
    self.sceneryArray = [[NSMutableArray alloc]init];

    
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 400, self.frame.size.width, 200)];
//        label.backgroundColor = [UIColor yellowColor];
//        [self.view addSubview:label];
//    
    
    [self drawWolrd];
    
    
    // configura os gesture recognizer
    
    // pinch para controlar o sol
    UIPinchGestureRecognizer *pinchGesture  = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(resizeSun:)];
    [self.view addGestureRecognizer:pinchGesture];
    
    // swipe para acrescentar e retirar nuvens
    
    UISwipeGestureRecognizer *swipeLeftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    UISwipeGestureRecognizer *swipeRightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    swipeLeftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeRightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightRecognizer];
    [self.view addGestureRecognizer:swipeLeftRecognizer];
    
    // mostra o termometro
    
    self.temperatureLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 50, 0, 50, 50)];
    self.temperatureLabel.text = [NSString stringWithFormat:@"%.f",self.sun.frame.size.height/5];
    [self.view addSubview:self.temperatureLabel];
    
}

// desenha e posiciona os elementos da tela

- (void)drawWolrd {
    
    float prop = 0.55;
    
    SKSpriteNode *cage = [SKSpriteNode spriteNodeWithImageNamed:@"Cage.png"];
    cage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    cage.size = CGSizeMake(cage.frame.size.width*prop, cage.frame.size.height*prop);
    [self addChild:cage];
    
    SKSpriteNode *sky = [SKSpriteNode spriteNodeWithImageNamed:@"Sky.png"];
    sky.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    sky.size = CGSizeMake(sky.frame.size.width*prop, sky.frame.size.height*prop);
    [self addChild:sky];
    
    SKSpriteNode *water = [SKSpriteNode spriteNodeWithImageNamed:@"Water.png"];
    water.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    water.size = CGSizeMake(water.frame.size.width*prop, water.frame.size.height*prop);
    [self addChild:water];
    
    SKSpriteNode *sea = [SKSpriteNode spriteNodeWithImageNamed:@"Sea.png"];
    sea.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    sea.size = CGSizeMake(sea.frame.size.width*prop, sea.frame.size.height*prop);
    [self addChild:sea];
    
    SKSpriteNode *sand = [SKSpriteNode spriteNodeWithImageNamed:@"Sand.png"];
    sand.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    sand.size = CGSizeMake(sand.frame.size.width*prop, sand.frame.size.height*prop);
    [self addChild:sand];
    
    self.island = [SKSpriteNode spriteNodeWithImageNamed:@"Island.png"];
    self.island.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    self.island.size = CGSizeMake(self.island.frame.size.width*prop, self.island.frame.size.height*prop);
    
    [self addChild:self.island];
    
    self.sun = [SKSpriteNode spriteNodeWithImageNamed:@"Sol.png"];
    self.sun.position = CGPointMake(80, self.frame.size.height - 80);

    
    
    [self addChild:self.sun];
    
}

-(void)resizeSun:(UIPinchGestureRecognizer*)recognizer{

    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    
    touchLocation = [self convertPointFromView:touchLocation];
    
    if ([self.sun containsPoint:touchLocation]){
        if (recognizer.scale > 1){
            if (self.sun.size.height * 1.07f < 250){
                self.sun.size = CGSizeMake(self.sun.size.width * 1.07f, self.sun.size.height * 1.07f);
                self.temperature = self.sun.frame.size.height/5 - 0.5f * [self.sceneryArray count];
    
            }
           
        }
        else{
            if (self.sun.size.height * 0.96f > 50){
                
                self.sun.size = CGSizeMake(self.sun.size.width * 0.96f, self.sun.size.height * 0.96f);
                self.temperature = self.sun.frame.size.height/5 - 0.5f * [self.sceneryArray count];
            }
        
        }
        self.temperatureLabel.text = [NSString stringWithFormat:@"%.f",self.temperature];
    }

}

// reconhece o swipe gesture recognizer

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    
    touchLocation = [self convertPointFromView:touchLocation];
    
    CGRect cloudArea = CGRectMake(0, 400, self.scene.frame.size.width, 300);
    
    if (CGRectContainsPoint(cloudArea, touchLocation)){
        
        if ([(UISwipeGestureRecognizer*)recognizer direction] == UISwipeGestureRecognizerDirectionLeft && [self.sceneryArray count] > 0){
            SKSpriteNode * temp = self.sceneryArray[0];
            [self.sceneryArray removeObjectAtIndex:0];
            self.temperature = self.temperature + 0.5f;
            self.humidity = self.humidity - 1.0f;
            [temp removeFromParent];
        }
        else if ([(UISwipeGestureRecognizer*)recognizer direction] == UISwipeGestureRecognizerDirectionRight ){
            SKSpriteNode *nuvem = [SKSpriteNode spriteNodeWithImageNamed:@"Nuvem1"];
            [self.sceneryArray addObject:nuvem];
            [self addChild:nuvem];
            int a = arc4random()%50;
            int b = arc4random()%50;
            int c = arc4random()%2;
            int d = arc4random()%2;
            if (!c)
                a = -a;
            if (!d)
                b = -b;
            nuvem.position = CGPointMake(touchLocation.x + a, touchLocation.y + b);
            nuvem.color = [UIColor grayColor];
            nuvem.colorBlendFactor = 0.0f;
            self.temperature = self.temperature - 0.5f;
            self.humidity++;
        }
        self.temperatureLabel.text = [NSString stringWithFormat:@"%.f",self.temperature];
        
    }
}

//administra os toques

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    

    // adiciona o elemento correto do pop-up menu
    
    for (int i = 0; i < self.menuArray.count; i++){
        if ([[self.menuArray objectAtIndex:i] isKindOfClass: [SKAnimals class]]){
            SKAnimals *temp = self.menuArray[i];
            if ([temp containsPoint:positionInScene]){
                [self.menuArray removeObject:temp];
                [self removeChildrenInArray:self.menuArray];
                [self.menuArray removeAllObjects];
                [self.animalArray addObject:temp];
                temp.position = CGPointMake(self.lastTouch.x, self.lastTouch.y);
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
                temp.position = CGPointMake(self.lastTouch.x, self.lastTouch.y);
                self.isMenu = false;
                return;
                
            }
        }
        else {
            SKSpriteNode *temp = self.menuArray[i];
            if ([temp containsPoint:positionInScene]){
                [self.menuArray removeObject:temp];
                [self removeChildrenInArray:self.menuArray];
                [self.menuArray removeAllObjects];
                [self.pollutionArray addObject:temp];
                temp.position = CGPointMake(self.lastTouch.x, self.lastTouch.y);
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
    
    // menu da agua
    
    CGRect rectAgua = CGRectMake(0,0,self.frame.size.width,180);
    if (CGRectContainsPoint(rectAgua, positionInScene)){
    
        SKAnimals *smallFish = [SKAnimals createAnimalofType:Animal_Water_Herbivore];
        SKAnimals *bigFish = [SKAnimals createAnimalofType:Animal_Water_Predator];
        smallFish.position = CGPointMake(positionInScene.x + 30, positionInScene.y);
        bigFish.position = CGPointMake(positionInScene.x - 30, positionInScene.y);
        [self.menuArray addObject:smallFish];
        [self.menuArray addObject:bigFish];
        [self addChild:smallFish];
        [self addChild:bigFish];
        self.isMenu = true;
    
    }
    //menu da terra
    
    CGRect rect = CGRectMake(40, 260, 240, 120);
    CGRect rect2 = CGRectMake(60, 220, 200, 40);
    if (CGRectContainsPoint(rect, positionInScene )||CGRectContainsPoint(rect2, positionInScene)){
        SKAnimals *herb = [SKAnimals createAnimalofType:Animal_Herbivore];
        SKAnimals *carn = [SKAnimals createAnimalofType:Animal_Carnivore];
        SKAnimals *bigCarn = [SKAnimals createAnimalofType:Animal_Predator];
        SKVegetables *tree = [SKVegetables createVegetableOfType:Vegetable_Tree];
        SKVegetables *grass = [SKVegetables createVegetableOfType:Vegetable_Grass];
        SKSpriteNode *factory = [SKSpriteNode spriteNodeWithImageNamed:@"industria.png"];
        factory.size = CGSizeMake(factory.frame.size.width * 0.8f, factory.frame.size.height * 0.8f);
        carn.size = CGSizeMake(herb.frame.size.width, herb.frame.size.height);
        bigCarn.size = CGSizeMake(herb.frame.size.width, herb.frame.size.height);
        herb.position = CGPointMake(positionInScene.x, positionInScene.y + 30);
        carn.position = CGPointMake(positionInScene.x, positionInScene.y - 30);
        bigCarn.position = CGPointMake(positionInScene.x + 30, positionInScene.y);
        grass.position = CGPointMake(positionInScene.x + 30, positionInScene.y + 30);
        factory.position = CGPointMake(positionInScene.x - 30, positionInScene.y - 30);
        herb.isChild = NO;
        carn.isChild = NO;
        bigCarn.isChild = NO;
        tree.position = CGPointMake(positionInScene.x - 30, positionInScene.y);
        tree.growthCounter = 7;
        tree.isNew = false;
        grass.isNew = false;
        [self.menuArray addObject:herb];
        [self.menuArray addObject:carn];
        [self.menuArray addObject:bigCarn];
        [self.menuArray addObject:tree];
        [self.menuArray addObject:grass];
        [self.menuArray addObject:factory];
        [self addChild:herb];
        [self addChild:carn];
        [self addChild:bigCarn];
        [self addChild:tree];
        [self addChild:grass];
        [self addChild:factory];
        self.isMenu = true;
        
        
        
    }
    self.lastTouch = positionInScene;
    
}

-(void)makeItRain{
    
    NSString * rainPath = [[NSBundle mainBundle]
     pathForResource:@"RainParticle" ofType:@"sks"];
    
    SKEmitterNode *burstNode =
    [NSKeyedUnarchiver unarchiveObjectWithFile:rainPath];
    
    burstNode.position = CGPointMake(50, self.frame.size.height - 100);
    
    burstNode.numParticlesToEmit = self.humidity * 10;
    
    self.humidity = 20;
    
    [self addChild:burstNode];
    
    for (int i = 0; i < self.sceneryArray.count/2; i++){
        SKSpriteNode * tempCloud = self.sceneryArray[i];
        SKAction * fadeAway = [SKAction fadeOutWithDuration:5.0f];
        [tempCloud runAction:fadeAway completion:^{
            [tempCloud removeFromParent];
            [self.sceneryArray removeObjectAtIndex:i];
        }];
    
    }
}

-(void)update:(CFTimeInterval)currentTime {
    
    
    
    self.timeSinceLast += currentTime - self.lastUpdateTimeInterval;
    
    // checagem do intervalo de 1 segundo
    
    self.lastUpdateTimeInterval = currentTime;
    if (self.timeSinceLast > 1) { // more than a second since last update
        self.timeSinceLast = 0;
        self.lastUpdateTimeInterval = currentTime;
        NSLog(@"%d segundos", self.global);
        NSLog(@"%f humidade", self.humidity);
        self.global++;
        
        // poluicao
        
        self.pollution = self.pollution + self.pollutionArray.count/5;
        if (self.pollution > 100)
            self.pollution = 100;
       
        // humidade
        
        if (40 > self.temperature && self.temperature > 25)
            self.humidity = self.humidity + 0.5f;
        if (self.temperature > 45)
            self.humidity = self.humidity - 1.0f;
        
        for (int i = 0; i < self.sceneryArray.count; i++){
            SKSpriteNode * tempCloud = self.sceneryArray[i];
            SKAction * color = [SKAction colorizeWithColorBlendFactor: self.humidity/100 duration:1.0f];
            [tempCloud runAction:color completion:^{ tempCloud.colorBlendFactor = self.humidity/100;}];
        
        }
        
        //checa por chuva
        
        if (self.humidity > 70 && self.sceneryArray.count > 3){
            [self makeItRain];
        }
        
        // iteracao pelos vegetais
        for (int i = 0; i < self.vegetableArray.count; i++){
            
            
            SKVegetables *temp = self.vegetableArray[i];
            
            //controla lifespan
            
            temp.energy--;
            if (temp.energy == 0){
                SKAction *shrink = [SKAction scaleTo:0 duration:0.5];
                SKAction *remove = [SKAction removeFromParent];
                SKAction *sequence = [SKAction sequence:@[shrink,remove]];
                [temp runAction:sequence];
                if (temp.vegetableType == Vegetable_Tree)
                    self.tree--;
                if (temp.vegetableType == Vegetable_Grass)
                    self.grass--;
                NSLog(@"%d arvore", self.tree);
                NSLog(@"%d grama", self.grass);
            }
            
            //controla crescimento
            
            if (temp.growthTime == 5 && temp.vegetableType == Vegetable_Tree) {
                if (temp.growthCounter < 7){
                    SKAction *scale = [SKAction scaleBy:1.2f duration:0.2];
                    [temp runAction:scale];
                    temp.growthCounter++;
                    temp.poisonLevel = self.pollution/10;
                    
                }
                temp.growthTime = 0;
            }
            temp.growthTime++;
            
            // controla numero de folhas
            
            if (temp.leavesCounter == 14 && temp.vegetableType == Vegetable_Tree){
                
                temp.leaves++;
                temp.leavesCounter = 0;
                SKAction *grow = [SKAction scaleBy:1.05 duration:0.5f];
                [temp runAction:grow];
                
            }
            temp.leavesCounter++;
            
            //cria mudas
            
            int check = arc4random()%temp.multiplyRate;
            if (!check){
                SKVegetables *new = [SKVegetables createVegetableOfType:temp.vegetableType];
                if (temp.vegetableType == Vegetable_Tree){
                    new.size = CGSizeMake(new.frame.size.width * 0.3f, new.frame.size.height * 0.3f);
                    self.tree++;
                }
                int a = arc4random()%50;
                int b = arc4random()%50;
                int c = arc4random()%2;
                int d = arc4random()%2;
                if (!c)
                    a = -a;
                if (!d)
                    b = -b;
                CGRect rect = CGRectMake(40, 260, 240, 120);
                CGRect rect2 = CGRectMake(60, 220, 200, 40);
                CGPoint point = CGPointMake(temp.position.x + a, temp.position.y + b);
                if (CGRectContainsPoint(rect, point)||CGRectContainsPoint(rect2, point)){
                    new.position = point;
                    [self.vegetableArray addObject:new];
                    [self addChild:new];
                    if (new.vegetableType == Vegetable_Grass){
                        new.poisonLevel = self.pollution/10;
                        self.grass++;
                    }
                NSLog(@"%d arvore", self.tree);
                NSLog(@"%d grama", self.grass);
                }
            }
        }
        
        for (int i = 0; i < self.animalArray.count; i++) {
            SKAnimals *temp = self.animalArray[i];
            
            // movimento
            
            int a = arc4random()%400;
            int b = arc4random()%400;
            int c = arc4random()%2;
            int d = arc4random()%2;
            if (!c)
                a = -a;
            if (!d)
                b = -b;
            a = a/10;
            b = b/10;
            CGPoint point = CGPointMake(temp.position.x + a, temp.position.y + b);
            SKAction *move = [SKAction moveTo: point duration:1.0f];
            CGRect rect = CGRectMake(40, 260, 240, 120);
            CGRect rect2 = CGRectMake(60, 220, 200, 40);
            if (CGRectContainsPoint(rect, point)||CGRectContainsPoint(rect2, point))
                [temp runAction:move];
            CGRect rectAgua = CGRectMake(0,0,self.frame.size.width,180);
            if (temp.animalType == Animal_Water_Predator || temp.animalType == Animal_Water_Herbivore){
                if (CGRectContainsPoint(rectAgua, point))
                    [temp runAction:move];
            }
            
            //checagem de temperatura
            
            if (self.temperature > 35 || self.temperature < 15){
                int a = arc4random()%20;
                if (!a){
                    [self.animalArray removeObject:temp];
                    [temp removeFromParent];
                }
            }
            
            
            //update de energia
            
            temp.energy--;
            if (temp.energy <= 0){
                [temp removeFromParent];
                [self.animalArray removeObject:temp];
                
            }
            
            //crescimento
            if (temp.isChild){
                SKAction *scale = [SKAction scaleBy:1.09f duration:0.3];
                [temp runAction:scale];
                if (temp.growth == 15)
                    temp.isChild = NO;
                temp.growth++;
            }
            //multiplicacao
            if (!temp.isChild)
            if (temp.energy >= temp.multiplyLimit){
                SKAnimals *animal = [SKAnimals createAnimalofType:temp.animalType];
                animal.position = CGPointMake(temp.frame.origin.x + 10, temp.frame.origin.y + 30);
                animal.size = CGSizeMake(temp.frame.size.width * 0.25f, temp.frame.size.height * 0.25f);
                [self addChild:animal];
                [self.animalArray addObject:animal];
                temp.energy = temp.energy/4;
            }
            
            //checa o contato com plantas
            
            if (temp.animalType == Animal_Herbivore){

                for (int k = 0; k < self.vegetableArray.count; k++){
                    SKVegetables *temp2 = self.vegetableArray[k];
                    Boolean viewsOverlap = CGRectIntersectsRect(temp.frame, temp2.frame);
                    
                    if (viewsOverlap){
                        if (temp2.vegetableType == Vegetable_Tree){
                        if (temp2.leaves != 0 && temp2.growthCounter == 7){
                            SKAction *shrinkTree = [SKAction scaleTo:0.95f duration:0.5];
                            SKAction *shrinkNewTree = [SKAction scaleTo:3.0f duration:0.5];
                            if (temp2.isNew)
                                [temp2 runAction:shrinkNewTree];
                            else {
                                [temp2 runAction:shrinkTree];
                            }
                            temp2.leaves--;
                            temp.energy += temp2.energyValue;
                        }
                        }
                        else{
                            temp2.leaves--;
                            temp.energy += temp2.energyValue;
                            if (temp2.leaves == 0){
                            SKAction *shrink = [SKAction scaleTo:0.0f duration:0.5f];
                            SKAction *remove = [SKAction removeFromParent];
                            SKAction *sequence = [SKAction sequence:@[shrink,remove]];
                            self.grass--;
                                [temp2 runAction:sequence completion:^{
                                    [self.vegetableArray removeObjectAtIndex:i];
                                }];
                            }
                        
                        }
                    }
                }
            }
            
            if (temp.animalType != Animal_Herbivore){
                if (temp.nextMeal > 0)
                    temp.nextMeal--;
            }
            
            //checa o contato dos animais
            if (temp.animalType == Animal_Carnivore || temp.animalType == Animal_Predator)
            for (int j = 0; j< self.animalArray.count; j++){
                SKAnimals *temp2 = self.animalArray[j];
                if (temp2.isChild)
                    continue;
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
                        if (temp.nextMeal == 0){
                            temp.energy += temp2.energyValue;
                            [temp2 runAction:sequence];
                            [self.animalArray removeObject:temp2];
                            temp.nextMeal = 8;
                            break;
                        }
                    }
                    else{
                        
                        if (temp2.nextMeal == 0){
                            temp2.energy += temp.energyValue;
                            [temp runAction:sequence];
                            [self.animalArray removeObject:temp];
                            temp2.nextMeal = 8;
                            break;
                        }
                    }
                    
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
