package com.sulake.habbo.avatar.animation
{
    import flash.geom.ColorTransform;
    import com.sulake.core.utils.Map;

    public class AvatarDataContainer implements IAvatarDataContainer 
    {

        private var _ink:int;
        private var _foreGround:uint;
        private var _backGround:uint;
        private var _colorTransform:ColorTransform;
        private var _SafeStr_1253:uint;
        private var _r:uint;
        private var _g:uint;
        private var _b:uint;
        private var _SafeStr_1254:Number = 1;
        private var _SafeStr_1255:Number = 1;
        private var _SafeStr_1256:Number = 1;
        private var _SafeStr_1257:Number = 1;
        private var _SafeStr_1258:Map;
        private var _paletteIsGrayscale:Boolean = true;

        public function AvatarDataContainer(_arg_1:XML)
        {
            _ink = parseInt(_arg_1.@ink);
            var _local_2:String = String(_arg_1.@foreground);
            _local_2 = _local_2.replace("#", "");
            var _local_3:String = String(_arg_1.@background);
            _local_3 = _local_3.replace("#", "");
            _foreGround = parseInt(_local_2, 16);
            _backGround = parseInt(_local_3, 16);
            _SafeStr_1253 = parseInt(_local_2, 16);
            _r = ((_SafeStr_1253 >> 16) & 0xFF);
            _g = ((_SafeStr_1253 >> 8) & 0xFF);
            _b = ((_SafeStr_1253 >> 0) & 0xFF);
            _SafeStr_1254 = ((_r / 0xFF) * 1);
            _SafeStr_1255 = ((_g / 0xFF) * 1);
            _SafeStr_1256 = ((_b / 0xFF) * 1);
            if (_ink == 37)
            {
                _SafeStr_1257 = 0.5;
                _paletteIsGrayscale = false;
            };
            _colorTransform = new ColorTransform(_SafeStr_1254, _SafeStr_1255, _SafeStr_1256, _SafeStr_1257);
            _SafeStr_1258 = generatePaletteMapForGrayscale(_backGround, _foreGround);
        }

        public function get ink():int
        {
            return (_ink);
        }

        public function get colorTransform():ColorTransform
        {
            return (_colorTransform);
        }

        public function get reds():Array
        {
            return (_SafeStr_1258.getValue("reds") as Array);
        }

        public function get greens():Array
        {
            return (_SafeStr_1258.getValue("greens") as Array);
        }

        public function get blues():Array
        {
            return (_SafeStr_1258.getValue("blues") as Array);
        }

        public function get alphas():Array
        {
            return (_SafeStr_1258.getValue("alphas") as Array);
        }

        public function get paletteIsGrayscale():Boolean
        {
            return (_paletteIsGrayscale);
        }

        private function generatePaletteMapForGrayscale(_arg_1:uint, _arg_2:uint):Map
        {
            var _local_9:int;
            var _local_15:Number = ((_arg_1 >> 24) & 0xFF);
            var _local_24:Number = ((_arg_1 >> 16) & 0xFF);
            var _local_10:Number = ((_arg_1 >> 8) & 0xFF);
            var _local_14:Number = ((_arg_1 >> 0) & 0xFF);
            var _local_17:Number = ((_arg_2 >> 24) & 0xFF);
            var _local_3:Number = ((_arg_2 >> 16) & 0xFF);
            var _local_11:Number = ((_arg_2 >> 8) & 0xFF);
            var _local_16:Number = ((_arg_2 >> 0) & 0xFF);
            var _local_21:Number = ((_local_17 - _local_15) / 0xFF);
            var _local_12:Number = ((_local_3 - _local_24) / 0xFF);
            var _local_6:Number = ((_local_11 - _local_10) / 0xFF);
            var _local_23:Number = ((_local_16 - _local_14) / 0xFF);
            var _local_22:Map = new Map();
            var _local_19:Array = [];
            var _local_8:Array = [];
            var _local_13:Array = [];
            var _local_20:Array = [];
            var _local_4:Number = _local_15;
            var _local_18:Number = _local_24;
            var _local_7:Number = _local_10;
            var _local_5:Number = _local_14;
            _local_9 = 0;
            while (_local_9 < 0x0100)
            {
                if ((((_local_18 == _local_24) && (_local_7 == _local_10)) && (_local_5 == _local_14)))
                {
                    _local_4 = 0;
                };
                _local_4 = (_local_4 + _local_21);
                _local_18 = (_local_18 + _local_12);
                _local_7 = (_local_7 + _local_6);
                _local_5 = (_local_5 + _local_23);
                _local_20.push((_local_4 << 24));
                _local_19.push(((((_local_4 << 24) | (_local_18 << 16)) | (_local_7 << 8)) | _local_5));
                _local_8.push(((((_local_4 << 24) | (_local_18 << 16)) | (_local_7 << 8)) | _local_5));
                _local_13.push(((((_local_4 << 24) | (_local_18 << 16)) | (_local_7 << 8)) | _local_5));
                _local_9++;
            };
            _local_22.add("alphas", _local_19);
            _local_22.add("reds", _local_19);
            _local_22.add("greens", _local_8);
            _local_22.add("blues", _local_13);
            return (_local_22);
        }


    }
}

