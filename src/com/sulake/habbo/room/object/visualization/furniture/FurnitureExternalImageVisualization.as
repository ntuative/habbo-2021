package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.habbo.room.object.visualization.data.ExtraDataManager;
    import com.adobe.serialization.json.JSONDecoder;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.display.BitmapData;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import com.sulake.room.object.visualization.IRoomObjectSprite;

    public class FurnitureExternalImageVisualization extends ExternalIsometricImageFurniVisualization 
    {

        private var _SafeStr_3304:Boolean;
        private var _SafeStr_3305:String;
        private var _SafeStr_3306:String;
        private var _SafeStr_780:String;
        private var _SafeStr_3307:Boolean = false;
        private var _SafeStr_3308:String = "";
        private var _SafeStr_3309:String;

        public function FurnitureExternalImageVisualization():void
        {
            hasOutline = true;
        }

        override public function setExternalBaseUrls(_arg_1:String, _arg_2:String, _arg_3:Boolean):void
        {
            _SafeStr_3305 = _arg_1;
            _SafeStr_3306 = _arg_2;
            _SafeStr_3304 = _arg_3;
        }

        override protected function getThumbnailURL():String
        {
            var _local_2:String;
            var _local_3:String;
            if ((((!(object)) || (_SafeStr_3305 == "disabled")) || (_SafeStr_780 == "REJECTED")))
            {
                return (null);
            };
            if (_SafeStr_780)
            {
                return (_SafeStr_780);
            };
            var _local_1:String = object.getModel().getString("furniture_data");
            if (_local_1 == null)
            {
                return (null);
            };
            try
            {
                if (object.getType().indexOf("external_image_wallitem_poster") != -1)
                {
                    _SafeStr_3308 = "";
                }
                else
                {
                    _SafeStr_3308 = "postcards/selfie/";
                };
                _local_2 = getJsonValue(_local_1, "id", null);
                if (((_local_2) && (_local_2.length > 0)))
                {
                    if (!_SafeStr_3307)
                    {
                        _SafeStr_3309 = _local_2;
                        _SafeStr_3307 = true;
                        if (_SafeStr_3304)
                        {
                            ExtraDataManager.requestExtraDataUrl(this);
                        }
                        else
                        {
                            loadExtraData(_local_2);
                        };
                    };

                    return null;
                };
                _local_3 = getJsonValue(_local_1, "w", "url");
                _local_3 = buildThumbnailUrl(_local_3, _SafeStr_3308);
            }
            catch(error:Error)
            {
                return (null);
            };
            _SafeStr_780 = _local_3;
            return (_local_3);
        }

        public function getExternalImageUUID():String
        {
            return (_SafeStr_3309);
        }

        private function buildThumbnailUrl(_arg_1:String, _arg_2:String):String
        {
            if (_arg_1 == "REJECTED")
            {
                return (_arg_1);
            };
            if (_arg_1.indexOf("http") != 0)
            {
                _arg_1 = ((_SafeStr_3305 + _arg_2) + _arg_1);
            };
            _arg_1 = _arg_1.replace(".png", "_small.png");
            if (_arg_1.indexOf(".png") == -1)
            {
                _arg_1 = (_arg_1 + "_small.png");
            };
            return (_arg_1);
        }

        private function getJsonValue(_arg_1:String, _arg_2:String, _arg_3:String):String
        {
            var _local_5:Object = new JSONDecoder(_arg_1, false).getValue();
            var _local_4:String = _local_5[_arg_2];
            if (((_local_4 == null) && (!(_arg_3 == null))))
            {
                _local_4 = _local_5[_arg_3];
            };
            return (_local_4);
        }

        private function loadExtraData(_arg_1:String):void
        {
            var _local_3:String = (_SafeStr_3306 + _arg_1);
            var _local_2:URLLoader = new URLLoader(new URLRequest(_local_3));
            _local_2.addEventListener("complete", onExtraDataLoaded);
            _local_2.addEventListener("ioError", onExtraDataError);
            _SafeStr_3307 = true;
        }

        private function onExtraDataError(_arg_1:Event):void
        {
            Logger.log(("Extra data failed to load " + _arg_1.toString()));
        }

        private function onExtraDataLoaded(_arg_1:Event):void
        {
            var _local_2:String = URLLoader(_arg_1.target).data;
            if (_local_2.length == 0)
            {
                return;
            };
            var _local_3:String = getJsonValue(_local_2, "w", "url");
            _SafeStr_780 = buildThumbnailUrl(_local_3, _SafeStr_3308);
        }

        public function onUrlFromExtraDataService(_arg_1:String):void
        {
            _SafeStr_780 = buildThumbnailUrl(_arg_1, _SafeStr_3308);
        }

        public function getExtraDataUrl():String
        {
            return (_SafeStr_3306);
        }

        override public function dispose():void
        {
            ExtraDataManager.furnitureDisposed(this);
            super.dispose();
        }

        override public function getImage(_arg_1:int, _arg_2:int):BitmapData
        {
            if (!assetCollection)
            {
                return (new BitmapData(1, 1, true, 0));
            };
            var _local_3:String = getFullThumbnailAssetName(_arg_2, 32);
            if (((assetCollection.getAsset(_local_3) == null) && (object)))
            {
                _local_3 = (object.getType() + "_icon_a");
            };
            if (assetCollection.getAsset(_local_3) == null)
            {
                return (new BitmapData(1, 1, true, 0));
            };
            var _local_4:Object = assetCollection.getAsset(_local_3).asset.content;
            if (!_local_4)
            {
                return (new BitmapData(1, 1, true, 0));
            };
            return ((_local_4 as BitmapData).clone());
        }

        override protected function getLibraryAssetNameForSprite(_arg_1:IGraphicAsset, _arg_2:IRoomObjectSprite):String
        {
            return (_SafeStr_780);
        }


    }
}

