//
//  ArPhysicArrow.h
//  ArcherGame
//
//  Created by QuangThai on 5/1/14.
//  Copyright (c) 2014 ISB. All rights reserved.
//

#import "ArPhysicObject.h"

@interface ArPhysicArrow : ArPhysicObject

- (id)initWithSpace:(ChipmunkSpace *)theSpace location:(CGPoint)location;

@end
