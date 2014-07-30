//
//  GameViewController.h
//  Texty Bird
//
//  Created by Ryan Handy on 7/30/14.
//  Copyright (c) 2014 handigarde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController
{
    IBOutlet UILabel *birdLabel;
    IBOutlet UILabel *startLabel;
    IBOutlet UILabel *scoreLabel;
    NSTimer *gameTimer;
    NSMutableArray *enemies;
    NSInteger gameState;
    NSInteger velocity;
    float score;
}

@property (nonatomic, retain) UILabel *birdLabel;
@property (nonatomic, retain) UILabel *startLabel;
@property (nonatomic, retain) UILabel *scoreLabel;
@property (nonatomic, retain) NSTimer *gameTimer;
@property (nonatomic, retain) NSMutableArray *enemies;

- (IBAction)flap;
- (void)startGame;
- (void)gameLoop;
- (void)moveEnemies;
- (void)checkIfAlive;
- (void)killBird;
- (void)dead;

@end
