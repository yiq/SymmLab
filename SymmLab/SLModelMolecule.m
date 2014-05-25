//
//  SLModelMolecule.m
//  SymmLab
//
//  Created by Yi Qiao on 5/25/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

#import "SLModelMolecule.h"
#import "SLAtom.h"
#import "SLModelSphere.h"

@implementation SLModelMolecule

- (id)initWithMolecule:(SLMolecule *)molecule {
    self = [super init];
    if (self) {
        _isRenderable = NO;
        
        for (SLAtom *atom in molecule.atoms) {
            
            NSDictionary *atomAttr = [SLAtom getAtomAttributesForType:atom.atomType];
            SLModelSphere *atomSphere = [[SLModelSphere alloc] initWithRadius:[atomAttr[@"radius"] floatValue]/2.0 longs:32 lats:32];
            [atomSphere translateByX:atom.position.x byY:atom.position.y byZ:atom.position.z];
            [atomSphere setColorWithR:[atomAttr[@"color"][@"red"] floatValue] g:[atomAttr[@"color"][@"green"] floatValue] b:[atomAttr[@"color"][@"blue"] floatValue] alpha:1.0f];
            
            [self addChild:atomSphere];
        }
        
    }
    
    return self;

}

@end
