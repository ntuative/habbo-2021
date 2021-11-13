package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class HeightMapMessageParser implements IMessageParser
    {

        private static const _SafeStr_2077:int = 0x4000;
        private static const _SafeStr_2078:int = 16383;

        private var _SafeStr_690:Vector.<int>;
        private var _width:int = 0;
        private var _height:int = 0;


        public static function decodeTileHeight(_arg_1:int):Number
        {
            return ((_arg_1 < 0) ? -1 : ((_arg_1 & 0x3FFF) / 0x0100));
        }

        public static function decodeIsStackingBlocked(_arg_1:int):Boolean
        {
            return !!(_arg_1 & 0x4000);
        }

        public static function decodeIsRoomTile(_arg_1:int):Boolean
        {
            return (_arg_1 >= 0);
        }


        public function get width():int
        {
            return (_width);
        }

        public function get height():int
        {
            return (_height);
        }

        public function getTileHeight(_arg_1:int, _arg_2:int):Number
        {
            if (((((_arg_1 < 0) || (_arg_1 >= _width)) || (_arg_2 < 0)) || (_arg_2 >= _height)))
            {
                return (-1);
            };
            return (decodeTileHeight(_SafeStr_690[((_arg_2 * _width) + _arg_1)]));
        }

        public function getStackingBlocked(_arg_1:int, _arg_2:int):Boolean
        {
            if (((((_arg_1 < 0) || (_arg_1 >= _width)) || (_arg_2 < 0)) || (_arg_2 >= _height)))
            {
                return (true);
            };
            return (decodeIsStackingBlocked(_SafeStr_690[((_arg_2 * _width) + _arg_1)]));
        }

        public function isRoomTile(_arg_1:int, _arg_2:int):Boolean
        {
            if (((((_arg_1 < 0) || (_arg_1 >= _width)) || (_arg_2 < 0)) || (_arg_2 >= _height)))
            {
                return (false);
            };
            return (decodeIsRoomTile(_SafeStr_690[((_arg_2 * _width) + _arg_1)]));
        }

        public function flush():Boolean
        {
            _SafeStr_690 = null;
            _width = 0;
            _height = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            if (_arg_1 == null)
            {
                return (false);
            };
            _width = _arg_1.readInteger();
            var _local_3:int = _arg_1.readInteger();
            _height = (_local_3 / _width);
            _SafeStr_690 = new Vector.<int>(_local_3);
            _local_2 = 0;
            while (_local_2 < _local_3)
            {
                _SafeStr_690[_local_2] = _arg_1.readShort();
                _local_2++;
            };
            return (true);
        }


    }
}