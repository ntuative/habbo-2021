package com.sulake.habbo.communication.messages.parser.availability
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class InfoHotelClosingMessageParser implements IMessageParser 
    {

        private var _minutesUntilClosing:int;


        public function get minutesUntilClosing():int
        {
            return (_minutesUntilClosing);
        }

        public function flush():Boolean
        {
            _minutesUntilClosing = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _minutesUntilClosing = _arg_1.readInteger();
            return (true);
        }


    }
}