package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class HandItemReceivedMessageParser implements IMessageParser 
    {

        private var _giverUserId:int = -1;
        private var _handItemType:int = 0;


        public function get giverUserId():int
        {
            return (_giverUserId);
        }

        public function get handItemType():int
        {
            return (_handItemType);
        }

        public function flush():Boolean
        {
            _giverUserId = -1;
            _handItemType = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _giverUserId = _arg_1.readInteger();
            _handItemType = _arg_1.readInteger();
            return (true);
        }


    }
}