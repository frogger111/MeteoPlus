//
//  WeatherCondition.h
//  MeteoPlus
//
//  Created by Tobiasz Parys on 12/03/14.
//  Copyright (c) 2014 Mobiware. All rights reserved.
//

#import <Mantle.h>


@interface WeatherCondition : MTLModel <MTLJSONSerializing>

@property (nonatomic, assign) NSInteger cloudcover;
@property (nonatomic, assign) NSInteger humidity;

@property (nonatomic, copy) NSString *observationTime;
@property (nonatomic, assign) CGFloat precipMM;
@property (nonatomic, assign) NSUInteger pressure;
@property (nonatomic, assign) NSUInteger tempC;
@property (nonatomic, assign) NSUInteger tempF;
@property (nonatomic, assign) NSInteger visibility;
@property (nonatomic, assign) NSInteger weatherCode;
@property (nonatomic, copy) NSString *weatherDesc;
@property (nonatomic, strong) NSString *weatherIconUrl;
@property (nonatomic, copy) NSString *winddir16Point;
@property (nonatomic, assign) NSInteger winddirDegree;
@property (nonatomic, assign) NSInteger windspeedKmph;
@property (nonatomic, assign) NSInteger windspeedMiles;

@property (nonatomic, strong) NSArray *weather;

@property (nonatomic, strong) NSArray *request;

@end
