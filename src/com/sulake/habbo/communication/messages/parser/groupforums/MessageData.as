package com.sulake.habbo.communication.messages.parser.groupforums
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class MessageData 
    {

        private var _groupId:int;
        private var _messageId:int;
        private var _messageIndex:int;
        private var _authorId:int;
        private var _threadId:int;
        private var _creationTimeAsSecondsAgo:int;
        private var _messageText:String;
        private var _authorName:String;
        private var _authorFigure:String;
        private var _state:int;
        private var _adminId:int;
        private var _adminName:String;
        private var _adminOperationTimeAsSeccondsAgo:int;
        private var _authorPostCount:int;


        public static function readFromMessage(_arg_1:IMessageDataWrapper):MessageData
        {
            var _local_2:MessageData = new MessageData();
            _local_2.messageId = _arg_1.readInteger();
            _local_2.messageIndex = _arg_1.readInteger();
            _local_2.authorId = _arg_1.readInteger();
            _local_2.authorName = _arg_1.readString();
            _local_2.authorFigure = _arg_1.readString();
            _local_2.creationTimeAsSecondsAgo = _arg_1.readInteger();
            _local_2.messageText = _arg_1.readString();
            _local_2.state = _arg_1.readByte();
            _local_2.adminId = _arg_1.readInteger();
            _local_2.adminName = _arg_1.readString();
            _local_2.adminOperationTimeAsSeccondsAgo = _arg_1.readInteger();
            _local_2.authorPostCount = _arg_1.readInteger();
            return (_local_2);
        }


        public function get state():int
        {
            return (_state);
        }

        public function set state(_arg_1:int):void
        {
            _state = _arg_1;
        }

        public function get adminId():int
        {
            return (_adminId);
        }

        public function set adminId(_arg_1:int):void
        {
            _adminId = _arg_1;
        }

        public function get adminName():String
        {
            return (_adminName);
        }

        public function set adminName(_arg_1:String):void
        {
            _adminName = _arg_1;
        }

        public function get adminOperationTimeAsSeccondsAgo():int
        {
            return (_adminOperationTimeAsSeccondsAgo);
        }

        public function set adminOperationTimeAsSeccondsAgo(_arg_1:int):void
        {
            _adminOperationTimeAsSeccondsAgo = _arg_1;
        }

        public function get MessageId():int
        {
            return (_messageId);
        }

        public function set MessageId(_arg_1:int):void
        {
            _messageId = _arg_1;
        }

        public function get creationTime():int
        {
            return (_creationTimeAsSecondsAgo);
        }

        public function set creationTime(_arg_1:int):void
        {
            _creationTimeAsSecondsAgo = _arg_1;
        }

        public function get authorName():String
        {
            return (_authorName);
        }

        public function set authorName(_arg_1:String):void
        {
            _authorName = _arg_1;
        }

        public function get authorFigure():String
        {
            return (_authorFigure);
        }

        public function set authorFigure(_arg_1:String):void
        {
            _authorFigure = _arg_1;
        }

        public function get threadId():int
        {
            return (_threadId);
        }

        public function set threadId(_arg_1:int):void
        {
            _threadId = _arg_1;
        }

        public function get messageId():int
        {
            return (_messageId);
        }

        public function set messageId(_arg_1:int):void
        {
            _messageId = _arg_1;
        }

        public function get messageIndex():int
        {
            return (_messageIndex);
        }

        public function set messageIndex(_arg_1:int):void
        {
            _messageIndex = _arg_1;
        }

        public function set groupID(_arg_1:int):void
        {
            _groupId = _arg_1;
        }

        public function get groupId():int
        {
            return (_groupId);
        }

        public function get authorId():int
        {
            return (_authorId);
        }

        public function set authorId(_arg_1:int):void
        {
            _authorId = _arg_1;
        }

        public function get creationTimeAsSecondsAgo():int
        {
            return (_creationTimeAsSecondsAgo);
        }

        public function set creationTimeAsSecondsAgo(_arg_1:int):void
        {
            _creationTimeAsSecondsAgo = _arg_1;
        }

        public function get messageText():String
        {
            return (_messageText);
        }

        public function set messageText(_arg_1:String):void
        {
            _messageText = _arg_1;
        }

        public function get authorPostCount():int
        {
            return (_authorPostCount);
        }

        public function set authorPostCount(_arg_1:int):void
        {
            _authorPostCount = _arg_1;
        }


    }
}