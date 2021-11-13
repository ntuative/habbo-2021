package com.sulake.habbo.communication.messages.parser.groupforums
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PostThreadMessageParser implements IMessageParser 
    {

        private var _groupId:int;
        private var _thread:ThreadData;


        public function get groupId():int
        {
            return (_groupId);
        }

        public function get thread():ThreadData
        {
            return (_thread);
        }

        public function flush():Boolean
        {
            _groupId = -1;
            _thread = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _groupId = _arg_1.readInteger();
            _thread = ThreadData.readFromMessage(_arg_1);
            return (true);
        }


    }
}