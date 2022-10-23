var exec = require('cordova/exec');

var fooInAppProvisioning = {};

fooInAppProvisioning.setHostNameAndPath = function(hostName, path, success, error) {

    if (!hostName || !path){
        error("Host and Path can not be empty")
        return
    }

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

fooInAppProvisioning.isCardAddedToLocalWalletWithCardSuffix = function(cardSuffix, success, error) {

    if (!cardSuffix){
        error("Card suffix can not be empty")
        return
    }

    exec(success, error, "FooInAppProvisioningCordovaPlugin", "isCardAddedToLocalWalletWithCardSuffix", [cardSuffix]);
};

fooInAppProvisioning.isCardAddedToRemoteWalletWithCardSuffix = function(cardSuffix, success, error) {

    if (!cardSuffix){
        error("Card suffix can not be empty")
        return
    }

    exec(success, error, "FooInAppProvisioningCordovaPlugin", "isCardAddedToRemoteWalletWithCardSuffix", [cardSuffix]);
};

fooInAppProvisioning.isCardAddedToLocalWalletWithPrimaryAccountIdentifier = function(primaryAccountIdentifier, success, error) {

    if (!primaryAccountIdentifier){
        error("Primary Account Identifier can not be empty")
        return
    }

    exec(success, error, "FooInAppProvisioningCordovaPlugin", "isCardAddedToLocalWalletWithPrimaryAccountIdentifier", [primaryAccountIdentifier]);
};

fooInAppProvisioning.isCardAddedToRemoteWalletWithPrimaryAccountIdentifier = function(primaryAccountIdentifier, success, error) {

    if (!primaryAccountIdentifier){
        error("Primary Account Identifier can not be empty")
        return
    }

    exec(success, error, "FooInAppProvisioningCordovaPlugin", "isCardAddedToRemoteWalletWithPrimaryAccountIdentifier", [primaryAccountIdentifier]);
};

fooInAppProvisioning.addCard = function(userId, cardId, cardHolderName, localizedDescription, cardPanSuffix, pan, expiryDate, success, error) {         

    if (!userId) {
        error("User Id is missing")
        return
    }

    if (!cardId) {
        error("Card Id is missing")
        return
    }

    if (!cardHolderName) {
        error("Card Holder Name is missing")
        return
    }

    if (!cardPanSuffix) {
        error("Card Pan Suffix is missing")
        return
    }

    exec(success, error, "FooInAppProvisioningCordovaPlugin", "addCardForUser", [userId, cardId, cardHolderName, localizedDescription, cardPanSuffix, pan, expiryDate]);
};

module.exports = fooInAppProvisioning;