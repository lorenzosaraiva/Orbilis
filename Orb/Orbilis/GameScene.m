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
    self.isNight = false;
    self.secondsToNight = 30;
    self.nightDuration = 15;
    self.temperature = 27;
    self.timeSinceLast = 0;
    self.earthPollution = 0;
    self.global = 0;
    self.tree = 0;
    self.pollution = 0;
    self.waterPollution = 0;
    self.humidity = 0;
    self.herbivores = 0;
    self.animalArray = [[NSMutableArray alloc] init];
    self.menuArray = [[NSMutableArray alloc] init];
    self.vegetableArray = [[NSMutableArray alloc] init];
    self.sceneryArray = [[NSMutableArray alloc] init];
    self.pollutionArray = [[NSMutableArray alloc] init];
    self.waterPollutionArray = [[NSMutableArray alloc]init];
    
    [self playMusic];
    [self drawWolrd];
    
    UIPinchGestureRecognizer *pinchGesture  = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(resizeSun:)];
    [self.view addGestureRecognizer:pinchGesture];
    
    UILongPressGestureRecognizer *holdGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleHoldGesture:)];
    holdGesture.allowableMovement = 200;
    [self.view addGestureRecognizer:holdGesture];
    
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

    self.dark = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:self.view.frame.size];
    self.dark.alpha = 0.0f;
    self.dark.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    self.dark.zPosition = 1.0f;
    [self addChild:self.dark];
    
}
-(void)playMusic{
    SKAction *playMusic = [SKAction repeatActionForever:[SKAction playSoundFileNamed:@"Music1.mp3" waitForCompletion:YES]];
    [self runAction:playMusic];

}
- (void)drawWolrd {
    
    
    [self drawPath];
    
    float prop = 0.52f;
    
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
    
    self.nightSky = [SKSpriteNode spriteNodeWithImageNamed:@"SkyDarkBlue.png"];
    self.nightSky.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+100);
    self.nightSky.size = CGSizeMake(self.nightSky.frame.size.width*prop, self.nightSky.frame.size.height*prop);
    self.nightSky.alpha = 0.0f;
    [self addChild:self.nightSky];
    
    self.water = [SKSpriteNode spriteNodeWithImageNamed:@"Water.png"];
    self.water.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    self.water.size = CGSizeMake(self.water.frame.size.width*prop, self.water.frame.size.height*prop);
    self.water.zPosition = 0.12f;
    [self addChild:self.water];
    
    self.sea = [SKSpriteNode spriteNodeWithImageNamed:@"Sea.png"];
    self.sea.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    self.sea.size = CGSizeMake(self.sea.frame.size.width*prop, self.sea.frame.size.height*prop);
    self.sea.zPosition = 0.11f;
    [self addChild:self.sea];
    
    self.sand = [SKSpriteNode spriteNodeWithImageNamed:@"Sand.png"];
    self.sand.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    self.sand.size = CGSizeMake(self.sand.frame.size.width*prop, self.sand.frame.size.height*prop);
    self.sand.zPosition = 0.13f;
    [self addChild:self.sand];
    
    self.island = [SKSpriteNode spriteNodeWithImageNamed:@"Island.png"];
    self.island.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    self.island.size = CGSizeMake(self.island.frame.size.width*prop, self.island.frame.size.height*prop);
    self.island.zPosition = 0.2f;
    
    [self addChild:self.island];
    
    self.sun = [SKSpriteNode spriteNodeWithImageNamed:@"Sol.png"];
    self.sun.position = CGPointMake(90, self.frame.size.height - 120);
    self.sun.zPosition = 0.1f;
    
    [self addChild:self.sun];
    
    self.moon = [SKSpriteNode spriteNodeWithImageNamed:@"Lua.png"];
    self.moon.position = CGPointMake(self.frame.size.width - 90, self.frame.size.height - 120);
    self.moon.zPosition = 0.1f;
    self.moon.alpha = 0.0f;
    
    [self addChild:self.moon];
    
    self.dark = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:self.view.frame.size];
    self.dark.alpha = 0.0f;
    self.dark.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    self.dark.zPosition = 1.0f;
    [self addChild:self.dark];
    
    self.removeButton = [SKSpriteNode spriteNodeWithImageNamed:@"ClearButton.png"];
    self.removeButton.size = CGSizeMake(30, 30);
    self.removeButton.position = CGPointMake(20, self.frame.size.height - 20);
    self.removeButton.zPosition = 1.0f;
    [self addChild:self.removeButton];
    
    self.infoButton = [SKSpriteNode spriteNodeWithImageNamed:@"InfoButton.png"];
    self.infoButton.size = CGSizeMake(30, 30);
    self.infoButton.position = CGPointMake(self.frame.size.width - 20, self.frame.size.height - 20);
    self.infoButton.zPosition = 1.0f;
    [self addChild:self.infoButton];
    
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
    self.islandShape.alpha = 0.0f;
    [self addChild:self.islandShape];
}

-(void)resizeSun:(UIPinchGestureRecognizer*)recognizer{
    if (self.isNight)
        return;
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    
    touchLocation = [self convertPointFromView:touchLocation];
    
    if ([self.sun containsPoint:touchLocation]){
        if (recognizer.scale > 1){
            if (self.sun.size.height * 1.03f < 180){
                self.sun.size = CGSizeMake(self.sun.size.width * 1.03f, self.sun.size.height * 1.03f);
                self.temperature = self.sun.frame.size.height/4 - 0.5f * [self.sceneryArray count];
                
            }
            
        }
        else {
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



-(void)makeItRain {
    
    
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

-(void)growLeavesInAllTrees {
    for (int i = 0; i < self.vegetableArray.count; i++){
        SKVegetables *tree = self.vegetableArray[i];
        if (tree.vegetableType == Vegetable_Tree)
            tree.leavesCounter = tree.leavesGrowth;
        
    }
}

-(void)acidRain {
    
    for (int i = 0; i < self.vegetableArray.count/2; i++){
        SKVegetables *vegetableToDie = self.vegetableArray[i];
        SKAction *sequence = [SKAction sequence:@[[SKAction scaleTo:0.0f duration:1.0f],[SKAction removeFromParent]]];
        [self.vegetableArray removeObject:vegetableToDie];
        [vegetableToDie runAction:sequence];
    }
}

- (void)handleHoldGesture:(UILongPressGestureRecognizer *)recognizer {
    
    CGPoint positionInScene = [recognizer locationInView:self.view];
    positionInScene = [self convertPointFromView:positionInScene];
    
    
    if (!self.clickedOnMenu&&!self.isMenu){
        [self checkForOpenLandMenu:positionInScene];
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
        [self runAction:[SKAction playSoundFileNamed:@"TheWhip2.wav" waitForCompletion:YES]];
        [self colorSky];
    }else{
    if (!self.clickedOnMenu){
        [self checkForAnimalClick:touchLocation];
        //        [self checkForOpenLandMenu:positionInScene];
        //        [self checkForWaterMenu:positionInScene];
        
    }
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
    //
    //        self.lightDark = true;
    //        self.light.alpha = 0.0f;
    //    }
    [self checkForButtonClick:positionInScene];
    [self checkForMenuClick:positionInScene];
    
    [self checkForClickOutsideMenu:positionInScene];
    
    
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

- (void)checkForButtonClick:(CGPoint)positionInScene {
    if ([self.infoButton containsPoint:positionInScene]){
        
        self.herbivores = 0;
        self.carnivores = 0;
        self.predators = 0;
        for (int i = 0; i < self.animalArray.count; i++){
            SKAnimals *temp = self.animalArray[i];
            if (temp.animalType == 0)
                self.herbivores++;
            if (temp.animalType == 1)
                self.carnivores++;
            if (temp.animalType == 2)
                self.predators++;
        }
        UIViewController *mainView = self.view.window.rootViewController;
        InfoTableViewController *infoView = [[InfoTableViewController alloc]init];
        infoView.temperature = self.temperature;
        infoView.animals = self.animalArray.count;
        infoView.humidity = self.humidity;
        infoView.pollution = self.earthPollution;
        infoView.herbivores = self.herbivores;
        infoView.carnivores = self.carnivores;
        infoView.predators = self.predators;
        infoView.vegetables = self.vegetableArray.count;
        [mainView presentViewController:infoView animated:YES completion:nil];
        
    }
    if ([self.removeButton containsPoint:positionInScene]){
        [self restartGame];
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
    NSLog(@"%d herbivoros", self.herbivores);
    
}

- (void)checkAmbientStatus {
    
    if (self.humidity > 75 && self.sceneryArray.count > 3)
        [self makeItRain];
    [self updatePollution];
    [self updateHumidity];
    [self updateNight];
    [self moveClouds];
}

- (void)moveClouds{
    
    for (int i = 0; i < self.sceneryArray.count; i++){
        SKSpriteNode * testingCloud = self.sceneryArray[i];
        CGRect cloudArea = CGRectMake(0, 400, self.scene.frame.size.width, 300);
        float a = 0;
        if (!self.isNight)
            a = getRandomNum(-5, 0);
        if (self.isNight)
            a = getRandomNum(0, 9);
        float b = getRandomNum(-4, 4);
        SKAction * move;
        if (CGRectContainsPoint(cloudArea, CGPointMake(testingCloud.position.x + a, testingCloud.position.y + b))){
            move = [SKAction moveBy:CGVectorMake(a, b)duration:1.0f];
            [testingCloud runAction:move];
        }
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
        
        CGPoint point = CGPointMake(mainTestingVegetable.position.x + vegetableX, mainTestingVegetable.position.y + vegetableY);
        if ([self pointInIsland:point]){
            new.position = point;
            [self.vegetableArray addObject:new];
            [self addChild:new];
            [self runAction:[SKAction playSoundFileNamed:@"TheSwipe.wav" waitForCompletion:YES]];
            new.poisonLevel = self.earthPollution/10;
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
                [self runAction:[SKAction playSoundFileNamed:@"TheSwipe.wav" waitForCompletion:YES]];
                new.poisonLevel = self.earthPollution/10;
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
        mainTestingVegetable.poisonLevel = self.earthPollution/10;
    }
    mainTestingVegetable.leavesCounter++;
    if (mainTestingVegetable.leavesCounter > mainTestingVegetable.leavesGrowth)
        mainTestingVegetable.leavesCounter = mainTestingVegetable.leavesGrowth;
}

- (void)checkVegetablesGrowthWithId:(int)i {
    
    SKVegetables *mainTestingVegetable = self.vegetableArray[i];
    
    if (mainTestingVegetable.growthTime == 5 && mainTestingVegetable.vegetableType == Vegetable_Tree && mainTestingVegetable.isNew) {
        if (mainTestingVegetable.growthCounter < mainTestingVegetable.maxGrowth){
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
        
        
        if ([self pointInIsland:point] && ![mainTestingAnimal hasActions])
            [mainTestingAnimal runAction:move];
        
        CGRect rectAgua = CGRectMake(0,50,self.frame.size.width,100);
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
    mainTestingAnimal.energy -= 0.02f;
    if (mainTestingAnimal.energy <= 0){
        SKAction *killAnimal = [SKAction sequence:@[[SKAction scaleTo:0 duration:1],[SKAction removeFromParent]]];
        [mainTestingAnimal runAction:killAnimal completion:^{[self.animalArray removeObject:mainTestingAnimal];}];
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
        [self runAction:[SKAction playSoundFileNamed:@"TheSwipe.wav" waitForCompletion:YES]];
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
                
                if (testingPlant.poisonLevel > 8){
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
                    mainTestingAnimal.nextMeal = 5;
                if (mainTestingAnimal.animalType == Animal_Predator)
                    mainTestingAnimal.nextMeal = 5;
                
                mainTestingAnimal.performingStopAction = YES;
                secondaryTestingAnimal.performingStopAction = YES;
                
                [secondaryTestingAnimal runAction:killAnimal completion:^{[self.animalArray removeObject:secondaryTestingAnimal];}];
            }
        }
    }
}

-(void)restartGame{
    [self removeChildrenInArray:self.animalArray];
    [self removeChildrenInArray:self.pollutionArray];
    [self removeChildrenInArray:self.sceneryArray];
    [self removeChildrenInArray:self.vegetableArray];
    self.isMenu = false;
    self.clickedOnMenu = false;
    self.isNight = false;
    self.secondsToNight = 30;
    self.nightDuration = 15;
    self.temperature = 27;
    self.timeSinceLast = 0;
    self.earthPollution = 0;
    self.global = 0;
    self.tree = 0;
    self.pollution = 0;
    self.waterPollution = 0;
    self.humidity = 0;
    self.herbivores = 0;
    self.carnivores = 0;
    self.predators = 0;
    [self.animalArray removeAllObjects];
    [self.pollutionArray removeAllObjects];
    [self.vegetableArray removeAllObjects];
    [self.sceneryArray removeAllObjects];
}

-(void)updateNight{
    
    if (!self.isNight){
        self.secondsToNight--;
        if (self.secondsToNight == 0){
            self.isNight = true;
            self.secondsToNight = 40;
            [self duskOrDawn:self.isNight];
        }
    } else {
        self.nightDuration--;
        if (self.nightDuration == 0){
            self.isNight = false;
            self.nightDuration = 20;
            [self duskOrDawn:self.isNight];
        }
    }
}
-(void)duskOrDawn:(BOOL)isNight{
    
    SKAction *fadeIn = [SKAction fadeInWithDuration:5.0f];
    SKAction *fadeOut = [SKAction fadeOutWithDuration:5.0f];
    if (isNight){
        [self.currentSky runAction:fadeOut];
        [self.nightSky runAction:fadeIn];
        self.temperature -= 5;
        SKAction *sunDown = [SKAction moveByX:0 y:-250 duration:5.0f];
        [self.sun runAction:sunDown];
        [self.moon runAction:fadeIn];
        self.lastSky = self.currentSky;
        self.currentSky = self.nightSky;
        [self.dark runAction:[SKAction fadeAlphaTo:0.3f duration:5.0f]];
        
    }
    else    {
        [self.nightSky runAction:fadeOut];
        [self.lastSky runAction:fadeIn];
        self.temperature+=5;
        SKAction *sunUp = [SKAction moveByX:0 y:250 duration:5.0f];
        [self.sun runAction:sunUp];
        [self.moon runAction:fadeOut];
        [self.dark runAction:[SKAction fadeAlphaTo:0.0f duration:5.0f]];
        
        self.currentSky = self.lastSky;
        self.lastSky = self.nightSky;
    }
}
-(void)updatePollution{
    
    for (int i = 0; i < self.pollutionArray.count; i++){
        self.earthPollution++;
    }
    for (int i = 0; i < self.vegetableArray.count; i++){
        self.earthPollution -= 0.05f;
    }
    self.earthPollution--;
    
    if (self.earthPollution > 100)
        self.earthPollution = 100;
    if (self.earthPollution < 0)
        self.earthPollution = 0;
    SKAction *colorSky = [SKAction colorizeWithColor:[UIColor grayColor] colorBlendFactor:self.earthPollution/100 duration:1.0f];
    [self.currentSky runAction:colorSky];
    [self.island runAction:colorSky];
    [self.sand runAction:colorSky];
    
    for (int i = 0; i < self.waterPollutionArray.count; i++){
        self.waterPollution++;
    }
    self.waterPollution--;
    if (self.waterPollution > 100)
        self.waterPollution = 100;
    if (self.waterPollution < 0)
        self.waterPollution = 0;
    
    self.waterPollution = self.earthPollution;
    SKAction *colorSea = [SKAction colorizeWithColor:[UIColor grayColor] colorBlendFactor:self.waterPollution/100 duration:1.0f];
    [self.sea runAction:colorSea];
    [self.water runAction:colorSea];
}

-(void)updateHumidity{
    if (43 > self.temperature && self.temperature >= 40)
        self.humidity = self.humidity + 1.0f;
    if (40 > self.temperature && self.temperature >= 32)
        self.humidity = self.humidity + 0.5f;
    if (32 > self.temperature && self.temperature > 25)
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
        
        [self runAction:[SKAction playSoundFileNamed:@"TheMenu.wav" waitForCompletion:YES]];
        
        SKMenuElement *menuAnimalOne = [SKMenuElement createMenuElementOfType:0 InPosition:positionInScene];
        SKMenuElement *menuAnimalTwo = [SKMenuElement createMenuElementOfType:1 InPosition:positionInScene];
        SKMenuElement *menuAnimalThree = [SKMenuElement createMenuElementOfType:2 InPosition:positionInScene];
        SKMenuElement *menuTreeOne = [SKMenuElement createMenuElementOfType:3 InPosition:positionInScene];
        SKMenuElement *menuTreeTwo = [SKMenuElement createMenuElementOfType:4 InPosition:positionInScene];
        SKMenuElement *menuFacotry = [SKMenuElement createMenuElementOfType:5 InPosition:positionInScene];
        
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
        self.lastTouch = positionInScene;
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
    SKMenuElement *testingElement;
    for (int i = 0; i < self.menuArray.count; i++){
        testingElement = [self.menuArray objectAtIndex:i];
        if (testingElement.elementType == 0|| testingElement.elementType == 1||testingElement.elementType == 2){
            if ([testingElement containsPoint:positionInScene]){
                SKAnimals *temp = [SKAnimals createAnimalofType:(AnimalType)testingElement.elementType];
                [self.animalArray addObject:temp];
                [self removeChildrenInArray:self.menuArray];
                [self.menuArray removeAllObjects];
                temp.size = CGSizeMake(20, 20);
                temp.position = CGPointMake(self.lastTouch.x, self.lastTouch.y);
                [self addChild:temp];
                self.isMenu = false;
                self.clickedOnMenu = true;
                [self runAction:[SKAction playSoundFileNamed:@"ThePop2.wav" waitForCompletion:YES]];
                return;
            }
        }
        else if (testingElement.elementType == 3 || testingElement.elementType == 4){
            if ([testingElement containsPoint:positionInScene]){
                
                SKVegetables *temp;
                if (testingElement.elementType == Vegetable_Grass_Menu){
                    temp = [SKVegetables createVegetableOfType:Vegetable_Grass];
                    temp.size = CGSizeMake(25, 35);
                }
                if (testingElement.elementType == Vegetable_Tree_Menu){
                    temp = [SKVegetables createVegetableOfType:Vegetable_Tree];
                    temp.size = CGSizeMake(30, 45);
                }
                temp.poisonLevel = self.earthPollution/10;
                
                [self removeChildrenInArray:self.menuArray];
                [self.menuArray removeAllObjects];
                [self.vegetableArray addObject:temp];
                
                temp.position = CGPointMake(self.lastTouch.x, self.lastTouch.y);
                temp.isNew = NO;
                
                [self addChild:temp];
                
                self.isMenu = false;
                self.clickedOnMenu = true;
                [self runAction:[SKAction playSoundFileNamed:@"ThePop2.wav" waitForCompletion:YES]];
                return;
                
            }
        }
        else{
            if ([testingElement containsPoint:positionInScene]){
                
                SKSpriteNode *temp = [SKSpriteNode spriteNodeWithImageNamed:@"industria.png"];
                temp.zPosition = 0.45f;
                [self removeChildrenInArray:self.menuArray];
                [self.menuArray removeAllObjects];
                temp.position = CGPointMake(self.lastTouch.x, self.lastTouch.y);
                temp.size = CGSizeMake(40, 40);
                [self addChild:temp];
                
                self.isMenu = false;
                self.clickedOnMenu = true;
                CGRect rectAgua = CGRectMake(0,50,self.frame.size.width,100);
                if (CGRectContainsPoint(rectAgua, temp.position)){
                    SKAction *animateBarrel = [SKAction moveToY:50 duration:3.0f];
                    [temp runAction:animateBarrel];
                    [self.waterPollutionArray addObject:temp];
                }
                else{
                    
                    [self addSmokeOnFacotry:temp];
                    [self.pollutionArray addObject:temp];
                }
                
                [self runAction:[SKAction playSoundFileNamed:@"ThePop2.wav" waitForCompletion:YES]];
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
            [self.animalArray removeObject:temp];
            [temp removeFromParent];
            [self runAction:[SKAction playSoundFileNamed:@"ThePop.wav" waitForCompletion:YES]];
            return;
        }
    }
    for (int i = 0; i < self.vegetableArray.count; i++){
        SKVegetables *temp = self.vegetableArray[i];
        if ([temp containsPoint:positionInScene]){
            [self.vegetableArray removeObject:temp];
            [temp removeFromParent];
            [self runAction:[SKAction playSoundFileNamed:@"ThePop.wav" waitForCompletion:YES]];
            return;
        }
    }
    for (int i = 0; i < self.pollutionArray.count; i++){
        SKSpriteNode *temp = self.pollutionArray[i];
        if ([temp containsPoint:positionInScene]){
            [self.pollutionArray removeObject:temp];
            [temp removeFromParent];
            [self runAction:[SKAction playSoundFileNamed:@"ThePop.wav" waitForCompletion:YES]];
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
