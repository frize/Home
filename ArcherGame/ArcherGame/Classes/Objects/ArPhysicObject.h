//
//  ArPhysicObject.h
//  ArcherGame
//
//  Created by tico on 4/28/14.
//  Copyright (c) 2014 ISB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ObjectiveChipmunk.h"

@interface ArPhysicObject : CCSprite

@property (nonatomic, strong) ChipmunkSpace *space;
@property (nonatomic, strong) ChipmunkBody *body;
@property (nonatomic, strong) ChipmunkShape *shape;
@property (nonatomic, assign) BOOL canBeDestroyed;

- (id)initWithSpace:(ChipmunkSpace *)theSpace location:(CGPoint)location spriteFrameName:(NSString *)spriteFrameName;
- (id)initWithSpace:(ChipmunkSpace *)theSpace location:(CGPoint)location spriteImageName:(NSString *)spriteImageName;
- (void)syncPhysic;
- (void)createBodyAtLocation:(CGPoint)location;
- (void)destroy;

@end
