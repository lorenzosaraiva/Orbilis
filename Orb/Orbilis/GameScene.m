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
    
    self.backgroundColor = [UIColor colorWithRed:204/255.0 green:229/255.0 blue:180/255.0 alpha:1];

    // inicia e alloca as coisas iniciais
    
    self.isMenu = false;
    self.clickedOnMenu = false;
    self.temperature = 27;
    self.timeSinceLast = 0;
    self.earthPollution = 0;
    self.global = 0;
    self.tree = 0;
    self.pollution = 0;
    self.waterPollution = 0;
    self.humidity = 0;
    self.animalArray = [[NSMutableArray alloc] init];
    self.menuArray = [[NSMutableArray alloc] init];
    self.vegetableArray = [[NSMutableArray alloc] init];
    self.sceneryArray = [[NSMutableArray alloc] init];
    self.pollutionArray = [[NSMutableArray alloc] init];
    self.waterPollutionArray = [[NSMutableArray alloc]init];
    
    [self drawWolrd];
    
    UIPinchGestureRecognizer *pinchGesture  = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(resizeSun:)];
    [self.view addGestureRecognizer:pinchGesture];
    
    UISwipeGestureRecognizer *swipeLeftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    UISwipeGestureRecognizer *swipeRightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    swipeLeftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeRightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightRecognizer];
    [self.view addGestureRecognizer:swipeLeftRecognizer];
    
    
//     CONTROLE DA LUMINOSIDADE (incompleto)
//    self.light = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:self.view.frame.size];
//    self.light.alpha = 0.0f;
//    self.light.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
//    self.light.zPosition = 1.0f;
//    [self addChild:self.light];
//    
//    self.dark = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:self.view.frame.size];
//    self.dark.alpha = 0.0f;
//    self.dark.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
//    self.dark.zPosition = 1.0f;
//    [self addChild:self.dark];

}

- (void)drawWolrd {
    
    [self drawPath];
    
    float prop = (self.frame.size.width/700);
    
    self.cage = [SKSpriteNode spriteNodeWithImageNamed:@"Cage.png"];
    self.cage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    self.cage.size = CGSizeMake(self.cage.frame.size.width*prop, self.cage.frame.size.height*prop);
    [self addChild:self.cage];
    
    self.sky = [SKSpriteNode spriteNodeWithImageNamed:@"Sky.png"];
    self.sky.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    self.sky.size = CGSizeMake(self.sky.frame.size.width*prop, self.sky.frame.size.height*prop);
    self.currentSky = self.sky;
    [self addChild:self.sky];
    
    self.orangeSky = [SKSpriteNode spriteNodeWithImageNamed:@"SkyOrange.png"];
    self.orangeSky.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    self.orangeSky.size = CGSizeMake(self.orangeSky.frame.size.width*prop, self.orangeSky.frame.size.height*prop);
    self.orangeSky.alpha = 0.0f;
    [self addChild:self.orangeSky];
    
    self.lightOrangeSky = [SKSpriteNode spriteNodeWithImageNamed:@"SkyLightOrange.png"];
    self.lightOrangeSky.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    self.lightOrangeSky.size = CGSizeMake(self.lightOrangeSky.frame.size.width*prop, self.lightOrangeSky.frame.size.height*prop);
    self.lightOrangeSky.alpha = 0.0f;
    [self addChild:self.lightOrangeSky];
    
    self.lightBlueSky = [SKSpriteNode spriteNodeWithImageNamed:@"SkyLightBlue.png"];
    self.lightBlueSky.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    self.lightBlueSky.size = CGSizeMake(self.lightBlueSky.frame.size.width*prop, self.lightBlueSky.frame.size.height*prop);
    self.lightBlueSky.alpha = 0.0f;
    [self addChild:self.lightBlueSky];

    self.water = [SKSpriteNode spriteNodeWithImageNamed:@"Water.png"];
    self.water.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    self.water.size = CGSizeMake(self.water.frame.size.width*prop, self.water.frame.size.height*prop);
    [self addChild:self.water];
    
    self.sea = [SKSpriteNode spriteNodeWithImageNamed:@"Sea.png"];
    self.sea.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    self.sea.size = CGSizeMake(self.sea.frame.size.width*prop, self.sea.frame.size.height*prop);
    [self addChild:self.sea];
    
    SKSpriteNode *sand = [SKSpriteNode spriteNodeWithImageNamed:@"Sand.png"];
    sand.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    sand.size = CGSizeMake(sand.frame.size.width*prop, sand.frame.size.height*prop);
    [self addChild:sand];
    
    self.island = [SKSpriteNode spriteNodeWithImageNamed:@"Island.png"];
    self.island.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    self.island.size = CGSizeMake(self.island.frame.size.width*prop, self.island.frame.size.height*prop);
    
    
    [self addChild:self.island];
    
    self.sun = [SKSpriteNode spriteNodeWithImageNamed:@"Sol.png"];
    self.sun.position = CGPointMake(90, self.frame.size.height - 120);
    self.sun.zPosition = 0.1f;

    [self addChild:self.sun];
}

-(void)drawPath{

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 25, 240);
    CGPathAddLineToPoint(path, nil, 35, 250);
    CGPathAddLineToPoint(path, nil, 40, 270);
    CGPathAddLineToPoint(path, nil, 50, 290);
    CGPathAddLineToPoint(path, nil, 75, 310);
    CGPathAddLineToPoint(path, nil, 85, 330);
    CGPathAddLineToPoint(path, nil, 120, 347);
    CGPathAddLineToPoint(path, nil, 175, 347);
    CGPathAddLineToPoint(path, nil, 270, 290);
    CGPathAddLineToPoint(path, nil, 295, 250);
    CGPathAddLineToPoint(path, nil, 295, 220);
    CGPathAddLineToPoint(path, nil, 260, 210);
    CGPathAddLineToPoint(path, nil, 50, 200);
    CGPathAddLineToPoint(path, nil, 25, 240);
    
    self.islandShape = [SKShapeNode shapeNodeWithPath:path];
    [self addChild:self.islandShape];
}

-(void)resizeSun:(UIPinchGestureRecognizer*)recognizer{

    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    
    touchLocation = [self convertPointFromView:touchLocation];
    
    if ([self.sun containsPoint:touchLocation]){
        if (recognizer.scale > 1){
            if (self.sun.size.height * 1.03f < 180){
                self.sun.size = CGSizeMake(self.sun.size.width * 1.03f, self.sun.size.height * 1.03f);
                self.temperature = self.sun.frame.size.height/4 - 0.5f * [self.sceneryArray count];
    
            }
           
        }
        else{
            if (self.sun.size.height * 0.98f > 50){
                
                self.sun.size = CGSizeMake(self.sun.size.width * 0.98f, self.sun.size.height * 0.98f);
                self.temperature = self.sun.frame.size.height/4 - 0.5f * [self.sceneryArray count];
            }
        
        }
        self.temperatureLabel.text = [NSString stringWithFormat:@"%.f",self.temperature];
        [self colorSky];
    }
}

-(void)colorSky{
    
    SKAction *fadeIn = [SKAction fadeInWithDuration:5.0f];
    SKAction *fadeOut = [SKAction fadeOutWithDuration:5.0f];
    [self.sky removeAllActions];
    [self.orangeSky removeAllActions];
    [self.lightOrangeSky removeAllActions];
    [self.lightBlueSky removeAllActions];
    if (self.temperature > 40){
        [self.orangeSky runAction:fadeIn];
        [self.sky runAction:fadeOut];
        [self.lightOrangeSky runAction:fadeOut];
        [self.lightBlueSky runAction:fadeOut];
        self.currentSky = self.orangeSky;
    }
    if (self.temperature > 30 && self.temperature < 40){
        [self.orangeSky runAction:fadeOut];
        [self.lightOrangeSky runAction:fadeIn];
        [self.sky runAction:fadeOut];
        [self.lightBlueSky runAction:fadeOut];
        self.currentSky = self.lightOrangeSky;
    
    }
    if (self.temperature < 30 && self.temperature > 15){
        [self.orangeSky runAction:fadeOut];
        [self.lightOrangeSky runAction:fadeOut];
        [self.sky runAction:fadeIn];
        [self.lightBlueSky runAction:fadeOut];
        self.currentSky = self.sky;
        
    }
    if (self.temperature < 15){
        [self.orangeSky runAction:fadeOut];
        [self.lightOrangeSky runAction:fadeOut];
        [self.sky runAction:fadeOut];
        [self.lightBlueSky runAction:fadeIn];
        self.currentSky = self.lightBlueSky;
    
    }
}



-(void)makeItRain{
    
    
    NSString * rainPath = [[NSBundle mainBundle]
                           pathForResource:@"RainParticle" ofType:@"sks"];
    
    NSString * snowPath = [[NSBundle mainBundle]
                           pathForResource:@"SnowParticle" ofType:@"sks"];
    
    for (int i = 0; i < self.sceneryArray.count; i++){
        SKSpriteNode * tempCloud = self.sceneryArray[i];
        
        SKEmitterNode *burstNode;
        
        if (self.temperature > 15){
            burstNode = [NSKeyedUnarchiver unarchiveObjectWithFile:rainPath];
            [self growLeavesInAllTrees];
        }
        else
            burstNode = [NSKeyedUnarchiver unarchiveObjectWithFile:snowPath];
        
        burstNode.zPosition = -0.1f;
        
        
        
        burstNode.position = CGPointMake(0 , 0);
        
        burstNode.numParticlesToEmit = self.humidity;
        
        [tempCloud addChild:burstNode];
        
    }
    
    
    int remainingClouds =  arc4random()%3;
    for (int i = 0; i < self.sceneryArray.count - remainingClouds; i++){
        SKSpriteNode * tempCloud = self.sceneryArray[i];
        SKAction * fadeAway = [SKAction fadeOutWithDuration:5.0f];
        [tempCloud runAction:fadeAway completion:^{
            [tempCloud removeFromParent];
            [self.sceneryArray removeObject:tempCloud];
        }];
        
    }
    
    
    
    self.humidity = 0;
    
    if (self.earthPollution > 75)
        [self acidRain];
    
    
}

-(void)growLeavesInAllTrees{
    for (int i = 0; i < self.vegetableArray.count; i++){
        SKVegetables *tree = self.vegetableArray[i];
        if (tree.vegetableType == Vegetable_Tree)
            tree.leavesCounter = tree.leavesGrowth;
        
    }
}

-(void)acidRain{

    for (int i = 0; i < self.vegetableArray.count/2; i++){
        SKVegetables *vegetableToDie = self.vegetableArray[i];
        SKAction *sequence = [SKAction sequence:@[[SKAction scaleTo:0.0f duration:1.0f],[SKAction removeFromParent]]];
        [self.vegetableArray removeObject:vegetableToDie];
        [vegetableToDie runAction:sequence];
    }
}

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
            nuvem.zPosition = 0.2f;
            NSLog(@"nuvem %f", nuvem.position.y);
            
            self.temperature = self.temperature - 0.5f;
            self.humidity++;
        }
        self.temperatureLabel.text = [NSString stringWithFormat:@"%.f",self.temperature];
        
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];

//    TESTE DE LUMINOSIDADE
//    if (self.lightDark){
//    [self.light runAction:[SKAction fadeAlphaTo:0.3f duration:3.0f]];
//        self.lightDark = false;
//        self.dark.alpha = 0.0f;
//    }
//    else{
//        [self.dark runAction:[SKAction fadeAlphaTo:0.3f duration:3.0f]];
//        self.lightDark = true;
//        self.light.alpha = 0.0f;
//    }
    
    [self checkForMenuClick:positionInScene];
    [self checkForAnimalClick:positionInScene];
    [self checkForClickOutsideMenu:positionInScene];
    if (!self.clickedOnMenu){
        [self checkForOpenLandMenu:positionInScene];
        [self checkForWaterMenu:positionInScene];
    }
    

    self.lastTouch = positionInScene; 
}

-(void)update:(CFTimeInterval)currentTime {
    
    [self updateTimeTick: currentTime];
    
    if (self.timeSinceLast > 1) {
        NSLog(@"temperatura: %f", self.temperature);
        [self updateGlobalTimeTick: currentTime];
        [self checkAmbientStatus];
        
        for (int i = 0; i < self.vegetableArray.count; i++){
        
            [self checkVegetablesLifespanWithId:i];
            [self checkVegetablesGrowthWithId:i];
            [self controlVegetableLeavesWithId:i];
            [self reproduceVegetableWithId:i];
            [self temperatureEffectOnPlantWithId:i];

        }
        
        for (int i = 0; i < self.animalArray.count; i++){
        
        if (i < self.animalArray.count)
        [self moveAnimalWithId:i];
        if (i < self.animalArray.count)
        [self checkPlantContactWithId:i];
        if (i < self.animalArray.count)
        [self checkAnimalContactWithId:i];
        if (i < self.animalArray.count)
        [self growAnimalWithId:i];
        if (i < self.animalArray.count)
        [self updateAnimalEnergyWithId:i];
        if (i < self.animalArray.count)
        [self temperatureEffectOnAnimalWithId:i];
        if (i < self.animalArray.count)
        [self reproduceAnimalWithId:i];
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
    NSLog(@"%f poluicao", self.earthPollution);
    NSLog(@"%lu animais", (unsigned long)self.animalArray.count);

}

- (void)checkAmbientStatus {
    
    if (self.humidity > 75 && self.sceneryArray.count > 3)
        [self makeItRain];
    [self updatePollution];
    [self updateHumidity];
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
   
        CGPoint point = CGPointMake(mainTestingVegetable.position.x + vegetableX, mainTestingVegetable.position.y + vegetableY);
        if ([self pointInIsland:point]){
            new.position = point;
            [self.vegetableArray addObject:new];
            [self addChild:new];
            new.poisonLevel = self.pollution/10;
        }
    } else {
        int grassSpawn = arc4random()%100;
        if (!grassSpawn){
            SKVegetables *new = [SKVegetables createVegetableOfType:Vegetable_Grass];
            
            int vegetableX = getRandomNum(0,100) - 50;
            int vegetableY = getRandomNum(0,100) - 50;
            
            CGPoint point = CGPointMake(mainTestingVegetable.position.x + vegetableX, mainTestingVegetable.position.y + vegetableY);
            if ([self pointInIsland:point]){
                new.position = point;
                [self.vegetableArray addObject:new];
                [self addChild:new];
                new.poisonLevel = self.pollution/10;
            }

        }
    }
}

- (void)controlVegetableLeavesWithId:(int)i {
        
    SKVegetables *mainTestingVegetable = self.vegetableArray[i];
    
    // controla numero de folhas
    
    if (mainTestingVegetable.leavesCounter == mainTestingVegetable.leavesGrowth && mainTestingVegetable.vegetableType == Vegetable_Tree && mainTestingVegetable.leaves < 1){
        
        mainTestingVegetable.leaves++;
        mainTestingVegetable.leavesCounter = 0;
    }
    mainTestingVegetable.leavesCounter++;
    if (mainTestingVegetable.leavesCounter > mainTestingVegetable.leavesGrowth)
        mainTestingVegetable.leavesCounter = mainTestingVegetable.leavesGrowth;
}

- (void)checkVegetablesGrowthWithId:(int)i {
        
    SKVegetables *mainTestingVegetable = self.vegetableArray[i];
    
    if (mainTestingVegetable.growthTime == 5 && mainTestingVegetable.vegetableType == Vegetable_Tree && mainTestingVegetable.isNew) {
        if (mainTestingVegetable.growthCounter < 7){
            SKAction *scale = [SKAction scaleBy:1.1f duration:0.2];
            [mainTestingVegetable runAction:scale];
            mainTestingVegetable.growthCounter++;
            mainTestingVegetable.poisonLevel = self.pollution/10;
            
        }
        mainTestingVegetable.growthTime = 0;
    }
    mainTestingVegetable.growthTime++;

}

- (void)checkVegetablesLifespanWithId:(int)i {

}

- (void)moveAnimalWithId:(int)i {

    SKAnimals *mainTestingAnimal = self.animalArray[i];
    
    if(mainTestingAnimal.performingStopAction==NO) {
    
        float xMovement = getRandomNum(0,80) - 40;
        float yMovement = getRandomNum(0,80) - 40;

        CGPoint point = CGPointMake(mainTestingAnimal.position.x + xMovement, mainTestingAnimal.position.y + yMovement);
        SKAction *move = [SKAction moveTo:point duration:1.0f];
        
        
        if ([self.islandShape containsPoint:point] && ![mainTestingAnimal hasActions])
            [mainTestingAnimal runAction:move];
         
        CGRect rectAgua = CGRectMake(0,50,self.frame.size.width,130);
        if (mainTestingAnimal.animalType == Animal_Water_Predator || mainTestingAnimal.animalType == Animal_Water_Herbivore){
            if (CGRectContainsPoint(rectAgua, point))
                [mainTestingAnimal runAction:move];
        }
        
    } else {
        
        mainTestingAnimal.performingStopAction = NO;
    }

    if (mainTestingAnimal.nextMeal > 0) {
        mainTestingAnimal.nextMeal--;
    }

}

- (void)updateAnimalEnergyWithId:(int)i {
    
    SKAnimals *mainTestingAnimal = self.animalArray[i];
    mainTestingAnimal.energy -= 0.01f;
    if (mainTestingAnimal.energy <= 0){
        SKAction *killAnimal = [SKAction sequence:@[[SKAction scaleTo:0 duration:1],[SKAction removeFromParent]]];
        [mainTestingAnimal runAction:killAnimal completion:^{[self.animalArray removeObject:mainTestingAnimal];}];
        [self.garbage addObject:mainTestingAnimal];
        
    }
}
- (void)temperatureEffectOnPlantWithId:(int)i{
    
    SKVegetables * mainTestingPlant = self.vegetableArray[i];
    if (self.temperature < 15){
        mainTestingPlant.leavesCounter = 0;
    }
    if (self.temperature > 43){
        int alive = arc4random()%50;
        if (!alive){
            SKAction *killPLant = [SKAction sequence:@[[SKAction scaleTo:0 duration:1],[SKAction removeFromParent]]];
            [mainTestingPlant runAction:killPLant];
            [self.vegetableArray removeObject:mainTestingPlant];
        }
    }
}
- (void)temperatureEffectOnAnimalWithId:(int)i {

    
    SKAnimals *mainTestingAnimal = self.animalArray[i];
    if (self.temperature > 42){
        int alive = arc4random()%100;
        if (!alive){
            SKAction *killAnimal = [SKAction sequence:@[[SKAction scaleTo:0 duration:1],[SKAction removeFromParent]]];
          
             [mainTestingAnimal runAction:killAnimal completion:^{[self.animalArray removeObject:mainTestingAnimal];}];
            [self.garbage addObject:mainTestingAnimal];
        }
    }
}


- (void)growAnimalWithId:(int)i {

    SKAnimals *mainTestingAnimal = self.animalArray[i];
    
    mainTestingAnimal.age++;

    if (mainTestingAnimal.age >= mainTestingAnimal.ageLimit) {
        
        SKAction *killAnimal = [SKAction sequence:@[[SKAction scaleTo:0 duration:1],[SKAction removeFromParent]]];
        [mainTestingAnimal runAction:killAnimal];
        [self.animalArray removeObject:mainTestingAnimal];
        [self.garbage addObject:mainTestingAnimal];
        
    }
}

- (void)reproduceAnimalWithId:(int)i {
    
    SKAnimals * mainTestingAnimal = self.animalArray[i];
    if (mainTestingAnimal.energy>=mainTestingAnimal.multiplyLimit) {
    
        mainTestingAnimal.energy = 0.5f;

        SKAnimals *newAnimal = [SKAnimals createAnimalofType:mainTestingAnimal.animalType];
        newAnimal.size = CGSizeMake(20, 20);
        newAnimal.position = CGPointMake(mainTestingAnimal.position.x, mainTestingAnimal.position.y);
        
        [self.animalArray addObject:newAnimal];
        [self addChild:newAnimal];
    }
}

- (void)checkPlantContactWithId:(int)i {

    SKAnimals *mainTestingAnimal = self.animalArray[i];

    for (int k = 0; k < self.vegetableArray.count; k++) {
        if (mainTestingAnimal.animalType == Animal_Herbivore && mainTestingAnimal.nextMeal == 0) {

            SKVegetables *testingPlant = self.vegetableArray[k];
                
            if (CGRectIntersectsRect(mainTestingAnimal.frame, testingPlant.frame)) {
        
                
                
                SKAction *sequence = [SKAction sequence:@[[SKAction scaleTo:0.0f duration:1.0f],[SKAction removeFromParent]]];
                
                
                
                if (testingPlant.vegetableType == Vegetable_Grass){
                    
                [testingPlant runAction:sequence];
                [self.vegetableArray removeObject:testingPlant];
                mainTestingAnimal.energy += testingPlant.energyValue;
                mainTestingAnimal.nextMeal = 3;
                    
                } else if (testingPlant.vegetableType == Vegetable_Tree && testingPlant.leaves > 0) {
                
                    testingPlant.leaves--;
                    mainTestingAnimal.energy += testingPlant.energyValue;
                    mainTestingAnimal.nextMeal = 3;
                    
                }
                
                if (testingPlant.poisonLevel > 7){
                    SKAction *killAnimal = [SKAction sequence:@[[SKAction scaleTo:0 duration:1],[SKAction removeFromParent]]];
                    [mainTestingAnimal runAction:killAnimal completion:^{[self.animalArray removeObject:mainTestingAnimal];}];
                    return;
                }
            }
        }
    }
}

- (void)checkAnimalContactWithId:(int)i {
    
    SKAnimals *mainTestingAnimal = self.animalArray[i];

    for (int j = 0; j < self.animalArray.count; j++) {
        
        SKAnimals *secondaryTestingAnimal = self.animalArray[j];
        
        if (CGRectIntersectsRect(mainTestingAnimal.frame, secondaryTestingAnimal.frame)&&(i!=j)&&mainTestingAnimal.animalType!=Animal_Herbivore&&mainTestingAnimal.nextMeal == 0) {
            
            SKAction *killAnimal = [SKAction sequence:@[[SKAction scaleTo:0 duration:1],[SKAction removeFromParent]]];
            
            
            if ((mainTestingAnimal.animalType==Animal_Carnivore&&secondaryTestingAnimal.animalType==Animal_Herbivore)||(mainTestingAnimal.animalType==Animal_Predator&&secondaryTestingAnimal.animalType==Animal_Carnivore)) {
                
                
                mainTestingAnimal.energy += secondaryTestingAnimal.energyValue;
                if (mainTestingAnimal.animalType == Animal_Carnivore)
                    mainTestingAnimal.nextMeal = 6;
                if (mainTestingAnimal.animalType == Animal_Predator)
                    mainTestingAnimal.nextMeal = 6;
                    
                mainTestingAnimal.performingStopAction = YES;
                secondaryTestingAnimal.performingStopAction = YES;

                [secondaryTestingAnimal runAction:killAnimal completion:^{[self.animalArray removeObject:secondaryTestingAnimal];}];
            }
        }   
    }
}

-(void)updatePollution{
   
    for (int i = 0; i < self.pollutionArray.count; i++){
        self.earthPollution++;
    }
    self.earthPollution--;
    if (self.earthPollution > 100)
        self.earthPollution = 100;
    if (self.earthPollution < 0)
        self.earthPollution = 0;
    SKAction *colorSky = [SKAction colorizeWithColor:[UIColor grayColor] colorBlendFactor:self.earthPollution/100 duration:1.0f];
    [self.currentSky runAction:colorSky];
    [self.island runAction:colorSky];
    
    for (int i = 0; i < self.waterPollutionArray.count; i++){
        self.waterPollution++;
    }
    self.waterPollution--;
    if (self.waterPollution > 100)
        self.waterPollution = 100;
    if (self.waterPollution < 0)
        self.waterPollution = 0;
    SKAction *colorSea = [SKAction colorizeWithColor:[UIColor grayColor] colorBlendFactor:self.waterPollution/100 duration:1.0f];
    [self.sea runAction:colorSea];
    [self.water runAction:colorSea];
}

-(void)updateHumidity{
    
        if (40 > self.temperature && self.temperature > 25)
            self.humidity = self.humidity + 0.25f;
        if (self.temperature > 43)
            self.humidity = self.humidity - 1.0f;
        if (self.humidity > 100)
            self.humidity = 100;
        if (self.humidity < 0)
            self.humidity = 0;
    
        for (int i = 0; i < self.sceneryArray.count; i++){
            SKSpriteNode * testingCloud = self.sceneryArray[i];
            SKAction * color = [SKAction colorizeWithColorBlendFactor: self.humidity/200 duration:1.0f];
            [testingCloud runAction:color completion:^{ testingCloud.colorBlendFactor = self.humidity/200;}];
        }


}

-(void)checkForOpenLandMenu:(CGPoint)positionInScene {

    if ([self pointInIsland:positionInScene]) {
        
        SKAnimals *menuAnimalOne = [SKAnimals createAnimalofType:Animal_Herbivore];
        SKAnimals *menuAnimalTwo = [SKAnimals createAnimalofType:Animal_Carnivore];
        SKAnimals *menuAnimalThree = [SKAnimals createAnimalofType:Animal_Predator];
        SKVegetables *menuTreeOne = [SKVegetables createVegetableOfType:Vegetable_Grass];
        SKVegetables *menuTreeTwo = [SKVegetables createVegetableOfType:Vegetable_Tree];
        SKSpriteNode *menuFacotry = [SKSpriteNode spriteNodeWithImageNamed:@"industria.png"];
        
        menuAnimalTwo.size = CGSizeMake(20, 20);
        menuAnimalOne.size = CGSizeMake(20, 20);
        menuAnimalThree.size = CGSizeMake(20, 20);
        menuTreeOne.size = CGSizeMake(25, 35);
        menuTreeTwo.size = CGSizeMake(30, 45);
        menuFacotry.size = CGSizeMake(30, 30);

        menuAnimalOne.position = CGPointMake(positionInScene.x, positionInScene.y + 30);
        menuAnimalTwo.position = CGPointMake(positionInScene.x, positionInScene.y - 30);
        menuAnimalThree.position = CGPointMake(positionInScene.x + 30, positionInScene.y);
        menuTreeOne.position = CGPointMake(positionInScene.x - 30, positionInScene.y);
        menuTreeTwo.position = CGPointMake(positionInScene.x - 30, positionInScene.y - 50);
        menuFacotry.position = CGPointMake(positionInScene.x + 30, positionInScene.y + 30);

        menuAnimalOne.isChild = NO;
        menuAnimalTwo.isChild = NO;
        menuAnimalThree.isChild = NO;
        menuTreeOne.isNew = false;
        menuTreeTwo.isNew = false;

        [self.menuArray addObject:menuAnimalOne];
        [self.menuArray addObject:menuAnimalTwo];
        [self.menuArray addObject:menuAnimalThree];
        [self.menuArray addObject:menuTreeOne];
        [self.menuArray addObject:menuTreeTwo];
        [self.menuArray addObject:menuFacotry];

        [self addChild:menuAnimalOne];
        [self addChild:menuAnimalTwo];
        [self addChild:menuAnimalThree];
        [self addChild:menuTreeOne];
        [self addChild:menuTreeTwo];
        [self addChild:menuFacotry];
        
        self.isMenu = true;
        
    }
}

-(void)checkForWaterMenu:(CGPoint)positionInScene{
    
    CGRect rectAgua = CGRectMake(0,50,self.frame.size.width,130);
    
    if (CGRectContainsPoint(rectAgua, positionInScene)){
        
                SKAnimals *smallFish = [SKAnimals createAnimalofType:Animal_Water_Herbivore];
                SKAnimals *bigFish = [SKAnimals createAnimalofType:Animal_Water_Predator];
                SKSpriteNode *barrel = [SKSpriteNode spriteNodeWithImageNamed:@"Barril1.png"];
        
                barrel.size = CGSizeMake(barrel.size.width * 0.5f, barrel.size.height * 0.5f);
        
                smallFish.position = CGPointMake(positionInScene.x + 30, positionInScene.y);
                bigFish.position = CGPointMake(positionInScene.x - 30, positionInScene.y);
                barrel.position = CGPointMake(positionInScene.x, positionInScene.y + 30);
        
                [self.menuArray addObject:smallFish];
                [self.menuArray addObject:bigFish];
                [self.menuArray addObject:barrel];
        
                [self addChild:smallFish];
                [self addChild:bigFish];
                [self addChild:barrel];
                self.isMenu = true;
        
                
            }


}

-(void)checkForMenuClick:(CGPoint)positionInScene {
    
    if (self.menuArray.count == 0)
        self.clickedOnMenu = false;
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
                self.clickedOnMenu = true;
                return;
            }
        }
        else if ([[self.menuArray objectAtIndex:i] isKindOfClass:[SKVegetables class]]){
            SKVegetables *temp = self.menuArray[i];
            if ([temp containsPoint:positionInScene]){
                temp.poisonLevel = self.earthPollution/10;
                [self.menuArray removeObject:temp];
                [self removeChildrenInArray:self.menuArray];
                [self.menuArray removeAllObjects];
                [self.vegetableArray addObject:temp];
                temp.position = CGPointMake(self.lastTouch.x, self.lastTouch.y);
                self.isMenu = false;
                self.clickedOnMenu = true;
                return;
                
            }
        }
        else{
            SKSpriteNode *temp = self.menuArray[i];
            if ([temp containsPoint:positionInScene]){
                [self.menuArray removeObject:temp];
                [self removeChildrenInArray:self.menuArray];
                [self.menuArray removeAllObjects];
                
                temp.position = CGPointMake(self.lastTouch.x, self.lastTouch.y);
                self.isMenu = false;
                self.clickedOnMenu = true;
                CGRect rectAgua = CGRectMake(0,50,self.frame.size.width,130);
                if (CGRectContainsPoint(rectAgua, temp.position)){
                    SKAction *animateBarrel = [SKAction moveToY:50 duration:3.0f];
                    [temp runAction:animateBarrel];
                    [self.waterPollutionArray addObject:temp];
                }
                else{
                    
                    [self addSmokeOnFacotry:temp];
                    [self.pollutionArray addObject:temp];
                }

                return;
                
            }

        }
    }
}


-(void)addSmokeOnFacotry:(SKSpriteNode*)factory{

    NSString * smokePath = [[NSBundle mainBundle]
                            pathForResource:@"SmokeParticle" ofType:@"sks"];
    
    SKEmitterNode *burstNode;
    
    burstNode = [NSKeyedUnarchiver unarchiveObjectWithFile:smokePath];
    
    
    burstNode.position = CGPointMake(-factory.frame.size.width/2 , factory.frame.size.height/2);
    
    burstNode.numParticlesToEmit = 1000;
    
    [factory addChild:burstNode];

}

-(void)checkForAnimalClick:(CGPoint)positionInScene {
    
    for (int i = 0; i < self.animalArray.count; i++){
        SKAnimals *temp = self.animalArray[i];
        if ([temp containsPoint:positionInScene]){
            [temp removeFromParent];
            return;
        }
    }
    
}

-(void)checkForClickOutsideMenu:(CGPoint)positionInScene {
 
    if (self.isMenu){
        [self removeChildrenInArray:self.menuArray];
        [self.menuArray removeAllObjects];
        self.isMenu = false;
        self.clickedOnMenu = true;
        return;
    }
}

-(BOOL)pointInIsland:(CGPoint)point {
    
    float width = self.frame.size.width/1.5;
    float height = self.frame.size.height/5;
    float x = CGRectGetMidX(self.frame);
    float y = CGRectGetMidY(self.frame) - self.frame.size.height*0.02;
    
    float a = width/2;
    float b = height; //POR QUE NAO HEIGHT/2 ????
    
    float yMin = y - (height/2);
    float yMax = y + (height/2);
    
    float yInElipse = point.y - yMin;
    
    float xInElipse = sqrtf( (a*a) * (1 - ((yInElipse*yInElipse)/(b*b))));
    float xMax = x + xInElipse;
    float xMin = x - xInElipse;
    
    if((point.y>yMin && point.y<yMax)&&(point.x>xMin && point.x<xMax)) {
        return true;
    } else {
        return false;
    }
    
}

float getRandomNum(float minimum, float maximum) {
    return arc4random_uniform((maximum - minimum) + 1.0) + minimum;
}


@end
