package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class MiniMailUnreadCountMessageParser implements IMessageParser 
    {

        private var _unreadMessageCount:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _unreadMessageCount = _arg_1.readInteger();
            return (true);
        }

        public function get unreadMessageCount():int
        {
            return (_unreadMessageCount);
        }


    }
}