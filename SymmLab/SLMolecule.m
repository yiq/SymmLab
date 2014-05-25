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
        if ([atomTypeSymbol characterAtIndex:0] == 'H') {
            atomType = MSAT_H;
        }
        else if ([atomTypeSymbol characterAtIndex:0] == 'C') {
            atomType = MSAT_C;
        }
        else {
            atomType = MSAT_Unlisted;
        }
        
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

@end
