package com.sulake.habbo.communication.messages.incoming.users
{
    import flash.utils.Dictionary;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuildMemberData 
    {

        private var _groupId:int;
        private var _groupName:String;
        private var _baseRoomId:int;
        private var _badgeCode:String;
        private var _totalEntries:int;
        private var _entries:Array;
        private var _allowedToManage:Boolean;
        private var _pageSize:int;
        private var _pageIndex:int;
        private var _searchType:int;
        private var _userNameFilter:String;
        private var _SafeStr_1852:Dictionary = new Dictionary();

        public function GuildMemberData(_arg_1:IMessageDataWrapper)
        {
            super();
            var _local_4:int;
            var _local_3:MemberData = null;
            _groupId = _arg_1.readInteger();
            _groupName = _arg_1.readString();
            _baseRoomId = _arg_1.readInteger();
            _badgeCode = _arg_1.readString();
            _totalEntries = _arg_1.readInteger();
            _entries = [];
            var _local_2:int = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_2)
            {
                _local_3 = new MemberData(_arg_1);
                _entries.push(_local_3);
                _SafeStr_1852[_local_3.userId] = _local_3;
                _local_4++;
            };
            _allowedToManage = _arg_1.readBoolean();
            _pageSize = _arg_1.readInteger();
            _pageIndex = _arg_1.readInteger();
            _searchType = _arg_1.readInteger();
            _userNameFilter = _arg_1.readString();
        }

        private static function removeFromArray(_arg_1:int, _arg_2:Array):void
        {
            var _local_4:int;
            var _local_3:MemberData;
            while (_local_4 < _arg_2.length)
            {
                _local_3 = _arg_2[_local_4];
                if (_local_3.userId == _arg_1)
                {
                    _arg_2.splice(_local_4, 1);
                }
                else
                {
                    _local_4++;
                };
            };
        }


        public function get groupId():int
        {
            return (_groupId);
        }

        public function get groupName():String
        {
            return (_groupName);
        }

        public function get baseRoomId():int
        {
            return (_baseRoomId);
        }

        public function get badgeCode():String
        {
            return (_badgeCode);
        }

        public function get totalEntries():int
        {
            return (_totalEntries);
        }

        public function get pageSize():int
        {
            return (_pageSize);
        }

        public function get pageIndex():int
        {
            return (_pageIndex);
        }

        public function get searchType():int
        {
            return (_searchType);
        }

        public function get entries():Array
        {
            return (_entries);
        }

        public function get allowedToManage():Boolean
        {
            return (_allowedToManage);
        }

        public function get userNameFilter():String
        {
            return (_userNameFilter);
        }

        public function get totalPages():int
        {
            return (Math.max(1, Math.ceil((_totalEntries / _pageSize))));
        }

        public function update(_arg_1:MemberData):void
        {
            var _local_3:int;
            var _local_2:MemberData;
            _SafeStr_1852[_arg_1.userId] = _arg_1;
            while (_local_3 < _entries.length)
            {
                _local_2 = _entries[_local_3];
                if (_local_2.userId == _arg_1.userId)
                {
                    _entries[_local_3] = _arg_1;
                    return;
                };
                _local_3++;
            };
            _entries.push(_arg_1);
        }

        public function remove(_arg_1:int):void
        {
            removeFromArray(_arg_1, _entries);
            delete _SafeStr_1852[_arg_1]; //not popped
        }

        public function getUser(_arg_1:int):MemberData
        {
            return (_SafeStr_1852[_arg_1]);
        }


    }
}

