package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.room.object.visualization.data.SizeData;
    import com.sulake.room.utils._SafeStr_93;

    public class FurnitureVisualizationData implements IRoomObjectVisualizationData 
    {

        public static const LAYER_LIMIT:int = 1000;
        public static const LAYER_NAMES:Array = new Array("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z");

        private var _SafeStr_3385:Map;
        private var _SafeStr_3386:Array = [];
        private var _SafeStr_3387:SizeData = null;
        private var _SafeStr_3388:int = -1;
        private var _SafeStr_3389:int = -1;
        private var _SafeStr_3390:int = -1;
        private var _SafeStr_741:String = "";

        public function FurnitureVisualizationData()
        {
            _SafeStr_3385 = new Map();
        }

        public function dispose():void
        {
            var _local_1:SizeData;
            var _local_2:int;
            if (_SafeStr_3385 != null)
            {
                _local_1 = null;
                _local_2 = 0;
                while (_local_2 < _SafeStr_3385.length)
                {
                    _local_1 = (_SafeStr_3385.getWithIndex(_local_2) as SizeData);
                    if (_local_1 != null)
                    {
                        _local_1.dispose();
                    };
                    _local_2++;
                };
                _SafeStr_3385.dispose();
                _SafeStr_3385 = null;
            };
            _SafeStr_3387 = null;
            _SafeStr_3386 = null;
        }

        public function initialize(_arg_1:XML):Boolean
        {
            reset();
            if (_arg_1 == null)
            {
                return (false);
            };
            var _local_2:String = _arg_1.@type;
            if (_local_2.length == 0)
            {
                return (false);
            };
            _SafeStr_741 = _local_2;
            if (!defineVisualizations(_arg_1))
            {
                reset();
                return (false);
            };
            return (true);
        }

        protected function reset():void
        {
            var _local_2:int;
            _SafeStr_741 = "";
            var _local_1:SizeData;
            _local_2 = 0;
            while (_local_2 < _SafeStr_3385.length)
            {
                _local_1 = (_SafeStr_3385.getWithIndex(_local_2) as SizeData);
                if (_local_1 != null)
                {
                    _local_1.dispose();
                };
                _local_2++;
            };
            _SafeStr_3385.reset();
            _SafeStr_3386 = [];
            _SafeStr_3387 = null;
            _SafeStr_3388 = -1;
        }

        protected function defineVisualizations(_arg_1:XML):Boolean
        {
            var _local_7:int;
            var _local_2:XML;
            var _local_3:int;
            var _local_4:int;
            var _local_8:int;
            var _local_11:SizeData;
            var _local_5:XMLList;
            var _local_9:int;
            var _local_12:XML;
            var _local_10:XMLList = _arg_1.graphics.visualization;
            if (_local_10.length() == 0)
            {
                return (false);
            };
            var _local_6:int;
            _local_7 = 0;
            while (_local_7 < _local_10.length())
            {
                _local_2 = _local_10[_local_7];
                if (!_SafeStr_93.checkRequiredAttributes(_local_2, ["size", "layerCount", "angle"]))
                {
                    return (false);
                };
                _local_3 = int(_local_2.@size);
                _local_4 = int(_local_2.@layerCount);
                _local_8 = int(_local_2.@angle);
                if (_local_3 < 1)
                {
                    _local_3 = 1;
                };
                if (_SafeStr_3385.getValue(String(_local_3)) != null)
                {
                    return (false);
                };
                _local_11 = createSizeData(_local_3, _local_4, _local_8);
                if (_local_11 == null)
                {
                    return (false);
                };
                _local_5 = _local_2.children();
                _local_9 = 0;
                while (_local_9 < _local_5.length())
                {
                    _local_12 = _local_5[_local_9];
                    if (!processVisualizationElement(_local_11, _local_12))
                    {
                        _local_11.dispose();
                        return (false);
                    };
                    _local_9++;
                };
                _SafeStr_3385.add(String(_local_3), _local_11);
                _SafeStr_3386.push(_local_3);
                _SafeStr_3386.sort(16);
                _local_7++;
            };
            return (true);
        }

        protected function createSizeData(_arg_1:int, _arg_2:int, _arg_3:int):SizeData
        {
            var _local_4:SizeData;
            _local_4 = new SizeData(_arg_2, _arg_3);
            return (_local_4);
        }

        protected function processVisualizationElement(_arg_1:SizeData, _arg_2:XML):Boolean
        {
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return (false);
            };
            switch (String(_arg_2.name()))
            {
                case "layers":
                    if (!_arg_1.defineLayers(_arg_2))
                    {
                        return (false);
                    };
                    break;
                case "directions":
                    if (!_arg_1.defineDirections(_arg_2))
                    {
                        return (false);
                    };
                    break;
                case "colors":
                    if (!_arg_1.defineColors(_arg_2))
                    {
                        return (false);
                    };
            };
            return (true);
        }

        public function getType():String
        {
            return (_SafeStr_741);
        }

        private function getSizeIndex(_arg_1:int):int
        {
            var _local_3:int;
            var _local_2:int;
            if (_arg_1 > 0)
            {
                _local_3 = 1;
                while (_local_3 < _SafeStr_3386.length)
                {
                    if (_SafeStr_3386[_local_3] > _arg_1)
                    {
                        if ((_SafeStr_3386[_local_3] / _arg_1) < (_arg_1 / _SafeStr_3386[(_local_3 - 1)]))
                        {
                            _local_2 = _local_3;
                        };
                        break;
                    };
                    _local_2 = _local_3;
                    _local_3++;
                };
            };
            return (_local_2);
        }

        public function getSize(_arg_1:int):int
        {
            if (_arg_1 == _SafeStr_3390)
            {
                return (_SafeStr_3389);
            };
            var _local_2:int = getSizeIndex(_arg_1);
            var _local_3:int = -1;
            if (_local_2 < _SafeStr_3386.length)
            {
                _local_3 = _SafeStr_3386[_local_2];
            };
            _SafeStr_3390 = _arg_1;
            _SafeStr_3389 = _local_3;
            return (_local_3);
        }

        public function getLayerCount(_arg_1:int):int
        {
            var _local_2:SizeData = getSizeData(_arg_1);
            if (_local_2 != null)
            {
                return (_local_2.layerCount);
            };
            return (0);
        }

        public function getDirectionValue(_arg_1:int, _arg_2:int):int
        {
            var _local_3:SizeData = getSizeData(_arg_1);
            if (_local_3 != null)
            {
                return (_local_3.getDirectionValue(_arg_2));
            };
            return (0);
        }

        public function getTag(_arg_1:int, _arg_2:int, _arg_3:int):String
        {
            var _local_4:SizeData = getSizeData(_arg_1);
            if (_local_4 != null)
            {
                return (_local_4.getTag(_arg_2, _arg_3));
            };
            return ("");
        }

        public function getInk(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:SizeData = getSizeData(_arg_1);
            if (_local_4 != null)
            {
                return (_local_4.getInk(_arg_2, _arg_3));
            };
            return (0);
        }

        public function getAlpha(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:SizeData = getSizeData(_arg_1);
            if (_local_4 != null)
            {
                return (_local_4.getAlpha(_arg_2, _arg_3));
            };
            return (0xFF);
        }

        public function getColor(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:SizeData = getSizeData(_arg_1);
            if (_local_4 != null)
            {
                return (_local_4.getColor(_arg_2, _arg_3));
            };
            return (0xFFFFFF);
        }

        public function getIgnoreMouse(_arg_1:int, _arg_2:int, _arg_3:int):Boolean
        {
            var _local_4:SizeData = getSizeData(_arg_1);
            if (_local_4 != null)
            {
                return (_local_4.getIgnoreMouse(_arg_2, _arg_3));
            };
            return (false);
        }

        public function getXOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:SizeData = getSizeData(_arg_1);
            if (_local_4 != null)
            {
                return (_local_4.getXOffset(_arg_2, _arg_3));
            };
            return (0);
        }

        public function getYOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:SizeData = getSizeData(_arg_1);
            if (_local_4 != null)
            {
                return (_local_4.getYOffset(_arg_2, _arg_3));
            };
            return (0);
        }

        public function getZOffset(_arg_1:int, _arg_2:int, _arg_3:int):Number
        {
            var _local_4:SizeData = getSizeData(_arg_1);
            if (_local_4 != null)
            {
                return (_local_4.getZOffset(_arg_2, _arg_3));
            };
            return (0);
        }

        protected function getSizeData(_arg_1:int):SizeData
        {
            if (_arg_1 == _SafeStr_3388)
            {
                return (_SafeStr_3387);
            };
            var _local_2:int = getSizeIndex(_arg_1);
            if (_local_2 < _SafeStr_3386.length)
            {
                _SafeStr_3387 = (_SafeStr_3385.getValue(String(_SafeStr_3386[_local_2])) as SizeData);
            }
            else
            {
                _SafeStr_3387 = null;
            };
            _SafeStr_3388 = _arg_1;
            return (_SafeStr_3387);
        }


    }
}

