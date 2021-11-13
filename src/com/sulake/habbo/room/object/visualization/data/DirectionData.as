package com.sulake.habbo.room.object.visualization.data
{
    public class DirectionData 
    {

        public static const USE_DEFAULT_DIRECTION:int = -1;

        private var _layers:Array = [];

        public function DirectionData(_arg_1:int)
        {
            super();
            var _local_2:int;
            var _local_3:LayerData = null;
            _local_2 = 0;
            while (_local_2 < _arg_1)
            {
                _local_3 = new LayerData();
                _layers.push(_local_3);
                _local_2++;
            };
        }

        public function dispose():void
        {
            _layers = null;
        }

        public function get layerCount():int
        {
            return (_layers.length);
        }

        private function getLayer(_arg_1:int):LayerData
        {
            if (((_arg_1 < 0) || (_arg_1 >= layerCount)))
            {
                return (null);
            };
            return (_layers[_arg_1]);
        }

        public function getTag(_arg_1:int):String
        {
            var _local_2:LayerData = getLayer(_arg_1);
            if (_local_2 != null)
            {
                return (_local_2.tag);
            };
            return ("");
        }

        public function setTag(_arg_1:int, _arg_2:String):void
        {
            var _local_3:LayerData = getLayer(_arg_1);
            if (_local_3 != null)
            {
                _local_3.tag = _arg_2;
            };
        }

        public function getInk(_arg_1:int):int
        {
            var _local_2:LayerData = getLayer(_arg_1);
            if (_local_2 != null)
            {
                return (_local_2.ink);
            };
            return (0);
        }

        public function setInk(_arg_1:int, _arg_2:int):void
        {
            var _local_3:LayerData = getLayer(_arg_1);
            if (_local_3 != null)
            {
                _local_3.ink = _arg_2;
            };
        }

        public function getAlpha(_arg_1:int):int
        {
            var _local_2:LayerData = getLayer(_arg_1);
            if (_local_2 != null)
            {
                return (_local_2.alpha);
            };
            return (0xFF);
        }

        public function setAlpha(_arg_1:int, _arg_2:int):void
        {
            var _local_3:LayerData = getLayer(_arg_1);
            if (_local_3 != null)
            {
                _local_3.alpha = _arg_2;
            };
        }

        public function getIgnoreMouse(_arg_1:int):Boolean
        {
            var _local_2:LayerData = getLayer(_arg_1);
            if (_local_2 != null)
            {
                return (_local_2.ignoreMouse);
            };
            return (false);
        }

        public function setIgnoreMouse(_arg_1:int, _arg_2:Boolean):void
        {
            var _local_3:LayerData = getLayer(_arg_1);
            if (_local_3 != null)
            {
                _local_3.ignoreMouse = _arg_2;
            };
        }

        public function getXOffset(_arg_1:int):int
        {
            var _local_2:LayerData = getLayer(_arg_1);
            if (_local_2 != null)
            {
                return (_local_2.xOffset);
            };
            return (0);
        }

        public function setXOffset(_arg_1:int, _arg_2:int):void
        {
            var _local_3:LayerData = getLayer(_arg_1);
            if (_local_3 != null)
            {
                _local_3.xOffset = _arg_2;
            };
        }

        public function getYOffset(_arg_1:int):int
        {
            var _local_2:LayerData = getLayer(_arg_1);
            if (_local_2 != null)
            {
                return (_local_2.yOffset);
            };
            return (0);
        }

        public function setYOffset(_arg_1:int, _arg_2:int):void
        {
            var _local_3:LayerData = getLayer(_arg_1);
            if (_local_3 != null)
            {
                _local_3.yOffset = _arg_2;
            };
        }

        public function getZOffset(_arg_1:int):Number
        {
            var _local_2:LayerData = getLayer(_arg_1);
            if (_local_2 != null)
            {
                return (_local_2.zOffset);
            };
            return (0);
        }

        public function setZOffset(_arg_1:int, _arg_2:Number):void
        {
            var _local_3:LayerData = getLayer(_arg_1);
            if (_local_3 != null)
            {
                _local_3.zOffset = _arg_2;
            };
        }

        public function copyValues(_arg_1:DirectionData):void
        {
            var _local_3:int;
            if (_arg_1 == null)
            {
                return;
            };
            if (layerCount != _arg_1.layerCount)
            {
                return;
            };
            var _local_4:LayerData;
            var _local_2:LayerData;
            _local_3 = 0;
            while (_local_3 < layerCount)
            {
                _local_4 = getLayer(_local_3);
                _local_2 = _arg_1.getLayer(_local_3);
                if (_local_4)
                {
                    _local_4.copyValues(_local_2);
                };
                _local_3++;
            };
        }


    }
}