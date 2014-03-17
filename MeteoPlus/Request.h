//
//  Request.h
//  MeteoPlus
//
//  Created by Tobiasz Parys on 12/03/14.
//  Copyright (c) 2014 Mobiware. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Request : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *query;
@property (nonatomic, copy) NSString *type;

@end
