//
//  SecondViewController.m
//  Orbilis
//
//  Created by Joao Nassar Galante Guedes on 28/01/15.
//  Copyright (c) 2015 BEPID-PucRJ. All rights reserved.
//

#import "SecondViewController.h"
#import "GameScene.h"

@implementation SKScene (Unarchive)

//+ (instancetype)unarchiveFromFile:(NSString *)file {
//    /* Retrieve scene file path from the application bundle */
//    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
//    /* Unarchive the file to an SKScene object */
//    NSData *data = [NSData dataWithContentsOfFile:nodePath
//                                          options:NSDataReadingMappedIfSafe
//                                            error:nil];
//    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//    [arch setClass:self forClassName:@"SKScene"];
//    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
//    [arch finishDecoding];
//
//    return scene;
//}

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    float width = screenRect.size.width;
    float height = screenRect.size.height;
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    background.image = [UIImage imageNamed:@"FirstScreen.png"];
    [self.view addSubview:background];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    SecondViewController *view = [[SecondViewController alloc] init];
    [self presentViewController:view animated:true completion:nil];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
