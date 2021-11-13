package com.sulake.habbo.communication.login
{
    import flash.events.Event;

    public class SsoTokenAvailableEvent extends Event 
    {

        public static const SSO_TOKEN_AVAILABLE:String = "SSO_TOKEN_AVAILABLE";

        private var _ssoToken:String;

        public function SsoTokenAvailableEvent(_arg_1:String, _arg_2:String, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            _ssoToken = _arg_2;
        }

        public function get ssoToken():String
        {
            return (_ssoToken);
        }


    }
}