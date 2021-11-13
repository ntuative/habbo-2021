package com.sulake.habbo.communication.messages.parser.availability
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class AvailabilityTimeMessageParser implements IMessageParser 
    {

        private var _isOpen:Boolean;
        private var _minutesUntilChange:int;


        public function get isOpen():Boolean
        {
            return (_isOpen);
        }

        public function get minutesUntilChange():int
        {
            return (_minutesUntilChange);
        }

        public function flush():Boolean
        {
            _isOpen = false;
            _minutesUntilChange = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _isOpen = (_arg_1.readInteger() > 0);
            _minutesUntilChange = _arg_1.readInteger();
            return (true);
        }


    }
}