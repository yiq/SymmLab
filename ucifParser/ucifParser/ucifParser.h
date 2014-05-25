//
//  ucifParser.h
//  ucifParser
//
//  Created by Yi Qiao on 5/24/14.
//
//

#import <Foundation/Foundation.h>

#define kUcifParsingErrorLexical (1<<0);
#define kUcifParsingErrorParsing (1<<1);


@interface ucifParser : NSObject

+(NSDictionary *)cifDictionaryFromString:(NSString *) cifContent withError:(NSError *__autoreleasing *)error;

@end
