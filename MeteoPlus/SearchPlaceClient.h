//
//  SearchPlaceClient.h
//  MeteoPlus
//
//  Created by Tobiasz Parys on 12/03/14.
//  Copyright (c) 2014 Mobiware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchPlaceClient : NSObject

-(void)searchPlaceWithName:(NSString *)string success:(void (^)(NSArray *places))success failure:(void (^)(NSError *error))failure;

@end
