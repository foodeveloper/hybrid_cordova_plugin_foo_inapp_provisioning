# Cordova Plugin Foo InApp Provisioning

## Installation:
- Add the plugin: `cordova plugin add git@github.com:foodeveloper/hybrid_cordova_plugin_foo_inapp_provisioning.git`
- Go to iOS platform project folder: `cd platforms/ios`
- Pod insall: `pod install`

## Implementation

### Add Host and Path: 
```function successCallback(result){
    //Add Success Handling here
  }
  
  function FailureCallback(message){
    //Add Failure Handling here
  }
  
  FooInAppProvisioningCordovaPlugin.setHostNameAndPath("YOUR_HOST", "YOUR_PATH", successCallback, FailureCallback);    
```

### Check device supports Apple Wallet

``` function successCallback(result){
    //Add Success Handling here
  }
  
  function FailureCallback(message){
    //Add Failure Handling here
  }
  
  FooInAppProvisioningCordovaPlugin.deviceSupportsAppleWallet(successCallback, FailureCallback);    
```

### Get Local Passes

``` function successCallback(result){
    //Add Success Handling here
  }
  
  function FailureCallback(message){
    //Add Failure Handling here
  }
  
   FooInAppProvisioningCordovaPlugin.getLocalPasses(successCallback, FailureCallback);    
```

### Get Remote Passes

``` function successCallback(result){
    //Add Success Handling here
  }
  
  function FailureCallback(message){
    //Add Failure Handling here
  }
  
   FooInAppProvisioningCordovaPlugin.getRemotePasses(successCallback, FailureCallback);    
```

### Check Card Added To Local Wallet With Card Suffix

``` function successCallback(result){
    //Add Success Handling here
  }
  
  function FailureCallback(message){
    //Add Failure Handling here
  }
  
   FooInAppProvisioningCordovaPlugin.isCardAddedToLocalWalletWithCardSuffix("CARD_SUFFIX", successCallback, FailureCallback);    
```


### Check Card Added To Remote Wallet With Card Suffix

``` function successCallback(result){
    //Add Success Handling here
  }
  
  function FailureCallback(message){
    //Add Failure Handling here
  }
  
   FooInAppProvisioningCordovaPlugin.isCardAddedToRemoteWalletWithCardSuffix("CARD_SUFFIX", successCallback, FailureCallback);    
```

### Check Card Added To Local Wallet With Primary Account Identifier

``` function successCallback(result){
    //Add Success Handling here
  }
  
  function FailureCallback(message){
    //Add Failure Handling here
  }
  
   FooInAppProvisioningCordovaPlugin.isCardAddedToLocalWalletWithPrimaryAccountIdentifier("ACCOUNT_IDENTIFIER", successCallback, FailureCallback);    
```


### Check Card Added To Remote Wallet With Primary Account Identifier

``` function successCallback(result){
    //Add Success Handling here
  }
  
  function FailureCallback(message){
    //Add Failure Handling here
  }
  
   FooInAppProvisioningCordovaPlugin.isCardAddedToRemoteWalletWithPrimaryAccountIdentifier("ACCOUNT_IDENTIFIER", successCallback, FailureCallback);    
```

### Add Card

``` function successCallback(result){
    //Add Success Handling here
  }
  
  function FailureCallback(message){
    //Add Failure Handling here
  }
  
   FooInAppProvisioningCordovaPlugin.addCard("USER_ID", "CARD_ID", "CARD_HOLDER_NAME", "LOCALIZED_DESCRIPTION", "CARD_PAN_SUFFIX", "PAN", "EXPIRY_DATE", successCallback, FailureCallback);    
```
   Examples:
```
      FooInAppProvisioningCordovaPlugin.addCard("1234", "123", "TEST USER", "en", "4178", "1234920006324178", "04/25", testSuccess, testFail)
      FooInAppProvisioningCordovaPlugin.addCard("1234", "123", "TEST USER", "en", "4178", null, null, testSuccess, testFail)
```



