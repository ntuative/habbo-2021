package com.sulake.habbo.communication.messages.parser.room.chat
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FloodControlMessageParser implements IMessageParser 
    {

        private var _seconds:int = 0;


        public function get seconds():int
        {
            return (_seconds);
        }

        public function flush():Boolean
        {
            _seconds = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            _seconds = _arg_1.readInteger();
            return (true);
        }


    }
}