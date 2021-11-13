package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RentableSpaceRentOkMessageParser implements IMessageParser 
    {

        private var _expiryTime:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _expiryTime = _arg_1.readInteger();
            return (true);
        }

        public function get expiryTime():int
        {
            return (_expiryTime);
        }


    }
}