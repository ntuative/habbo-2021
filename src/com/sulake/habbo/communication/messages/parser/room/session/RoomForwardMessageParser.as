package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomForwardMessageParser implements IMessageParser 
    {

        private var _roomId:int;


        public function get roomId():int
        {
            return (_roomId);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _roomId = _arg_1.readInteger();
            return (true);
        }


    }
}