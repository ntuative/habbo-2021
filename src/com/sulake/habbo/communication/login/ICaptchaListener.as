package com.sulake.habbo.communication.login
{
    import flash.utils.Dictionary;

    public /*dynamic*/ interface ICaptchaListener 
    {

        function handleCaptchaError():void;
        function handleCaptchaResult(_arg_1:String):void;
        function getProperty(_arg_1:String, _arg_2:Dictionary=null):String;

    }
}