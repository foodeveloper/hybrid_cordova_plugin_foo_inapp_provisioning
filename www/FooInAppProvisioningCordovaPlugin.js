var exec = require('cordova/exec');

var fooInAppProvisioning = {};

fooInAppProvisioning.setHostNameAndPath = function(hostName, path, success, error) {
    exec(success, error, "FooInAppProvisioningCordovaPlugin", "setHostNameAndPath", [hostName, path]);
};

fooInAppProvisioning.deviceSupportsAppleWallet = function(success, error) {
    exec(success, error, "FooInAppProvisioningCordovaPlugin", "deviceSupportsAppleWallet", []);
};

fooInAppProvisioning.getLocalPasses = function(success, error) {
    exec(success, error, "FooInAppProvisioningCordovaPlugin", "getLocalPasses", []);
};

fooInAppProvisioning.getRemotePasses = function(success, error) {
    exec(success, error, "FooInAppProvisioningCordovaPlugin", "getRemotePasses",[]);
};

fooInAppProvisioning.getLocalPassesWithCardSuffix = function(cardSuffix, success, error) {
    exec(success, error, "FooInAppProvisioningCordovaPlugin", "getLocalPassWithCardSuffix", [cardSuffix]);
};

fooInAppProvisioning.getRemotePassesWithCardSuffix = function(cardSuffix, success, error) {
    exec(success, error, "FooInAppProvisioningCordovaPlugin", "getRemotePassWithCardSuffix",[cardSuffix]);
};

fooInAppProvisioning.isCardAddedToLocalWalletWithCardSuffix = function(cardSuffix, success, error) {
    exec(success, error, "FooInAppProvisioningCordovaPlugin", "isCardAddedToLocalWalletWithCardSuffix", [cardSuffix]);
};

fooInAppProvisioning.isCardAddedToRemoteWalletWithCardSuffix = function(cardSuffix, success, error) {
    exec(success, error, "FooInAppProvisioningCordovaPlugin", "isCardAddedToRemoteWalletWithCardSuffix", [cardSuffix]);
};

fooInAppProvisioning.isCardAddedToLocalWalletWithPrimaryAccountIdentifier = function(primaryAccountIdentifier, success, error) {
    exec(success, error, "FooInAppProvisioningCordovaPlugin", "isCardAddedToLocalWalletWithPrimaryAccountIdentifier", [primaryAccountIdentifier]);
};

fooInAppProvisioning.isCardAddedToRemoteWalletWithPrimaryAccountIdentifier = function(primaryAccountIdentifier, success, error) {    
    exec(success, error, "FooInAppProvisioningCordovaPlugin", "isCardAddedToRemoteWalletWithPrimaryAccountIdentifier", [primaryAccountIdentifier]);
};

fooInAppProvisioning.addCard = function(userId, cardId, cardHolderName, cardPanSuffix, localizedDescription, pan, expiryDate, success, error) {
    exec(success, error, "FooInAppProvisioningCordovaPlugin", "addCardForUser", [userId, cardId, cardHolderName, cardPanSuffix, localizedDescription, pan, expiryDate]);
};

fooInAppProvisioning.isWatchPaired = function(success, error) {
    exec(success, error, "FooInAppProvisioningCordovaPlugin", "isWatchPaired", []);
};

fooInAppProvisioning.openWalletPassUrl = function(urlString, success, error) {
    exec(success, error, "FooInAppProvisioningCordovaPlugin", "openWalletPassUrl", [urlString]);
};

module.exports = fooInAppProvisioning;