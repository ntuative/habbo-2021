package com.sulake.habbo.communication.messages.parser.room.chat
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomChatSettings;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomChatSettingsMessageParser implements IMessageParser 
    {

        private var _chatSettings:RoomChatSettings;


        public function flush():Boolean
        {
            _chatSettings = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _chatSettings = new RoomChatSettings(_arg_1);
            return (true);
        }

        public function get chatSettings():RoomChatSettings
        {
            return (_chatSettings);
        }


    }
}