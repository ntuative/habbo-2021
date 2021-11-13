package com.sulake.habbo.friendbar.groupforums
{
    import flash.utils.Dictionary;

    public class MessagesListData 
    {

        private var _threadId:int;
        private var _startIndex:int;
        private var _totalMessages:int;
        private var _messages:Array;
        private var _messagesById:Dictionary;

        public function MessagesListData(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Array):void
        {
            super();
            var _local_5:int;
            var _local_6:* = null;
            _threadId = _arg_1;
            _startIndex = _arg_3;
            _totalMessages = _arg_2;
            _messages = _arg_4;
            _messagesById = new Dictionary();
            _local_5 = 0;
            while (_local_5 < _arg_4.length)
            {
                _local_6 = _arg_4[_local_5];
                _messagesById[_local_6.messageId] = _local_6;
                _local_5++;
            };
        }

        public function get threadId():int
        {
            return (_threadId);
        }

        public function get startIndex():int
        {
            return (_startIndex);
        }

        public function get totalMessages():int
        {
            return (_totalMessages);
        }

        public function get messages():Array
        {
            return (_messages);
        }

        public function get messagesById():Dictionary
        {
            return (_messagesById);
        }

        public function get size():int
        {
            return (_messages.length);
        }


    }
}