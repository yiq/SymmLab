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
    return [self initWithPosition:GLKVector3Make(0.0f, 0.0f, 0.0f) element:@"UNKNOWN"];
}

- (id)initWithPosition:(GLKVector3)position element:(NSString *)element {
    self = [super init];
    if (self) {
        _position = position;
        _element = element;
        _label = @"";
    }
    
    return self;
}

+ (id)atomWithPosition:(GLKVector3)position element:(NSString *)element {
    return [[SLAtom alloc] initWithPosition:position element:element];
}

+ (NSDictionary *)getAtomAttributesForElement:(NSString *)element {
    static NSDictionary *elementAttributes = nil;
    if (elementAttributes == nil) {
        elementAttributes = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AtomProperties" ofType:@"plist"]];
        NSLog(@"loaded property list: %@", elementAttributes);
    }
    
    if ([[elementAttributes allKeys] containsObject:element]) {
        return elementAttributes[element];
    }
    
    return nil;
}
@end
