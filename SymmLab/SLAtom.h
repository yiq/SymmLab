//
//  MSAtom.h
//  MolySym
//
//  Created by Yi Qiao on 5/19/14.
//
//

@import Foundation;
@import GLKit;

@interface SLAtom : NSObject

@property NSString * label;
@property GLKVector3 position;
@property NSString * element;
@property BOOL isHighlighted;

- (id)initWithPosition:(GLKVector3)position element:( NSString *)element;
+ (id)atomWithPosition:(GLKVector3)position element:( NSString *)element;
+ (NSDictionary *)getAtomAttributesForElement:( NSString *)element;

@end
