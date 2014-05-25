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
    
    NSArray *atomsData = parsedCif[@"_atom_site_"];
    for (NSDictionary *atomData in atomsData) {
        CGFloat xCoord = [atomData[@"_atom_site_fract_x"] floatValue];
        CGFloat yCoord = [atomData[@"_atom_site_fract_y"] floatValue];
        CGFloat zCoord = [atomData[@"_atom_site_fract_z"] floatValue];
        
        MSAtomType atomType;
        NSString * atomTypeSymbol = atomData[@"_atom_site_type_symbol"];
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
    
    NSString *cifFileContent = [NSString stringWithContentsOfFile:cifPath encoding:NSUTF8StringEncoding error:NULL];
    NSDictionary * parsedCif = [ucifParser cifDictionaryFromString:cifFileContent withError:NULL];
    return [self moleculeWithCifDictionary:parsedCif];
}

@end
