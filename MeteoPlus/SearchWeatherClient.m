//
//  SearchWeatherClient.m
//  MeteoPlus
//
//  Created by Tobiasz Parys on 12/03/14.
//  Copyright (c) 2014 Mobiware. All rights reserved.
//

#import "SearchWeatherClient.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking-RACExtensions/AFHTTPRequestOperationManager+RACSupport.h>
#import "WeatherCondition.h"

@implementation SearchWeatherClient{

    AFHTTPRequestOperationManager *_afHttpRequestOperationManager;
}

-(id)init{

    if(self = [super init]){
        
        _afHttpRequestOperationManager = [AFHTTPRequestOperationManager manager];
        _afHttpRequestOperationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}


-(RACSignal *)fetchCurrentConditionsForLocation:(CLLocationCoordinate2D)coordinate{
    
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"plist"];
    NSDictionary *config = [NSDictionary dictionaryWithContentsOfFile:configPath];
    
    NSDictionary *params = @{@"q":[NSString stringWithFormat:@"%f,%f", coordinate.latitude, coordinate.longitude],
                             @"format":@"json",
                             @"num_of_days":@"5",
                             @"key":[config objectForKey:@"WolrdWeatherOnlineKey"]};
    
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        AFHTTPRequestOperation *op = [_afHttpRequestOperationManager GET:[config objectForKey:@"WorldWetherOnlineURL"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSError *error;
            
            WeatherCondition *weatherCondition = [MTLJSONAdapter modelOfClass:[WeatherCondition class] fromJSONDictionary:(NSDictionary *)responseObject error:&error];
            
            if(!error && weatherCondition) {
                
                [subscriber sendNext:weatherCondition];
                [subscriber sendCompleted];
            } else {
            
                [subscriber sendError:error];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [op cancel];
        }];
    }] doError:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end
