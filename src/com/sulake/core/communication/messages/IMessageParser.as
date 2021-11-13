package com.sulake.core.communication.messages
{
    public /*dynamic*/ interface IMessageParser 
    {

        function flush():Boolean;
        function parse(_arg_1:IMessageDataWrapper):Boolean;

    }
}