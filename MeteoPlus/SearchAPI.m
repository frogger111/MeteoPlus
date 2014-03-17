//
//  SearchAPI.m
//  MeteoPlus
//
//  Created by Tobiasz Parys on 11/03/14.
//  Copyright (c) 2014 Mobiware. All rights reserved.
//

#import "SearchAPI.h"
#import "SearchPlaceClient.h"
#import "SearchWeatherClient.h"


@interface SearchAPI()

@property (nonatomic, strong, readwrite) WeatherCondition *currentWeatherCondition;

@property (nonatomic, strong, readwrite) CLLocation *currentLocation;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL isFirstUpdate;

@end

@implementation SearchAPI{

    SearchPlaceClient *_searchplaceClient;
    SearchWeatherClient *_searchWeatherClient;
}

+(instancetype)api{

    static SearchAPI *_instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });

    return _instance;
}

-(id)init{

    if(self = [super init]){
    
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
        _searchplaceClient = [[SearchPlaceClient alloc] init];
        _searchWeatherClient = [[SearchWeatherClient alloc] init];
        
        [[[[RACObserve(self, currentLocation)

            ignore:nil]

            flattenMap:^(CLLocation *newLocation) {
               return [self updateCurrentConditions];

            }] deliverOn:RACScheduler.mainThreadScheduler]

            subscribeError:^(NSError *error) {
                [TSMessage showNotificationWithTitle:@"Error"
                                            subtitle:@"There was a problem fetching the latest weather."
                                                type:TSMessageNotificationTypeError];
         }];
    }
    
    return self;
}

-(void)searchPlaceWithName:(NSString *)string success:(void (^)(NSArray *places))success failure:(void (^)(NSError *error))failure{

    [_searchplaceClient searchPlaceWithName:string success:success failure:failure];
   
}

-(RACSignal *) updateCurrentConditions{
    return [[_searchWeatherClient fetchCurrentConditionsForLocation:self.currentLocation.coordinate] doNext:^(WeatherCondition *condition) {
        self.currentWeatherCondition = condition;
    }];
}

- (void)findCurrentLocation {
    self.isFirstUpdate = YES;
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if (self.isFirstUpdate) {
        self.isFirstUpdate = NO;
        return;
    }
    
    CLLocation *location = [locations lastObject];
    
    if (location.horizontalAccuracy > 0) {
    
        self.currentLocation = location;
        [self.locationManager stopUpdatingLocation];
    }
}

@end
