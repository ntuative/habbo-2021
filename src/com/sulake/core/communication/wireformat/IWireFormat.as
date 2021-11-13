package com.sulake.core.communication.wireformat
{
    import flash.utils.ByteArray;
    import com.sulake.core.communication.connection.IConnection;

        public /*dynamic*/ interface IWireFormat 
    {

        function dispose():void;
        function encode(_arg_1:int, _arg_2:Array):ByteArray;
        function splitMessages(_arg_1:ByteArray, _arg_2:IConnection):Array;

    }
}