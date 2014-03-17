//
//  WeatherCondition.m
//  MeteoPlus
//
//  Created by Tobiasz Parys on 12/03/14.
//  Copyright (c) 2014 Mobiware. All rights reserved.
//

#import "WeatherCondition.h"
#import "Request.h"
#import "Weather.h"

@implementation WeatherCondition

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    
    return @{@"cloudcover":@"data.current_condition.cloudcover",
             @"humidity":@"data.current_condition.humidity",
             @"observationTime":@"data.current_condition.observation_time",
             @"humidity":@"data.current_condition.precipMM",
             @"pressure":@"data.current_condition.pressure",
             @"tempC":@"data.current_condition.temp_C",
             @"tempF":@"data.current_condition.temp_F",
             @"visibility":@"data.current_condition.visibility",
             @"weatherCode":@"data.current_condition.weatherCode",
             @"weatherDesc":@"data.current_condition.weatherDesc.value",
             @"weatherIconUrl":@"data.current_condition.weatherIconUrl.value",
             @"winddir16Point":@"data.current_condition.winddir16Point",
             @"winddirDegree":@"data.current_condition.winddirDegree",
             @"windspeedKmph":@"data.current_condition.windspeedKmph",
             @"windspeedMiles":@"data.current_condition.windspeedMiles",
             @"request":@"data.request",
             @"weather":@"data.weather"
             };
}

+ (NSValueTransformer *)cloudcoverJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSArray *values) {
        return [values firstObject];
    } reverseBlock:^(NSNumber *number) {
        return @[number];
    }];
}

+ (NSValueTransformer *)humidityJSONTransformer {
    return [self cloudcoverJSONTransformer];
}

+ (NSValueTransformer *)pressureJSONTransformer {
    return [self cloudcoverJSONTransformer];
}

+ (NSValueTransformer *)tempCJSONTransformer {
    return [self cloudcoverJSONTransformer];
}

+ (NSValueTransformer *)tempFJSONTransformer {
    return [self cloudcoverJSONTransformer];
}

+ (NSValueTransformer *)weatherCodeJSONTransformer {
    return [self cloudcoverJSONTransformer];
}

+ (NSValueTransformer *)visibilityJSONTransformer {
    return [self cloudcoverJSONTransformer];
}

+ (NSValueTransformer *)winddir16PointJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSArray *values) {
        return [values firstObject];
    } reverseBlock:^(NSString *string) {
        return @[string];
    }];
}

+ (NSValueTransformer *)weatherDescJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSArray *values) {
        return [[values firstObject] firstObject];
    } reverseBlock:^(NSString *string) {
        return @[string];
    }];
}

+ (NSValueTransformer *)weatherIconUrlJSONTransformer {
    
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSArray *values) {
        
        NSString *url = [[values firstObject] firstObject];
        
        url = [url stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        return url;
    } reverseBlock:^(NSString *string) {
        string = [string stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        
        return @[string];
    }];
}

+ (NSValueTransformer *)winddirDegreeJSONTransformer {
    return [self cloudcoverJSONTransformer];
}

+ (NSValueTransformer *)windspeedKmphJSONTransformer {
    return [self cloudcoverJSONTransformer];
}

+ (NSValueTransformer *)windspeedMilesJSONTransformer {
    return [self cloudcoverJSONTransformer];
}

+ (NSValueTransformer *)weatherJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[Weather class]];
}

+ (NSValueTransformer *)requestJSONTransformer {
    
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[Request class]];
}


@end
