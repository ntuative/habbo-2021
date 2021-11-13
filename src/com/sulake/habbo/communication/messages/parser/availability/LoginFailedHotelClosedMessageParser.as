package com.sulake.habbo.communication.messages.parser.availability
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class LoginFailedHotelClosedMessageParser implements IMessageParser 
    {

        private var _openHour:int;
        private var _openMinute:int;


        public function get openHour():int
        {
            return (_openHour);
        }

        public function get openMinute():int
        {
            return (_openMinute);
        }

        public function flush():Boolean
        {
            _openHour = 0;
            _openMinute = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _openHour = _arg_1.readInteger();
            _openMinute = _arg_1.readInteger();
            return (true);
        }


    }
}