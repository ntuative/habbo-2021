package com.sulake.habbo.communication
{
    public /*dynamic*/ interface IApiListener 
    {

        function apiResponse(_arg_1:String, _arg_2:Object):void;
        function apiRawResponse(_arg_1:String, _arg_2:Object):void;
        function apiError(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:Object, _arg_5:Boolean=false):void;

    }
}