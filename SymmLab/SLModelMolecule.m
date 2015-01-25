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
#import "SLModelLine.h"

static UIColor* blend( UIColor* c1, UIColor* c2, float alpha )
{
    alpha = MIN( 1.f, MAX( 0.f, alpha ) );
    float beta = 1.f - alpha;
    CGFloat r1, g1, b1, a1, r2, g2, b2, a2;
    [c1 getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    [c2 getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
    CGFloat r = r1 * beta + r2 * alpha;
    CGFloat g = g1 * beta + g2 * alpha;
    CGFloat b = b1 * beta + b2 * alpha;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}

@implementation SLModelMolecule

- (id)initWithMolecule:(SLMolecule *)molecule {
    self = [super init];
    if (self) {
        _isRenderable = NO;
        
        BOOL hasSeenFirst = NO;
        
        for (SLAtom *atom in molecule.atoms) {
            
            NSDictionary *atomAttr = [SLAtom getAtomAttributesForElement:atom.element];
            SLModelSphere *atomSphere = [[SLModelSphere alloc] initWithRadius:[atomAttr[@"radius"] floatValue]/2.0 longs:16 lats:16];
            [atomSphere translateByX:atom.position.x byY:atom.position.y byZ:atom.position.z];
            
            if (!hasSeenFirst && ! [atom.element isEqualToString: @"H"]) {
                hasSeenFirst = YES;
                
                UIColor * intrinsicColor = [UIColor colorWithRed:[atomAttr[@"color"][@"red"] floatValue]/255.0f green:[atomAttr[@"color"][@"green"] floatValue]/255.0f blue:[atomAttr[@"color"][@"blue"] floatValue]/255.0f alpha:1.0f];
                UIColor * highlightColor = [UIColor colorWithRed:0.9f green:0.8f blue:0.2f alpha:1.0f];
                
                UIColor * blentColor = blend(intrinsicColor, highlightColor, 0.5);
                
                CGFloat r, g, b, a;
                [blentColor getRed:&r green:&g blue:&b alpha:&a];
                
                
                [atomSphere setColorWithR:r g:g b:b alpha:a];
            }
            else {
                [atomSphere setColorWithR:[atomAttr[@"color"][@"red"] floatValue]/255.0f g:[atomAttr[@"color"][@"green"] floatValue]/255.0f b:[atomAttr[@"color"][@"blue"] floatValue]/255.0f alpha:1.0f];
            }
            
            [self addChild:atomSphere];
        }
        
        for (NSDictionary *bond in molecule.bonds) {
            SLAtom *atom1 = bond[@"atom1"];
            SLAtom *atom2 = bond[@"atom2"];
            
            GLKVector3 bondPoints[2];
            bondPoints[0] = atom1.position;
            bondPoints[1] = atom2.position;
            
            SLColor white = {.r=1.0f, .g=1.0f, .b= 1.0f, .a=1.0f};
            
            SLColor bondColors[2];
            bondColors[0] = white;
            bondColors[1] = white;
            
            
            SLModelLine *bondModel = [[SLModelLine alloc] initWithPoints:bondPoints colors:bondColors count:2 lineWidth:10.0f];
            [self addChild:bondModel];
        }
        
    }
    
    return self;

}

@end
