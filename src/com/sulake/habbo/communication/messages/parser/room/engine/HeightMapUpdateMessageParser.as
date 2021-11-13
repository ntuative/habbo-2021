package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class HeightMapUpdateMessageParser implements IMessageParser 
    {

        private var _SafeStr_690:IMessageDataWrapper;
        private var _SafeStr_2079:int;
        private var _x:int;
        private var _y:int;
        private var _SafeStr_1623:int;


        public function next():Boolean
        {
            if (_SafeStr_2079 == 0)
            {
                return (false);
            };
            _SafeStr_2079--;
            _x = _SafeStr_690.readByte();
            _y = _SafeStr_690.readByte();
            _SafeStr_1623 = _SafeStr_690.readShort();
            return (true);
        }

        public function get x():int
        {
            return (_x);
        }

        public function get y():int
        {
            return (_y);
        }

        public function get tileHeight():Number
        {
            return (HeightMapMessageParser.decodeTileHeight(_SafeStr_1623));
        }

        public function get isStackingBlocked():Boolean
        {
            return (HeightMapMessageParser.decodeIsStackingBlocked(_SafeStr_1623));
        }

        public function get isRoomTile():Boolean
        {
            return (HeightMapMessageParser.decodeIsRoomTile(_SafeStr_1623));
        }

        public function flush():Boolean
        {
            _SafeStr_2079 = 0;
            _SafeStr_690 = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            _SafeStr_690 = _arg_1;
            _SafeStr_2079 = _arg_1.readByte();
            return (true);
        }


    }
}

