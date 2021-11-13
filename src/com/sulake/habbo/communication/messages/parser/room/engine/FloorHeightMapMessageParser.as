package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FloorHeightMapMessageParser implements IMessageParser 
    {

        private var _text:String = "";
        private var _SafeStr_2076:Array = [];
        private var _width:int = 0;
        private var _height:int = 0;
        private var _scale:Number = 0;
        private var _fixedWallsHeight:int = -1;


        public function get width():int
        {
            return (_width);
        }

        public function get height():int
        {
            return (_height);
        }

        public function get fixedWallsHeight():int
        {
            return (_fixedWallsHeight);
        }

        public function get scale():Number
        {
            return (_scale);
        }

        public function getTileHeight(_arg_1:int, _arg_2:int):int
        {
            if (((((_arg_1 < 0) || (_arg_1 >= width)) || (_arg_2 < 0)) || (_arg_2 >= height)))
            {
                return (-110);
            };
            var _local_3:Array = (_SafeStr_2076[_arg_2] as Array);
            return (_local_3[_arg_1]);
        }

        public function flush():Boolean
        {
            _SafeStr_2076 = [];
            _width = 0;
            _height = 0;
            _text = "";
            _fixedWallsHeight = -1;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:String;
            if (_arg_1 == null)
            {
                return (false);
            };
            var _local_5:Boolean = _arg_1.readBoolean();
            _fixedWallsHeight = _arg_1.readInteger();
            _text = _arg_1.readString();
            var _local_9:Array = _text.split("\r");
            var _local_6:int;
            var _local_7:int;
            var _local_10:int;
            var _local_2:Array;
            var _local_11:int = _local_9.length;
            var _local_3:int;
            var _local_8:String;
            _local_7 = 0;
            while (_local_7 < _local_11)
            {
                _local_8 = (_local_9[_local_7] as String);
                if (_local_8.length > _local_3)
                {
                    _local_3 = _local_8.length;
                };
                _local_7++;
            };
            _SafeStr_2076 = [];
            _local_7 = 0;
            while (_local_7 < _local_11)
            {
                _local_2 = [];
                _local_6 = 0;
                while (_local_6 < _local_3)
                {
                    _local_2.push(-110);
                    _local_6++;
                };
                _SafeStr_2076.push(_local_2);
                _local_7++;
            };
            _width = _local_3;
            _height = _local_11;
            _local_7 = 0;
            while (_local_7 < _local_9.length)
            {
                _local_2 = (_SafeStr_2076[_local_7] as Array);
                _local_8 = (_local_9[_local_7] as String);
                if (_local_8.length > 0)
                {
                    _local_6 = 0;
                    while (_local_6 < _local_8.length)
                    {
                        _local_4 = _local_8.charAt(_local_6);
                        if (((!(_local_4 == "x")) && (!(_local_4 == "X"))))
                        {
                            _local_10 = parseInt(_local_4, 36);
                        }
                        else
                        {
                            _local_10 = -110;
                        };
                        _local_2[_local_6] = _local_10;
                        _local_6++;
                    };
                };
                _local_7++;
            };
            _scale = ((_local_5) ? 32 : 64);
            return (true);
        }

        public function get text():String
        {
            return (_text);
        }


    }
}

