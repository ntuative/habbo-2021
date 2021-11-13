package com.sulake.habbo.communication.messages.parser.room.layout
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomEntryTileMessageParser implements IMessageParser 
    {

        private var _x:int;
        private var _y:int;
        private var _dir:uint;


        public function get x():int
        {
            return (_x);
        }

        public function get y():int
        {
            return (_y);
        }

        public function get dir():uint
        {
            return (_dir);
        }

        public function flush():Boolean
        {
            _x = 0;
            _y = 0;
            _dir = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _x = _arg_1.readInteger();
            _y = _arg_1.readInteger();
            _dir = _arg_1.readInteger();
            return (true);
        }


    }
}