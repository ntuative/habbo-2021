package com.sulake.habbo.communication.messages.parser.groupforums
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ThreadMessagesMessageParser implements IMessageParser 
    {

        private var _groupId:int;
        private var _threadId:int;
        private var _startIndex:int;
        private var _amount:int;
        private var _messages:Array;


        public function get groupId():int
        {
            return (_groupId);
        }

        public function get threadId():int
        {
            return (_threadId);
        }

        public function get startIndex():int
        {
            return (_startIndex);
        }

        public function get amount():int
        {
            return (_amount);
        }

        public function get messages():Array
        {
            return (_messages);
        }

        public function flush():Boolean
        {
            _groupId = -1;
            _threadId = -1;
            _startIndex = -1;
            _amount = -1;
            _messages = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            var _local_3:MessageData;
            _groupId = _arg_1.readInteger();
            _threadId = _arg_1.readInteger();
            _startIndex = _arg_1.readInteger();
            _amount = _arg_1.readInteger();
            _local_2 = 0;
            while (_local_2 < _amount)
            {
                _local_3 = MessageData.readFromMessage(_arg_1);
                _local_3.groupID = _groupId;
                _local_3.threadId = _threadId;
                _messages.push(_local_3);
                _local_2++;
            };
            return (true);
        }


    }
}