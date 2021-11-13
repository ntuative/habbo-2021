package com.sulake.habbo.communication
{
    public /*dynamic*/ interface IHabboWebApiListener 
    {

        function get disposed():Boolean;
        function habboWebApiResponse(_arg_1:String, _arg_2:Object):void;
        function habboWebApiRawResponse(_arg_1:String, _arg_2:Object):void;
        function habboWebApiError(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:Object, _arg_5:Boolean=false):void;

    }
}