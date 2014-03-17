//
//  Request.m
//  MeteoPlus
//
//  Created by Tobiasz Parys on 12/03/14.
//  Copyright (c) 2014 Mobiware. All rights reserved.
//

#import "Request.h"

@implementation Request

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    
    return @{@"query":@"query",
             @"type":@"type"
             };
}

+ (NSValueTransformer *)winddir16PointJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSArray *values) {
        return [values firstObject];
    } reverseBlock:^(NSString *string) {
        return @[string];
    }];
}

@end
