package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomMessageNotificationMessageParser implements IMessageParser 
    {

        private var _roomId:int;
        private var _roomName:String;
        private var _messageCount:int;


        public function get roomId():int
        {
            return (_roomId);
        }

        public function get roomName():String
        {
            return (_roomName);
        }

        public function get messageCount():int
        {
            return (_messageCount);
        }

        public function flush():Boolean
        {
            _roomId = -1;
            _roomName = "";
            _messageCount = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _roomId = _arg_1.readInteger();
            _roomName = _arg_1.readString();
            _messageCount = _arg_1.readInteger();
            return (true);
        }


    }
}