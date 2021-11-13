package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class HabboActivityPointNotificationMessageParser implements IMessageParser 
    {

        private var _amount:int = 0;
        private var _change:int = 0;
        private var _type:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _amount = _arg_1.readInteger();
            _change = _arg_1.readInteger();
            _type = _arg_1.readInteger();
            return (true);
        }

        public function get amount():int
        {
            return (_amount);
        }

        public function get change():int
        {
            return (_change);
        }

        public function get type():int
        {
            return (_type);
        }


    }
}