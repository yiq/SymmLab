//
//  MSAtom.m
//  MolySym
//
//  Created by Yi Qiao on 5/19/14.
//
//

#import "SLAtom.h"

@implementation SLAtom

- (id)init {
    return [self initWithPosition:GLKVector3Make(0.0f, 0.0f, 0.0f) type:MSAT_Unlisted];
}

- (id)initWithPosition:(GLKVector3)position type:(MSAtomType)type {
    self = [super init];
    if (self) {
        _position = position;
        _atomType = type;
    }
    
    return self;
}

+ (id)atomWithPosition:(GLKVector3)position type:(MSAtomType)type {
    return [[SLAtom alloc] initWithPosition:position type:type];
}

+ (NSDictionary *)getAtomAttributesForType:(MSAtomType)type {
    switch (type) {
        case MSAT_H:
            return @{@"radius": @(0.031), @"color":@"333388"};
        case MSAT_C:
            return @{@"radius": @(0.076), @"color":@"999999"};
        default:
            break;
    }
    
    return nil;
    
}

@end
