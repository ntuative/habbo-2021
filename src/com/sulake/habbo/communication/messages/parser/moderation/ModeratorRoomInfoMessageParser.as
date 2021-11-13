package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomModerationData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ModeratorRoomInfoMessageParser implements IMessageParser 
    {

        private var _data:RoomModerationData;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _data = new RoomModerationData(_arg_1);
            return (true);
        }

        public function get data():RoomModerationData
        {
            return (_data);
        }


    }
}