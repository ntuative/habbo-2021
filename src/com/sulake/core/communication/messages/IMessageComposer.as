package com.sulake.core.communication.messages
{
    public /*dynamic*/ interface IMessageComposer 
    {

        function getMessageArray():Array;
        function dispose():void;

    }
}