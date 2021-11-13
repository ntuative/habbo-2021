package com.sulake.habbo.communication.messages.parser.availability
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class InfoHotelClosedMessageParser implements IMessageParser 
    {

        private var _openHour:int;
        private var _openMinute:int;
        private var _userThrownOutAtClose:Boolean;


        public function get openHour():int
        {
            return (_openHour);
        }

        public function get openMinute():int
        {
            return (_openMinute);
        }

        public function get userThrownOutAtClose():Boolean
        {
            return (_userThrownOutAtClose);
        }

        public function flush():Boolean
        {
            _openHour = 0;
            _openMinute = 0;
            _userThrownOutAtClose = false;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _openHour = _arg_1.readInteger();
            _openMinute = _arg_1.readInteger();
            _userThrownOutAtClose = _arg_1.readBoolean();
            return (true);
        }


    }
}