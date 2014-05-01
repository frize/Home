//
//  ArPhysicObject.m
//  ArcherGame
//
//  Created by tico on 4/28/14.
//  Copyright (c) 2014 ISB. All rights reserved.
//

#import "ArPhysicObject.h"

@implementation ArPhysicObject

- (void)syncPhysic {
    self.position = self.body.position;
    self.rotation = CC_RADIANS_TO_DEGREES(-1 * self.body.angle);
}

- (void)createBodyAtLocation:(CGPoint)location{}

- (id)initWithSpace:(ChipmunkSpace *)theSpace location:(CGPoint)location spriteFrameName:(NSString *)spriteFrameName {

    if ((self = [super initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:spriteFrameName]])) {
        self.space = theSpace;
        [self createBodyAtLocation:location];
        self.canBeDestroyed = YES;
    }
    return self;

}

- (id)initWithSpace:(ChipmunkSpace *)theSpace location:(CGPoint)location spriteImageName:(NSString *)spriteImageName{

    if (self = [super initWithImageNamed:spriteImageName]){
        self.space = theSpace;
        [self createBodyAtLocation:location];
        self.canBeDestroyed = YES;
    }
    return self;
}


- (void)destroy {
    if (!self.canBeDestroyed) return;

    [self.space remove:self.body];
    [self.space remove:self.shape];
    [self removeFromParentAndCleanup:YES];
}

@end
