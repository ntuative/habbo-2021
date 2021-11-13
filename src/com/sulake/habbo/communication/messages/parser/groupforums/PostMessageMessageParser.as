package com.sulake.habbo.communication.messages.parser.groupforums
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PostMessageMessageParser implements IMessageParser 
    {

        private var _groupId:int;
        private var _threadId:int;
        private var _message:MessageData;


        public function get groupId():int
        {
            return (_groupId);
        }

        public function get threadId():int
        {
            return (_threadId);
        }

        public function get message():MessageData
        {
            return (_message);
        }

        public function flush():Boolean
        {
            _groupId = -1;
            _threadId = -1;
            _message = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _groupId = _arg_1.readInteger();
            _threadId = _arg_1.readInteger();
            _message = MessageData.readFromMessage(_arg_1);
            return (true);
        }


    }
}