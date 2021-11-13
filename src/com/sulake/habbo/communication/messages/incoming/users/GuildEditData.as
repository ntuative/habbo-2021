package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuildEditData implements IGuildData 
    {

        private var _ownedRooms:Array;
        private var _isOwner:Boolean;
        private var _groupId:int;
        private var _groupName:String;
        private var _groupDesc:String;
        private var _baseRoomId:int;
        private var _primaryColorId:int;
        private var _secondaryColorId:int;
        private var _locked:Boolean;
        private var _url:String;
        private var _guildType:int;
        private var _guildRightsLevel:int;
        private var _badgeSettings:Array;
        private var _badgeCode:String;
        private var _membershipCount:int;

        public function GuildEditData(_arg_1:IMessageDataWrapper)
        {
            var _local_3:int;
            var _local_2:int;
            super();
            _ownedRooms = [];
            _local_2 = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _ownedRooms.push(new RoomEntryData(_arg_1.readInteger(), _arg_1.readString(), _arg_1.readBoolean()));
                _local_3++;
            };
            _isOwner = _arg_1.readBoolean();
            _groupId = _arg_1.readInteger();
            _groupName = _arg_1.readString();
            _groupDesc = _arg_1.readString();
            _baseRoomId = _arg_1.readInteger();
            _primaryColorId = _arg_1.readInteger();
            _secondaryColorId = _arg_1.readInteger();
            _guildType = _arg_1.readInteger();
            _guildRightsLevel = _arg_1.readInteger();
            _locked = _arg_1.readBoolean();
            _url = _arg_1.readString();
            _badgeSettings = [];
            _local_2 = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _badgeSettings.push(new GuildBadgeSettings(_arg_1));
                _local_3++;
            };
            _badgeCode = _arg_1.readString();
            _membershipCount = _arg_1.readInteger();
        }

        public function get ownedRooms():Array
        {
            return (_ownedRooms);
        }

        public function get exists():Boolean
        {
            return (true);
        }

        public function get isOwner():Boolean
        {
            return (_isOwner);
        }

        public function get groupId():int
        {
            return (_groupId);
        }

        public function get groupName():String
        {
            return (_groupName);
        }

        public function get groupDesc():String
        {
            return (_groupDesc);
        }

        public function get baseRoomId():int
        {
            return (_baseRoomId);
        }

        public function get primaryColorId():int
        {
            return (_primaryColorId);
        }

        public function get secondaryColorId():int
        {
            return (_secondaryColorId);
        }

        public function get badgeSettings():Array
        {
            return (_badgeSettings);
        }

        public function get locked():Boolean
        {
            return (_locked);
        }

        public function get url():String
        {
            return (_url);
        }

        public function get guildType():int
        {
            return (_guildType);
        }

        public function get guildRightsLevel():int
        {
            return (_guildRightsLevel);
        }

        public function get badgeCode():String
        {
            return (_badgeCode);
        }

        public function get membershipCount():int
        {
            return (_membershipCount);
        }


    }
}