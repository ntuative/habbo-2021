package com.sulake.habbo.communication.login
{
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.communication.IHabboCommunicationManager;

    public /*dynamic*/ interface ILoginProvider extends IEventDispatcher 
    {

        function closeCaptcha():void;
        function init(_arg_1:IHabboCommunicationManager):void;
        function loginWithCredentials(_arg_1:String, _arg_2:String, _arg_3:int=0):void;
        function loginWithCredentialsWeb(_arg_1:String):void;
        function selectAvatar(_arg_1:int):void;
        function selectAvatarUniqueid(_arg_1:String):void;

    }
}