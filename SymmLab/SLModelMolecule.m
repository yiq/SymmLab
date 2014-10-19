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
        
        BOOL hasSeenFirst = NO;
        
        for (SLAtom *atom in molecule.atoms) {
            
            NSDictionary *atomAttr = [SLAtom getAtomAttributesForType:atom.atomType];
            SLModelSphere *atomSphere = [[SLModelSphere alloc] initWithRadius:[atomAttr[@"radius"] floatValue]/2.0 longs:16 lats:16];
            [atomSphere translateByX:atom.position.x byY:atom.position.y byZ:atom.position.z];
            
            if (!hasSeenFirst && atom.atomType != MSAT_H) {
                hasSeenFirst = YES;
                [atomSphere setColorWithR:0.9f g:0.8f b:0.2f alpha:1.0f];
            }
            else {
                [atomSphere setColorWithR:[atomAttr[@"color"][@"red"] floatValue] g:[atomAttr[@"color"][@"green"] floatValue] b:[atomAttr[@"color"][@"blue"] floatValue] alpha:1.0f];
                
            }
            
            [self addChild:atomSphere];
        }
        
    }
    
    return self;

}

@end
