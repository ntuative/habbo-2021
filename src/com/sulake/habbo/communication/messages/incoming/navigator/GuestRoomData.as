package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuestRoomData implements IDisposable 
    {

        private const _SafeStr_1799:int = 1;
        private const _SafeStr_1800:int = 2;
        private const _SafeStr_1801:int = 4;
        private const _SafeStr_1802:int = 8;
        private const _SafeStr_1803:int = 16;
        private const _SafeStr_1804:int = 32;

        private var _flatId:int;
        private var _roomName:String;
        private var _showOwner:Boolean;
        private var _ownerId:int;
        private var _ownerName:String;
        private var _doorMode:int;
        private var _userCount:int;
        private var _maxUserCount:int;
        private var _description:String;
        private var _tradeMode:int;
        private var _score:int;
        private var _ranking:int;
        private var _categoryId:int;
        private var _SafeStr_1805:int;
        private var _habboGroupId:int = 0;
        private var _groupName:String = "";
        private var _groupBadgeCode:String = "";
        private var _tags:Array = [];
        private var _thumbnail:RoomThumbnailData;
        private var _allowPets:Boolean;
        private var _displayRoomEntryAd:Boolean;
        private var _roomAdName:String = "";
        private var _roomAdDescription:String = "";
        private var _roomAdExpiresInMin:int = 0;
        private var _allInRoomMuted:Boolean;
        private var _canMute:Boolean;
        private var _disposed:Boolean;
        private var _officialRoomPicRef:String = null;

        public function GuestRoomData(_arg_1:IMessageDataWrapper)
        {
            super();
            var _local_4:int;
            var _local_5:String = null;
            _flatId = _arg_1.readInteger();
            _roomName = _arg_1.readString();
            _ownerId = _arg_1.readInteger();
            _ownerName = _arg_1.readString();
            _doorMode = _arg_1.readInteger();
            _userCount = _arg_1.readInteger();
            _maxUserCount = _arg_1.readInteger();
            _description = _arg_1.readString();
            _tradeMode = _arg_1.readInteger();
            _score = _arg_1.readInteger();
            _ranking = _arg_1.readInteger();
            _categoryId = _arg_1.readInteger();
            var _local_3:int = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_5 = _arg_1.readString();
                _tags.push(_local_5);
                _local_4++;
            };
            var _local_2:int = _arg_1.readInteger();
            if ((_local_2 & 0x01) > 0)
            {
                _officialRoomPicRef = _arg_1.readString();
            };
            if ((_local_2 & 0x02) > 0)
            {
                _habboGroupId = _arg_1.readInteger();
                _groupName = _arg_1.readString();
                _groupBadgeCode = _arg_1.readString();
            };
            if ((_local_2 & 0x04) > 0)
            {
                _roomAdName = _arg_1.readString();
                _roomAdDescription = _arg_1.readString();
                _roomAdExpiresInMin = _arg_1.readInteger();
            };
            _showOwner = ((_local_2 & 0x08) > 0);
            _allowPets = ((_local_2 & 0x10) > 0);
            _displayRoomEntryAd = ((_local_2 & 0x20) > 0);
            _thumbnail = new RoomThumbnailData(null);
            _thumbnail.setDefaults();
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _disposed = true;
            this._tags = null;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get flatId():int
        {
            return (_flatId);
        }

        public function get roomName():String
        {
            return (_roomName);
        }

        public function get showOwner():Boolean
        {
            return (_showOwner);
        }

        public function get ownerId():int
        {
            return (_ownerId);
        }

        public function get ownerName():String
        {
            return (_ownerName);
        }

        public function get doorMode():int
        {
            return (_doorMode);
        }

        public function get userCount():int
        {
            return (_userCount);
        }

        public function get maxUserCount():int
        {
            return (_maxUserCount);
        }

        public function get description():String
        {
            return (_description);
        }

        public function get tradeMode():int
        {
            return (_tradeMode);
        }

        public function get score():int
        {
            return (_score);
        }

        public function get ranking():int
        {
            return (_ranking);
        }

        public function get categoryId():int
        {
            return (_categoryId);
        }

        public function get habboGroupId():int
        {
            return (_habboGroupId);
        }

        public function get groupName():String
        {
            return (_groupName);
        }

        public function get groupBadgeCode():String
        {
            return (_groupBadgeCode);
        }

        public function get tags():Array
        {
            return (_tags);
        }

        public function get thumbnail():RoomThumbnailData
        {
            return (_thumbnail);
        }

        public function get allowPets():Boolean
        {
            return (_allowPets);
        }

        public function get displayRoomEntryAd():Boolean
        {
            return (_displayRoomEntryAd);
        }

        public function get roomAdName():String
        {
            return (_roomAdName);
        }

        public function get roomAdDescription():String
        {
            return (_roomAdDescription);
        }

        public function get roomAdExpiresInMin():int
        {
            return (_roomAdExpiresInMin);
        }

        public function get allInRoomMuted():Boolean
        {
            return (_allInRoomMuted);
        }

        public function get officialRoomPicRef():String
        {
            return (_officialRoomPicRef);
        }

        public function set allInRoomMuted(_arg_1:Boolean):void
        {
            _allInRoomMuted = _arg_1;
        }

        public function set roomName(_arg_1:String):void
        {
            _roomName = _arg_1;
        }

        public function get canMute():Boolean
        {
            return (_canMute);
        }

        public function set canMute(_arg_1:Boolean):void
        {
            _canMute = _arg_1;
        }


    }
}

