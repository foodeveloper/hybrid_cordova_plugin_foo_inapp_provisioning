/********* FooInAppProvisioningCordovaPlugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>

@interface FooInAppProvisioningCordovaPlugin : CDVPlugin {
  // Member variables go here.
}

- (void)setHostNameAndPath:(CDVInvokedUrlCommand*)command;
- (NSNumber *)deviceSupportsAppleWallet;
- (nullable NSArray <PKPass *>*)getLocalPasses;
- (nullable NSArray <PKPaymentPass *>*)getRemotePasses;
- (NSNumber *)isCardAddedToLocalWalletWithCardSuffix:(CDVInvokedUrlCommand*)command;
- (NSNumber *)isCardAddedToRemoteWalletWithCardSuffix:(CDVInvokedUrlCommand*)command;
- (NSNumber *)isCardAddedToLocalWalletWithPrimaryAccountIdentifier:(CDVInvokedUrlCommand*)command;
- (NSNumber *)isCardAddedToRemoteWalletWithPrimaryAccountIdentifier:(CDVInvokedUrlCommand*)command;
- (void)addCardForUser:(CDVInvokedUrlCommand*)command;

@end

@implementation FooInAppProvisioningCordovaPlugin

- (void)setHostNameAndPath:(CDVInvokedUrlCommand*)command
{
    NSString* hostName = [command.arguments objectAtIndex:0];
    NSString* path = [command.arguments objectAtIndex:1];    

    [FOAppleWallet setHostName:hostName andPath:path];

    __block CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:success];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (NSNumber *)deviceSupportsAppleWallet
{
    BOOL result = [FOInAppProvisioning deviceSupportsAppleWallet];

    __block CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:success];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    return [NSNumber numberWithBool:result];
}

- (nullable NSArray <PKPass *>*)getLocalPasses
{
    NSMutableArray* jsonList = [NSMutableArray arrayWithCapacity:[FOInAppProvisioning getLocalPasses].count];
    for (PKPass* pkPass in [FOInAppProvisioning getLocalPasses]) {
        [jsonList addObject: [self getDictionaryFromPkPass:pkPass]];
    }

    __block CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:success];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    return jsonList;
}

- (nullable NSArray <PKPaymentPass *>*)getRemotePasses
{
    NSMutableArray* jsonList = [NSMutableArray arrayWithCapacity:[FOInAppProvisioning getRemotePasses].count];
    for (PKPaymentPass* pkPaymentPass in [FOInAppProvisioning getRemotePasses]) {
      [jsonList addObject: [self getDictionaryFromPkPaymentPass:pkPaymentPass]];
    }

    __block CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:success];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    return jsonList;
}

- (NSNumber *)isCardAddedToLocalWalletWithCardSuffix:(CDVInvokedUrlCommand*)command
{
    NSString* cardSuffix = [command.arguments objectAtIndex:0];
    BOOL result = [FOInAppProvisioning isCardAddedToLocalWalletWithCardSuffix:cardSuffix];

    __block CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:success];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    return [NSNumber numberWithBool:result];
}

- (NSNumber *)isCardAddedToRemoteWalletWithCardSuffix:(CDVInvokedUrlCommand*)command
{
    NSString* cardSuffix = [command.arguments objectAtIndex:0];
    BOOL result = [FOInAppProvisioning isCardAddedToRemoteWalletWithCardSuffix:cardSuffix];

    __block CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:success];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    return [NSNumber numberWithBool:result];
}

- (NSNumber *)isCardAddedToLocalWalletWithPrimaryAccountIdentifier:(CDVInvokedUrlCommand*)command
{
    NSString* primaryAccountIdentifier = [command.arguments objectAtIndex:0];
    BOOL result = [FOInAppProvisioning isCardAddedToLocalWalletWithPrimaryAccountIdentifier:primaryAccountIdentifier];

    __block CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:success];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    return [NSNumber numberWithBool:result];
}

- (NSNumber *)isCardAddedToRemoteWalletWithPrimaryAccountIdentifier:(CDVInvokedUrlCommand*)command
{
    NSString* primaryAccountIdentifier = [command.arguments objectAtIndex:0];
    BOOL result = [FOInAppProvisioning isCardAddedToRemoteWalletWithPrimaryAccountIdentifier:primaryAccountIdentifier];

    __block CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:success];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    return [NSNumber numberWithBool:result];
}

- (void)addCardForUser:(CDVInvokedUrlCommand*)command
{
    NSString* userId = [command.arguments objectAtIndex:0];
    NSString* cardId = [command.arguments objectAtIndex:1];
    NSString* cardHolderName = [command.arguments objectAtIndex:2];
    NSString* cardPanSuffix = [command.arguments objectAtIndex:3];
    NSString* localizedDescription = [command.arguments objectAtIndex:4];
    NSString* pan = [command.arguments objectAtIndex:5];
    NSString* expiryDate = [command.arguments objectAtIndex:6];    
    return [FOInAppProvisioning addCardForUserId:userId cardId:cardId cardHolderName:cardHolderName cardPanSuffix:cardPanSuffix localizedDescription:localizedDescription inViewController:[UIApplication sharedApplication].keyWindow.rootViewController delegate:self];
}

//Delegate
- (void)didFinishAddingCard:(nullable PKPaymentPass *)pass error:(FOInAppAddCardError)error errorMessage:(nullable NSString *)errorMessage {    

    __block CDVPluginResult* pluginResult = nil;

    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        
        NSMutableDictionary* details = [NSMutableDictionary new];
          
          if(pass != nil) {
              [details setObject:[self getDictionaryFromPkPaymentPass:pass] forKey:@"PKPaymentPass"];
          }
          [details setValue:@(error) forKey:@"error"];
          
          if(errorMessage != nil) {
              [details setObject:errorMessage forKey:@"errorMessage"];
          }
          
          NSError *error;
          NSData *jsonData = [NSJSONSerialization dataWithJSONObject:details
                                                             options:NSJSONWritingPrettyPrinted
                                                               error:&error];
            if (!jsonData) {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:failure];
            } else {
                NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];            
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:success];            
            }
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
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

@end
