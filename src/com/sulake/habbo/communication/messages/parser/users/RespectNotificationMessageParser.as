package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RespectNotificationMessageParser implements IMessageParser 
    {

        private var _userId:int = 0;
        private var _respectTotal:int = 0;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _userId = _arg_1.readInteger();
            _respectTotal = _arg_1.readInteger();
            return (true);
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get respectTotal():int
        {
            return (_respectTotal);
        }


    }
}