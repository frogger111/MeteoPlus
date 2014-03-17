//
//  Weather.h
//  MeteoPlus
//
//  Created by Tobiasz Parys on 12/03/14.
//  Copyright (c) 2014 Mobiware. All rights reserved.
//

#import <Mantle/Mantle.h>
@interface Weather : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *date;
@property (nonatomic, assign) CGFloat precipMM;
@property (nonatomic, assign) NSInteger tempMaxC;
@property (nonatomic, assign) NSInteger tempMaxF;
@property (nonatomic, assign) NSInteger tempMinC;
@property (nonatomic, assign) NSInteger tempMinF;
@property (nonatomic, assign) NSInteger weatherCode;
@property (nonatomic, copy) NSString *weatherDesc;
@property (nonatomic, copy) NSString *weatherIconUrl;
@property (nonatomic, copy) NSString *winddir16Point;
@property (nonatomic, assign) NSInteger winddirDegree;
@property (nonatomic, copy) NSString *winddirection;
@property (nonatomic, assign) NSUInteger windspeedKmph;
@property (nonatomic, assign) NSUInteger windspeedMiles;

@end
