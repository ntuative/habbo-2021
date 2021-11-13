package com.sulake.habbo.communication
{
    public class WebApiRequest extends ApiRequest 
    {

        private var _requiresSession:Boolean;

        public function WebApiRequest(_arg_1:String, _arg_2:String, _arg_3:Boolean=true)
        {
            _requiresSession = _arg_3;
            super(_arg_2, _arg_1);
        }

        public function get requiresSession():Boolean
        {
            return (_requiresSession);
        }


    }
}