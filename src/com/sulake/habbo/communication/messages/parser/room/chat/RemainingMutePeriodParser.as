package com.sulake.habbo.communication.messages.parser.room.chat
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RemainingMutePeriodParser implements IMessageParser 
    {

        private var _secondsRemaining:int = 0;


        public function get secondsRemaining():int
        {
            return (_secondsRemaining);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _secondsRemaining = _arg_1.readInteger();
            return (true);
        }


    }
}