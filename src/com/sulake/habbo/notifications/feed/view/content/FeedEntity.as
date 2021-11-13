package com.sulake.habbo.notifications.feed.view.content
{
    import __AS3__.vec.Vector;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.notifications.feed.NotificationController;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.assets.IAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.localization.ILocalization;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;

    public class FeedEntity implements IFeedEntity 
    {

        private static const _SafeStr_3006:Vector.<FeedEntity> = new Vector.<FeedEntity>();
        protected static const LIST:String = "content_list";
        protected static const TITLE:String = "title";
        protected static const MESSAGE:String = "message";
        protected static const TIME:String = "time";
        protected static const ICON:String = "icon";
        protected static const DECORATION:String = "decoration";
        protected static const ACTION_BUTTON:String = "action_button";
        protected static const UNIT_MINUTES:String = "minutes";
        protected static const UNIT_HOURS:String = "hours";
        protected static const _SafeStr_3007:String = "days";
        private static const BUTTON_HEIGHT:int = 25;

        public static var _SafeStr_647:IWindowContainer;
        public static var _SafeStr_648:IHabboLocalizationManager;
        public static var ASSETS:IAssetLibrary;
        public static var FEED_CONTROLLER:NotificationController;

        protected var _window:IWindowContainer;
        protected var _disposed:Boolean = false;
        protected var _SafeStr_1037:Boolean = false;
        protected var _SafeStr_698:int = -1;
        protected var _SafeStr_3008:int;
        protected var _iconFilePath:String;
        protected var _decorationFilePath:String;
        protected var _buttonAction:String;

        public function FeedEntity():void
        {
            _window = (_SafeStr_647.clone() as IWindowContainer);
        }

        public static function assignHandles(_arg_1:IHabboWindowManager, _arg_2:IAssetLibrary, _arg_3:IHabboLocalizationManager, _arg_4:NotificationController):void
        {
            _SafeStr_647 = (_arg_1.buildFromXML((_arg_2.getAssetByName("feed_entity_xml").content as XML)) as IWindowContainer);
            ASSETS = _arg_2;
            _SafeStr_648 = _arg_3;
            FEED_CONTROLLER = _arg_4;
        }

        public static function removeHandles():void
        {
            if (_SafeStr_647)
            {
                _SafeStr_647.dispose();
                _SafeStr_647 = null;
            };
            ASSETS = null;
            _SafeStr_648 = null;
            FEED_CONTROLLER = null;
        }

        public static function allocate():FeedEntity
        {
            var _local_1:FeedEntity = ((_SafeStr_3006.length > 0) ? _SafeStr_3006.pop() : new FeedEntity());
            _local_1._SafeStr_1037 = false;
            return (_local_1);
        }


        public function set id(_arg_1:int):void
        {
            _SafeStr_698 = _arg_1;
        }

        public function get id():int
        {
            return (_SafeStr_698);
        }

        public function set title(_arg_1:String):void
        {
            _window.findChildByName("title").caption = ((_arg_1) ? _arg_1 : "");
        }

        public function get title():String
        {
            return ((_window) ? _window.findChildByName("title").caption : null);
        }

        public function set message(_arg_1:String):void
        {
            _window.findChildByName("message").caption = ((_arg_1) ? _arg_1 : "");
        }

        public function get message():String
        {
            return ((_window) ? _window.findChildByName("message").caption : null);
        }

        public function setButton(_arg_1:String, _arg_2:String):void
        {
            if (!_window)
            {
                return;
            };
            _buttonAction = _arg_1;
            var _local_3:_SafeStr_101 = (_window.findChildByName("action_button") as _SafeStr_101);
            if (_buttonAction == null)
            {
                _local_3.height = 0;
            }
            else
            {
                _local_3.height = 25;
                _local_3.caption = _arg_2;
                _local_3.addEventListener("WME_CLICK", onActionButton);
            };
        }

        public function set iconFilePath(_arg_1:String):void
        {
            var _local_2:IAsset;
            if (!_arg_1)
            {
                return;
            };
            if (_arg_1 != _iconFilePath)
            {
                _iconFilePath = _arg_1;
                _local_2 = ASSETS.getAssetByName(_arg_1);
                if (_local_2)
                {
                    icon = (_local_2.content as BitmapData);
                }
                else
                {
                    loadImageUrl(_arg_1);
                };
            };
        }

        public function set decorationFilePath(_arg_1:String):void
        {
            var _local_2:IAsset;
            if (!_arg_1)
            {
                return;
            };
            if (_arg_1 != _decorationFilePath)
            {
                _decorationFilePath = _arg_1;
                _local_2 = ASSETS.getAssetByName(_arg_1);
                if (_local_2)
                {
                    decoration = (_local_2.content as BitmapData);
                }
                else
                {
                    loadImageUrl(_arg_1);
                };
            };
        }

        public function set icon(_arg_1:BitmapData):void
        {
            if (((disposed) || (!(_window))))
            {
                return;
            };
            var _local_2:IBitmapWrapperWindow = (_window.findChildByName("icon") as IBitmapWrapperWindow);
            updateImage(_local_2, _arg_1);
            _iconFilePath = null;
        }

        public function set decoration(_arg_1:BitmapData):void
        {
            if (((disposed) || (!(_window))))
            {
                return;
            };
            var _local_2:IBitmapWrapperWindow = (_window.findChildByName("decoration") as IBitmapWrapperWindow);
            updateImage(_local_2, _arg_1);
            _decorationFilePath = null;
        }

        public function get window():IWindowContainer
        {
            return (_window);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get recycled():Boolean
        {
            return (_SafeStr_1037);
        }

        public function set minutesElapsed(_arg_1:int):void
        {
            var _local_4:ITextWindow = (_window.findChildByName("time") as ITextWindow);
            if (_arg_1 < 0)
            {
                _local_4.height = 0;
                return;
            };
            _SafeStr_3008 = _arg_1;
            var _local_3:String = "minutes";
            if (_SafeStr_3008 >= 1440)
            {
                _local_3 = "days";
                _arg_1 = int((_arg_1 / 1440));
            }
            else
            {
                if (_SafeStr_3008 >= 60)
                {
                    _local_3 = "hours";
                    _arg_1 = int((_arg_1 / 60));
                };
            };
            var _local_2:ILocalization = _SafeStr_648.getLocalizationRaw((("friendbar.stream." + _local_3) + ".ago"));
            _local_4.caption = ((_local_2) ? _local_2.raw.replace("%value%", String(_arg_1)) : "...?");
        }

        public function get minutesElapsed():int
        {
            return (_SafeStr_3008);
        }

        public function updateContainerSize():void
        {
            if (((!(_window)) || (disposed)))
            {
                return;
            };
            var _local_2:IItemListWindow = (_window.findChildByName("content_list") as IItemListWindow);
            var _local_1:IWindow = (_local_2.getListItemAt((_local_2.numListItems - 1)) as IWindow);
            _local_2.height = ((_local_1) ? (_local_1.y + _local_1.height) : 0);
        }

        public function recycle():void
        {
            if (!_SafeStr_1037)
            {
                if (!_disposed)
                {
                    _window.parent = null;
                    IBitmapWrapperWindow(_window.findChildByName("decoration")).bitmap = null;
                    IBitmapWrapperWindow(_window.findChildByName("icon")).bitmap = null;
                    (_window.findChildByName("action_button") as _SafeStr_101).removeEventListener("WME_CLICK", onActionButton);
                    _decorationFilePath = null;
                    _SafeStr_1037 = true;
                    _SafeStr_3006.push(this);
                };
            };
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_window)
                {
                    _window.dispose();
                    _window = null;
                };
                if (_SafeStr_1037)
                {
                    _SafeStr_3006.splice(_SafeStr_3006.indexOf(this), 1);
                    _SafeStr_1037 = false;
                };
                _disposed = true;
            };
        }

        protected function onActionButton(_arg_1:WindowMouseEvent):void
        {
            FEED_CONTROLLER.executeAction(_buttonAction);
        }

        private function updateImage(_arg_1:IBitmapWrapperWindow, _arg_2:BitmapData):void
        {
            if (_arg_2 == null)
            {
                _arg_1.bitmap = null;
                _arg_1.height = 0;
                return;
            };
            var _local_4:Number = (_arg_1.x + (_arg_1.width / 2));
            var _local_3:Number = (_arg_1.y + (_arg_1.height / 2));
            _arg_1.bitmap = _arg_2;
            _arg_1.x = (_local_4 - (_arg_2.width / 2));
            _arg_1.y = (_local_3 - (_arg_2.height / 2));
            _arg_1.width = _arg_2.width;
            _arg_1.height = _arg_2.height;
        }

        private function loadImageUrl(_arg_1:String):void
        {
            var _local_2:AssetLoaderStruct = ASSETS.loadAssetFromFile(_arg_1, new URLRequest(_arg_1));
            _local_2.addEventListener("AssetLoaderEventComplete", onImageFileLoaded);
            _local_2.addEventListener("AssetLoaderEventError", onImageFileLoaded);
        }

        private function onImageFileLoaded(_arg_1:AssetLoaderEvent):void
        {
            var _local_2:AssetLoaderStruct;
            var _local_3:IAsset;
            if (_arg_1.type == "AssetLoaderEventComplete")
            {
                _local_2 = (_arg_1.target as AssetLoaderStruct);
                if (_local_2.assetName == _decorationFilePath)
                {
                    _local_3 = ASSETS.getAssetByName(_decorationFilePath);
                    if (_local_3)
                    {
                        decoration = (_local_3.content as BitmapData);
                    };
                }
                else
                {
                    if (_local_2.assetName == _iconFilePath)
                    {
                        _local_3 = ASSETS.getAssetByName(_iconFilePath);
                        if (_local_3)
                        {
                            icon = (_local_3.content as BitmapData);
                        };
                    };
                };
                updateContainerSize();
            };
        }


    }
}

