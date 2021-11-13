package com.sulake.core.communication.connection
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public /*dynamic*/ interface IConnectionStateListener 
    {

        function connectionInit(_arg_1:String, _arg_2:int):void;
        function messageReceived(_arg_1:String):void;
        function messageSent(_arg_1:String):void;
        function messageParseError(_arg_1:IMessageDataWrapper):void;

    }
}