package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuildFurniContextMenuInfoMessageParser implements IMessageParser 
    {

        private var _objectId:int;
        private var _guildId:int;
        private var _guildName:String;
        private var _guildHomeRoomId:int;
        private var _userIsMember:Boolean;
        private var _guildHasReadableForum:Boolean;


        public function get objectId():int
        {
            return (_objectId);
        }

        public function get guildId():int
        {
            return (_guildId);
        }

        public function get guildName():String
        {
            return (_guildName);
        }

        public function get guildHomeRoomId():int
        {
            return (_guildHomeRoomId);
        }

        public function get userIsMember():Boolean
        {
            return (_userIsMember);
        }

        public function get guildHasReadableForum():Boolean
        {
            return (_guildHasReadableForum);
        }

        public function flush():Boolean
        {
            _objectId = -1;
            _guildId = -1;
            _guildName = "";
            _guildHomeRoomId = -1;
            _userIsMember = false;
            _guildHasReadableForum = false;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            _objectId = _arg_1.readInteger();
            _guildId = _arg_1.readInteger();
            _guildName = _arg_1.readString();
            _guildHomeRoomId = _arg_1.readInteger();
            _userIsMember = _arg_1.readBoolean();
            _guildHasReadableForum = _arg_1.readBoolean();
            return (true);
        }


    }
}