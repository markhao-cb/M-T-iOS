//
//  AppDelegate.m
//  qdrj
//
//  Created by Yu Qi Hao on 12/8/14.
//  Copyright (c) 2014 Yu Qi Hao. All rights reserved.
//

#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    _db = [[DBAPI alloc] init];
    
    NSLog(@"didReceiveRemoteNotification");
    if (launchOptions != NULL)
    {
        NSDictionary *userInfo = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
        NSString *message = nil;
        id payload = [userInfo objectForKey:@"aps"];
        if ([payload isKindOfClass:[NSString class]]) {
            message = payload;
        } else if ([payload isKindOfClass:[NSDictionary class]]) {
            message = [payload objectForKey:@"alert"];
        }
        
        NSLog(@"message=%@", message); // should be something like jtang207 feeling Lonely
        NSArray *components = [message componentsSeparatedByString:@"|"];
        
        [_db modifyDB:[NSString stringWithFormat:@"insert into promotion(ID, title, issue_date, exp_date, detail, type, image, others) values (null, '%@', '%@', '%@', '%@', '%d','%@','%@')",[components objectAtIndex:0], [components objectAtIndex:2], [components objectAtIndex:3], [components objectAtIndex:1],1,@"",@""]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New Promotion" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"My token is: %@", deviceToken);
    NSString *devtoken = [[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]
                          stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    NSUUID *oNSUUID = [[UIDevice currentDevice] identifierForVendor];
    NSString *udid = [oNSUUID UUIDString];
    
    NSString *url = [NSString stringWithFormat:@"http://www.morkout.com/iapps/qdrj/setdevtoken.php?udid=%@&devtoken=%@", udid, devtoken];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
         
         NSLog(@"returnString=%@", returnString);
     }];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"didReceiveRemoteNotification");
    
    NSString *message = nil;
    id payload = [userInfo objectForKey:@"aps"];
    if ([payload isKindOfClass:[NSString class]]) {
        message = payload;
    } else if ([payload isKindOfClass:[NSDictionary class]]) {
        message = [payload objectForKey:@"alert"];
    }
    
    NSLog(@"message=%@", message); // should be something like jtang207 feeling Lonely
    NSArray *components = [message componentsSeparatedByString:@"|"];
    
    [_db modifyDB:[NSString stringWithFormat:@"insert into promotion(ID, title, issue_date, exp_date, detail, type, image, others) values (null, '%@', '%@', '%@', '%@', '%d','%@','%@')",[components objectAtIndex:0], [components objectAtIndex:2], [components objectAtIndex:3], [components objectAtIndex:1],1,@"",@""]];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New Promotion" message:[NSString stringWithFormat:@"%@%@",[components objectAtIndex:0],[components objectAtIndex:1]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    
}

@end
