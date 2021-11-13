package com.sulake.room.object.visualization.utils
{
    import __AS3__.vec.Vector;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.assets.IAsset;
    import flash.display.BitmapData;

    public class GraphicAsset implements IGraphicAsset 
    {

        private static const _SafeStr_3006:Vector.<GraphicAsset> = new Vector.<GraphicAsset>();

        private var _assetName:String;
        private var _libraryAssetName:String;
        private var _asset:BitmapDataAsset;
        private var _flipH:Boolean;
        private var _flipV:Boolean;
        private var _usesPalette:Boolean;
        private var _originalOffsetX:int;
        private var _originalOffsetY:int;
        private var _width:int;
        private var _SafeStr_1113:int;
        private var _SafeStr_527:Boolean;


        public static function allocate(_arg_1:String, _arg_2:String, _arg_3:IAsset, _arg_4:Boolean, _arg_5:Boolean, _arg_6:int, _arg_7:int, _arg_8:Boolean=false):GraphicAsset
        {
            var _local_9:GraphicAsset = ((_SafeStr_3006.length > 0) ? _SafeStr_3006.pop() : new GraphicAsset());
            _local_9._assetName = _arg_1;
            _local_9._libraryAssetName = _arg_2;
            var _local_10:BitmapDataAsset = (_arg_3 as BitmapDataAsset);
            if (_local_10 != null)
            {
                _local_9._asset = _local_10;
                _local_9._SafeStr_527 = false;
            }
            else
            {
                _local_9._asset = null;
                _local_9._SafeStr_527 = true;
            };
            _local_9._flipH = _arg_4;
            _local_9._flipV = _arg_5;
            _local_9._originalOffsetX = _arg_6;
            _local_9._originalOffsetY = _arg_7;
            _local_9._usesPalette = _arg_8;
            return (_local_9);
        }


        public function recycle():void
        {
            _asset = null;
            _SafeStr_3006.push(this);
        }

        private function initialize():void
        {
            var _local_1:BitmapData;
            if (((!(_SafeStr_527)) && (!(_asset == null))))
            {
                _local_1 = (_asset.content as BitmapData);
                if (_local_1 != null)
                {
                    _width = _local_1.width;
                    _SafeStr_1113 = _local_1.height;
                };
                _SafeStr_527 = true;
            };
        }

        public function get flipV():Boolean
        {
            return (_flipV);
        }

        public function get flipH():Boolean
        {
            return (_flipH);
        }

        public function get width():int
        {
            initialize();
            return (_width);
        }

        public function get height():int
        {
            initialize();
            return (_SafeStr_1113);
        }

        public function get assetName():String
        {
            return (_assetName);
        }

        public function get libraryAssetName():String
        {
            return (_libraryAssetName);
        }

        public function get asset():IAsset
        {
            return (_asset);
        }

        public function get usesPalette():Boolean
        {
            return (_usesPalette);
        }

        public function get offsetX():int
        {
            if (!_flipH)
            {
                return (_originalOffsetX);
            };
            return (-(width + _originalOffsetX));
        }

        public function get offsetY():int
        {
            if (!_flipV)
            {
                return (_originalOffsetY);
            };
            return (-(height + _originalOffsetY));
        }

        public function get originalOffsetX():int
        {
            return (_originalOffsetX);
        }

        public function get originalOffsetY():int
        {
            return (_originalOffsetY);
        }


    }
}

