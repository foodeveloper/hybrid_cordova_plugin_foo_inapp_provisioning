/********* FooInAppProvisioningCordovaPlugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <FooAppleWallet/FOAppleWallet.h>
#import <FooAppleWallet/FOInAppProvisioning.h>
#import <WatchConnectivity/WatchConnectivity.h>

@interface FooInAppProvisioningCordovaPlugin : CDVPlugin <FOInAppProtocol, WCSessionDelegate> {
  // Member variables go here.  
}

@property (nonatomic, strong) CDVInvokedUrlCommand *inAppDelegateCommand;
@property (nonatomic, strong) CDVInvokedUrlCommand *watchDelegateCommand;

- (void)setHostNameAndPath:(CDVInvokedUrlCommand*)command;
- (void)deviceSupportsAppleWallet:(CDVInvokedUrlCommand*)command;
- (void)getLocalPasses:(CDVInvokedUrlCommand*)command;
- (void)getRemotePasses:(CDVInvokedUrlCommand*)command;
- (void)isCardAddedToLocalWalletWithCardSuffix:(CDVInvokedUrlCommand*)command;
- (void)isCardAddedToRemoteWalletWithCardSuffix:(CDVInvokedUrlCommand*)command;
- (void)isCardAddedToLocalWalletWithPrimaryAccountIdentifier:(CDVInvokedUrlCommand*)command;
- (void)isCardAddedToRemoteWalletWithPrimaryAccountIdentifier:(CDVInvokedUrlCommand*)command;
- (void)addCardForUser:(CDVInvokedUrlCommand*)command;

- (void)isWatchPaired:(CDVInvokedUrlCommand*)command;

@end

@implementation FooInAppProvisioningCordovaPlugin

- (void)setHostNameAndPath:(CDVInvokedUrlCommand*)command
{
    NSString* hostName = [command.arguments objectAtIndex:0];
    NSString* path = [command.arguments objectAtIndex:1];    

    [FOAppleWallet setHostName:hostName andPath:path];

    __block CDVPluginResult* pluginResult = nil;
    NSDictionary *success = @{};
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:success];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)deviceSupportsAppleWallet:(CDVInvokedUrlCommand*)command
{
    BOOL deviceSupportsAppleWallet = [FOInAppProvisioning deviceSupportsAppleWallet];
    NSNumber* result = [NSNumber numberWithBool:deviceSupportsAppleWallet];

    __block CDVPluginResult* pluginResult = nil;
    NSDictionary *success = @{@"result":result};    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:success];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];    
}

- (void)getLocalPasses:(CDVInvokedUrlCommand*)command
{
    NSMutableArray* jsonList = [NSMutableArray arrayWithCapacity:[FOInAppProvisioning getLocalPasses].count];
    for (PKPass* pkPass in [FOInAppProvisioning getLocalPasses]) {
        [jsonList addObject: [self getDictionaryFromPkPass:pkPass]];
    }

    __block CDVPluginResult* pluginResult = nil;
    NSDictionary *success = @{@"result":jsonList};
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:success];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];    
}

- (void)getRemotePasses:(CDVInvokedUrlCommand*)command
{
    NSMutableArray* jsonList = [NSMutableArray arrayWithCapacity:[FOInAppProvisioning getRemotePasses].count];
    for (PKPaymentPass* pkPaymentPass in [FOInAppProvisioning getRemotePasses]) {
      [jsonList addObject: [self getDictionaryFromPkPaymentPass:pkPaymentPass]];
    }

    __block CDVPluginResult* pluginResult = nil;
    NSDictionary *success = @{@"result":jsonList};
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:success];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)isCardAddedToLocalWalletWithCardSuffix:(CDVInvokedUrlCommand*)command
{
    NSString* cardSuffix = [command.arguments objectAtIndex:0];
    BOOL cardAdded = [FOInAppProvisioning isCardAddedToLocalWalletWithCardSuffix:cardSuffix];
    NSNumber* result = [NSNumber numberWithBool:cardAdded];

    __block CDVPluginResult* pluginResult = nil;
    NSDictionary *success = @{@"result":result};
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:success];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];    
}

- (void)isCardAddedToRemoteWalletWithCardSuffix:(CDVInvokedUrlCommand*)command
{
    NSString* cardSuffix = [command.arguments objectAtIndex:0];
    BOOL cardAdded = [FOInAppProvisioning isCardAddedToRemoteWalletWithCardSuffix:cardSuffix];
    NSNumber* result = [NSNumber numberWithBool:cardAdded];

    __block CDVPluginResult* pluginResult = nil;
    NSDictionary *success = @{@"result":result};
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:success];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];    
}

- (void)isCardAddedToLocalWalletWithPrimaryAccountIdentifier:(CDVInvokedUrlCommand*)command
{
    NSString* primaryAccountIdentifier = [command.arguments objectAtIndex:0];
    BOOL cardAdded = [FOInAppProvisioning isCardAddedToLocalWalletWithPrimaryAccountIdentifier:primaryAccountIdentifier];
    NSNumber* result = [NSNumber numberWithBool:cardAdded];

    __block CDVPluginResult* pluginResult = nil;
    NSDictionary *success = @{@"result":result};
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:success];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];    
}

- (void)isCardAddedToRemoteWalletWithPrimaryAccountIdentifier:(CDVInvokedUrlCommand*)command
{
    NSString* primaryAccountIdentifier = [command.arguments objectAtIndex:0];
    BOOL cardAdded = [FOInAppProvisioning isCardAddedToRemoteWalletWithPrimaryAccountIdentifier:primaryAccountIdentifier];
    NSNumber* result = [NSNumber numberWithBool:cardAdded];

    __block CDVPluginResult* pluginResult = nil;
    NSDictionary *success = @{@"result":result};
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:success];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];    
}

- (void)addCardForUser:(CDVInvokedUrlCommand*)command
{
    NSString* userId = [command.arguments objectAtIndex:0];
    NSString* cardId = [command.arguments objectAtIndex:1];
    NSString* cardHolderName = [command.arguments objectAtIndex:2];    
    NSString* localizedDescription = [command.arguments objectAtIndex:3];
    NSString* cardPanSuffix = [command.arguments objectAtIndex:4];
    NSString* pan = [command.arguments objectAtIndex:5];
    NSString* expiryDate = [command.arguments objectAtIndex:6];    
    self.inAppDelegateCommand = command;
    
    if (pan != nil && expiryDate != nil && ![pan isEqual:[NSNull null]] && ![expiryDate isEqual:[NSNull null]] && pan.length > 0 && expiryDate.length > 0) {

        return [FOInAppProvisioning addCardForUserId:userId cardId:cardId cardHolderName:cardHolderName cardPanSuffix:cardPanSuffix localizedDescription:localizedDescription pan:pan expiryDate:expiryDate inViewController:[UIApplication sharedApplication].keyWindow.rootViewController delegate:self];        
    }
    else {

        return [FOInAppProvisioning addCardForUserId:userId cardId:cardId cardHolderName:cardHolderName cardPanSuffix:cardPanSuffix localizedDescription:localizedDescription inViewController:[UIApplication sharedApplication].keyWindow.rootViewController delegate:self];
    }
}

- (void)isWatchPaired:(CDVInvokedUrlCommand*)command {
    
    self.watchDelegateCommand = command;   
    if (![WCSession isSupported]){        
        NSDictionary *result = @{@"status" : @"notSupported"};
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:result];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:self.watchDelegateCommand.callbackId];
        return;
    }
    
    [self activateSession];    
    
    BOOL isPaired = [[WCSession defaultSession] isPaired];
    NSDictionary *result = @{@"isPaired" : @(isPaired)};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.watchDelegateCommand.callbackId];
}

//Delegates

////FOInAppProtocol
- (void)didFinishAddingCard:(nullable PKPaymentPass *)pass error:(FOInAppAddCardError)error errorMessage:(nullable NSString *)errorMessage {    

    __block CDVPluginResult* pluginResult = nil;

    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        
        NSMutableDictionary* details = [NSMutableDictionary new];
          
          if(pass != nil) {
              [details setObject:[self getDictionaryFromPkPaymentPass:pass] forKey:@"PKPaymentPass"];
          }

          [details setObject:@(error) forKey:@"error"];
          
          if(errorMessage != nil) {
              [details setObject:errorMessage forKey:@"errorMessage"];
          }
          
          NSError *error;
          NSData *jsonData = [NSJSONSerialization dataWithJSONObject:details
                                                             options:NSJSONWritingPrettyPrinted
                                                               error:&error];
            if (!jsonData) {
                NSDictionary *failure = @{@"error" : error.localizedDescription};
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:failure];
            } else {
                NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                NSDictionary *success = @{@"result":jsonString};
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:success];
            }
            [self.commandDelegate sendPluginResult:pluginResult callbackId:self.inAppDelegateCommand.callbackId];
    }];
}

////WCSessionDelegate
- (void)session:(nonnull WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(nullable NSError *)error {            
    NSDictionary *result = @{@"status" : @"active"};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.watchDelegateCommand.callbackId];
}

- (void)sessionDidBecomeInactive:(nonnull WCSession *)session {
    NSDictionary *result = @{@"status" : @"inactive"};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.watchDelegateCommand.callbackId];
}

- (void)sessionDidDeactivate:(nonnull WCSession *)session {
    NSDictionary *result = @{@"status" : @"deactived"};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.watchDelegateCommand.callbackId];
}

//Helpers
- (NSDictionary *)getDictionaryFromPkPaymentPass:(PKPaymentPass *)pkPaymentPass  {
    
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    if(pkPaymentPass.description != nil) {
        [dictionary setObject:pkPaymentPass.description forKey:@"Description"];
    }
    
    if(pkPaymentPass.authenticationToken != nil) {
        [dictionary setObject:pkPaymentPass.authenticationToken forKey:@"AuthenticationToken"];
    }
    
    if(pkPaymentPass.deviceAccountIdentifier != nil) {
        [dictionary setObject:pkPaymentPass.deviceAccountIdentifier forKey:@"DeviceAccountIdentifier"];
    }
    
    if(pkPaymentPass.deviceAccountNumberSuffix != nil) {
        [dictionary setObject:pkPaymentPass.deviceAccountNumberSuffix forKey:@"DeviceAccountNumberSuffix"];
    }
    
    if(pkPaymentPass.deviceName != nil) {
        [dictionary setObject:pkPaymentPass.deviceName forKey:@"DeviceName"];
    }
    
    [dictionary setObject:@(pkPaymentPass.isProxy) forKey:@"IsProxy"];
    
    return [dictionary copy];
}

- (NSDictionary *)getDictionaryFromPkPass:(PKPass *)pkPass  {
    
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    if(pkPass.paymentPass != nil) {
        [dictionary setObject:[self getDictionaryFromPkPaymentPass:pkPass.paymentPass] forKey:@"PKPaymentPass"];
    }
    
    if(pkPass.serialNumber != nil) {
        [dictionary setObject:pkPass.serialNumber forKey:@"SerialNumber"];
    }
    
    if(pkPass.webServiceURL != nil) {
        [dictionary setObject:pkPass.webServiceURL forKey:@"WebServiceURL"];
    }
    
    if(pkPass.passTypeIdentifier != nil) {
        [dictionary setObject:pkPass.passTypeIdentifier forKey:@"PassTypeIdentifier"];
    }
    
    if(pkPass.authenticationToken != nil) {
        [dictionary setObject:pkPass.authenticationToken forKey:@"AuthenticationToken"];
    }
    
    return [dictionary copy];
}

- (void)activateSession {        
    [[WCSession defaultSession] setDelegate:self];
    [[WCSession defaultSession] activateSession];
}

@end
