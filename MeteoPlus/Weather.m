//
//  Weather.m
//  MeteoPlus
//
//  Created by Tobiasz Parys on 12/03/14.
//  Copyright (c) 2014 Mobiware. All rights reserved.
//

#import "Weather.h"

@implementation Weather


+(NSDictionary *)JSONKeyPathsByPropertyKey{
    
    return @{@"date":@"date",
             @"precipMM":@"precipMM",
             @"tempMaxC":@"tempMaxC",
             @"tempMaxF":@"tempMaxF",
             @"tempMinC":@"tempMinC",
             @"tempMinF":@"tempMinF",
             @"weatherCode":@"weatherCode",
             @"weatherDesc":@"weatherDesc.value",
             @"weatherIconUrl":@"weatherIconUrl.value",
             @"winddir16Point":@"winddir16Point",
             @"winddirDegree":@"winddirDegree",
             @"winddirection":@"winddirection",
             @"windspeedKmph":@"windspeedKmph",
             @"windspeedMiles":@"windspeedMiles"
             };
}

+ (NSValueTransformer *)weatherDescJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSArray *values) {
        return [values firstObject];
    } reverseBlock:^(NSString *string) {
        return @[string];
    }];
}

+ (NSValueTransformer *)weatherIconUrlJSONTransformer {
    
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
