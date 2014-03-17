//
//  Search.h
//  MeteoPlus
//
//  Created by Tobiasz Parys on 12/03/14.
//  Copyright (c) 2014 Mobiware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
@interface Search : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSArray *places;

@end
