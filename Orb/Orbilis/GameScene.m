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
    self.clickedOnMenu = false;
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
    
    [self drawWolrd];
    
    UIPinchGestureRecognizer *pinchGesture  = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(resizeSun:)];
    [self.view addGestureRecognizer:pinchGesture];
    
    UISwipeGestureRecognizer *swipeLeftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    UISwipeGestureRecognizer *swipeRightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    swipeLeftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeRightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightRecognizer];
    [self.view addGestureRecognizer:swipeLeftRecognizer];
    
}

- (void)drawWolrd {
    
    float prop = 0.55;
    
    SKSpriteNode *cage = [SKSpriteNode spriteNodeWithImageNamed:@"Cage.png"];
    cage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    cage.size = CGSizeMake(cage.frame.size.width*prop, cage.frame.size.height*prop);
    [self addChild:cage];
    
    self.sky = [SKSpriteNode spriteNodeWithImageNamed:@"Sky.png"];
    self.sky.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    self.sky.size = CGSizeMake(self.sky.frame.size.width*prop, self.sky.frame.size.height*prop);
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
    self.sun.position = CGPointMake(90, self.frame.size.height - 120);
    self.sun.zPosition = 0.1f;

    [self addChild:self.sun];
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
    }
    if (self.temperature > 30 && self.temperature < 40){
        [self.orangeSky runAction:fadeOut];
        [self.lightOrangeSky runAction:fadeIn];
        [self.sky runAction:fadeOut];
        [self.lightBlueSky runAction:fadeOut];
    
    }
    if (self.temperature < 30 && self.temperature > 15){
        [self.orangeSky runAction:fadeOut];
        [self.lightOrangeSky runAction:fadeOut];
        [self.sky runAction:fadeIn];
        [self.lightBlueSky runAction:fadeOut];
        
    }
    if (self.temperature < 15){
        [self.orangeSky runAction:fadeOut];
        [self.lightOrangeSky runAction:fadeOut];
        [self.sky runAction:fadeOut];
        [self.lightBlueSky runAction:fadeIn];
    
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
            self.temperature = self.temperature - 0.5f;
            self.humidity++;
        }
        self.temperatureLabel.text = [NSString stringWithFormat:@"%.f",self.temperature];
        
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    
    
    [self checkForMenuClick:positionInScene];
    [self checkForAnimalClick:positionInScene];
    [self checkForClickOutsideMenu:positionInScene];
    if (!self.clickedOnMenu)
    [self checkForOpenLandMenu:positionInScene];
    

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
            [self checkVegetablsGrowthWithId:i];
            [self controlVegetableLeavesWithId:i];
            [self reproduceVegetableWithId:i];

        }
        
        for (int i = 0; i < self.animalArray.count; i++){
        NSLog(@"animais: %lu", (unsigned long)self.animalArray.count);
        
        [self moveAnimalWithId:i];
        [self checkPlantContactWithId:i];
        if (i < self.animalArray.count)
        [self checkAnimalContactWithId:i];
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
            if (new.vegetableType == Vegetable_Grass){
                new.poisonLevel = self.pollution/10;
                self.grass++;
            }
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

    if (mainTestingAnimal.nextMeal > 0) {
        mainTestingAnimal.nextMeal--;
    }

}

- (void)updateAnimalsEnergy {
    
}

- (void)growAnimalWithId:(int)i {

    SKAnimals *mainTestingAnimal = self.animalArray[i];
    
    mainTestingAnimal.age++;

    if (mainTestingAnimal.age >= mainTestingAnimal.ageLimit) {

        [self.animalArray removeObject:mainTestingAnimal];
        [mainTestingAnimal removeFromParent];
    }
}

- (void)reproduceAnimal:(SKAnimals*)mainTestingAnimal {
        
    if (mainTestingAnimal.energy>=mainTestingAnimal.multiplyLimit) {
    
        mainTestingAnimal.energy--;

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
        
                mainTestingAnimal.energy += testingPlant.energyValue;
                            
                SKAction *sequence = [SKAction sequence:@[[SKAction scaleTo:0.0f duration:1.0f],[SKAction removeFromParent]]];
                mainTestingAnimal.nextMeal = 10;
                self.grass--;
                
                [testingPlant runAction:sequence];
                [self.vegetableArray removeObject:testingPlant];                  
            }
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
                mainTestingAnimal.nextMeal = 10;

                mainTestingAnimal.performingStopAction = YES;
                secondaryTestingAnimal.performingStopAction = YES;

                [secondaryTestingAnimal runAction:eatAnimal];
                [self.animalArray removeObject:secondaryTestingAnimal];
                [self reproduceAnimal:mainTestingAnimal];  
            }
        }   
    }
}

-(void)checkForOpenLandMenu:(CGPoint)positionInScene {

    if ([self pointInIsland:positionInScene]) {
        
        SKAnimals *menuAnimalOne = [SKAnimals createAnimalofType:Animal_Herbivore];
        SKAnimals *menuAnimalTwo = [SKAnimals createAnimalofType:Animal_Carnivore];
        SKAnimals *menuAnimalThree = [SKAnimals createAnimalofType:Animal_Predator];
        SKVegetables *menuTreeOne = [SKVegetables createVegetableOfType:Vegetable_Grass];

        menuAnimalTwo.size = CGSizeMake(20, 20);
        menuAnimalOne.size = CGSizeMake(20, 20);
        menuAnimalThree.size = CGSizeMake(20, 20);
        menuTreeOne.size = CGSizeMake(25, 35);

        menuAnimalOne.position = CGPointMake(positionInScene.x, positionInScene.y + 30);
        menuAnimalTwo.position = CGPointMake(positionInScene.x, positionInScene.y - 30);
        menuAnimalThree.position = CGPointMake(positionInScene.x + 30, positionInScene.y);
        menuTreeOne.position = CGPointMake(positionInScene.x - 30, positionInScene.y);

        menuAnimalOne.isChild = NO;
        menuAnimalTwo.isChild = NO;
        menuAnimalThree.isChild = NO;
        menuTreeOne.isNew = false;

        [self.menuArray addObject:menuAnimalOne];
        [self.menuArray addObject:menuAnimalTwo];
        [self.menuArray addObject:menuAnimalThree];
        [self.menuArray addObject:menuTreeOne];

        [self addChild:menuAnimalOne];
        [self addChild:menuAnimalTwo];
        [self addChild:menuAnimalThree];
        [self addChild:menuTreeOne];
        
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
    }
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
    
    return (CGRectContainsPoint(rect, point )||CGRectContainsPoint(rect2, point));
}

float getRandomNum(float minimum, float maximum) {
    return arc4random_uniform((maximum - minimum) + 1.0) + minimum;
}


@end
