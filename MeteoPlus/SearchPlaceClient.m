//
//  SearchPlaceClient.m
//  MeteoPlus
//
//  Created by Tobiasz Parys on 12/03/14.
//  Copyright (c) 2014 Mobiware. All rights reserved.
//

#import "SearchPlaceClient.h"
#import "Search.h"
#import <AFNetworking/AFNetworking.h>

@implementation SearchPlaceClient{

    AFHTTPRequestOperationManager *_afHttpRequestOperationManager;
}

-(id)init{

    if(self = [super init]){
    
        _afHttpRequestOperationManager = [AFHTTPRequestOperationManager manager];
        _afHttpRequestOperationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    return self;
}

-(void)searchPlaceWithName:(NSString *)string success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{

    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"plist"];
    NSDictionary *config = [NSDictionary dictionaryWithContentsOfFile:configPath];
    
    // new request has come, so I have to cancel all previews operations
    [_afHttpRequestOperationManager.operationQueue cancelAllOperations];
    
    NSDictionary *params = @{@"q":string,
                             @"format":@"json",
                             @"key":[config objectForKey:@"WolrdWeatherOnlineKey"]};
    
    [_afHttpRequestOperationManager GET:[config objectForKey:@"WorldWetherOnlineSearchPlaceURL"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"%@", responseObject);
        
        NSError *error;
        
        // I know that I'm parsing JSON in main thread. but the response is short, so I decided to parse it here. If response would be heavy, I would pass response to another thread and parse it there.
        Search *search = [MTLJSONAdapter modelOfClass:[Search class] fromJSONDictionary:(NSDictionary *)responseObject error:&error];
        
        if(success){

            success(search.places);
        }
        
//        NSLog(@"Search %d", [search places].count );
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if(failure) {
        
            failure(error);
        }
    }];
    
}

@end
