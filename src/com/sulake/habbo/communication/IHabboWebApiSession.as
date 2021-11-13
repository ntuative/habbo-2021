package com.sulake.habbo.communication
{
    import com.sulake.core.runtime.IDisposable;

    public /*dynamic*/ interface IHabboWebApiSession extends IDisposable 
    {

        function addListener(_arg_1:IHabboWebApiListener):Boolean;
        function removeListener(_arg_1:IHabboWebApiListener):void;
        function setCaptchaToken(_arg_1:String):Boolean;
        [HabboWebApiRoute(uri="/api/force/email-change", method="POST")]
        function emailChange(_arg_1:String):void;
        [HabboWebApiRoute(uri="/api/force/password-change", method="POST")]
        function passwordChange(_arg_1:String):void;
        [HabboWebApiRoute(uri="/api/force/tos-accept", method="POST")]
        function tosAccept():void;
        [HabboWebApiRoute(uri="/api/public/captcha", method="GET")]
        function captcha():void;
        [HabboWebApiRoute(uri="/api/public/achievements", method="GET")]
        function achievements():void;
        [HabboWebApiRoute(uri="/api/public/achievements/:id", method="GET")]
        function achievementsForId(_arg_1:int):void;
        [HabboWebApiRoute(uri="/api/public/registration/activate", method="POST")]
        function activate(_arg_1:String):void;
        [HabboWebApiRoute(uri="/api/public/authentication/login", method="POST")]
        function login(_arg_1:String, _arg_2:String):void;
        [HabboWebApiRoute(uri="/api/public/authentication/facebook", method="POST")]
        function facebook(_arg_1:String):void;
        [HabboWebApiRoute(uri="/api/public/authentication/rpx", method="POST")]
        function rpx(_arg_1:String):void;
        [HabboWebApiRoute(uri="/api/public/authentication/logout", method="POST")]
        function logout():void;
        [HabboWebApiRoute(uri="/api/public/authentication/user", method="GET")]
        function authenticateUser():void;
        [HabboWebApiRoute(uri="/api/public/forgotPassword/send", method="POST")]
        function forgotPassword(_arg_1:String):void;
        [HabboWebApiRoute(uri="/api/public/forgotPassword/changePassword", method="POST")]
        function changePassword(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String):void;
        [HabboWebApiRoute(uri="/api/public/groups/:id", method="GET")]
        function groups(_arg_1:int):void;
        [HabboWebApiRoute(uri="/api/public/groups/:id/members", method="GET")]
        function members(_arg_1:int):void;
        [HabboWebApiRoute(uri="/api/public/info/hello", method="GET")]
        function hello():void;
        [HabboWebApiRoute(uri="/api/public/info/time", method="GET")]
        function time():void;
        [HabboWebApiRoute(uri="/api/public/registration/new", method="POST")]
        function register(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Boolean, _arg_7:String):void;
        [HabboWebApiRoute(uri="/api/public/rooms/popular", method="GET")]
        function popularRooms():void;
        [HabboWebApiRoute(uri="/api/public/rooms/:roomId", method="GET")]
        function room(_arg_1:int):void;
        [HabboWebApiRoute(uri="/api/public/lists/hotlooks", method="GET")]
        function hotlooks():void;
        [HabboWebApiRoute(uri="/api/log/crash", method="POST")]
        function logCrash(_arg_1:String):void;
        [HabboWebApiRoute(uri="/api/log/error", method="POST")]
        function logError(_arg_1:String):void;
        [HabboWebApiRoute(uri="/api/log/loginstep", method="POST")]
        function logLoginStep(_arg_1:String, _arg_2:String):void;
        [HabboWebApiRoute(uri="/api/client/clienturl", method="GET")]
        function clientUrl():void;
        [HabboWebApiRoute(uri="/api/newuser/name/check", method="POST")]
        function nameCheck(_arg_1:String):void;
        [HabboWebApiRoute(uri="/api/newuser/name/select", method="POST")]
        function selectUser(_arg_1:String):void;
        [HabboWebApiRoute(uri="/api/newuser/room/select", method="POST")]
        function selectRoom(_arg_1:int):void;
        [HabboWebApiRoute(uri="/api/safetylock/featureStatus", method="GET")]
        function safetyLockStatus():void;
        [HabboWebApiRoute(uri="/api/safetylock/disable", method="GET")]
        function safetyLockDisable():void;
        [HabboWebApiRoute(uri="/api/safetylock/resetTrustedLogins", method="GET")]
        function resetTrustedLogins():void;
        [HabboWebApiRoute(uri="/api/safetylock/save", method="POST")]
        function safetyLockSave(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:String):void;
        [HabboWebApiRoute(uri="/api/safetylock/questions", method="GET")]
        function safetyLockQuestions():void;
        [HabboWebApiRoute(uri="/api/safetylock/unlock", method="POST")]
        function safetyLockUnlock(_arg_1:String, _arg_2:String, _arg_3:Boolean):void;
        [HabboWebApiRoute(uri="/api/user/:id/common_friends", method="GET")]
        function commonFriends(_arg_1:int):void;
        [HabboWebApiRoute(uri="/api/user/preferences", method="GET")]
        function preferences():void;
        [HabboWebApiRoute(uri="/api/user/self", method="GET")]
        function self():void;
        [HabboWebApiRoute(uri="/api/user/ping", method="GET")]
        function ping():void;
        [HabboWebApiRoute(uri="/api/user/preferences/save", method="POST")]
        function saveUser():void;
        [HabboWebApiRoute(uri="/api/user/preferences/save/visibility", method="POST")]
        function saveVisibility(_arg_1:Boolean):void;
        [HabboWebApiRoute(uri="/api/user/campaign_messages", method="GET")]
        function campaignMessages():void;
        [HabboWebApiRoute(uri="/api/user/campaign_messages/all", method="GET")]
        function campaignMessagesAll():void;
        [HabboWebApiRoute(uri="/api/user/campaign_messages/seen", method="GET")]
        function campaignMessagesSeen():void;
        [HabboWebApiRoute(uri="/api/user/discussions", method="GET")]
        function discussions():void;
        [HabboWebApiRoute(uri="/api/user/credit_balance", method="GET")]
        function creditBalance():void;
        [HabboWebApiRoute(uri="/api/user/friendrequests/sent", method="GET")]
        function friendRequestsSent():void;
        [HabboWebApiRoute(uri="/api/user/friendrequests/received", method="GET")]
        function friendRequestsReceived():void;
        [HabboWebApiRoute(uri="/api/user/look/save", method="POST")]
        function saveLooks(_arg_1:String, _arg_2:String):void;
        [HabboWebApiRoute(uri="/api/user/avatars", method="GET")]
        function avatars():void;
        [HabboWebApiRoute(uri="/api/user/avatars/select", method="POST")]
        function selectAvatar(_arg_1:String):void;
        [HabboWebApiRoute(uri="/api/user/email/change", method="POST")]
        function changeEmail(_arg_1:String, _arg_2:String):void;
        [HabboWebApiRoute(uri="/api/user/avatars", method="POST")]
        function createAvatar(_arg_1:String):void;
        [HabboWebApiRoute(uri="/api/user/profile", method="GET")]
        function profile():void;
        [HabboWebApiRoute(uri="/api/ssotoken", method="GET")]
        function ssoToken():void;
        [HabboWebApiRoute(uri="/shopapi/iap/itunes/validate", method="POST")]
        function validateItunesIAP(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:String):void;
        [HabboWebApiRoute(uri="/shopapi/iap/playstore/validate", method="POST")]
        function validatePlaystoreIAP(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:String, _arg_5:String):void;
        [HabboWebApiRoute(uri="/api/pushwoosh/devicetoken", method="POST")]
        function setDeviceToken(_arg_1:String):void;
        function getDeviceToken():String;

    }
}