package com.sulake.habbo.communication.messages.parser.room.chat
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class UserTypingMessageParser implements IMessageParser 
    {

        private var _userId:int = 0;
        private var _isTyping:Boolean = false;


        public function get userId():int
        {
            return (_userId);
        }

        public function get isTyping():Boolean
        {
            return (_isTyping);
        }

        public function flush():Boolean
        {
            _userId = 0;
            _isTyping = false;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            _userId = _arg_1.readInteger();
            _isTyping = (_arg_1.readInteger() == 1);
            return (true);
        }


    }
}