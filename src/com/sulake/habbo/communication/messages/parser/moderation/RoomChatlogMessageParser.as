package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.moderation.ChatRecordData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomChatlogMessageParser implements IMessageParser 
    {

        private var _data:ChatRecordData;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _data = new ChatRecordData(_arg_1);
            return (true);
        }

        public function get data():ChatRecordData
        {
            return (_data);
        }


    }
}