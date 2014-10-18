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
//        case MSAT_H:
//            return @{@"radius": @(0.37), @"color":@{@"red": @(0.6f), @"green": @(0.6f), @"blue": @(0.9f)}};
//        case MSAT_C:
//            return @{@"radius": @(0.91), @"color":@{@"red": @(0.9f), @"green": @(0.9f), @"blue": @(0.9f)}};
        case MSAT_H:
            return @{@"radius": @(0.25), @"color":@{@"red": @(0.6f), @"green": @(0.6f), @"blue": @(0.9f)}, @"weight": @(1.008)};
        case MSAT_B:
            return @{@"radius": @(0.85), @"color":@{@"red": @(0.3f), @"green": @(0.5f), @"blue": @(0.3f)}, @"weight": @(10.81)};
        case MSAT_C:
            return @{@"radius": @(0.7), @"color":@{@"red": @(0.9f), @"green": @(0.9f), @"blue": @(0.9f)}, @"weight": @(12.011)};
        case MSAT_O:
            return @{@"radius": @(0.6), @"color":@{@"red": @(0.9f), @"green": @(0.5f), @"blue": @(0.5f)}, @"weight": @(15.999)};
        case MSAT_F:
            return @{@"radius": @(0.5), @"color":@{@"red": @(147.0f / 255.0f), @"green": @(157.0f / 255.0f), @"blue": @(185.0f / 255.0f)}, @"weight": @(18.998)};
        case MSAT_Co:
            return @{@"radius": @(1.35), @"color":@{@"red": @(0.05f), @"green": @(0.05f), @"blue": @(0.52f)}, @"weight": @(58.933)};
        case MSAT_Ru:
            return @{@"radius": @(1.30), @"color":@{@"red": @(151.0f / 255.0f), @"green": @(139.0f / 255.0f), @"blue": @(133.0f / 255.0f)}, @"weight": @(101.07)};
        default:
            break;
    }
    
    return nil;
}

+ (MSAtomType)getAtomTypeByString:(NSString *)atomName
{
    
    if ([atomName isEqualToString: @"H"]) {
        return MSAT_H;
    }
    else if ([atomName isEqualToString: @"He"]) {
        return MSAT_He;
    }
    else if ([atomName isEqualToString: @"Li"]) {
        return MSAT_Li;
    }
    else if ([atomName isEqualToString: @"Be"]) {
        return MSAT_Be;
    }
    else if ([atomName isEqualToString: @"B"]) {
        return MSAT_B;
    }
    else if ([atomName isEqualToString: @"C"]) {
        return MSAT_C;
    }
    else if ([atomName isEqualToString: @"N"]) {
        return MSAT_N;
    }
    else if ([atomName isEqualToString: @"O"]) {
        return MSAT_O;
    }
    else if ([atomName isEqualToString: @"F"]) {
        return MSAT_F;
    }
    else if ([atomName isEqualToString: @"Ne"]) {
        return MSAT_Ne;
    }
    else if ([atomName isEqualToString: @"Na"]) {
        return MSAT_Na;
    }
    else if ([atomName isEqualToString: @"Mg"]) {
        return MSAT_Mg;
    }
    else if ([atomName isEqualToString: @"Al"]) {
        return MSAT_Al;
    }
    else if ([atomName isEqualToString: @"Si"]) {
        return MSAT_Si;
    }
    else if ([atomName isEqualToString: @"P"]) {
        return MSAT_P;
    }
    else if ([atomName isEqualToString: @"S"]) {
        return MSAT_S;
    }
    else if ([atomName isEqualToString: @"Cl"]) {
        return MSAT_Cl;
    }
    else if ([atomName isEqualToString: @"Ar"]) {
        return MSAT_Ar;
    }
    else if ([atomName isEqualToString: @"K"]) {
        return MSAT_K;
    }
    else if ([atomName isEqualToString: @"Ca"]) {
        return MSAT_Ca;
    }
    else if ([atomName isEqualToString: @"Sc"]) {
        return MSAT_Sc;
    }
    else if ([atomName isEqualToString: @"Ti"]) {
        return MSAT_Ti;
    }
    else if ([atomName isEqualToString: @"V"]) {
        return MSAT_V;
    }
    else if ([atomName isEqualToString: @"Cr"]) {
        return MSAT_Cr;
    }
    else if ([atomName isEqualToString: @"Mn"]) {
        return MSAT_Mn;
    }
    else if ([atomName isEqualToString: @"Fe"]) {
        return MSAT_Fe;
    }
    else if ([atomName isEqualToString: @"Co"]) {
        return MSAT_Co;
    }
    else if ([atomName isEqualToString: @"Ni"]) {
        return MSAT_Ni;
    }
    else if ([atomName isEqualToString: @"Cu"]) {
        return MSAT_Cu;
    }
    else if ([atomName isEqualToString: @"Zn"]) {
        return MSAT_Zn;
    }
    else if ([atomName isEqualToString: @"Ga"]) {
        return MSAT_Ga;
    }
    else if ([atomName isEqualToString: @"Ge"]) {
        return MSAT_Ge;
    }
    else if ([atomName isEqualToString: @"As"]) {
        return MSAT_As;
    }
    else if ([atomName isEqualToString: @"Se"]) {
        return MSAT_Se;
    }
    else if ([atomName isEqualToString: @"Br"]) {
        return MSAT_Br;
    }
    else if ([atomName isEqualToString: @"Kr"]) {
        return MSAT_Kr;
    }
    else if ([atomName isEqualToString: @"Ru"]) {
        return MSAT_Ru;
    }
    else {
        return MSAT_Unlisted;
    }
}

@end
