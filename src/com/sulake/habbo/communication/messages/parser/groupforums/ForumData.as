package com.sulake.habbo.communication.messages.parser.groupforums
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ForumData 
    {

        private var _groupId:int;
        private var _name:String;
        private var _description:String;
        private var _icon:String;
        private var _totalThreads:int;
        private var _leaderboardScore:int;
        private var _totalMessages:int;
        private var _unreadMessages:int;
        private var _lastMessageId:int;
        private var _lastMessageAuthorId:int;
        private var _lastMessageAuthorName:String;
        private var _lastMessageTimeAsSecondsAgo:int;


        public static function readFromMessage(_arg_1:IMessageDataWrapper):ForumData
        {
            return (fillFromMessage(new ForumData(), _arg_1));
        }

        internal static function fillFromMessage(_arg_1:ForumData, _arg_2:IMessageDataWrapper):ForumData
        {
            _arg_1._groupId = _arg_2.readInteger();
            _arg_1._name = _arg_2.readString();
            _arg_1._description = _arg_2.readString();
            _arg_1._icon = _arg_2.readString();
            _arg_1._totalThreads = _arg_2.readInteger();
            _arg_1._leaderboardScore = _arg_2.readInteger();
            _arg_1._totalMessages = _arg_2.readInteger();
            _arg_1._unreadMessages = _arg_2.readInteger();
            _arg_1._lastMessageId = _arg_2.readInteger();
            _arg_1._lastMessageAuthorId = _arg_2.readInteger();
            _arg_1._lastMessageAuthorName = _arg_2.readString();
            _arg_1._lastMessageTimeAsSecondsAgo = _arg_2.readInteger();
            return (_arg_1);
        }


        public function get groupId():int
        {
            return (_groupId);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get description():String
        {
            return (_description);
        }

        public function get icon():String
        {
            return (_icon);
        }

        public function get totalThreads():int
        {
            return (_totalThreads);
        }

        public function get leaderboardScore():int
        {
            return (_leaderboardScore);
        }

        public function get totalMessages():int
        {
            return (_totalMessages);
        }

        public function get unreadMessages():int
        {
            return (_unreadMessages);
        }

        public function get lastMessageId():int
        {
            return (_lastMessageId);
        }

        public function get lastMessageAuthorId():int
        {
            return (_lastMessageAuthorId);
        }

        public function get lastMessageAuthorName():String
        {
            return (_lastMessageAuthorName);
        }

        public function get lastMessageTimeAsSecondsAgo():int
        {
            return (_lastMessageTimeAsSecondsAgo);
        }

        public function updateFrom(_arg_1:ForumData):void
        {
            _totalThreads = _arg_1._totalThreads;
            _totalMessages = _arg_1._totalMessages;
            _unreadMessages = _arg_1._unreadMessages;
            _lastMessageAuthorId = _arg_1._lastMessageAuthorId;
            _lastMessageAuthorName = _arg_1._lastMessageAuthorName;
            _lastMessageId = _arg_1._lastMessageId;
            _lastMessageTimeAsSecondsAgo = _arg_1._lastMessageTimeAsSecondsAgo;
        }

        public function get lastReadMessageId():int
        {
            return (_totalMessages - _unreadMessages);
        }

        public function set lastReadMessageId(_arg_1:int):void
        {
            _unreadMessages = (_totalMessages - _arg_1);
            if (_unreadMessages < 0)
            {
                _unreadMessages = 0;
            };
        }

        public function addNewThread(_arg_1:ThreadData):void
        {
            _lastMessageAuthorId = _arg_1.lastMessageAuthorId;
            _lastMessageAuthorName = _arg_1.lastMessageAuthorName;
            _lastMessageId = _arg_1.lastMessageId;
            _lastMessageTimeAsSecondsAgo = _arg_1.lastMessageTimeAsSecondsAgo;
            _totalThreads++;
            _totalMessages++;
            _unreadMessages = 0;
        }


    }
}