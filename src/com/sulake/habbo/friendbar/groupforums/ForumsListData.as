package com.sulake.habbo.friendbar.groupforums
{
    import com.sulake.habbo.communication.messages.parser.groupforums.GetForumsListMessageParser;
    import com.sulake.habbo.communication.messages.parser.groupforums.ForumData;

    public class ForumsListData 
    {

        private var _listCode:int;
        private var _totalAmount:int;
        private var _startIndex:int;
        private var _forums:Array;

        public function ForumsListData(_arg_1:GetForumsListMessageParser)
        {
            _listCode = _arg_1.listCode;
            _totalAmount = _arg_1.totalAmount;
            _startIndex = _arg_1.startIndex;
            _forums = _arg_1.forums;
        }

        public function get listCode():int
        {
            return (_listCode);
        }

        public function get totalAmount():int
        {
            return (_totalAmount);
        }

        public function get startIndex():int
        {
            return (_startIndex);
        }

        public function get forums():Array
        {
            return (_forums);
        }

        public function get unreadForumsCount():int
        {
            var _local_3:int;
            var _local_1:ForumData;
            var _local_2:int;
            _local_3 = 0;
            while (_local_3 < _forums.length)
            {
                _local_1 = _forums[_local_3];
                if (_local_1.unreadMessages > 0)
                {
                    _local_2++;
                };
                _local_3++;
            };
            return (_local_2);
        }

        public function getForumData(_arg_1:int):ForumData
        {
            for each (var _local_2:ForumData in _forums)
            {
                if (_local_2.groupId == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function updateUnreadMessages(_arg_1:ForumData, _arg_2:int):void
        {
            var _local_3:ForumData = getForumData(_arg_1.groupId);
            if (_local_3 != null)
            {
                _local_3.updateFrom(_arg_1);
                _local_3.lastReadMessageId = _arg_2;
            };
        }


    }
}