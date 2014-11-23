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
        
        MSAtomType atomType;
        NSString * atomTypeSymbol = atomData[@"type_symbol"];
        
        atomType = [SLAtom getAtomTypeByString:atomTypeSymbol];
        
        [atoms addObject:[SLAtom atomWithPosition:GLKVector3Make(xCoord, yCoord, zCoord) type:atomType]];
    }
    
    mol.atoms = [NSArray arrayWithArray:atoms];
    mol.cellAngleX = [parsedCif[@"_cell_angle_alpha"] floatValue];
    mol.cellAngleY = [parsedCif[@"_cell_angle_beta"] floatValue];
    mol.cellAngleZ = [parsedCif[@"_cell_angle_gamma"] floatValue];
    
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
        
        MSAtomType atomType = [SLAtom getAtomTypeByString:atomProps[0]];
        NSDictionary *atomAttr = [SLAtom getAtomAttributesForType:atomType];
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
    
        [atoms addObject:[SLAtom atomWithPosition:GLKVector3Make(xCoord, yCoord, zCoord) type:atomType]];
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
    
    return mol;
}

@end
