//
//  SearchWeatherClient.h
//  MeteoPlus
//
//  Created by Tobiasz Parys on 12/03/14.
//  Copyright (c) 2014 Mobiware. All rights reserved.
//

@import CoreLocation;

#import <Foundation/Foundation.h>
#import "WeatherCondition.h"
#import <ReactiveCocoa/ReactiveCocoa/ReactiveCocoa.h>


@interface SearchWeatherClient : NSObject

-(RACSignal *)fetchCurrentConditionsForLocation:(CLLocationCoordinate2D)coordinate;

@end
