//
//  Place.h
//  MeteoPlus
//
//  Created by Tobiasz Parys on 12/03/14.
//  Copyright (c) 2014 Mobiware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface Location : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *areaName;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;
@property (nonatomic, assign) NSUInteger population;
@property (nonatomic, assign) NSString *weatherUrl;

@end
