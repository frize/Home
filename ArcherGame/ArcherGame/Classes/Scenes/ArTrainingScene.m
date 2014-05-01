//
//  ArTrainingScene.m
//  ArcherGame
//
//  Created by tico on 4/28/14.
//  Copyright (c) 2014 ISB. All rights reserved.
//

#import "ArTrainingScene.h"
#import "ArPhysicArrow.h"

@interface ArTrainingScene()

@property (nonatomic, strong) ChipmunkSpace *space;
@property (nonatomic, assign) CGPoint touchBeginLocation;
@property (nonatomic, strong) NSDate *touchBeginTime;
@property (nonatomic, strong) CCSpriteBatchNode *arrowBatch;

@end

@implementation ArTrainingScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (ArTrainingScene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);

    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;

    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f]];
    [self addChild:background];

    // Setup Space
    self.space = [[ChipmunkSpace alloc] init];
    [self.space setGravity:ccp(0, -980)];
    [self.space setDamping:0.9];
    cpBB bounds = cpBBNew(0, self.contentSize.height, self.contentSize.width, 0);
    [self.space addBounds:bounds thickness:1.5 elasticity:0.3 friction:0.9 filter:CP_SHAPE_FILTER_ALL collisionType:0];

    self.arrowBatch = [CCSpriteBatchNode batchNodeWithFile:@"Arrow.png"];
    [self addChild:self.arrowBatch];

    // Create a back button
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];

    // done
	return self;
}

// -----------------------------------------------------------------------

- (void)dealloc
{
    // clean up code goes here
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];

    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInterActionEnabled for the individual nodes
    // Per frame update is automatically enabled, if update is overridden

}

- (void)update:(CCTime)delta{
//    [self.space step:delta];
    for (ChipmunkBody *body in self.space.bodies){
       [[body userData] syncPhysic];
    }
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}

// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    self.touchBeginLocation = [touch locationInNode:self];
    self.touchBeginTime = [NSDate date];
}

-(void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint touchEndLocation = [touch locationInNode:self];
    NSDate *touchEndTime = [NSDate date];
    double time = [touchEndTime timeIntervalSinceDate:self.touchBeginTime];

    CGPoint distVect = CGPointMake((touchEndLocation.x - self.touchBeginLocation.x), (touchEndLocation.y - self.touchBeginLocation.y));
    CGPoint speedVect = CGPointMake(distVect.x/time, distVect.y/time);

    CGFloat rad = atan(distVect.y / (distVect.x == 0 ? 1 : distVect.x));
//    CGFloat angle = CC_RADIANS_TO_DEGREES(rad);

    ArPhysicArrow *arrow = [[ArPhysicArrow alloc] initWithSpace:self.space location:ccp(50, self.touchBeginLocation.y)];
    [arrow.body setAngle:rad];
    [arrow.body setVelocity:ccp(speedVect.x * 0.75, speedVect.y * 0.75)];

    [self.arrowBatch addChild:arrow];
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
//    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
//                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

// -----------------------------------------------------------------------

@end
