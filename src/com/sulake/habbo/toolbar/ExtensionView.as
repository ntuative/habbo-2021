package com.sulake.habbo.toolbar
{
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.Core;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindow;
    import flash.utils.Timer;
    import com.sulake.habbo.toolbar.events.ExtensionViewEvent;
    import flash.events.TimerEvent;
    import flash.geom.Rectangle;

    public class ExtensionView implements IExtensionView 
    {

        private static const MARGIN:int = 3;
        private static const PURSE_EXTENSION_OFFSET:int = -8;

        private var _toolbar:HabboToolbar;
        private var _SafeStr_3812:IItemListWindow;
        private var _items:Map;
        private var _disposed:Boolean = false;
        private var _landingView:Boolean = false;
        private var _SafeStr_3813:Array = [];
        private var _windowManager:IHabboWindowManager;
        private var _extraMargin:int = 0;

        public function ExtensionView(_arg_1:IHabboWindowManager, _arg_2:IAssetLibrary, _arg_3:HabboToolbar)
        {
            _toolbar = _arg_3;
            _windowManager = _arg_1;
            var _local_5:XmlAsset = (_arg_2.getAssetByName("extension_grid_xml") as XmlAsset);
            if (_local_5)
            {
                _SafeStr_3812 = (_arg_1.buildFromXML((_local_5.content as XML), 1) as IItemListWindow);
            };
            var _local_4:IWindowContainer = _SafeStr_3812.desktop;
            if (_SafeStr_3812)
            {
                _SafeStr_3812.x = (((_local_4.width - _SafeStr_3812.width) - 3) - extraMargin);
                _SafeStr_3812.y = 3;
                _SafeStr_3812.visible = true;
            }
            else
            {
                Core.error("Unable to initialize Toolbar Extension view window from xml asset", false);
            };
            _items = new Map();
        }

        public function dispose():void
        {
            var _local_1:Array;
            var _local_2:String;
            if (!_disposed)
            {
                _local_1 = _items.getKeys();
                for each (_local_2 in _local_1)
                {
                    detachExtension(_local_2);
                };
                if (_SafeStr_3812)
                {
                    _SafeStr_3812.dispose();
                    _SafeStr_3812 = null;
                };
                _SafeStr_3813 = null;
                _toolbar = null;
                _items = null;
                _disposed = true;
            };
        }

        public function get visible():Boolean
        {
            return ((_SafeStr_3812) && (_SafeStr_3812.visible));
        }

        public function get screenHeight():uint
        {
            if (!_SafeStr_3812)
            {
                return (0);
            };
            return (_SafeStr_3812.height + _SafeStr_3812.y);
        }

        public function attachExtension(_arg_1:String, _arg_2:IWindow, _arg_3:int=-1, _arg_4:Array=null):void
        {
            if (!_disposed)
            {
                if (_items.getValue(_arg_1))
                {
                    return;
                };
                _items.add(_arg_1, _arg_2);
                _arg_3 = ((_arg_4 != null) ? resolveIndex(_arg_4) : _arg_3);
                if (_arg_3 == -1)
                {
                    _SafeStr_3813.push(_arg_2);
                }
                else
                {
                    _SafeStr_3813.splice(_arg_3, 0, _arg_2);
                };
                if (_SafeStr_3812)
                {
                    _toolbar.createAndAttachDimmerWindow((_arg_2 as IWindowContainer));
                    refreshItemWindow();
                };
                queueResizeEvent();
            };
        }

        public function hasExtension(_arg_1:String):Boolean
        {
            return (!(_items.getValue(_arg_1) == null));
        }

        private function getKeyForWindow(_arg_1:IWindow):String
        {
            var _local_2:int = _items.getValues().indexOf(_arg_1);
            if (_local_2 != -1)
            {
                return (_items.getKeys()[_local_2]);
            };
            return ("");
        }

        public function refreshItemWindow():void
        {
            var _local_2:String;
            _SafeStr_3812.removeListItems();
            for each (var _local_1:IWindow in _SafeStr_3813)
            {
                _local_2 = getKeyForWindow(_local_1);
                switch (_local_2)
                {
                    case "logout_tools":
                    case "purse_credits":
                    case "purse_engagement_currency":
                    case "purse_habbo_club":
                    case "purse_seasonal_currency":
                    case "talent_promo":
                    case "club_promo":
                    case "vip_quests":
                    case "video_offers":
                    case "settings":
                    case "phone_number":
                    case "verification_code":
                    case "return_gift":
                    case "targeted_offer":
                        _SafeStr_3812.addListItem(_local_1);
                        break;
                    case "purse":
                        _SafeStr_3812.addListItem(_local_1);
                        _SafeStr_3812.y = (3 + -8);
                        break;
                    default:
                        if (!_landingView)
                        {
                            _SafeStr_3812.addListItem(_local_1);
                        };
                };
            };
            _SafeStr_3812.arrangeListItems();
            _SafeStr_3812.invalidate();
        }

        private function resolveIndex(_arg_1:Array):int
        {
            var _local_2:int;
            _local_2 = 0;
            while (_local_2 < _SafeStr_3813.length)
            {
                if (_arg_1.indexOf(_SafeStr_3813[_local_2].name) > -1)
                {
                    return (_local_2);
                };
                _local_2++;
            };
            return (-1);
        }

        public function detachExtension(_arg_1:String):void
        {
            var _local_2:IWindowContainer;
            if (!_disposed)
            {
                _local_2 = _items[_arg_1];
                if (_local_2 != null)
                {
                    _SafeStr_3813.splice(_SafeStr_3813.indexOf(_local_2), 1);
                    if (_SafeStr_3812)
                    {
                        _toolbar.removeDimmer(_local_2);
                        refreshItemWindow();
                    };
                };
                _items.remove(_arg_1);
                queueResizeEvent();
            };
        }

        private function queueResizeEvent():void
        {
            var _local_1:Timer = new Timer(25, 1);
            _local_1.addEventListener("timerComplete", onResizeTimer);
            _local_1.start();
        }

        private function onResizeTimer(_arg_1:TimerEvent):void
        {
            if (_toolbar)
            {
                _toolbar.events.dispatchEvent(new ExtensionViewEvent("EVE_EXTENSION_VIEW_RESIZED"));
            };
        }

        public function set visible(_arg_1:Boolean):void
        {
            if (_SafeStr_3812)
            {
                _SafeStr_3812.visible = _arg_1;
            };
        }

        public function removeDimmers():void
        {
            for each (var _local_1:IWindowContainer in _SafeStr_3813)
            {
                _toolbar.removeDimmer(_local_1);
            };
        }

        public function getIconLocation(_arg_1:String):Rectangle
        {
            var _local_3:IWindow;
            var _local_2:Rectangle;
            switch (_arg_1)
            {
                case "HTIE_EXT_GROUP":
                    _local_3 = (_items["room_group_info"] as IWindow);
            };
            if (((!(_local_3 == null)) && (_local_3.visible)))
            {
                _local_2 = new Rectangle();
                _local_3.getGlobalRectangle(_local_2);
                return (_local_2);
            };
            return (null);
        }

        public function getIcon(_arg_1:String):IWindow
        {
            var _local_2:IWindow;
            if (_arg_1 == "HTIE_EXT_GROUP")
            {
                _local_2 = (_items["room_group_info"] as IWindow);
            };
            return (_local_2);
        }

        public function get landingView():Boolean
        {
            return (_landingView);
        }

        public function set landingView(_arg_1:Boolean):void
        {
            _landingView = _arg_1;
            refreshItemWindow();
        }

        public function set extraMargin(_arg_1:int):void
        {
            _extraMargin = _arg_1;
            if (_SafeStr_3812)
            {
                _SafeStr_3812.x = (((_SafeStr_3812.desktop.width - _SafeStr_3812.width) - 3) - extraMargin);
            };
        }

        public function get extraMargin():int
        {
            return (_extraMargin);
        }


    }
}

