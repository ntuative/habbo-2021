package com.sulake.habbo.roomevents.userdefinedroomevents.help
{
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components._SafeStr_143;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.localization.ILocalization;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;

    public class UserDefinedRoomEventsHelp 
    {

        private var _roomEvents:HabboUserDefinedRoomEvents;
        private var _SafeStr_3673:IWindowContainer;
        private var _window:IFrameWindow;
        private var _SafeStr_570:IWindowContainer;
        private var _SafeStr_2271:int = 0;
        private var _SafeStr_819:Array;
        private var _SafeStr_3674:_SafeStr_143;
        private var _buttonPrevious:_SafeStr_143;

        public function UserDefinedRoomEventsHelp(_arg_1:HabboUserDefinedRoomEvents)
        {
            _roomEvents = _arg_1;
        }

        public function dispose():void
        {
        }

        private function prepareWindow():void
        {
            if (this._window != null)
            {
                return;
            };
            initLocalizations();
            _window = IFrameWindow(_roomEvents.getXmlWindow("ude_help"));
            _SafeStr_3673 = IWindowContainer(find(_window, "help_container"));
            _buttonPrevious = (_SafeStr_3673.findChildByName("button_previous") as _SafeStr_143);
            if (_buttonPrevious)
            {
                _buttonPrevious.procedure = onButtonClick;
            };
            _SafeStr_3674 = (_SafeStr_3673.findChildByName("button_next") as _SafeStr_143);
            if (_SafeStr_3674)
            {
                _SafeStr_3674.procedure = onButtonClick;
            };
            var _local_1:IWindow = _window.findChildByTag("close");
            _local_1.procedure = onWindowClose;
            _window.center();
        }

        public function open(_arg_1:int=-1, _arg_2:int=-1):void
        {
            prepareWindow();
            openPage();
            _window.visible = true;
            if (_arg_1 >= 0)
            {
                _window.x = _arg_1;
            };
            if (_arg_2 >= 0)
            {
                _window.y = _arg_2;
            };
        }

        private function onWindowClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                close();
            };
        }

        public function close():void
        {
            if (_window)
            {
                _window.visible = false;
            };
        }

        private function find(_arg_1:IWindowContainer, _arg_2:String):IWindow
        {
            var _local_3:IWindow = _arg_1.findChildByName(_arg_2);
            if (_local_3 == null)
            {
                throw (new Error((("Window element with name: " + _arg_2) + " cannot be found!")));
            };
            return (_local_3);
        }

        public function toggle():void
        {
            _window.visible = (!(_window.visible));
        }

        private function openPage():void
        {
            localize();
            checkButtons();
        }

        private function checkButtons():void
        {
            if (_SafeStr_2271 >= (_SafeStr_819.length - 1))
            {
                _SafeStr_3674.disable();
            }
            else
            {
                _SafeStr_3674.enable();
            };
            if (_SafeStr_2271 <= 0)
            {
                _buttonPrevious.disable();
            }
            else
            {
                _buttonPrevious.enable();
            };
        }

        private function nextPage():void
        {
            _SafeStr_2271++;
            _SafeStr_2271 = Math.min(_SafeStr_2271, (_SafeStr_819.length - 1));
            openPage();
        }

        private function previousPage():void
        {
            _SafeStr_2271--;
            _SafeStr_2271 = Math.max(_SafeStr_2271, 0);
            openPage();
        }

        private function initLocalizations():void
        {
            var _local_1:ILocalization;
            var _local_4:ILocalization;
            var _local_3:ILocalization;
            _SafeStr_819 = [];
            var _local_2:int = 1;
            while (_roomEvents.localization.getLocalizationRaw((("wiredfurni.help." + _local_2) + ".title")))
            {
                _local_1 = _roomEvents.localization.getLocalizationRaw((("wiredfurni.help." + _local_2) + ".title"));
                _local_4 = _roomEvents.localization.getLocalizationRaw((("wiredfurni.help." + _local_2) + ".img"));
                _local_3 = _roomEvents.localization.getLocalizationRaw((("wiredfurni.help." + _local_2) + ".text"));
                _SafeStr_819.push([_local_1, _local_4, _local_3]);
                _local_2++;
            };
        }

        private function onButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "button_previous":
                        previousPage();
                        return;
                    case "button_next":
                        nextPage();
                        return;
                };
            };
        }

        private function localize():void
        {
            var _local_1:ILocalization;
            var _local_3:String;
            var _local_5:ITextWindow = (find(_window, "help_title") as ITextWindow);
            var _local_4:ITextWindow = (find(_window, "help_text") as ITextWindow);
            var _local_2:IBitmapWrapperWindow = (find(_window, "help_image") as IBitmapWrapperWindow);
            if (((_SafeStr_819 == null) || (_SafeStr_819.length == 0)))
            {
                return;
            };
            if (_local_5)
            {
                _local_1 = ILocalization(_SafeStr_819[_SafeStr_2271][0]);
                if (_local_1 != null)
                {
                    _local_5.text = _local_1.value;
                };
            };
            if (_local_4)
            {
                _local_1 = ILocalization(_SafeStr_819[_SafeStr_2271][2]);
                if (_local_1 != null)
                {
                    _local_5.text = _local_1.value;
                };
            };
            if (_local_2)
            {
                _local_1 = ILocalization(_SafeStr_819[_SafeStr_2271][1]);
                if (_local_1 != null)
                {
                    _local_3 = _local_1.value;
                    setPreviewFromAsset(_local_3);
                };
            };
        }

        private function setElementImage(_arg_1:IBitmapWrapperWindow, _arg_2:BitmapData):void
        {
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
            var _local_3:int = int(((_arg_1.width - _arg_2.width) / 2));
            var _local_4:int = int(((_arg_1.height - _arg_2.height) / 2));
            if (_arg_1.bitmap == null)
            {
                _arg_1.bitmap = new BitmapData(_arg_1.width, _arg_1.height, true, 0xFFFFFF);
            };
            _arg_1.bitmap.fillRect(_arg_1.bitmap.rect, 0xFFFFFF);
            _arg_1.bitmap.copyPixels(_arg_2, _arg_2.rect, new Point(_local_3, _local_4), null, null, false);
            _arg_1.invalidate();
        }

        private function setPreviewFromAsset(_arg_1:String):void
        {
            if ((((!(_arg_1)) || (!(_roomEvents))) || (!(_roomEvents.assets))))
            {
                return;
            };
            var _local_3:BitmapDataAsset = (_roomEvents.assets.getAssetByName(_arg_1) as BitmapDataAsset);
            if (_local_3 == null)
            {
                retrievePreviewAsset(_arg_1);
                return;
            };
            var _local_2:IBitmapWrapperWindow = (find(_window, "help_image") as IBitmapWrapperWindow);
            if (_local_2)
            {
                setElementImage(_local_2, (_local_3.content as BitmapData));
            };
        }

        private function retrievePreviewAsset(_arg_1:String):void
        {
            if ((((!(_arg_1)) || (!(_roomEvents))) || (!(_roomEvents.assets))))
            {
                return;
            };
            var _local_4:String = _roomEvents.getProperty("image.library.catalogue.url");
            var _local_5:String = ((_local_4 + _arg_1) + ".gif");
            Logger.log(("[ProductViewCatalogWidget] Retrieve Product Preview Asset: " + _local_5));
            var _local_2:URLRequest = new URLRequest(_local_5);
            var _local_3:AssetLoaderStruct = _roomEvents.assets.loadAssetFromFile(_arg_1, _local_2, "image/gif");
            if (!_local_3)
            {
                return;
            };
            _local_3.addEventListener("AssetLoaderEventComplete", onPreviewImageReady);
        }

        private function onPreviewImageReady(_arg_1:AssetLoaderEvent):void
        {
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (_local_2 != null)
            {
                setPreviewFromAsset(_local_2.assetName);
            };
        }


    }
}

