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
    self.animalArray = [[NSMutableArray alloc]init];
    self.menuArray = [[NSMutableArray alloc]init];
    self.vegetableArray = [[NSMutableArray alloc]init];
    self.sceneryArray = [[NSMutableArray alloc]init];
    // cria e define posicao dos elementos da tela
    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, 260, 240, 120)];
//    label.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:label];
//    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(60, 220, 200, 40)];
//    label2.backgroundColor = [UIColor redColor];
//    [self.view addSubview:label2];
//    
    [self drawWolrd];
    
//    self.sun = [SKSpriteNode spriteNodeWithImageNamed:@"sun.jpg"];
//    self.sun.position = CGPointMake(170, 550);
//    [self addChild:self.sun];
    
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
    NSLog(@"%f",positionInScene.x);
    
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
    
    CGRect rect = CGRectMake(40, 260, 240, 120);
    CGRect rect2 = CGRectMake(60, 220, 200, 40);
    if (CGRectContainsPoint(rect, positionInScene )||CGRectContainsPoint(rect2, positionInScene)){
        SKAnimals *herb = [SKAnimals createAnimalofType:Animal_Herbivore];
        SKAnimals *carn = [SKAnimals createAnimalofType:Animal_Carnivore];
        SKAnimals *bigCarn = [SKAnimals createAnimalofType:Animal_Predator];
        SKVegetables *factory = [SKVegetables createVegetableOfType:Vegetable_Tree];
        carn.size = CGSizeMake(herb.frame.size.width, herb.frame.size.height);
        bigCarn.size = CGSizeMake(herb.frame.size.width, herb.frame.size.height);
        herb.position = CGPointMake(positionInScene.x, positionInScene.y + 30);
        carn.position = CGPointMake(positionInScene.x, positionInScene.y - 30);
        bigCarn.position = CGPointMake(positionInScene.x + 30, positionInScene.y);
        factory.position = CGPointMake(positionInScene.x - 30, positionInScene.y);
        factory.growthCounter = 7;
        factory.isNew = false;
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
<<<<<<< Updated upstream
    self.lastTouch = positionInScene;
=======
    
>>>>>>> Stashed changes
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
  
   self.timeSinceLast += currentTime - self.lastUpdateTimeInterval;
    
    // checagem do intervalo de 1 segundo
    
    self.lastUpdateTimeInterval = currentTime;
    if (self.timeSinceLast > 1) { // more than a second since last update
        self.timeSinceLast = 0;
        self.lastUpdateTimeInterval = currentTime;
        NSLog(@"%d segundos", self.global);
        self.global++;
    
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
        
        }
        
        //controla crescimento
        
        if (temp.growthTime == 3 ){
            if (temp.growthCounter < 7){
                SKAction *scale = [SKAction scaleBy:1.2f duration:0.2];
                [temp runAction:scale];
                temp.growthCounter++;
        
            }
            temp.growthTime = 0;
        }
        temp.growthTime++;
        
        // controla numero de folhas
        
        if (temp.leavesCounter == 18){
            
            temp.leaves++;
            temp.leavesCounter = 0;
            SKAction *grow = [SKAction scaleBy:1.05 duration:0.5f];
            [temp runAction:grow];
            
        }
        temp.leavesCounter++;
        
        //cria mudas
        
        int check = arc4random()%300;
        if (!check){
            SKVegetables *new = [SKVegetables createVegetableOfType:Vegetable_Tree];
            new.size = CGSizeMake(new.frame.size.width * 0.3f, new.frame.size.height * 0.3f);
            int a = arc4random()%50;
            int b = arc4random()%50;
            int c = arc4random()%2;
            int d = arc4random()%2;
            if (!c)
                a = -a;
            if (!d)
                b = -b;
            new.position = CGPointMake(temp.position.x + a, temp.position.y + b);
            [self.vegetableArray addObject:new];
            [self addChild:new];
            self.tree++;
            NSLog(@"%d arvore", self.tree);
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
        SKAction *move = [SKAction moveTo: CGPointMake(temp.position.x + a, temp.position.y + b) duration:1.0f];
        CGRect rect = CGRectMake(40, 260, 240, 120);
        CGRect rect2 = CGRectMake(60, 220, 200, 40);
        if (CGRectContainsPoint(rect, CGPointMake(temp.position.x + a, temp.position.y + b) )||CGRectContainsPoint(rect2, CGPointMake(temp.position.x + a, temp.position.y + b)))
        [temp runAction:move];
        
//        temp.position = CGPointMake(temp.position.x + a, temp.position.y + b);
        
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
        if (temp.energy <= 0){
            [temp removeFromParent];
            [self.animalArray removeObject:temp];
        
        }
        //multiplicacao
        
        if (temp.energy >= temp.multiplyLimit){
            SKAnimals *animal = [SKAnimals createAnimalofType:temp.animalType];
            animal.position = CGPointMake(temp.frame.origin.x + 10, temp.frame.origin.y + 30);
            animal.size = CGSizeMake(temp.frame.size.width, temp.frame.size.height);
            [self addChild:animal];
            [self.animalArray addObject:animal];
            temp.energy = temp.energy/3;
        }
        
        //checa o contato com plantas
        
        if (temp.animalType == Animal_Herbivore){
            
            for (int k = 0; k < self.vegetableArray.count; k++){
                SKVegetables *temp2 = self.vegetableArray[k];
                Boolean viewsOverlap = CGRectIntersectsRect(temp.frame, temp2.frame);
                
                if (viewsOverlap){
                    NSLog(@"ONE");
                    if (temp2.leaves != 0 && temp2.growthCounter == 7){
                        NSLog(@"TWO");
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
                        break;
                    }
                    else{
                        temp2.energy += temp2.energyValue;
                        [temp runAction:sequence];
                        [self.animalArray removeObject:temp];
                        break;
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
