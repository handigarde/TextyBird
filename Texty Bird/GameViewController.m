//
//  GameViewController.m
//  Texty Bird
//
//  Created by Ryan Handy on 7/30/14.
//  Copyright (c) 2014 handigarde. All rights reserved.
//

#import "GameViewController.h"

#define CLICK_TO_START 0
#define IN_GAME 1
#define DYING 2
#define ENEMY_COUNT 8
#define GRAVITY 1
#define FLAP_VELOCITY -13
#define ENEMY_VELOCITY 8
#define DYING_FLAP -8


@interface GameViewController ()

@end

@implementation GameViewController

@synthesize birdLabel;
@synthesize startLabel;
@synthesize scoreLabel;
@synthesize gameTimer;
@synthesize enemies;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    birdLabel.text = @"Bird";
    gameState = 0;
    score = 0.0;
    scoreLabel.text = [NSString stringWithFormat:@"%.02f", score];
    velocity = FLAP_VELOCITY;
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:.04 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
    enemies = [[NSMutableArray alloc]init];
    for (int i = 0; i < ENEMY_COUNT; i++) {
        UILabel *enemyLabel = [[UILabel alloc]initWithFrame:CGRectMake(-200, 300, 53, 21)];
        //UILabel *enemyLabel = [[UILabel alloc]initWithFrame:CGRectMake(300, i * 100, 53, 21)];
        enemyLabel.text = @"enemy";
        [self.view addSubview:enemyLabel];
        [enemies addObject:enemyLabel];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) flap
{
    if (gameState == CLICK_TO_START)
    {
        [self startGame];
    }
    else if (gameState == IN_GAME)
    {
        birdLabel.text = @"Flap";
        velocity = FLAP_VELOCITY;
    }
}

- (void)gameLoop
{
    if (!gameState == CLICK_TO_START)
    {
        birdLabel.frame = CGRectMake(birdLabel.frame.origin.x, birdLabel.frame.origin.y + velocity, birdLabel.frame.size.width, birdLabel.frame.size.height);
        velocity += GRAVITY;
        [self moveEnemies];
        if (gameState == IN_GAME) {
            score += 0.04;
            scoreLabel.text = [NSString stringWithFormat:@"%.02f", score];
            [self checkIfAlive];
        }
        if (velocity > -3 && gameState != DYING)
        {
            birdLabel.text = @"Bird";
        }
        if (gameState == DYING && birdLabel.frame.origin.y > self.view.frame.size.height + 10) {
            [self dead];
        }
    }
}

- (void)moveEnemies
{
    for (UILabel *enemy in enemies)
    {
        if (enemy.frame.origin.x < 0 - (enemy.frame.size.width + 20))
        {
            enemy.frame = CGRectMake(arc4random()%150 + self.view.frame.size.width, arc4random() % (int)self.view.frame.size.height, enemy.frame.size.width, enemy.frame.size.height);
        }
        enemy.frame = CGRectMake(enemy.frame.origin.x - ENEMY_VELOCITY, enemy.frame.origin.y, enemy.frame.size.width, enemy.frame.size.height);
    }
}

- (void)startGame
{
    gameState = IN_GAME;
    velocity = FLAP_VELOCITY;
    birdLabel.text = @"Flap";
    score = 0.0;
    [startLabel setAlpha:0.0];
    //startLabel.frame = CGRectMake(self.view.frame.size.width + 2, startLabel.frame.origin.y, startLabel.frame.size.width, startLabel.frame.size.height);
    birdLabel.frame = CGRectMake(20, self.view.frame.size.height / 2, birdLabel.frame.size.width, birdLabel.frame.size.height);
    for (UILabel *enemy in enemies) {
        enemy.frame = CGRectMake(-200, 300, 53, 21);
    }
}

- (void)checkIfAlive
{
    if (birdLabel.frame.origin.y > (self.view.frame.size.height - birdLabel.frame.size.height) || birdLabel.frame.origin.y < 0)
    {
        [self killBird];
    }
    for (UILabel *enemy in enemies) {
        if (CGRectIntersectsRect(enemy.frame, birdLabel.frame)) {
            [self killBird];
        }
    }
}

- (void)killBird
{
    birdLabel.text = @"Dead";
    gameState = DYING;
    velocity = DYING_FLAP;
}

- (void)dead
{
    gameState = CLICK_TO_START;
    [startLabel setAlpha:1.0];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
