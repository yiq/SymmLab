//
//  MSMolecule.m
//  MolySym
//
//  Created by Yi Qiao on 5/19/14.
//
//

#import "SLMolecule.h"
#import "SLAtom.h"

#import "ucifParser.h"

@implementation SLMolecule

- (id)init {
    self = [super init];
    
    if(self) {
        _atoms = nil;
    }
    return self;
}

+ (id)moleculeWithCifDictionary:(NSDictionary *)parsedCif {
    SLMolecule *mol = [[SLMolecule alloc] init];
    NSMutableArray *atoms = [[NSMutableArray alloc] init];
    
    if ([[parsedCif allKeys] containsObject:@"_cell_length_a"]) {
        mol.cellLengthA = [parsedCif[@"_cell_length_a"] floatValue];
        mol.cellLengthB = [parsedCif[@"_cell_length_b"] floatValue];
        mol.cellLengthC = [parsedCif[@"_cell_length_c"] floatValue];

    }
    
    NSArray *atomsData = parsedCif[@"_atom_site"];
    for (NSDictionary *atomData in atomsData) {
        
        CGFloat xCoord, yCoord, zCoord;
        
        if ([[atomData allKeys] containsObject:@"fract_x"]) {
            xCoord = [atomData[@"fract_x"] floatValue] * mol.cellLengthA;
            yCoord = [atomData[@"fract_y"] floatValue] * mol.cellLengthB;
            zCoord = [atomData[@"fract_z"] floatValue] * mol.cellLengthC;
        }
        else if ([[atomData allKeys] containsObject:@"cartn_x"]) {
            xCoord = [atomData[@"cartn_x"] floatValue];
            yCoord = [atomData[@"cartn_y"] floatValue];
            zCoord = [atomData[@"cartn_z"] floatValue];
        }
        else {
            xCoord = 0;
            yCoord = 0;
            zCoord = 0;
        }
        
        NSString * atomTypeSymbol = atomData[@"type_symbol"];

        [atoms addObject:[SLAtom atomWithPosition:GLKVector3Make(xCoord, yCoord, zCoord) element:atomTypeSymbol]];
    }
    
    mol.atoms = [NSArray arrayWithArray:atoms];
    mol.cellAngleX = [parsedCif[@"_cell_angle_alpha"] floatValue];
    mol.cellAngleY = [parsedCif[@"_cell_angle_beta"] floatValue];
    mol.cellAngleZ = [parsedCif[@"_cell_angle_gamma"] floatValue];
    
    // identify chemical bonds
    NSMutableArray *bonds = [[NSMutableArray alloc] init];
    
    for (NSUInteger i=0; i<atoms.count; i++) {
        for (NSUInteger j=i+1; j<atoms.count; j++) {
            
            SLAtom *atom1 = (SLAtom *)atoms[i];
            SLAtom *atom2 = (SLAtom *)atoms[j];
            
            NSDictionary *atom1Attr = [SLAtom getAtomAttributesForElement:atom1.element];
            NSDictionary *atom2Attr = [SLAtom getAtomAttributesForElement:atom2.element];
            
            if ([atom1Attr objectForKey:@"vdwradius"] == nil || [atom2Attr objectForKey:@"vdwradius"] == nil) {
                continue;
            }
            
            float atomDistance = GLKVector3Distance(atom1.position, atom2.position);
            float vdwRadiiSum = [(NSNumber *)atom1Attr[@"vdwradius"] floatValue] + [(NSNumber *)atom2Attr[@"vdwradius"] floatValue];
            
            NSLog(@"distance between %@(%f, %f, %f) and %@(%f, %f, %f) is %f, sum of vdwradius is %f", atom1.label, atom1.position.x, atom1.position.y, atom1.position.z, atom2.label, atom2.position.x, atom2.position.y, atom2.position.z, GLKVector3Distance(atom1.position, atom2.position), vdwRadiiSum);
            
            if( atomDistance < (vdwRadiiSum/2.0f) ) {
                NSLog(@"adding bond");
                [bonds addObject:@{@"atom1": atom1, @"atom2": atom2}];
                
            }
        }
    }
    mol.bonds = [NSArray arrayWithArray:bonds];
    
    return mol;
    
}

+ (id)moleculeWithCifFile:(NSString *)cifPath {
    
    NSError *error;
    
    NSString *cifFileContent = [NSString stringWithContentsOfFile:cifPath encoding:NSUTF8StringEncoding error:NULL];
    NSDictionary * parsedCif = [ucifParser cifDictionaryFromString:cifFileContent withError:&error];
    return [self moleculeWithCifDictionary:parsedCif];
}

+ (id)moleculeWithXyzFile:(NSString *)xyzPath {
    SLMolecule *mol = [[SLMolecule alloc] init];
    NSMutableArray *atoms = [[NSMutableArray alloc] init];
    
    NSString *xyzFileContent = [NSString stringWithContentsOfFile:xyzPath encoding:NSUTF8StringEncoding error:NULL];
    NSArray *lines = [xyzFileContent componentsSeparatedByString:@"\n"];
    NSUInteger numberOfAtoms = [lines[0] integerValue];
    
    assert(lines.count >= 2+numberOfAtoms);
    
    CGFloat xCenter = 0, yCenter = 0, zCenter = 0, totalWeight = 0;
    
    for(size_t i=2; i<2+numberOfAtoms; i++) {
        CGFloat xCoord, yCoord, zCoord;
        
        NSArray *atomProps = [lines[i] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        atomProps = [atomProps filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
        
        NSDictionary *atomAttr = [SLAtom getAtomAttributesForElement:atomProps[0]];
        xCoord = [atomProps[1] floatValue];
        yCoord = [atomProps[2] floatValue];
        zCoord = [atomProps[3] floatValue];
        
        xCenter += xCoord;
        yCenter += yCoord;
        zCenter += zCoord;

        
//        xCenter += xCoord * [atomAttr[@"weight"] floatValue];
//        yCenter += yCoord * [atomAttr[@"weight"] floatValue];
//        zCenter += zCoord * [atomAttr[@"weight"] floatValue];
        totalWeight += [atomAttr[@"weight"] floatValue];
    
        SLAtom * newAtom = [SLAtom atomWithPosition:GLKVector3Make(xCoord, yCoord, zCoord) element:atomProps[0]];
        newAtom.label = atomProps[0];
        [atoms addObject:newAtom];
    }
    
    xCenter /= numberOfAtoms;
    yCenter /= numberOfAtoms;
    zCenter /= numberOfAtoms;
    
//    xCenter /= totalWeight;
//    yCenter /= totalWeight;
//    zCenter /= totalWeight;
    
    for (SLAtom * atom in atoms) {
        atom.position = GLKVector3Add(atom.position, GLKVector3Make(-xCenter, -yCenter, -zCenter));
    }
    
    mol.atoms = [NSArray arrayWithArray:atoms];
    
    // identify chemical bonds
    NSMutableArray *bonds = [[NSMutableArray alloc] init];

    for (NSUInteger i=0; i<atoms.count; i++) {
        for (NSUInteger j=i+1; j<atoms.count; j++) {
            
            SLAtom *atom1 = (SLAtom *)atoms[i];
            SLAtom *atom2 = (SLAtom *)atoms[j];
            
            NSDictionary *atom1Attr = [SLAtom getAtomAttributesForElement:atom1.element];
            NSDictionary *atom2Attr = [SLAtom getAtomAttributesForElement:atom2.element];
            
            if ([atom1Attr objectForKey:@"vdwradius"] == nil || [atom2Attr objectForKey:@"vdwradius"] == nil) {
                continue;
            }
            
            float atomDistance = GLKVector3Distance(atom1.position, atom2.position);
            float vdwRadiiSum = [(NSNumber *)atom1Attr[@"vdwradius"] floatValue] + [(NSNumber *)atom2Attr[@"vdwradius"] floatValue];
            
            NSLog(@"distance between %@(%f, %f, %f) and %@(%f, %f, %f) is %f, sum of vdwradius is %f", atom1.label, atom1.position.x, atom1.position.y, atom1.position.z, atom2.label, atom2.position.x, atom2.position.y, atom2.position.z, GLKVector3Distance(atom1.position, atom2.position), vdwRadiiSum);
            
            if( atomDistance < (vdwRadiiSum/2.0f) ) {
                NSLog(@"adding bond");
                [bonds addObject:@{@"atom1": atom1, @"atom2": atom2}];
                
            }
        }
    }
    mol.bonds = [NSArray arrayWithArray:bonds];
    
    return mol;
}

@end
