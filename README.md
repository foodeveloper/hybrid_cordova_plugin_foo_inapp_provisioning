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
"result": [PKPass]
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
"result": [PKPaymentPass]
```

failureCallback:
- {}

#### Get Local Passes with Card Suffix

```
function successCallback(result){
  //Add Success Handling here
}

function failureCallback(message){
  //Add Failure Handling here
}

FooInAppProvisioningCordovaPlugin.getLocalPassesWithCardSuffix(cardSuffix, successCallback, failureCallback);
```

successCallback:
```
"result": PKPass
```

failureCallback:
- {}

#### Get Remote Passes with Card Suffix

```
function successCallback(result){
  //Add Success Handling here
}

function failureCallback(message){
  //Add Failure Handling here
}

FooInAppProvisioningCordovaPlugin.getRemotePassesWithCardSuffix(cardSuffix, successCallback, failureCallback);
```

successCallback:
```
"result": PKPaymentPass
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
  
FooInAppProvisioningCordovaPlugin.addCard("USER_ID", "CARD_ID", "CARD_HOLDER_NAME", "CARD_PAN_SUFFIX","LOCALIZED_DESCRIPTION", "PAN", "EXPIRY_DATE", successCallback, failureCallback);
```

successCallback:
```
"result": PKPaymentPass
```

failureCallback:
```
"result": {
  "error": (Int / Enum),
  "errorMessage": (String)
}
```

Examples:

```
FooInAppProvisioningCordovaPlugin.addCard("1234", "123", "TEST USER", "4178", "en", "1234920006324178", "04/25", testSuccess, testFail)
FooInAppProvisioningCordovaPlugin.addCard("1234", "123", "TEST USER", "4178",  "en", null, null, testSuccess, testFail)
```

### Watch support

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

### PassKit support

#### Open Wallet Passkit URL

```
function successCallback(result){
  //Add Success Handling here
}

function failureCallback(message){
  //Add Failure Handling here
}

FooInAppProvisioningCordovaPlugin.openWalletPassUrl(passUrl, successCallback, failureCallback);
```

successCallback:
- "result" : {"error":0/null/undefined}

failureCallback:
- "result" : {"error":"ERROR_MESSAGE"}

## Response Description

### PKPass
```
{
  "PassType":(Integer),
  "SecureElementPass":(PKSecureElementPass),
  "SerialNumber":(String),
  "PassTypeIdentifier":(String),
  "DeviceName":(String),
  "LocalizedName":(String),
  "LocalizedDescription":(String),
  "RemotePass":(Boolean 1/0),
  "PKPaymentPass":(PKPaymentPass),
  "WebServiceURL":(String),
  "AuthenticationToken":(String),
  "OrganizationName":(String),
  "passURL":(String)
}
```

### PKSecureElementPass
- Contains all parameters in PKPass with the addition of the below:
```
{
  "PassActivationState":(Integer),
  "DeviceAccountIdentifier":(String),
  "DeviceAccountNumberSuffix":(String),
  "DevicePassIdentifier":(String),
  "PairedTerminalIdentifier":(String),
  "PrimaryAccountIdentifier":(String),
  "PrimaryAccountNumberSuffix":(String)
}
```

### PKPaymentPass
- Contains all parameters in PKSecureElementPass with the addition of the below:
```
{
  "ActivationState": (Integer)
}
```