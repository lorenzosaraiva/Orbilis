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
    self.animalArray = [[NSMutableArray alloc] init];
    self.menuArray = [[NSMutableArray alloc] init];
    self.vegetableArray = [[NSMutableArray alloc] init];
    self.sceneryArray = [[NSMutableArray alloc] init];
    
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
                [self.animalArray addObject:temp];
                [self.menuArray removeObject:temp];
                [self removeChildrenInArray:self.menuArray];
                [self.menuArray removeAllObjects];
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

    if ([self pointInIsland:positionInScene]){
        SKAnimals *herb = [SKAnimals createAnimalofType:Animal_Herbivore];
        SKAnimals *carn = [SKAnimals createAnimalofType:Animal_Carnivore];
        SKAnimals *bigCarn = [SKAnimals createAnimalofType:Animal_Predator];
        SKVegetables *tree = [SKVegetables createVegetableOfType:Vegetable_Tree];
        SKVegetables *grass = [SKVegetables createVegetableOfType:Vegetable_Grass];
        SKSpriteNode *factory = [SKSpriteNode spriteNodeWithImageNamed:@"industria.png"];
        factory.size = CGSizeMake(factory.frame.size.width * 0.8f, factory.frame.size.height * 0.8f);
        carn.size = CGSizeMake(20, 20);
        herb.size = CGSizeMake(20, 20);
        bigCarn.size = CGSizeMake(20, 20);
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
            [self.sceneryArray removeObject:tempCloud];
        }];
    
    }
}

-(void)update:(CFTimeInterval)currentTime {
    
    [self updateTimeTick: currentTime];

    if (self.timeSinceLast > 1) {
        
        [self updateGlobalTimeTick: currentTime];
        [self checkAmbientStatus];
        
        for (int i = 0; i < self.vegetableArray.count; i++){
        
            [self checkVegetablesLifespanWithId:i];
            [self checkVegetablsGrowthWithId:i];
            [self controlVegetableLeavesWithId:i];
            [self reproduceVegetableWithId:i];
            
        }
        for (int i = 0; i < self.animalArray.count; i++){
        NSLog(@"animais: %d", self.animalArray.count);
        
        [self moveAnimalWithId:i];
        [self checkPlantContactWithId:i];
        if (i < self.animalArray.count)
        [self checkAnimalContactWithId:i];
        if (i < self.animalArray.count)
        [self checkTemperatureFromAnimalWithId:i];
//        [self updateAnimalsEnergy];
        if (i < self.animalArray.count)
        [self growAnimalWithId:i];
        
        }
    }
   
}

- (void)updateTimeTick:(CFTimeInterval)currentTime {

    self.timeSinceLast += currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;

}

- (void)updateGlobalTimeTick:(CFTimeInterval)currentTime {

    self.timeSinceLast = 0;
    self.lastUpdateTimeInterval = currentTime;
    self.global++;

    NSLog(@"%d segundos", self.global);
    NSLog(@"%f humidade", self.humidity);

}

- (void)checkAmbientStatus {

    //Poluicao
    self.pollution = self.pollution + self.pollutionArray.count/5;
    if (self.pollution > 100)
        self.pollution = 100;
    
    //Umidade
    if (40 > self.temperature && self.temperature > 25)
        self.humidity = self.humidity + 0.5f;
    if (self.temperature > 45)
        self.humidity = self.humidity - 1.0f;
    if (self.humidity > 100)
        self.humidity = 100;
    
    for (int i = 0; i < self.sceneryArray.count; i++){
        SKSpriteNode * testingCloud = self.sceneryArray[i];
        SKAction * color = [SKAction colorizeWithColorBlendFactor: self.humidity/100 duration:1.0f];
        [testingCloud runAction:color completion:^{ testingCloud.colorBlendFactor = self.humidity/100;}];
    }
    
    //Chuva
    if (self.humidity > 70 && self.sceneryArray.count > 3){
        [self makeItRain];
    }

}

- (void)reproduceVegetableWithId:(int)i {

   
        
        SKVegetables *mainTestingVegetable = self.vegetableArray[i];
        
        int check = arc4random()%mainTestingVegetable.multiplyRate;

        if (!check) {
            SKVegetables *new = [SKVegetables createVegetableOfType:mainTestingVegetable.vegetableType];
            if (mainTestingVegetable.vegetableType == Vegetable_Tree) {
                new.size = CGSizeMake(new.frame.size.width * 0.3f, new.frame.size.height * 0.3f);
                self.tree++;
            }
            int vegetableX = getRandomNum(0,100) - 50;
            int vegetableY = getRandomNum(0,100) - 50;

            CGRect islandRectOne = CGRectMake(40, 260, 240, 120);
            CGRect islandRectTwo = CGRectMake(60, 220, 200, 40);
            CGPoint point = CGPointMake(mainTestingVegetable.position.x + vegetableX, mainTestingVegetable.position.y + vegetableY);
            if (CGRectContainsPoint(islandRectOne, point)||CGRectContainsPoint(islandRectTwo, point)){
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

- (void)controlVegetableLeavesWithId:(int)i {

    
        
        SKVegetables *mainTestingVegetable = self.vegetableArray[i];
        
        // controla numero de folhas
        
        if (mainTestingVegetable.leavesCounter == 14 && mainTestingVegetable.vegetableType == Vegetable_Tree){
            
            mainTestingVegetable.leaves++;
            mainTestingVegetable.leavesCounter = 0;
            SKAction *grow = [SKAction scaleBy:1.05 duration:0.5f];
            [mainTestingVegetable runAction:grow];
            
        }
        mainTestingVegetable.leavesCounter++;
    

}

- (void)checkVegetablsGrowthWithId:(int)i {

   
        
        SKVegetables *mainTestingVegetable = self.vegetableArray[i];
        
        //controla crescimento
        
        if (mainTestingVegetable.growthTime == 5 && mainTestingVegetable.vegetableType == Vegetable_Tree) {
            if (mainTestingVegetable.growthCounter < 7){
                SKAction *scale = [SKAction scaleBy:1.2f duration:0.2];
                [mainTestingVegetable runAction:scale];
                mainTestingVegetable.growthCounter++;
                mainTestingVegetable.poisonLevel = self.pollution/10;
                
            }
            mainTestingVegetable.growthTime = 0;
        }
        mainTestingVegetable.growthTime++;
    

}

- (void)checkVegetablesLifespanWithId:(int)i {

    
        
        SKVegetables *mainTestingVegetable = self.vegetableArray[i];
        
        mainTestingVegetable.energy--;
        if (mainTestingVegetable.energy == 0){
            SKAction *shrink = [SKAction scaleTo:0 duration:0.5];
            SKAction *remove = [SKAction removeFromParent];
            SKAction *sequence = [SKAction sequence:@[shrink,remove]];
            [mainTestingVegetable runAction:sequence];
            [self.vegetableArray removeObject:mainTestingVegetable];
            if (mainTestingVegetable.vegetableType == Vegetable_Tree)
                self.tree--;
            if (mainTestingVegetable.vegetableType == Vegetable_Grass)
                self.grass--;
            NSLog(@"%d arvore", self.tree);
            NSLog(@"%d grama", self.grass);
        }
    

}

- (void)moveAnimalWithId:(int)i {

    

        SKAnimals *mainTestingAnimal = self.animalArray[i];
        
        if(mainTestingAnimal.performingStopAction==NO) {
        
            float xMovement = getRandomNum(0,80) - 40;
            float yMovement = getRandomNum(0,80) - 40;

            CGPoint point = CGPointMake(mainTestingAnimal.position.x + xMovement, mainTestingAnimal.position.y + yMovement);
            SKAction *move = [SKAction moveTo:point duration:1.0f];
            
            if ([self pointInIsland:point])
                [mainTestingAnimal runAction:move];
             
            CGRect rectAgua = CGRectMake(0,0,self.frame.size.width,180);
            if (mainTestingAnimal.animalType == Animal_Water_Predator || mainTestingAnimal.animalType == Animal_Water_Herbivore){
                if (CGRectContainsPoint(rectAgua, point))
                    [mainTestingAnimal runAction:move];
            }
            
        } else {
            
            mainTestingAnimal.performingStopAction = NO;
        
        }
    

}

- (void)checkTemperatureFromAnimalWithId:(int)i {

    

        SKAnimals *mainTestingAnimal = self.animalArray[i];
    
        if (self.temperature > 35 || self.temperature < 15){
            int removeChance = getRandomNum(0,20);
            if (!removeChance) {
                
                [mainTestingAnimal removeFromParent];
                [self.animalArray removeObjectAtIndex:i];
            }
        }
    

}

- (void)updateAnimalsEnergy {
    
//    for (int i = 0; i < self.animalArray.count; i++) {
//
//        SKAnimals *mainTestingAnimal = self.animalArray[i];
//        
//        mainTestingAnimal.energy--;
//        if (mainTestingAnimal.energy <= 0){
//            [mainTestingAnimal removeFromParent];
//            [self.animalArray removeObject:mainTestingAnimal];
//        }
//    }

}

- (void)growAnimalWithId:(int)i {

    

        SKAnimals *mainTestingAnimal = self.animalArray[i];
        mainTestingAnimal.age++;
        if (mainTestingAnimal.age >= mainTestingAnimal.ageLimit){
            [self.animalArray removeObject:mainTestingAnimal];
            [mainTestingAnimal removeFromParent];
        }
//        if (mainTestingAnimal.isChild){
//            SKAction *scale = [SKAction scaleBy:1.09f duration:0.3];
//            [mainTestingAnimal runAction:scale];
//            if (mainTestingAnimal.growth == 15)
//                mainTestingAnimal.isChild = NO;
//            mainTestingAnimal.growth++;
//        }
    

}

- (void)reproduceAnimal:(SKAnimals*)mainTestingAnimal {
        
        if (mainTestingAnimal.energy>=mainTestingAnimal.multiplyLimit) {
        
            SKAnimals *newAnimal = [SKAnimals createAnimalofType:mainTestingAnimal.animalType];
            [newAnimal setSize:CGSizeMake(20, 20)];
            [newAnimal setPosition:CGPointMake(mainTestingAnimal.position.x, mainTestingAnimal.position.y)];
            [self.animalArray addObject:newAnimal];
            [self addChild:newAnimal];
            mainTestingAnimal.energy--;
            
        }
    
    //        if (!mainTestingAnimal.isChild) {
    //
    //            if (mainTestingAnimal.energy >= mainTestingAnimal.multiplyLimit) {
    //
    //                SKAnimals *animal = [SKAnimals createAnimalofType:mainTestingAnimal.animalType];
    //                animal.position = CGPointMake(mainTestingAnimal.frame.origin.x + 10, mainTestingAnimal.frame.origin.y + 30);
    //                animal.size = CGSizeMake(mainTestingAnimal.frame.size.width * 0.25f, mainTestingAnimal.frame.size.height * 0.25f);
    //                [self addChild:animal];
    //                [self.animalArray addObject:animal];
    //                mainTestingAnimal.energy = mainTestingAnimal.energy/4; //Por que (energy/4) e nao (energy/2)?
    //            }
    //        }
    
}

- (void)checkPlantContactWithId:(int)i {

    
    NSLog(@"chamda");
        SKAnimals *mainTestingAnimal = self.animalArray[i];
        
        if (mainTestingAnimal.animalType == Animal_Herbivore && mainTestingAnimal.nextMeal == 0) {
            
            for (int k = 0; k < self.vegetableArray.count; k++) {

                SKVegetables *testingPlant = self.vegetableArray[k];
                
                if (CGRectIntersectsRect(mainTestingAnimal.frame, testingPlant.frame)) {
                    if (testingPlant.vegetableType == Vegetable_Tree) {
                        if (testingPlant.leaves != 0 && testingPlant.growthCounter == 7) {

                            SKAction *shrinkTree = [SKAction scaleTo:0.95f duration:0.5];
                            SKAction *shrinkNewTree = [SKAction scaleTo:3.0f duration:0.5];
                            
                            if (testingPlant.isNew) {
                                [testingPlant runAction:shrinkNewTree];
                            }
                          
                            else {
                                [testingPlant runAction:shrinkTree];
                            }
                            testingPlant.leaves--;
                            mainTestingAnimal.energy += testingPlant.energyValue;
                        }
                    }
                    else if (testingPlant.vegetableType == Vegetable_Grass){
        
                        testingPlant.leaves--;
                        mainTestingAnimal.energy += testingPlant.energyValue;
                        if (testingPlant.leaves <= 0) {
                            
                            SKAction *shrink = [SKAction scaleTo:0.0f duration:1.0f];
                            SKAction *remove = [SKAction removeFromParent];
                            SKAction *sequence = [SKAction sequence:@[shrink,remove]];
                            self.grass--;
                           

                                [testingPlant runAction:sequence completion:
                                    ^{
                                        [self.vegetableArray removeObject:testingPlant];
                                    }];
                        }
                    
                    }
                }
            }
        } else {

            if (mainTestingAnimal.nextMeal > 0) {
                mainTestingAnimal.nextMeal--;
            }
        }
    [self reproduceAnimal:mainTestingAnimal];

}

- (void)checkAnimalContactWithId:(int)i {


        for (int j = 0; j < self.animalArray.count; j++) {

            SKAnimals *mainTestingAnimal = self.animalArray[i];
            SKAnimals *secondaryTestingAnimal = self.animalArray[j];
            
            if (CGRectIntersectsRect(mainTestingAnimal.frame, secondaryTestingAnimal.frame)&&(i!=j)&&mainTestingAnimal.animalType!=Animal_Herbivore&&mainTestingAnimal.nextMeal == 0) {
                
                SKAction *eatAnimal = [SKAction sequence:@[[SKAction scaleTo:0 duration:1],[SKAction removeFromParent]]];
                
                if ((mainTestingAnimal.animalType==Animal_Carnivore&&secondaryTestingAnimal.animalType==Animal_Herbivore)||(mainTestingAnimal.animalType==Animal_Predator&&secondaryTestingAnimal.animalType!=Animal_Predator)) {
                    
                    mainTestingAnimal.energy += secondaryTestingAnimal.energyValue;
                    mainTestingAnimal.performingStopAction = YES;
                    mainTestingAnimal.nextMeal = 10;
                    secondaryTestingAnimal.performingStopAction = YES;
                    [secondaryTestingAnimal runAction:eatAnimal];
                    [self.animalArray removeObject:secondaryTestingAnimal];
                    [self reproduceAnimal:mainTestingAnimal];
                    
                }
            }
        
    }
//
//        if (mainTestingAnimal.animalType == Animal_Carnivore || mainTestingAnimal.animalType == Animal_Predator)
//        
//        for (int j = 0; j< self.animalArray.count; j++){
//            
//            SKAnimals *secondaryTestingAnimal = self.animalArray[j];
//            
//            if ((secondaryTestingAnimal.isChild)||(j == i)||(mainTestingAnimal.animalType == secondaryTestingAnimal.animalType)) {
//                continue;
//            }
//
//            if (CGRectIntersectsRect(mainTestingAnimal.frame, secondaryTestingAnimal.frame)) {
//
//                SKAction *shrink = [SKAction scaleTo:0 duration:1];
//                SKAction *remove = [SKAction removeFromParent];
//                SKAction *sequence = [SKAction sequence:@[shrink,remove]]; 
//
//                if ([(SKAnimals*)mainTestingAnimal strenght] > [(SKAnimals*)secondaryTestingAnimal strenght]) {
//                    if (mainTestingAnimal.nextMeal == 0) {
//                        mainTestingAnimal.energy += secondaryTestingAnimal.energyValue;
//                        [secondaryTestingAnimal runAction:sequence];
//                        [self.animalArray removeObject:secondaryTestingAnimal];
//                        mainTestingAnimal.nextMeal = 8;
//                        break;
//                    }
//                }
//
//                else {
//                    
//                    if (secondaryTestingAnimal.nextMeal == 0) {
//                        secondaryTestingAnimal.energy += mainTestingAnimal.energyValue;
//                        [mainTestingAnimal runAction:sequence];
//                        [self.animalArray removeObject:mainTestingAnimal];
//                        secondaryTestingAnimal.nextMeal = 8;
//                        break;
//                    }
//                }  
//            }
//        }
    

}

-(BOOL)pointInIsland:(CGPoint)point {
    
    float prop1 = 0.60;
    float prop2 = 0.10;
    float prop3 = 0.01;
    float prop4 = -0.05;
    
    float prop5 = 0.40;
    float prop6 = 0.08;
    float prop7 = 0.01;
    float prop8 = 0.025;
    
    float x1 = ((self.frame.size.width-self.frame.size.width*prop1)/2) + (self.frame.size.width*prop3);
    float y1 = ((self.frame.size.height-self.frame.size.height*prop2)/2) + (self.frame.size.height*prop4);
    float width1 = self.frame.size.width*prop1;
    float height1 = self.frame.size.height*prop2;
    
    float x2 = ((self.frame.size.width-self.frame.size.width*prop5)/2) + (self.frame.size.width*prop7);
    float y2 = ((self.frame.size.height-self.frame.size.height*prop6)/2) + (self.frame.size.height*prop8);
    float width2 = self.frame.size.width*prop5;
    float height2 = self.frame.size.height*prop6;
    
    CGRect rect = CGRectMake(x1, y1, width1, height1);
    CGRect rect2 = CGRectMake(x2, y2, width2, height2);

    if(CGRectContainsPoint(rect, point )||CGRectContainsPoint(rect2, point)) {
        return YES;
    } else {
        return NO;
    }
}

float getRandomNum(float minimum, float maximum) {
    return arc4random_uniform((maximum - minimum) + 1.0) + minimum;
}


@end
