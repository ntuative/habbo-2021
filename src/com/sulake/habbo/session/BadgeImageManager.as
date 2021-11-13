package com.sulake.habbo.session
{
    import com.sulake.core.assets.IAssetLibrary;
    import flash.events.IEventDispatcher;
    import com.sulake.core.runtime.ICoreConfiguration;
    import flash.utils.Dictionary;
    import com.sulake.core.assets.AssetLibrary;
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import flash.display.Bitmap;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.geom.Matrix;
    import com.sulake.core.assets.IAsset;

    public class BadgeImageManager 
    {

        public static const _SafeStr_3702:String = "group_badge";
        public static const TYPE_NORMAL:String = "normal_badge";

        private const ASSET_PREFIX:String = "badge_";
        private const ASSET_SMALL_POSTFIX:String = "_32";

        private var _assets:IAssetLibrary;
        private var _SafeStr_913:IEventDispatcher;
        private var _configuration:ICoreConfiguration;
        private var _SafeStr_3703:Dictionary = new Dictionary();

        public function BadgeImageManager(_arg_1:IAssetLibrary, _arg_2:IEventDispatcher, _arg_3:ICoreConfiguration)
        {
            if (_arg_1 == null)
            {
                _arg_1 = new AssetLibrary("badge_images");
            };
            _assets = _arg_1;
            _SafeStr_913 = _arg_2;
            _configuration = _arg_3;
        }

        public function dispose():void
        {
            _assets = null;
        }

        public function getBadgeImage(_arg_1:String, _arg_2:String="normal_badge", _arg_3:Boolean=true, _arg_4:Boolean=false):BitmapData
        {
            var _local_5:BitmapData = getBadgeImageInternal(_arg_1, _arg_2, _arg_4);
            if (((!(_local_5)) && (_arg_3)))
            {
                _local_5 = getPlaceholder();
            };
            return (_local_5);
        }

        public function getSmallBadgeImage(_arg_1:String, _arg_2:String="normal_badge"):BitmapData
        {
            if (((getBadgeImageInternal(_arg_1, _arg_2, true) == null) && (!(getBadgeImageInternal(_arg_1) == null))))
            {
                createSmallBadgeBitmap(("badge_" + _arg_1), _arg_1);
            };
            return (getBadgeImage(_arg_1, _arg_2, false, true));
        }

        public function getBadgeImageWithInfo(_arg_1:String):BadgeInfo
        {
            var _local_2:BitmapData = getBadgeImageInternal(_arg_1);
            return ((_local_2 != null) ? new BadgeInfo(_local_2, false) : new BadgeInfo(getPlaceholder(), true));
        }

        public function getBadgeImageAssetName(_arg_1:String, _arg_2:String="normal_badge", _arg_3:Boolean=false):String
        {
            var _local_4:String = (("badge_" + _arg_1) + ((_arg_3) ? "_32" : ""));
            if (_assets.hasAsset(_local_4))
            {
                return (_local_4);
            };
            getBadgeImageInternal(_arg_1, _arg_2, _arg_3);
            return (null);
        }

        public function getSmallScaleBadgeAssetName(_arg_1:String, _arg_2:String="normal_badge"):String
        {
            var _local_3:String = getBadgeImageAssetName(_arg_1, _arg_2, true);
            if (_local_3 == null)
            {
                createSmallBadgeBitmap(("badge_" + _arg_1), _arg_1);
            }
            else
            {
                return (_local_3);
            };
            return (getBadgeImageAssetName(_arg_1, _arg_2, true));
        }

        private function getBadgeImageInternal(_arg_1:String, _arg_2:String="normal_badge", _arg_3:Boolean=false):BitmapData
        {
            var _local_7:BitmapDataAsset;
            var _local_8:URLRequest;
            var _local_5:String;
            var _local_4:AssetLoaderStruct;
            var _local_6:String = (("badge_" + _arg_1) + ((_arg_3) ? "_32" : ""));
            if (_assets.hasAsset(_local_6))
            {
                _local_7 = (_assets.getAssetByName(_local_6) as BitmapDataAsset);
                return ((_local_7.content as BitmapData).clone());
            };
            if (_arg_3)
            {
                return (null);
            };
            Logger.log(("Request badge: " + _arg_1));
            switch (_arg_2)
            {
                case "normal_badge":
                    if (_configuration != null)
                    {
                        _local_5 = _configuration.getProperty("image.library.url");
                        _local_5 = (_local_5 + (("album1584/" + _arg_1) + ".png"));
                        _local_8 = new URLRequest(_local_5);
                    };
                    break;
                case "group_badge":
                    if (((!(_configuration == null)) && (!(_SafeStr_3703[_local_6]))))
                    {
                        _local_5 = _configuration.getProperty("group.badge.url");
                        _local_5 = _local_5.replace("%imagerdata%", _arg_1);
                        if (_local_5.substr(-4) == ".gif")
                        {
                            _local_5 = (_local_5.slice(0, -3) + "png");
                        };
                        _local_8 = new URLRequest(_local_5);
                        _SafeStr_3703[_local_6] = true;
                    };
            };
            if (_local_8 != null)
            {
                _local_4 = _assets.loadAssetFromFile(_local_6, _local_8, "image/png");
                _local_4.addEventListener("AssetLoaderEventComplete", onBadgeImageReady);
            };
            return (null);
        }

        private function getPlaceholder():BitmapData
        {
            return (BitmapData(_assets.getAssetByName("loading_icon").content).clone());
        }

        private function onBadgeImageReady(_arg_1:AssetLoaderEvent):void
        {
            var _local_4:String;
            var _local_3:String;
            var _local_2:Bitmap;
            var _local_5:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (_local_5 != null)
            {
                if (((!(_local_5.assetLoader == null)) && (!(_local_5.assetLoader.content == null))))
                {
                    _local_4 = _local_5.assetName;
                    _local_3 = _local_4.replace("badge_", "");
                    _local_2 = (_local_5.assetLoader.content as Bitmap);
                    if (_local_2 == null)
                    {
                        return;
                    };
                    _SafeStr_913.dispatchEvent(new BadgeImageReadyEvent(_local_3, _local_2.bitmapData.clone()));
                };
            };
        }

        private function createSmallBadgeBitmap(_arg_1:String, _arg_2:String):void
        {
            var _local_4:BitmapDataAsset;
            var _local_3:BitmapData = renderSmallScaleBadgeBitmap(_arg_1);
            if (_local_3)
            {
                _local_4 = new BitmapDataAsset(_assets.getAssetTypeDeclarationByClass(BitmapDataAsset));
                if (_local_4 != null)
                {
                    _assets.setAsset((("badge_" + _arg_2) + "_32"), _local_4);
                    _local_4.setUnknownContent(_local_3);
                };
            };
        }

        private function renderSmallScaleBadgeBitmap(_arg_1:String):BitmapData
        {
            var _local_3:BitmapData;
            var _local_5:BitmapData;
            var _local_2:Matrix;
            var _local_4:IAsset = _assets.getAssetByName(_arg_1);
            if (_local_4 != null)
            {
                _local_3 = (_local_4.content as BitmapData);
                _local_5 = new BitmapData((_local_3.width / 2), (_local_3.height / 2), true, 0);
                _local_2 = new Matrix(0.5, 0, 0, 0.5);
                _local_5.draw(_local_3, _local_2, null, null, null, true);
                return (_local_5);
            };
            return (null);
        }


    }
}

