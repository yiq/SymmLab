//
//  ucifParser.m
//  ucifParser
//
//  Created by Yi Qiao on 5/24/14.
//
//

#import "ucifParser.h"

#include <ucif/parser.h>
#include <vector>
#include <string>

#define STR(x) ([NSString stringWithCString:x.c_str() encoding:NSUTF8StringEncoding])

using namespace ucif;

std::string longestCommonPrefix(std::vector<std::string> const& strs) {
    std::string prefix;
    if(strs.size() > 0)
        prefix = strs[0];
    for(int i = 1; i < strs.size(); ++i) {
        std::string s = strs[i];
        int j = 0;
        for(; j < MIN(prefix.size(), s.size()); ++j) {
            if(prefix[j] != s[j])
                break;
        }
        prefix = prefix.substr(0, j);
    }
    return prefix;
}

struct my_array_wrapper : array_wrapper_base
{
	std::vector<std::string> _array;
    
	my_array_wrapper() : _array() {}
    
	virtual void push_back(std::string const& value) {
		_array.push_back(value);
	}
    
	virtual std::string operator[](unsigned const& i) const {
		return _array[i];
	}
    
	virtual unsigned size() const {
		return _array.size();
	}
};

struct my_builder : builder_base
{
    
    __weak NSMutableDictionary *_dict;
    
    my_builder(__weak NSMutableDictionary * dict) : builder_base(), _dict(dict) {}
    
	virtual void start_save_frame(std::string const& save_frame_heading) {
        NSLog(@"UcifParser: Start of Save Frame %@", STR(save_frame_heading));
	}
    
	virtual void end_save_frame() {
		NSLog(@"UcifParser: End of Save Frame");
	}
    
	virtual void add_data_item(std::string const& tag, std::string const& value) {
        if(_dict) {
            [_dict setObject:STR(value) forKey:STR(tag)];
        }
	}
    
	virtual void add_loop(array_wrapper_base const& loop_headers, std::vector<array_wrapper_base *> const& values) {
        
		size_t nrows = values[0]->size();
		size_t ncols = values.size();
        
        assert(loop_headers.size() == ncols);
        
        NSMutableArray *valueArray = [[NSMutableArray alloc] init];
        
		for(int i=0; i<nrows; i++) {
            
            NSMutableDictionary *valueRow = [[NSMutableDictionary alloc] init];
            
			for(int j=0; j<ncols; j++) {
				my_array_wrapper *valarr = dynamic_cast<my_array_wrapper*>(values[j]);
				assert(valarr != NULL);
                [valueRow setValue:STR(valarr->operator[](i)) forKey:STR(loop_headers[j])];
			}
            
            [valueArray addObject:[NSDictionary dictionaryWithDictionary:valueRow]];
		}
        
        std::string lcp = longestCommonPrefix(dynamic_cast<my_array_wrapper const &>(loop_headers)._array);
        
        if(_dict) {
            [_dict setValue:[NSArray arrayWithArray:valueArray] forKey:STR(lcp)];
        }
        
        
	}
    virtual void add_data_block(std::string const& data_block_heading) {
        NSLog(@"UcifParser: Add Data Block %@", STR(data_block_heading));
	}
    
	virtual array_wrapper_base* new_array() {
		return new my_array_wrapper();
	}
};


@implementation ucifParser

+(NSDictionary *)cifDictionaryFromString:(NSString *) cifContent withError:(NSError *__autoreleasing *)error
{
    NSMutableDictionary * resultDict = [[NSMutableDictionary alloc] init];
    my_builder builder(resultDict);
    ucif::parser parsed(&builder, [cifContent cStringUsingEncoding:NSUTF8StringEncoding]);
    
    std::vector<std::string> lexer_errors = dynamic_cast<my_array_wrapper *>(parsed.lxr->errors)->_array;
	std::vector<std::string> parser_errors = dynamic_cast<my_array_wrapper *>(parsed.psr->errors)->_array;
    
    if (lexer_errors.size() + parser_errors.size() != 0) {
        if (error != NULL) {
            // populate the error object
            int errorCode = 0;
            if(lexer_errors.size() > 0) errorCode = errorCode | kUcifParsingErrorLexical;
            if(parser_errors.size() > 0) errorCode = errorCode | kUcifParsingErrorParsing;
            
            NSMutableArray *lexerErrors = [[NSMutableArray alloc] init];
            for (std::vector<std::string>::const_iterator iter = lexer_errors.cbegin(); iter != lexer_errors.cend(); iter++) {
                [lexerErrors addObject:[NSString stringWithCString:iter->c_str() encoding:NSUTF8StringEncoding]];
            }
            
            NSMutableArray *parserErrors = [[NSMutableArray alloc] init];
            for (std::vector<std::string>::const_iterator iter = parser_errors.cbegin(); iter != parser_errors.cend(); iter++) {
                [parserErrors addObject:[NSString stringWithCString:iter->c_str() encoding:NSUTF8StringEncoding]];
            }
            
            *error = [NSError errorWithDomain:@"UcifParser"
                                         code:errorCode
                                     userInfo:@{@"lexer_errors": lexerErrors, @"parser_errors": parserErrors}];
        }
        
        return nil;
    }
    
    return resultDict;
}

@end
