package com.sulake.habbo.catalog.marketplace
{
    import flash.display.BitmapData;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.geom.Matrix;
    import flash.display.Shape;

    public class MarketplaceChart 
    {

        private var _SafeStr_954:Array;
        private var _SafeStr_955:Array;
        private var _chartWidth:int;
        private var _SafeStr_1450:int;
        private var _xMin:int = -30;
        private var _SafeStr_1451:int;

        public function MarketplaceChart(_arg_1:Array, _arg_2:Array)
        {
            _SafeStr_954 = _arg_1.slice();
            _SafeStr_955 = _arg_2.slice();
        }

        public function draw(_arg_1:int, _arg_2:int):BitmapData
        {
            var _local_5:int;
            var _local_7:int;
            var _local_8:BitmapData = new BitmapData(_arg_1, _arg_2);
            if (!available)
            {
                return (_local_8);
            };
            _SafeStr_1451 = 0;
            for each (_local_5 in _SafeStr_955)
            {
                if (_local_5 > _SafeStr_1451)
                {
                    _SafeStr_1451 = _local_5;
                };
            };
            var _local_6:int = Math.pow(10, (_SafeStr_1451.toString().length - 1));
            _SafeStr_1451 = (Math.ceil((_SafeStr_1451 / _local_6)) * _local_6);
            var _local_9:TextField = new TextField();
            var _local_4:TextFormat = new TextFormat();
            _local_9.embedFonts = true;
            _local_4.font = "Volter";
            _local_4.size = 9;
            _local_9.defaultTextFormat = _local_4;
            _local_9.text = _SafeStr_1451.toString();
            _local_8.draw(_local_9);
            _chartWidth = ((_arg_1 - _local_9.textWidth) - 2);
            _SafeStr_1450 = (_arg_2 - _local_9.textHeight);
            var _local_10:int = _local_9.textWidth;
            _local_9.text = "0";
            _local_8.draw(_local_9, new Matrix(1, 0, 0, 1, ((_local_10 - _local_9.textWidth) + 1), ((_arg_2 - _local_9.textHeight) - 1)));
            var _local_3:Shape = new Shape();
            _local_3.graphics.lineStyle(1, 0xCCCCCC);
            _local_3.graphics.moveTo(0, 0);
            _local_3.graphics.lineTo(0, _SafeStr_1450);
            _local_7 = 0;
            while (_local_7 <= 5)
            {
                _local_5 = int((((_SafeStr_1450 - 1) / 5) * _local_7));
                _local_3.graphics.moveTo(0, _local_5);
                _local_3.graphics.lineTo((_chartWidth - 1), _local_5);
                _local_7++;
            };
            _local_3.graphics.lineStyle(2, 0xFF);
            _local_3.graphics.moveTo(getX(0), getY(0));
            _local_7 = 1;
            while (_local_7 < _SafeStr_954.length)
            {
                _local_3.graphics.lineTo(getX(_local_7), getY(_local_7));
                _local_7++;
            };
            _local_8.draw(_local_3, new Matrix(1, 0, 0, 1, (_arg_1 - _chartWidth), ((_arg_2 - _SafeStr_1450) / 2)));
            return (_local_8);
        }

        private function getX(_arg_1:int):Number
        {
            return (_chartWidth + ((_chartWidth / -(_xMin)) * _SafeStr_954[_arg_1]));
        }

        private function getY(_arg_1:int):Number
        {
            return (_SafeStr_1450 - ((_SafeStr_1450 / _SafeStr_1451) * _SafeStr_955[_arg_1]));
        }

        public function get available():Boolean
        {
            return (((_SafeStr_954) && (_SafeStr_955)) && (_SafeStr_954.length > 1));
        }


    }
}

