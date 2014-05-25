//
//  ucifParserTests.m
//  ucifParserTests
//
//  Created by Yi Qiao on 5/24/14.
//
//

#import <XCTest/XCTest.h>
#import "ucifParser.h"

#define TEST_DATA_ITEM(dict, key, value) XCTAssertTrue([[(dict) allKeys] containsObject:(key)], @"the parsed dictionary should contains data item %@", (key)); XCTAssertEqualObjects((dict)[(key)], (value), @"the value for data item %@ should be %@", (key), (value));


@interface ucifParserTests : XCTestCase {
    NSString *testData;
    NSDictionary *parsedData;
}

@end

@implementation ucifParserTests

- (void)setUp
{
    [super setUp];
    
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"coronene" ofType:@"cif"];
    
    testData = [NSString stringWithContentsOfFile:path
                                         encoding:NSUTF8StringEncoding
                                           error:NULL];
    
    parsedData = [ucifParser cifDictionaryFromString:testData withError:NULL];

}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testParsing
{
    XCTAssertNotNil(parsedData, @"Unable to parse the coronene.cif, which is known to be parsable");
}

- (void)testDataItems
{
    
    TEST_DATA_ITEM(parsedData, @"_database_code_ICSD", @"157701");
    TEST_DATA_ITEM(parsedData, @"_audit_creation_date", @"2008-02-01");
    TEST_DATA_ITEM(parsedData, @"_chemical_name_systematic", @"Coronene");
    TEST_DATA_ITEM(parsedData, @"_chemical_formula_structural", @"C24 H12");
    TEST_DATA_ITEM(parsedData, @"_chemical_formula_sum", @"C24 H12");
    TEST_DATA_ITEM(parsedData, @"_chemical_name_mineral", @"Carpathite");
    TEST_DATA_ITEM(parsedData, @"_exptl_crystal_density_diffrn", @"1.41");
    
    TEST_DATA_ITEM(parsedData, @"_cell_length_a", @"16.094(9)");
    TEST_DATA_ITEM(parsedData, @"_cell_length_b", @"4.690(3)");
    TEST_DATA_ITEM(parsedData, @"_cell_length_c", @"10.049(8)");
    TEST_DATA_ITEM(parsedData, @"_cell_angle_alpha", @"90.");
    TEST_DATA_ITEM(parsedData, @"_cell_angle_beta", @"110.79(2)");
    TEST_DATA_ITEM(parsedData, @"_cell_angle_gamma", @"90.");
    TEST_DATA_ITEM(parsedData, @"_cell_volume", @"709.12");
    TEST_DATA_ITEM(parsedData, @"_cell_formula_units_Z", @"2");
    TEST_DATA_ITEM(parsedData, @"_symmetry_space_group_name_H-M", @"P 1 21/a 1");
    TEST_DATA_ITEM(parsedData, @"_symmetry_Int_Tables_number", @"14");
    TEST_DATA_ITEM(parsedData, @"_refine_ls_R_factor_all", @"0.0344");
}

- (void)testLoop
{
    XCTAssertTrue([[parsedData allKeys] containsObject:@"_citation"], @"the parsed dictionary should contain loop _citation_");
    XCTAssertEqual([parsedData[@"_citation"] count], (NSUInteger)(1), @"the _citation_ loop should contain 1 element");
    
    NSDictionary *row = parsedData[@"_citation"][0];
    TEST_DATA_ITEM(row, @"id", @"primary");
    TEST_DATA_ITEM(row, @"journal_full", @"American Mineralogist");
    TEST_DATA_ITEM(row, @"year", @"2007");
    TEST_DATA_ITEM(row, @"journal_volume", @"92");
    TEST_DATA_ITEM(row, @"page_first", @"1262");
    TEST_DATA_ITEM(row, @"page_last", @"1269");
    TEST_DATA_ITEM(row, @"journal_id_ASTM", @"AMMIAY");
}

@end
