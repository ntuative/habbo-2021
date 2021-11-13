package com.sulake.habbo.communication.messages.parser.groupforums
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ForumThreadsMessageParser implements IMessageParser 
    {

        private var _groupId:int;
        private var _startIndex:int;
        private var _amount:int;
        private var _threads:Array;


        public function get groupId():int
        {
            return (_groupId);
        }

        public function get startIndex():int
        {
            return (_startIndex);
        }

        public function get amount():int
        {
            return (_amount);
        }

        public function get threads():Array
        {
            return (_threads);
        }

        public function flush():Boolean
        {
            _groupId = -1;
            _startIndex = -1;
            _amount = -1;
            _threads = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            _groupId = _arg_1.readInteger();
            _startIndex = _arg_1.readInteger();
            _amount = _arg_1.readInteger();
            _local_2 = 0;
            while (_local_2 < amount)
            {
                _threads.push(ThreadData.readFromMessage(_arg_1));
                _local_2++;
            };
            return (true);
        }


    }
}