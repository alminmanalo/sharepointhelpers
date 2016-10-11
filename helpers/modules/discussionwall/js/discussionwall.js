// $(document).ready(function () {
//     SP.SOD.executeFunc('sp.js', 'SP.ClientContext', LoadCurrentUser);
// });

// function LoadCurrentUser() {
//     var context = SP.ClientContext.get_current();
//     var siteColl = context.get_site();
//     var web = siteColl.get_rootWeb();
//     this._currentUser = web.get_currentUser(); 
//     context.load(this._currentUser);
//     context.executeQueryAsync(Function.createDelegate(this, GetCurrentUserProperties), Function.createDelegate(this, LoadUserfailed));
// }

// function LoadUserfailed() {
//     alert('failed');
// }

// function GetCurrentUserProperties() {
//     var loginName = this._currentUser.get_loginName();
//     var email = this._currentUser.get_email();
//     var userid = this._currentUser.get_id();
//     var username = this._currentUser.get_title();

//     console.log(this._currentUser);
// }

// $(document).ready(function () {
//     SP.SOD.executeOrDelayUntilScriptLoaded(loadUserData, 'SP.UserProfiles.js');
// });

// var userProfileProperties;

// function loadUserData() {
//     console.log('hello');
//     var clientContext = new SP.ClientContext.get_current();
//     var peopleManager = new SP.UserProfiles.PeopleManager(clientContext);
//     userProfileProperties = peopleManager.getMyProperties()

//     clientContext.load(userProfileProperties);
//     clientContext.executeQueryAsync(onSuccess);
// }

// function onSuccess() {
//     var userProfilePic = userProfileProperties[1];
// }

var _currentWebUrl = _spPageContextInfo.webAbsoluteUrl;
var _currentSiteUrl = _spPageContextInfo.siteAbsoluteUrl;

$(document).ready(function () {
    alert('hello world');

    //richtext editor plugin initialize
    $('.trumbowygContainer').trumbowyg({
        svgPath: _currentWebUrl + '/discussionCatalog/css/libraries/icons.svg',
        btns: [
            ['bold', 'italic'],
            ['link'],
            ['insertImage'],
            ['formatting']
        ]
    });

    jQuery.getJSON(_currentSiteUrl + "/_api/SP.UserProfiles.PeopleManager/GetMyProperties/PictureUrl", function (data) {
        $('.currentUserProfile').prepend('<img alt="Current User" src="' + data.value.toLowerCase().replace('mthumb', 'sthumb') + '" />');
    });
});