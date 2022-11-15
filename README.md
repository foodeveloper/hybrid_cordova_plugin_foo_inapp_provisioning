# Cordova Plugin Foo InApp Provisioning

## Installation:
- Add the plugin: `cordova plugin add git@github.com:foodeveloper/hybrid_cordova_plugin_foo_inapp_provisioning.git`
- Go to iOS platform project folder: `cd platforms/ios`
- Pod insall: `pod install`

## Implementation

## Apple Wallet

#### Add Host and Path:
```
function successCallback(result){
  //Add Success Handling here
}

function failureCallback(message){
  //Add Failure Handling here
}

FooInAppProvisioningCordovaPlugin.setHostNameAndPath("YOUR_HOST", "YOUR_PATH", successCallback, failureCallback);
```

successCallback:
- {}

failureCallback:
- {}

#### Check device supports Apple Wallet

```
function successCallback(result){
  //Add Success Handling here
}

function failureCallback(message){
  //Add Failure Handling here
}

FooInAppProvisioningCordovaPlugin.deviceSupportsAppleWallet(successCallback, failureCallback);
```

successCallback:
- "result": 1/0

failureCallback:
- {}

#### Get Local Passes

``` 
function successCallback(result){
  //Add Success Handling here
}

function failureCallback(message){
  //Add Failure Handling here
}

FooInAppProvisioningCordovaPlugin.getLocalPasses(successCallback, failureCallback);
```

successCallback:
```
"result": [{
  "PKPaymentPass": {
      "Description": (String),
      "AuthenticationToken": (String),
      "DeviceAccountIdentifier": (String),
      "DeviceAccountNumberSuffix": (String),
      "DeviceName": (String),
      "IsProxy": (1/0)
  },
  "SerialNumber": (String),
  "WebServiceURL": (String),
  "PassTypeIdentifier": (String),
  "AuthenticationToken":  (String)
}]
```

failureCallback:
- {}

#### Get Remote Passes

``` 
function successCallback(result){
  //Add Success Handling here
}

function failureCallback(message){
  //Add Failure Handling here
}

FooInAppProvisioningCordovaPlugin.getRemotePasses(successCallback, failureCallback);
```

successCallback:
```
"result": [{
  "PKPaymentPass": {
      "Description": (String),
      "AuthenticationToken": (String),
      "DeviceAccountIdentifier": (String),
      "DeviceAccountNumberSuffix": (String),
      "DeviceName": (String),
      "IsProxy": (1/0)
  },
  "SerialNumber": (String),
  "WebServiceURL": (String),
  "PassTypeIdentifier": (String),
  "AuthenticationToken":  (String)
}]
```

failureCallback:
- {}

#### Check Card Added To Local Wallet With Card Suffix

``` 
function successCallback(result){
  //Add Success Handling here
}

function failureCallback(message){
  //Add Failure Handling here
}
  
FooInAppProvisioningCordovaPlugin.isCardAddedToLocalWalletWithCardSuffix("CARD_SUFFIX", successCallback, failureCallback);
```

successCallback:
- "result": 1/0

failureCallback:
- {}


#### Check Card Added To Remote Wallet With Card Suffix

```
function successCallback(result){
  //Add Success Handling here
}

function failureCallback(message){
  //Add Failure Handling here
}
  
FooInAppProvisioningCordovaPlugin.isCardAddedToRemoteWalletWithCardSuffix("CARD_SUFFIX", successCallback, failureCallback);
```

successCallback:
- "result": 1/0

failureCallback:
- {}

#### Check Card Added To Local Wallet With Primary Account Identifier

```
function successCallback(result){
  //Add Success Handling here
}
  
function failureCallback(message){
  //Add Failure Handling here
}
  
FooInAppProvisioningCordovaPlugin.isCardAddedToLocalWalletWithPrimaryAccountIdentifier("ACCOUNT_IDENTIFIER", successCallback, failureCallback);
```

successCallback:
- "result": 1/0

failureCallback:
- {}

#### Check Card Added To Remote Wallet With Primary Account Identifier

```
function successCallback(result){
  //Add Success Handling here
}

function failureCallback(message){
  //Add Failure Handling here
}

FooInAppProvisioningCordovaPlugin.isCardAddedToRemoteWalletWithPrimaryAccountIdentifier("ACCOUNT_IDENTIFIER", successCallback, failureCallback);
```

successCallback:
- "result": 1/0

failureCallback:
- {}

#### Add Card

``` 
function successCallback(result){
  //Add Success Handling here
}
  
function failureCallback(message){
  //Add Failure Handling here
}
  
FooInAppProvisioningCordovaPlugin.addCard("USER_ID", "CARD_ID", "CARD_HOLDER_NAME", "LOCALIZED_DESCRIPTION", "CARD_PAN_SUFFIX", "PAN", "EXPIRY_DATE", successCallback, failureCallback);
```

successCallback:
```
"result": {
  "pass": {
    "authenticationToken": (String),
    "description": (String),
    "deviceAccountIdentifier": (String),
    "deviceAccountNumberSuffix": (String),
    "deviceName": (String),
    "isProxy": (1/0)
  },
  "error": (Int / Enum),
  "errorMessage": (String)
}
```

failureCallback:
- {"error" : (String)};

Examples:

```
FooInAppProvisioningCordovaPlugin.addCard("1234", "123", "TEST USER", "en", "4178", "1234920006324178", "04/25", testSuccess, testFail)
FooInAppProvisioningCordovaPlugin.addCard("1234", "123", "TEST USER", "en", "4178", null, null, testSuccess, testFail)
```

### Watch supports

#### Check Watch Pairing

```
function successCallback(result){
  //Add Success Handling here
}

function failureCallback(message){
  //Add Failure Handling here
}

FooInAppProvisioningCordovaPlugin.isWatchPaired(successCallback, failureCallback);
```

successCallback:
- "isPaired" : true/false
- "status" : "active"/"inactive"/"deactived"

failureCallback:
- "status" : "notSupported"