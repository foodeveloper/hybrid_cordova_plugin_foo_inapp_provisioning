/********* FooInAppProvisioningCordovaPlugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <FooAppleWallet/FOAppleWallet.h>
#import <FooAppleWallet/FOInAppProvisioning.h>
#import <PassKit/PassKit.h>
#import <WatchConnectivity/WatchConnectivity.h>

@interface FooInAppProvisioningCordovaPlugin : CDVPlugin <FOInAppProtocol, WCSessionDelegate> {
  // Member variables go here.  
}

@property (nonatomic, strong) CDVInvokedUrlCommand *inAppDelegateCommand;
@property (nonatomic, strong) CDVInvokedUrlCommand *watchDelegateCommand;

//InAppProvisioniong FooAppleWalletFramework SDK
- (void)setHostNameAndPath:(CDVInvokedUrlCommand*)command;
- (void)deviceSupportsAppleWallet:(CDVInvokedUrlCommand*)command;
- (void)getLocalPasses:(CDVInvokedUrlCommand*)command;
- (void)getRemotePasses:(CDVInvokedUrlCommand*)command;
- (void)getLocalPassWithCardSuffix:(CDVInvokedUrlCommand*)command;
- (void)getRemotePassWithCardSuffix:(CDVInvokedUrlCommand*)command;
//- (nullable PKPass*)getPassWithCardSuffix:(NSString *)cardSuffix passes:(nullable NSArray <PKPass *>*)passes;
- (void)isCardAddedToLocalWalletWithCardSuffix:(CDVInvokedUrlCommand*)command;
- (void)isCardAddedToRemoteWalletWithCardSuffix:(CDVInvokedUrlCommand*)command;
- (void)isCardAddedToLocalWalletWithPrimaryAccountIdentifier:(CDVInvokedUrlCommand*)command;
- (void)isCardAddedToRemoteWalletWithPrimaryAccountIdentifier:(CDVInvokedUrlCommand*)command;
- (void)addCardForUser:(CDVInvokedUrlCommand*)command;

//WatchConnectivity
- (void)isWatchPaired:(CDVInvokedUrlCommand*)command;

//PassKit
- (void)openWalletPassUrl:(CDVInvokedUrlCommand*)command;

@end

@implementation FooInAppProvisioningCordovaPlugin

#pragma mark - FooAppleWalletFramework

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
        [jsonList addObject: [self getDictionaryFromPkPass:pkPass parseNested:YES]];
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
      [jsonList addObject: [self getDictionaryFromPkPaymentPass:pkPaymentPass parseNested:YES]];
    }

    __block CDVPluginResult* pluginResult = nil;
    NSDictionary *success = @{@"result":jsonList};
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:success];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getLocalPassWithCardSuffix:(CDVInvokedUrlCommand*)command {

    NSString* cardSuffix = [command.arguments objectAtIndex:0];
    PKPass* pkPass = [FOInAppProvisioning getLocalPassWithCardSuffix:cardSuffix];
    NSDictionary* jsonList = [self getDictionaryFromPkPass:pkPass parseNested:YES];

    __block CDVPluginResult* pluginResult = nil;
    NSDictionary *success = @{@"result":jsonList};
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:success];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getRemotePassWithCardSuffix:(CDVInvokedUrlCommand*)command {

    NSString* cardSuffix = [command.arguments objectAtIndex:0];
    PKPaymentPass* pkPaymentPass = [FOInAppProvisioning getRemotePassWithCardSuffix:cardSuffix];
    NSDictionary* jsonList = [self getDictionaryFromPkPaymentPass:pkPaymentPass parseNested:YES];

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
    NSString* cardPanSuffix = [command.arguments objectAtIndex:3];
    NSString* localizedDescription = [command.arguments objectAtIndex:4];
    NSString* pan = [command.arguments objectAtIndex:5];
    NSString* expiryDate = [command.arguments objectAtIndex:6];    
    self.inAppDelegateCommand = command;
    
    if (pan != nil && expiryDate != nil && ![pan isEqual:[NSNull null]] && ![expiryDate isEqual:[NSNull null]] && pan.length > 0 && expiryDate.length > 0) {

        return [FOInAppProvisioning addCardForUserId:userId deviceId:nil cardId:cardId cardHolderName:cardHolderName cardPanSuffix:cardPanSuffix localizedDescription:localizedDescription pan:pan expiryDate:expiryDate inViewController:[UIApplication sharedApplication].keyWindow.rootViewController delegate:self];
    }
    else {

        return [FOInAppProvisioning addCardForUserId:userId deviceId:nil cardId:cardId cardHolderName:cardHolderName cardPanSuffix:cardPanSuffix sessionId:nil localizedDescription:localizedDescription inViewController:[UIApplication sharedApplication].keyWindow.rootViewController delegate:self];
    }
}

#pragma mark - WatchConnectivity

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

#pragma mark - PassKit

- (void)openWalletPassUrl:(CDVInvokedUrlCommand*)command {
        
    NSMutableDictionary *result = [NSMutableDictionary new];
    NSString* passURLString = [command.arguments objectAtIndex:0];
    
    if (passURLString == nil || [passURLString isEqual:[NSNull null]]){
        NSDictionary *error = @{@"error":@"No URL provided"};
        [result setObject:error forKey:@"result"];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:result];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
        
    NSURL *url = [NSURL URLWithString:passURLString];
    if (url == nil){
        NSDictionary *error = @{@"error":[NSString stringWithFormat:@"Invalid URL: %@", passURLString]};
        [result setObject:error forKey:@"result"];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:result];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
    
    if (![[UIApplication sharedApplication] canOpenURL:url]){
        NSDictionary *error = @{@"error":[NSString stringWithFormat:@"Can not open URL: %@", passURLString]};
        [result setObject:error forKey:@"result"];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:result];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
        
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSDictionary *error = @{@"error":@(0)};
            [result setObject:error forKey:@"result"];
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        else {
            NSDictionary *error = @{@"error":[NSString stringWithFormat:@"Failed to open URL: %@", passURLString]};
            [result setObject:error forKey:@"result"];
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:result];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }];
}

#pragma mark - Delegates

#pragma mark FOInAppProtocol
- (void)didFinishAddingCard:(nullable PKPaymentPass *)pass error:(FOInAppAddCardError)error errorMessage:(nullable NSString *)errorMessage {    

    __block CDVPluginResult* pluginResult = nil;

    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        
        NSMutableDictionary* details = [NSMutableDictionary new];
          
        if(pass != nil) {
            [details setObject:[self getDictionaryFromPkPaymentPass:pass parseNested:YES] forKey:@"PKPaymentPass"];
        }
        [details setObject:@(error) forKey:@"error"];
        
        if(errorMessage != nil) {
            [details setObject:errorMessage forKey:@"errorMessage"];
        }

        NSDictionary *result = @{@"result":details};
        if (error == 0){            
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];            
        }   
        else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:result];            
        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:self.inAppDelegateCommand.callbackId];
    }];
}

#pragma mark WCSessionDelegate

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

#pragma mark - Helpers
//PKPaymentPass
- (NSDictionary *)getDictionaryFromPkPaymentPass:(PKPaymentPass *)pkPaymentPass parseNested:(BOOL)parseNested {
    //https://developer.apple.com/documentation/passkit/pkpaymentpass
    NSMutableDictionary *dictionary = [NSMutableDictionary new];

    //Get Super Class PKSecureElementPass - BOOL No to avoid loop
    NSDictionary *pkPassInfo = [self getDictionaryFromPkSecureElementPass:pkPaymentPass parseNested:parseNested];
    [dictionary addEntriesFromDictionary:pkPassInfo];

    //Determining activation state - Deprecated
    [dictionary setObject:@(pkPaymentPass.activationState) forKey:@"ActivationState"];

    return [dictionary copy];
}

//PKSecureElementPass
- (NSDictionary *)getDictionaryFromPkSecureElementPass:(PKSecureElementPass *)pkSecureElementPass parseNested:(BOOL)parseNested {
    //https://developer.apple.com/documentation/passkit/pksecureelementpass
    NSMutableDictionary *dictionary = [NSMutableDictionary new];

    //Get Super Class PKPass - BOOL No to avoid loop
    NSDictionary *pkPassInfo = [self getDictionaryFromPkPass:pkSecureElementPass parseNested:parseNested];
    [dictionary addEntriesFromDictionary:pkPassInfo];

    //Getting the activation state
    [dictionary setObject:@(pkSecureElementPass.passActivationState) forKey:@"PassActivationState"];

    //Getting the hardware attributes
    if(pkSecureElementPass.deviceAccountIdentifier != nil) {
        [dictionary setObject:pkSecureElementPass.deviceAccountIdentifier forKey:@"DeviceAccountIdentifier"];
    }

    if(pkSecureElementPass.deviceAccountNumberSuffix != nil) {
        [dictionary setObject:pkSecureElementPass.deviceAccountNumberSuffix forKey:@"DeviceAccountNumberSuffix"];
    }

    if(pkSecureElementPass.devicePassIdentifier != nil) {
        [dictionary setObject:pkSecureElementPass.devicePassIdentifier forKey:@"DevicePassIdentifier"];
    }

    if(pkSecureElementPass.pairedTerminalIdentifier != nil) {
        [dictionary setObject:pkSecureElementPass.pairedTerminalIdentifier forKey:@"PairedTerminalIdentifier"];
    }

    //Getting the account attributes
    if(pkSecureElementPass.primaryAccountIdentifier != nil) {
        [dictionary setObject:pkSecureElementPass.primaryAccountIdentifier forKey:@"PrimaryAccountIdentifier"];
    }

    if(pkSecureElementPass.primaryAccountNumberSuffix != nil) {
        [dictionary setObject:pkSecureElementPass.primaryAccountNumberSuffix forKey:@"PrimaryAccountNumberSuffix"];
    }

    //Others
    if(pkSecureElementPass.description != nil) {
        [dictionary setObject:pkSecureElementPass.description forKey:@"Description"];
    }

    return [dictionary copy];
}

//PKPass
- (NSDictionary *)getDictionaryFromPkPass:(PKPass *)pkPass parseNested:(BOOL)parseNested {
    //https://developer.apple.com/documentation/passkit/pkpass?language=objc
    NSMutableDictionary *dictionary = [NSMutableDictionary new];

    //Identifying a pass
    [dictionary setObject:@(pkPass.passType) forKey:@"PassType"];

    if(pkPass.secureElementPass != nil && parseNested) {
        [dictionary setObject:[self getDictionaryFromPkSecureElementPass:pkPass.secureElementPass parseNested:NO] forKey:@"SecureElementPass"];
    }

    if(pkPass.serialNumber != nil) {
        [dictionary setObject:pkPass.serialNumber forKey:@"SerialNumber"];
    }

    if(pkPass.passTypeIdentifier != nil) {
        [dictionary setObject:pkPass.passTypeIdentifier forKey:@"PassTypeIdentifier"];
    }

    if(pkPass.deviceName != nil) {
        [dictionary setObject:pkPass.deviceName forKey:@"DeviceName"];
    }

    if(pkPass.localizedName != nil) {
        [dictionary setObject:pkPass.localizedName forKey:@"LocalizedName"];
    }

    if(pkPass.localizedDescription != nil) {
        [dictionary setObject:pkPass.localizedDescription forKey:@"LocalizedDescription"];
    }

    [dictionary setObject:@(pkPass.remotePass) forKey:@"RemotePass"];

    //Deprecated
    if(pkPass.paymentPass != nil  && parseNested) {
        [dictionary setObject:[self getDictionaryFromPkPaymentPass:pkPass.paymentPass parseNested:NO] forKey:@"PKPaymentPass"];
    }

    //Getting the web service information
    if(pkPass.webServiceURL != nil) {
        [dictionary setObject:pkPass.webServiceURL.absoluteString forKey:@"WebServiceURL"];
    }

    if(pkPass.authenticationToken != nil) {
        [dictionary setObject:pkPass.authenticationToken forKey:@"AuthenticationToken"];
    }

    //Getting the display attributes
    //icon UIImage
    //relevantDate NSDate
    //localizedValueForFieldKey: String
    if(pkPass.organizationName != nil) {
        [dictionary setObject:pkPass.organizationName forKey:@"OrganizationName"];
    }

    //Getting the Wallet URL
    if(pkPass.passURL != nil) {
        [dictionary setObject:pkPass.passURL.absoluteString forKey:@"passURL"];
    }

    //Providing contextual information
    //userInfo  NSDictionary

    return [dictionary copy];
}

- (void)activateSession {        
    [[WCSession defaultSession] setDelegate:self];
    [[WCSession defaultSession] activateSession];
}

@end
