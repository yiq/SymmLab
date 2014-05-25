//
//  MSAtom.h
//  MolySym
//
//  Created by Yi Qiao on 5/19/14.
//
//

@import Foundation;
@import GLKit;

enum SLAtomType {
    MSAT_H, MSAT_He,
    MSAT_Li, MSAT_Be, MSAT_B, MSAT_C, MSAT_N, MSAT_O, MSAT_F, MSAT_Ne,
    MSAT_Na, MSAT_Mg, MSAT_Al, MSAT_Si, MSAT_P, MSAT_S, MSAT_Cl, MSAT_Ar,
    MSAT_K, MSAT_Ca, MSAT_Sc, MSAT_Ti, MSAT_V, MSAT_Cr, MSAT_Mn, MSAT_Fe, MSAT_Co, MSAT_Ni, MSAT_Cu, MSAT_Zn, MSAT_Ga, MSAT_Ge, MSAT_As, MSAT_Se, MSAT_Br, MSAT_Kr,
    
    MSAT_Unlisted=999};

typedef enum SLAtomType MSAtomType;

@interface SLAtom : NSObject

@property GLKVector3 position;
@property MSAtomType atomType;

- (id)initWithPosition:(GLKVector3)position type:(MSAtomType)type;
+ (id)atomWithPosition:(GLKVector3)position type:(MSAtomType)type;
+ (NSDictionary *)getAtomAttributesForType:(MSAtomType)type;

@end
