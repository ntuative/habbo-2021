package com.sulake.habbo.communication.login
{
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;

    public /*dynamic*/ interface ILoginViewer 
    {

        function getProperty(_arg_1:String, _arg_2:Dictionary=null):String;
        function showLoginScreen():void;
        function showRegistrationError(_arg_1:Object):void;
        function showInvalidLoginError(_arg_1:Object):void;
        function nameCheckResponse(_arg_1:Object, _arg_2:Boolean):void;
        function showAccountError(_arg_1:Object):void;
        function showLoadingScreen():void;
        function saveLooksError(_arg_1:Object):void;
        function showTOS():void;
        function environmentReady():void;
        function populateCharacterList(_arg_1:Vector.<AvatarData>):void;
        function showSelectAvatar(_arg_1:Object):void;
        function showPromoHabbos(_arg_1:XML):void;
        function showSelectRoom():void;
        function showCaptchaError():void;
        function createCaptchaView():ICaptchaView;
        function captchaReady():void;

    }
}