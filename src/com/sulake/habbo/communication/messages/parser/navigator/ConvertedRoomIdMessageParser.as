package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ConvertedRoomIdMessageParser implements IMessageParser 
    {

        private var _globalId:String;
        private var _convertedId:int;


        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _globalId = _arg_1.readString();
            _convertedId = _arg_1.readInteger();
            return (true);
        }

        public function flush():Boolean
        {
            _globalId = null;
            return (true);
        }

        public function get globalId():String
        {
            return (_globalId);
        }

        public function get convertedId():int
        {
            return (_convertedId);
        }


    }
}