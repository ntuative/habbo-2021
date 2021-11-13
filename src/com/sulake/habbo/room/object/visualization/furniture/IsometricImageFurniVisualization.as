package com.sulake.habbo.room.object.visualization.furniture
{
    import flash.display.BitmapData;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import flash.display.Bitmap;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;

    public class IsometricImageFurniVisualization extends AnimatedFurnitureVisualization 
    {

        protected static const THUMBNAIL_SPRITE_TAG:String = "THUMBNAIL";

        private var _SafeStr_3399:String = null;
        private var _thumbnailAssetNameNormal:String = null;
        private var _SafeStr_3400:Boolean = false;
        private var _SafeStr_3401:BitmapData;
        private var _thumbnailImageNormal:BitmapData;
        private var _thumbnailDirection:int;
        private var _SafeStr_3402:Boolean;


        public function set hasOutline(_arg_1:Boolean):void
        {
            _SafeStr_3400 = _arg_1;
        }

        public function get hasThumbnailImage():Boolean
        {
            return (!(_thumbnailImageNormal == null));
        }

        public function setThumbnailImages(_arg_1:BitmapData, _arg_2:BitmapData=null):void
        {
            _thumbnailImageNormal = _arg_1;
            _SafeStr_3401 = ((_arg_2 != null) ? _arg_2 : _arg_1);
            _SafeStr_3402 = true;
        }

        override protected function updateModel(_arg_1:Number):Boolean
        {
            var _local_2:Boolean = super.updateModel(_arg_1);
            if (!object)
            {
                return (_local_2);
            };
            if (((!(_SafeStr_3402)) && (_thumbnailDirection == direction)))
            {
                return (_local_2);
            };
            refreshThumbnail();
            return (true);
        }

        private function refreshThumbnail():void
        {
            if (assetCollection == null)
            {
                return;
            };
            if (_thumbnailImageNormal != null)
            {
                addThumbnailAsset(_thumbnailImageNormal, 64);
                addThumbnailAsset(_SafeStr_3401, 32);
            }
            else
            {
                assetCollection.disposeAsset(getThumbnailAssetName(64));
                assetCollection.disposeAsset(getThumbnailAssetName(32));
            };
            _SafeStr_3402 = false;
            _thumbnailDirection = direction;
        }

        private function addThumbnailAsset(_arg_1:BitmapData, _arg_2:int):void
        {
            var _local_5:int;
            var _local_6:String;
            var _local_4:IGraphicAsset;
            var _local_3:BitmapData;
            var _local_7:String;
            _local_5 = 0;
            while (_local_5 < spriteCount)
            {
                if (getSpriteTag(_arg_2, direction, _local_5) == "THUMBNAIL")
                {
                    _local_6 = (getSpriteAssetNameWithoutFrame(_arg_2, _local_5, false) + getFrameNumber(_arg_2, _local_5));
                    _local_4 = getAsset(_local_6, _local_5);
                    if (_local_4 != null)
                    {
                        _local_3 = generateTransformedThumbnail(_arg_1, _local_4);
                        _local_7 = getThumbnailAssetName(_arg_2);
                        assetCollection.disposeAsset(_local_7);
                        assetCollection.addAsset(_local_7, _local_3, true, _local_4.offsetX, _local_4.offsetY);
                    };
                    return;
                };
                _local_5++;
            };
        }

        private function generateTransformedThumbnail(_arg_1:BitmapData, _arg_2:IGraphicAsset):BitmapData
        {
            var _local_3:BitmapData;
            var _local_8:Bitmap;
            var _local_7:ColorTransform;
            var _local_4:Number = 1.1;
            var _local_6:Matrix = new Matrix();
            var _local_5:Number = (_arg_2.width / _arg_1.width);
            switch (direction)
            {
                case 2:
                    _local_6.a = _local_5;
                    _local_6.b = (-0.5 * _local_5);
                    _local_6.c = 0;
                    _local_6.d = (_local_5 * _local_4);
                    _local_6.tx = 0;
                    _local_6.ty = ((0.5 * _local_5) * _arg_1.width);
                    break;
                case 0:
                case 4:
                    _local_6.a = _local_5;
                    _local_6.b = (0.5 * _local_5);
                    _local_6.c = 0;
                    _local_6.d = (_local_5 * _local_4);
                    _local_6.tx = 0;
                    _local_6.ty = 0;
                    break;
                default:
                    _local_6.a = _local_5;
                    _local_6.b = 0;
                    _local_6.c = 0;
                    _local_6.d = _local_5;
                    _local_6.tx = 0;
                    _local_6.ty = 0;
            };
            if (_SafeStr_3400)
            {
                _local_3 = new BitmapData((_arg_2.width + 2), (_arg_2.height + 2), true, 0);
                _local_8 = new Bitmap(_arg_1);
                _local_7 = new ColorTransform();
                _local_7.color = 0;
                _local_3.draw(_local_8, _local_6, _local_7);
                _local_6.tx = (_local_6.tx + 1);
                _local_6.ty = (_local_6.ty - 1);
                _local_3.draw(_local_8, _local_6, _local_7);
                _local_6.ty = (_local_6.ty + 2);
                _local_3.draw(_local_8, _local_6, _local_7);
                _local_6.tx = (_local_6.tx + 1);
                _local_6.ty = (_local_6.ty - 1);
                _local_3.draw(_local_8, _local_6, _local_7);
                _local_6.tx = (_local_6.tx - 1);
                _local_3.draw(_local_8, _local_6);
            }
            else
            {
                _local_3 = new BitmapData(_arg_2.width, _arg_2.height, true, 0);
                _local_3.draw(_arg_1, _local_6);
            };
            return (_local_3);
        }

        override protected function getSpriteAssetName(_arg_1:int, _arg_2:int):String
        {
            if (((_thumbnailImageNormal == null) || (!(getSpriteTag(_arg_1, direction, _arg_2) == "THUMBNAIL"))))
            {
                return (super.getSpriteAssetName(_arg_1, _arg_2));
            };
            return (getThumbnailAssetName(_arg_1));
        }

        protected function getThumbnailAssetName(_arg_1:int):String
        {
            if (_SafeStr_3399 == null)
            {
                _SafeStr_3399 = getFullThumbnailAssetName(object.getId(), 32);
                _thumbnailAssetNameNormal = getFullThumbnailAssetName(object.getId(), 64);
            };
            return ((_arg_1 == 32) ? _SafeStr_3399 : _thumbnailAssetNameNormal);
        }

        protected function getFullThumbnailAssetName(_arg_1:int, _arg_2:int):String
        {
            return ([type, _arg_1, "thumb", _arg_2].join("_"));
        }


    }
}

