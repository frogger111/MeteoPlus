//
//  SearchAPI.h
//  MeteoPlus
//
//  Created by Tobiasz Parys on 11/03/14.
//  Copyright (c) 2014 Mobiware. All rights reserved.
//

@import CoreLocation;

#import <Foundation/Foundation.h>
#import "WeatherCondition.h"
#import <ReactiveCocoa/ReactiveCocoa/ReactiveCocoa.h>
#import <TSMessages/TSMessage.h>

@interface SearchAPI : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong, readonly) CLLocation *currentLocation;
@property (nonatomic, strong, readonly) WeatherCondition *currentWeatherCondition;


+(instancetype)api;

-(void)findCurrentLocation;

-(void)searchPlaceWithName:(NSString *)string success:(void (^)(NSArray *places))success failure:(void (^)(NSError *error))failure;

//-(void)searchWeather:(CGPoint)location success:(void (^)(WeatherCondition *weatherCondition))success
//             failure:(void (^)(NSError *error))failure;

@end
