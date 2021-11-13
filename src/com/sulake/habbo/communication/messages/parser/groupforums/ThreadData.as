package com.sulake.habbo.communication.messages.parser.groupforums
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ThreadData 
    {

        private var _threadId:int;
        private var _threadAuthorId:int;
        private var _threadAuthorName:String;
        private var _creationTimeAsSecondsAgo:int;
        private var _header:String;
        private var _nMessages:int;
        private var _nUnreadMessages:int;
        private var _lastMessageId:int;
        private var _lastMessageAuthorId:int;
        private var _lastMessageAuthorName:String;
        private var _lastMessageTimeAsSecondsAgo:int;
        private var _state:int;
        private var _adminId:int;
        private var _adminName:String;
        private var _adminOperationTimeAsSecondsAgo:int;
        private var _isSticky:Boolean;
        private var _isLocked:Boolean;


        public static function readFromMessage(_arg_1:IMessageDataWrapper):ThreadData
        {
            var _local_2:ThreadData = new ThreadData();
            _local_2.threadId = _arg_1.readInteger();
            _local_2.threadAuthorId = _arg_1.readInteger();
            _local_2.threadAuthorName = _arg_1.readString();
            _local_2.header = _arg_1.readString();
            _local_2.isSticky = _arg_1.readBoolean();
            _local_2.isLocked = _arg_1.readBoolean();
            _local_2.creationTimeAsSecondsAgo = _arg_1.readInteger();
            _local_2.nMessages = _arg_1.readInteger();
            _local_2.nUnreadMessages = _arg_1.readInteger();
            _local_2.lastMessageId = _arg_1.readInteger();
            _local_2.lastMessageAuthorId = _arg_1.readInteger();
            _local_2.lastMessageAuthorName = _arg_1.readString();
            _local_2.lastMessageTimeAsSecondsAgo = _arg_1.readInteger();
            _local_2.state = _arg_1.readByte();
            _local_2.adminId = _arg_1.readInteger();
            _local_2.adminName = _arg_1.readString();
            _local_2.adminOperationTimeAsSecondsAgo = _arg_1.readInteger();
            return (_local_2);
        }


        public function get adminOperationTimeAsSecondsAgo():int
        {
            return (_adminOperationTimeAsSecondsAgo);
        }

        public function set adminOperationTimeAsSecondsAgo(_arg_1:int):void
        {
            _adminOperationTimeAsSecondsAgo = _arg_1;
        }

        public function get lastMessageTimeAsSecondsAgo():int
        {
            return (_lastMessageTimeAsSecondsAgo);
        }

        public function set lastMessageTimeAsSecondsAgo(_arg_1:int):void
        {
            _lastMessageTimeAsSecondsAgo = _arg_1;
        }

        public function get threadId():int
        {
            return (_threadId);
        }

        public function set threadId(_arg_1:int):void
        {
            _threadId = _arg_1;
        }

        public function get threadAuthorId():int
        {
            return (_threadAuthorId);
        }

        public function set threadAuthorId(_arg_1:int):void
        {
            _threadAuthorId = _arg_1;
        }

        public function get threadAuthorName():String
        {
            return (_threadAuthorName);
        }

        public function set threadAuthorName(_arg_1:String):void
        {
            _threadAuthorName = _arg_1;
        }

        public function get creationTimeAsSecondsAgo():int
        {
            return (_creationTimeAsSecondsAgo);
        }

        public function set creationTimeAsSecondsAgo(_arg_1:int):void
        {
            _creationTimeAsSecondsAgo = _arg_1;
        }

        public function get header():String
        {
            return (_header);
        }

        public function set header(_arg_1:String):void
        {
            _header = _arg_1;
        }

        public function get lastMessageId():int
        {
            return (_lastMessageId);
        }

        public function set lastMessageId(_arg_1:int):void
        {
            _lastMessageId = _arg_1;
        }

        public function get lastMessageAuthorId():int
        {
            return (_lastMessageAuthorId);
        }

        public function set lastMessageAuthorId(_arg_1:int):void
        {
            _lastMessageAuthorId = _arg_1;
        }

        public function get lastMessageAuthorName():String
        {
            return (_lastMessageAuthorName);
        }

        public function set lastMessageAuthorName(_arg_1:String):void
        {
            _lastMessageAuthorName = _arg_1;
        }

        public function get nMessages():int
        {
            return (_nMessages);
        }

        public function set nMessages(_arg_1:int):void
        {
            _nMessages = _arg_1;
        }

        public function get nUnreadMessages():int
        {
            return (_nUnreadMessages);
        }

        public function set nUnreadMessages(_arg_1:int):void
        {
            _nUnreadMessages = _arg_1;
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

        public function get isSticky():Boolean
        {
            return (_isSticky);
        }

        public function set isSticky(_arg_1:Boolean):void
        {
            _isSticky = _arg_1;
        }

        public function get isLocked():Boolean
        {
            return (_isLocked);
        }

        public function set isLocked(_arg_1:Boolean):void
        {
            _isLocked = _arg_1;
        }


    }
}