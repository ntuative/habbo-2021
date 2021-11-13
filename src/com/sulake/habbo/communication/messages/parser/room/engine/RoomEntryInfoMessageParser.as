package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomEntryInfoMessageParser implements IMessageParser 
    {

        private var _guestRoomId:int;
        private var _owner:Boolean;


        public function get guestRoomId():int
        {
            return (_guestRoomId);
        }

        public function get owner():Boolean
        {
            return (_owner);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _guestRoomId = _arg_1.readInteger();
            _owner = _arg_1.readBoolean();
            return (true);
        }


    }
}