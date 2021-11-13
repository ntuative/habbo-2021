package com.sulake.habbo.game.snowwar.utils
{
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.display.Bitmap;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.ITextWindow;

    public class WindowUtils
    {

        private static var _assets:IAssetLibrary;
        private static var _windowManager:IHabboWindowManager;


        public static function setCaption(_arg_1:IWindow, _arg_2:String):void
        {
            var _local_3:IWindow;
            _arg_1.caption = _arg_2;
            if ((_arg_1.parent is IWindowContainer))
            {
                _local_3 = (_arg_1.parent as IWindowContainer).findChildByName((_arg_1.name + "_stroke"));
            };
            if ((_arg_1.parent is IItemListWindow))
            {
                _local_3 = (_arg_1.parent as IItemListWindow).getListItemByName((_arg_1.name + "_stroke"));
            };
            if ((_arg_1.parent is IItemGridWindow))
            {
                _local_3 = (_arg_1.parent as IItemGridWindow).getGridItemByName((_arg_1.name + "_stroke"));
            };
            if (_local_3)
            {
                if (_local_3.caption != _arg_2)
                {
                    _local_3.caption = _arg_2;
                };
            };
        }

        public static function init(_arg_1:IAssetLibrary, _arg_2:IHabboWindowManager):void
        {
            _assets = _arg_1;
            _windowManager = _arg_2;
        }

        public static function setElementImage(_arg_1:IWindow, _arg_2:BitmapData, _arg_3:int=0, _arg_4:int=0, _arg_5:int=0):void
        {
            var _local_9:IBitmapWrapperWindow;
            var _local_6:IDisplayObjectWrapper;
            if (_arg_2 == null)
            {
                return;
            };
            if (_arg_1 == null)
            {
                return;
            };
            if (_arg_1.disposed)
            {
                return;
            };
            var _local_10:int = ((_arg_3 > 0) ? _arg_3 : _arg_1.height);
            var _local_7:int = int((((_arg_1.width - _arg_2.width) / 2) + _arg_4));
            var _local_8:int = int((((_local_10 - _arg_2.height) / 2) + _arg_5));
            if ((_arg_1 as IBitmapWrapperWindow) != null)
            {
                _local_9 = IBitmapWrapperWindow(_arg_1);
                if (((_local_9.bitmap == null) || (_arg_3 > 0)))
                {
                    _local_9.bitmap = new BitmapData(_arg_1.width, _local_10, true, 0xFFFFFF);
                };
                _local_9.bitmap.fillRect(_local_9.bitmap.rect, 0xFFFFFF);
                _local_9.bitmap.copyPixels(_arg_2, _arg_2.rect, new Point(_local_7, _local_8), null, null, false);
                _arg_1.invalidate();
            }
            else
            {
                if ((_arg_1 as IDisplayObjectWrapper) != null)
                {
                    _local_6 = IDisplayObjectWrapper(_arg_1);
                    _local_6.setDisplayObject(new Bitmap(_arg_2));
                };
            };
        }

        public static function createWindow(_arg_1:String, _arg_2:int=2):IWindow
        {
            HabboGamesCom.log(("CreateWindow: " + _arg_1));
            if (((!(_assets)) || (!(_windowManager))))
            {
                return (null);
            };
            var _local_4:XmlAsset = (_assets.getAssetByName(_arg_1) as XmlAsset);
            if (_local_4 == null)
            {
                HabboGamesCom.log(("CreateWindow() could not find the asset for window: " + _arg_1));
                return (null);
            };
            var _local_5:IWindow = _windowManager.buildFromXML((_local_4.content as XML), _arg_2);
            var _local_3:Array = [];
            if ((_local_5 is IWindowContainer))
            {
                (_local_5 as IWindowContainer).groupChildrenWithTag("bitmap", _local_3, -1);
            }
            else
            {
                if ((_local_5 is IItemListWindow))
                {
                    (_local_5 as IItemListWindow).groupListItemsWithTag("bitmap", _local_3, -1);
                }
                else
                {
                    if ((_local_5 is IItemGridWindow))
                    {
                    };
                };
            };
            for each (var _local_7:IWindow in _local_3)
            {
                HabboGamesCom.log(("Found child: " + _local_7.name));
            };
            for each (var _local_6:IBitmapWrapperWindow in _local_3)
            {
                if (_local_6 != null)
                {
                    setDefaultElementImage(_local_6, false);
                };
            };
            return (_local_5);
        }

        private static function setDefaultElementImage(_arg_1:IBitmapWrapperWindow, _arg_2:Boolean):void
        {
            var bmpWindow:IBitmapWrapperWindow = _arg_1;
            var active:Boolean = _arg_2;
            if (!_assets)
            {
                return;
            };
            if (bmpWindow == null)
            {
                return;
            };
            var result:Array = bmpWindow.properties.filter(function (_arg_1:*, _arg_2:int, _arg_3:Array):Boolean
            {
                return (PropertyStruct(_arg_1).key == "bitmap_asset_name");
            });
            var offset:Point = new Point();
            if (((result) && (result.length)))
            {
                var assetName:String = (PropertyStruct(result[0]).value as String);
                HabboGamesCom.log(((("Found Image: " + bmpWindow.name) + " : ") + assetName));
                if (active)
                {
                    assetName = assetName.replace("_on", "");
                };
                var asset:IAsset = _assets.getAssetByName(assetName);
                if (((asset) && (asset is BitmapDataAsset)))
                {
                    bmpWindow.bitmap = new BitmapData(bmpWindow.width, bmpWindow.height, true, 0);
                    var src:BitmapData = (asset.content as BitmapData);
                    offset.x = ((bmpWindow.width - src.width) / 2);
                    offset.y = ((bmpWindow.height - src.height) / 2);
                    bmpWindow.bitmap.copyPixels(src, src.rect, offset);
                };
            };
        }

        public static function hideElement(_arg_1:IWindowContainer, _arg_2:String):void
        {
            var _local_4:IWindow = _arg_1.findChildByName(_arg_2);
            if (_local_4)
            {
                _local_4.visible = false;
            };
            var _local_3:IWindow = _arg_1.findChildByName((_arg_2 + "_stroke"));
            if (_local_3)
            {
                _local_3.visible = false;
            };
        }

        public static function colorStrokes(_arg_1:IWindow, _arg_2:uint):void
        {
            var _local_3:Array = [];
            if ((_arg_1 is IWindowContainer))
            {
                (_arg_1 as IWindowContainer).groupChildrenWithTag("stroke", _local_3, 10);
            }
            else
            {
                if ((_arg_1 is IItemListWindow))
                {
                    (_arg_1 as IItemListWindow).groupListItemsWithTag("stroke", _local_3, 10);
                }
                else
                {
                    if ((_arg_1 is IItemGridWindow))
                    {
                    };
                };
            };
            for each (var _local_4:ITextWindow in _local_3)
            {
                if (_local_4 != null)
                {
                    _local_4.textColor = _arg_2;
                };
            };
        }

        public static function showElement(_arg_1:IWindowContainer, _arg_2:String):void
        {
            var _local_4:IWindow = _arg_1.findChildByName(_arg_2);
            if (_local_4)
            {
                _local_4.visible = true;
            };
            var _local_3:IWindow = _arg_1.findChildByName((_arg_2 + "_stroke"));
            if (_local_3)
            {
                _local_3.visible = true;
            };
        }


    }
}
