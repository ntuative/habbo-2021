package com.sulake.habbo.communication.messages.parser.roomsettings
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class UserUnbannedFromRoomParser implements IMessageParser 
    {

        private var _roomId:int;
        private var _userId:int;


        public function flush():Boolean
        {
            _roomId = 0;
            _userId = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _roomId = _arg_1.readInteger();
            _userId = _arg_1.readInteger();
            return (true);
        }

        public function get roomId():int
        {
            return (_roomId);
        }

        public function get userId():int
        {
            return (_userId);
        }


    }
}