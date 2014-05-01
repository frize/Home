//
//  ArPhysicArrow.m
//  ArcherGame
//
//  Created by QuangThai on 5/1/14.
//  Copyright (c) 2014 ISB. All rights reserved.
//

#import "ArPhysicArrow.h"

@implementation ArPhysicArrow

- (void)createBodyAtLocation:(CGPoint)location{
    //row 1, col 1
    int num = 9;
    CGPoint verts[] = {
        cpv(-48.0f, -4.5f),
        cpv(-52.0f, -0.5f),
        cpv(-52.0f, 0.5f),
        cpv(-49.0f, 3.5f),
        cpv(38.0f, 2.5f),
        cpv(48.0f, -0.5f),
        cpv(50.0f, -1.5f),
        cpv(48.0f, -2.5f),
        cpv(41.0f, -4.5f)
    };

    float mass = 1.0;
    self.body = [[ChipmunkBody alloc] initWithMass:mass andMoment:cpMomentForPoly(mass, num, verts, CGPointZero, 0)];
    self.body.position = location;
    self.body.userData = self;
    [self.body setCenterOfGravity:CGPointMake(30.0f, 0.0f)];
    [self.space add:self.body];

    self.shape = [[ChipmunkPolyShape alloc] initWithBody:self.body count:num verts:verts transform:cpTransformIdentity radius:0];
    self.shape.elasticity = 0.3;
    self.shape.friction = 1.0;
    self.shape.userData = self;
    [self.space add:self.shape];

}

- (id)initWithSpace:(ChipmunkSpace *)theSpace location:(CGPoint)location{
    self = [super initWithSpace:theSpace location:location spriteImageName:@"Arrow.png"];
    return self;
}

@end
