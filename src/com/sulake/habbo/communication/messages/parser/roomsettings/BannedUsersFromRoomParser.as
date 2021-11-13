package com.sulake.habbo.communication.messages.parser.roomsettings
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.BannedUserData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class BannedUsersFromRoomParser implements IMessageParser 
    {

        private var _roomId:int;
        private var _bannedUsers:Array;


        public function flush():Boolean
        {
            _bannedUsers = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _roomId = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _bannedUsers.push(new BannedUserData(_arg_1));
                _local_3++;
            };
            return (true);
        }

        public function get roomId():int
        {
            return (_roomId);
        }

        public function get bannedUsers():Array
        {
            return (_bannedUsers);
        }


    }
}