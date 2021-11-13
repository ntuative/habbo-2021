package com.sulake.habbo.communication.messages.parser.groupforums
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class UnreadForumsCountMessageParser implements IMessageParser 
    {

        private var _unreadForumsCount:int;


        public function get unreadForumsCount():int
        {
            return (_unreadForumsCount);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _unreadForumsCount = _arg_1.readInteger();
            return (true);
        }


    }
}