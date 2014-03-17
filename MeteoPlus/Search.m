//
//  Search.m
//  MeteoPlus
//
//  Created by Tobiasz Parys on 12/03/14.
//  Copyright (c) 2014 Mobiware. All rights reserved.
//

#import "Search.h"
#import "Location.h"

@implementation Search

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    
    return @{
             @"places":@"search_api.result"
             };
}

+ (NSValueTransformer *)placesJSONTransformer {
    
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[Location class]];
}

@end
