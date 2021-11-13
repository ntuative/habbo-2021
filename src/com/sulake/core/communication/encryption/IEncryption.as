package com.sulake.core.communication.encryption
{
    import flash.utils.ByteArray;

    public /*dynamic*/ interface IEncryption 
    {

        function init(_arg_1:ByteArray):void;
        function encipher(_arg_1:ByteArray):void;
        function decipher(_arg_1:ByteArray):void;
        function mark():void;
        function reset():void;

    }
}