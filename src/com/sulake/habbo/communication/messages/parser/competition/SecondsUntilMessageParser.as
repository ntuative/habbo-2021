package com.sulake.habbo.communication.messages.parser.competition
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class SecondsUntilMessageParser implements IMessageParser 
    {

        private var _timeStr:String;
        private var _secondsUntil:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _timeStr = _arg_1.readString();
            _secondsUntil = _arg_1.readInteger();
            return (true);
        }

        public function get timeStr():String
        {
            return (_timeStr);
        }

        public function get secondsUntil():int
        {
            return (_secondsUntil);
        }


    }
}