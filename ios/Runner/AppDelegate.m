#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#include "LMURLProtocol.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [NSURLProtocol registerClass:LMURLProtocol.class];
    
    [GeneratedPluginRegistrant registerWithRegistry:self];
  
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
