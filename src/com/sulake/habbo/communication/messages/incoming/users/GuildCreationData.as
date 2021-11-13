package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuildCreationData implements IGuildData 
    {

        private var _costInCredits:int;
        private var _ownedRooms:Array;
        private var _badgeSettings:Array;

        public function GuildCreationData(_arg_1:IMessageDataWrapper)
        {
            var _local_3:int;
            var _local_2:int;
            super();
            _costInCredits = _arg_1.readInteger();
            _ownedRooms = [];
            _local_2 = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _ownedRooms.push(new RoomEntryData(_arg_1.readInteger(), _arg_1.readString(), _arg_1.readBoolean()));
                _local_3++;
            };
            _local_2 = _arg_1.readInteger();
            _badgeSettings = [];
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _badgeSettings.push(new GuildBadgeSettings(_arg_1));
                _local_3++;
            };
        }

        public function get costInCredits():int
        {
            return (_costInCredits);
        }

        public function get ownedRooms():Array
        {
            return (_ownedRooms);
        }

        public function get exists():Boolean
        {
            return (false);
        }

        public function get isOwner():Boolean
        {
            return (true);
        }

        public function get groupId():int
        {
            return (0);
        }

        public function get groupName():String
        {
            return ("");
        }

        public function get groupDesc():String
        {
            return ("");
        }

        public function get baseRoomId():int
        {
            return (0);
        }

        public function get primaryColorId():int
        {
            return (0);
        }

        public function get secondaryColorId():int
        {
            return (0);
        }

        public function get badgeSettings():Array
        {
            return (_badgeSettings);
        }

        public function get locked():Boolean
        {
            return (false);
        }

        public function get url():String
        {
            return ("");
        }

        public function get guildType():int
        {
            return (0);
        }

        public function get guildRightsLevel():int
        {
            return (0);
        }

        public function get badgeCode():String
        {
            return ("");
        }

        public function get membershipCount():int
        {
            return (0);
        }


    }
}