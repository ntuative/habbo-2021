package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CustomUserNotificationMessageParser implements IMessageParser 
    {

        private var _code:int = 0;


        public function get code():int
        {
            return (_code);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            _code = _arg_1.readInteger();
            return (true);
        }


    }
}