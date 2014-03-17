//
//  Place.m
//  MeteoPlus
//
//  Created by Tobiasz Parys on 12/03/14.
//  Copyright (c) 2014 Mobiware. All rights reserved.
//

#import "Location.h"

@implementation Location

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    
    return @{@"areaName":@"areaName.value",
             @"country":@"country.value",
             @"latitude":@"latitude",
             @"longitude":@"longitude",
             @"population":@"population",
             @"weatherUrl":@"weatherUrl.value",
             };
}

+ (NSValueTransformer *)areaNameJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSArray *values) {
        return [values firstObject];
    } reverseBlock:^(NSString *string) {
        return @[string];
    }];
}

+ (NSValueTransformer *)countryJSONTransformer {
    return [self areaNameJSONTransformer];
}

//+ (NSValueTransformer *)latitudeJSONTransformer {
//    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSArray *values) {
//        return [values firstObject];
//    } reverseBlock:^(NSNumber *number) {
//        return @[number] ;
//    }];
//}

//+ (NSValueTransformer *)longitudeJSONTransformer {
//    return  [self latitudeJSONTransformer];
//}

//+ (NSValueTransformer *)polulationJSONTransformer {
//    return  [self latitudeJSONTransformer];
//}

+ (NSValueTransformer *)weatherUrlJSONTransformer {
    
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSArray *values) {
        
        NSString *url = [values firstObject];
        
        url = [url stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        return url;
    } reverseBlock:^(NSString *string) {
        string = [string stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        
        return @[string];
    }];
}

@end
