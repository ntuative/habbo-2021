package com.sulake.habbo.room.object.visualization.room.mask
{
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
    import com.sulake.core.utils.Map;
    import com.sulake.room.utils._SafeStr_93;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.geom.Matrix;
    import com.sulake.room.utils.IVector3d;

    public class PlaneMaskManager 
    {

        private var _assetCollection:IGraphicAssetCollection = null;
        private var _SafeStr_3426:Map = null;
        private var _data:XML = null;

        public function PlaneMaskManager()
        {
            _SafeStr_3426 = new Map();
        }

        public function get data():XML
        {
            return (_data);
        }

        public function dispose():void
        {
            var _local_1:int;
            var _local_2:PlaneMask;
            _assetCollection = null;
            _data = null;
            if (_SafeStr_3426 != null)
            {
                _local_1 = 0;
                while (_local_1 < _SafeStr_3426.length)
                {
                    _local_2 = (_SafeStr_3426.getWithIndex(_local_1) as PlaneMask);
                    if (_local_2 != null)
                    {
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                _SafeStr_3426.dispose();
            };
        }

        public function initialize(_arg_1:XML):void
        {
            _data = _arg_1;
        }

        public function initializeAssetCollection(_arg_1:IGraphicAssetCollection):void
        {
            if (data == null)
            {
                return;
            };
            _assetCollection = _arg_1;
            parseMasks(data, _arg_1);
        }

        private function parseMasks(_arg_1:XML, _arg_2:IGraphicAssetCollection):void
        {
            var _local_5:int;
            var _local_16:XML;
            var _local_14:String;
            var _local_15:PlaneMask;
            var _local_9:XMLList;
            var _local_7:int;
            var _local_13:XML;
            var _local_11:int;
            var _local_4:PlaneMaskVisualization;
            var _local_3:XMLList;
            var _local_12:String;
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return;
            };
            var _local_10:Array = ["id"];
            var _local_8:Array = ["size"];
            var _local_6:XMLList = _arg_1.mask;
            _local_5 = 0;
            while (_local_5 < _local_6.length())
            {
                _local_16 = _local_6[_local_5];
                if (_SafeStr_93.checkRequiredAttributes(_local_16, _local_10))
                {
                    _local_14 = _local_16.@id;
                    if (_SafeStr_3426.getValue(_local_14) == null)
                    {
                        _local_15 = new PlaneMask();
                        _local_9 = _local_16.maskVisualization;
                        _local_7 = 0;
                        while (_local_7 < _local_9.length())
                        {
                            _local_13 = _local_9[_local_7];
                            if (_SafeStr_93.checkRequiredAttributes(_local_13, _local_8))
                            {
                                _local_11 = parseInt(_local_13.@size);
                                _local_4 = _local_15.createMaskVisualization(_local_11);
                                if (_local_4 != null)
                                {
                                    _local_3 = _local_13.bitmap;
                                    _local_12 = parseMaskBitmaps(_local_3, _local_4, _arg_2);
                                    _local_15.setAssetName(_local_11, _local_12);
                                };
                            };
                            _local_7++;
                        };
                        _SafeStr_3426.add(_local_14, _local_15);
                    };
                };
                _local_5++;
            };
        }

        private function parseMaskBitmaps(_arg_1:XMLList, _arg_2:PlaneMaskVisualization, _arg_3:IGraphicAssetCollection):String
        {
            var _local_8:int;
            var _local_4:XML;
            var _local_6:Number;
            var _local_12:Number;
            var _local_9:Number;
            var _local_5:Number;
            var _local_7:String;
            var _local_11:IGraphicAsset;
            if (_arg_1 == null)
            {
                return (null);
            };
            var _local_10:String;
            _local_8 = 0;
            while (_local_8 < _arg_1.length())
            {
                _local_4 = _arg_1[_local_8];
                if (_SafeStr_93.checkRequiredAttributes(_local_4, ["assetName"]))
                {
                    _local_6 = -1;
                    _local_12 = 1;
                    _local_9 = -1;
                    _local_5 = 1;
                    if (String(_local_4.@normalMinX) != "")
                    {
                        _local_6 = parseFloat(_local_4.@normalMinX);
                    };
                    if (String(_local_4.@normalMaxX) != "")
                    {
                        _local_12 = parseFloat(_local_4.@normalMaxX);
                    };
                    if (String(_local_4.@normalMinY) != "")
                    {
                        _local_9 = parseFloat(_local_4.@normalMinY);
                    };
                    if (String(_local_4.@normalMaxY) != "")
                    {
                        _local_5 = parseFloat(_local_4.@normalMaxY);
                    };
                    _local_7 = _local_4.@assetName;
                    _local_11 = _arg_3.getAsset(_local_7);
                    if (_local_11 != null)
                    {
                        if (!_local_11.flipH)
                        {
                            _local_10 = _local_7;
                        };
                        _arg_2.addBitmap(_local_11, _local_6, _local_12, _local_9, _local_5);
                    };
                };
                _local_8++;
            };
            return (_local_10);
        }

        public function updateMask(_arg_1:BitmapData, _arg_2:String, _arg_3:Number, _arg_4:IVector3d, _arg_5:int, _arg_6:int):Boolean
        {
            var _local_15:IGraphicAsset;
            var _local_9:BitmapDataAsset;
            var _local_10:BitmapData;
            var _local_8:Point;
            var _local_7:Matrix;
            var _local_13:Number;
            var _local_14:Number;
            var _local_12:Number;
            var _local_11:Number;
            var _local_16:PlaneMask = (_SafeStr_3426.getValue(_arg_2) as PlaneMask);
            if (_local_16 != null)
            {
                _local_15 = _local_16.getGraphicAsset(_arg_3, _arg_4);
                if (_local_15 != null)
                {
                    _local_9 = (_local_15.asset as BitmapDataAsset);
                    if (_local_9 != null)
                    {
                        _local_10 = (_local_9.content as BitmapData);
                        if (_local_10 != null)
                        {
                            _local_8 = new Point((_arg_5 + _local_15.offsetX), (_arg_6 + _local_15.offsetY));
                            _local_7 = new Matrix();
                            _local_13 = 1;
                            _local_14 = 1;
                            _local_12 = 0;
                            _local_11 = 0;
                            if (_local_15.flipH)
                            {
                                _local_13 = -1;
                                _local_12 = _local_10.width;
                            };
                            if (_local_15.flipV)
                            {
                                _local_14 = -1;
                                _local_11 = _local_10.height;
                            };
                            _local_7.scale(_local_13, _local_14);
                            _local_7.translate((_local_8.x + _local_12), (_local_8.y + _local_11));
                            _arg_1.draw(_local_10, _local_7);
                        };
                    };
                };
            };
            return (true);
        }

        public function getMask(_arg_1:String):PlaneMask
        {
            return (_SafeStr_3426.getValue(_arg_1) as PlaneMask);
        }


    }
}

