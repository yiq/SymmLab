//
//  MSMolecule.h
//  MolySym
//
//  Created by Yi Qiao on 5/19/14.
//
//

@import Foundation;
@import GLKit;

@interface SLMolecule : NSObject

@property CGFloat cellAngleX;
@property CGFloat cellAngleY;
@property CGFloat cellAngleZ;

@property CGFloat cellLengthA;
@property CGFloat cellLengthB;
@property CGFloat cellLengthC;

@property NSArray * atoms;
@property NSArray * bonds;

+ (id)moleculeWithCifDictionary:(NSDictionary *)parsedCif;
+ (id)moleculeWithCifFile:(NSString *)cifPath;
+ (id)moleculeWithXyzFile:(NSString *)xyzPath;

@end
