package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RentableSpaceRentFailedMessageParser implements IMessageParser 
    {

        private var _reason:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _reason = _arg_1.readInteger();
            return (true);
        }

        public function get reason():int
        {
            return (_reason);
        }


    }
}