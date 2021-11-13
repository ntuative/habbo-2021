package com.sulake.habbo.ui.widget.furniture.stickie
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.events.RoomWidgetStickieDataUpdateEvent;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetStickieSendUpdateMessage;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class StickieFurniWidget extends RoomWidgetBase
    {

        private static const FIELD_MAX_LINES:int = 14;
        private static const FIELD_MAX_CHARS:int = 500;
        private static const _SafeStr_4079:Number = 100;
        private static const _SafeStr_4080:Number = 100;

        private var _window:IWindowContainer;
        protected var _SafeStr_1922:int = -1;
        protected var _SafeStr_4132:String;
        protected var _text:String;
        protected var _SafeStr_1928:String;
        protected var _SafeStr_1284:Boolean;
        private var _SafeStr_4133:BitmapData;
        protected var _windowName:String = "stickieui_container";

        public function StickieFurniWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        protected function get window():IWindowContainer
        {
            return (_window);
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            hideInterface();
            if (_SafeStr_4133)
            {
                _SafeStr_4133.dispose();
            };
            super.dispose();
        }

        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addEventListener("RWSDUE_STICKIE_DATA", onObjectUpdate);
            super.registerUpdateEvents(_arg_1);
        }

        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.removeEventListener("RWSDUE_STICKIE_DATA", onObjectUpdate);
        }

        protected function onObjectUpdate(_arg_1:RoomWidgetStickieDataUpdateEvent):void
        {
            hideInterface(false);
            _SafeStr_1922 = _arg_1.objectId;
            _SafeStr_4132 = _arg_1.objectType;
            _text = _arg_1.text;
            _SafeStr_1928 = _arg_1.colorHex;
            _SafeStr_1284 = _arg_1.controller;
            showInterface();
        }

        protected function showInterface():void
        {
            var _local_7:ITextFieldWindow;
            var _local_4:BitmapDataAsset;
            var _local_3:BitmapData;
            var _local_2:IBitmapWrapperWindow;
            var _local_6:String;
            if (_SafeStr_1922 == -1)
            {
                return;
            };
            var _local_5:IAsset = assets.getAssetByName("stickie");
            if (_local_5 == null)
            {
                return;
            };
            var _local_1:XmlAsset = XmlAsset(_local_5);
            if (_local_1 == null)
            {
                return;
            };
            if (_window == null)
            {
                _window = (windowManager.createWindow(_windowName, "", 4, 0, (0x020000 | 0x01), new Rectangle(100, 100, 2, 2), null, 0) as IWindowContainer);
                _window.buildFromXML(XML(_local_1.content));
            };
            _local_7 = (_window.findChildByName("text") as ITextFieldWindow);
            if (_local_7 != null)
            {
                _local_7.text = _text;
                _local_7.addEventListener("WE_CHANGE", onTextWindowEvent);
            };
            _local_2 = (_window.findChildByTag("bg") as IBitmapWrapperWindow);
            if (_local_2 != null)
            {
                _local_6 = _SafeStr_4132.replace("post_it", "stickie");
                if (((assets.hasAsset(_local_6)) && (assets.getAssetByName(_local_6) is BitmapDataAsset)))
                {
                    _local_4 = (assets.getAssetByName(_local_6) as BitmapDataAsset);
                }
                else
                {
                    _local_4 = (assets.getAssetByName("stickie_blanco") as BitmapDataAsset);
                    _local_2.color = uint(("0xFF" + _SafeStr_1928));
                };
                _local_3 = (_local_4.content as BitmapData);
                if (_SafeStr_4133)
                {
                    _local_3 = _SafeStr_4133;
                };
                _local_2.bitmap = new BitmapData(_local_2.width, _local_2.height, true, 0);
                _local_2.bitmap.copyPixels(_local_3, _local_3.rect, new Point(0, 0));
            };
            _local_2 = (_window.findChildByTag("close_button") as IBitmapWrapperWindow);
            if (_local_2 != null)
            {
                _local_4 = (assets.getAssetByName("stickie_close") as BitmapDataAsset);
                _local_3 = (_local_4.content as BitmapData);
                _local_2.bitmap = new BitmapData(_local_2.width, _local_2.height, true, 0);
                _local_2.bitmap.copyPixels(_local_3, _local_3.rect, new Point(0, 0));
                _local_2.addEventListener("WME_CLICK", onMouseEvent);
            };
            _local_2 = (_window.findChildByTag("delete_button") as IBitmapWrapperWindow);
            if (((!(_local_2 == null)) && (_SafeStr_1284)))
            {
                _local_4 = (assets.getAssetByName("stickie_remove") as BitmapDataAsset);
                _local_3 = (_local_4.content as BitmapData);
                _local_2.bitmap = new BitmapData(_local_2.width, _local_2.height, true, 0);
                _local_2.bitmap.copyPixels(_local_3, _local_3.rect, new Point(0, 0));
                _local_2.addEventListener("WME_CLICK", onMouseEvent);
            };
            setColorButtons(((_SafeStr_1284) && (_SafeStr_4132 == "post_it")));
        }

        protected function hideInterface(_arg_1:Boolean=true):void
        {
            if (_arg_1)
            {
                sendUpdate();
            };
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
            _SafeStr_1922 = -1;
            _text = null;
            _SafeStr_1284 = false;
        }

        private function setColorButtons(_arg_1:Boolean):void
        {
            var _local_2:IWindow;
            var _local_3:int;
            var _local_4:Array = new Array("blue", "purple", "green", "yellow");
            _local_3 = 0;
            while (_local_3 <= _local_4.length)
            {
                _local_2 = _window.findChildByName(_local_4[_local_3]);
                if (_local_2 != null)
                {
                    if (_arg_1)
                    {
                        _local_2.visible = true;
                        _local_2.addEventListener("WME_CLICK", onMouseEvent);
                    }
                    else
                    {
                        _local_2.visible = false;
                    };
                };
                _local_3++;
            };
        }

        protected function storeTextFromField():Boolean
        {
            var _local_1:ITextFieldWindow = (_window.findChildByName("text") as ITextFieldWindow);
            if (_local_1 == null)
            {
                return (false);
            };
            if (_text == _local_1.text)
            {
                return (false);
            };
            _text = _local_1.text;
            return (true);
        }

        protected function sendUpdate():void
        {
            var _local_1:RoomWidgetStickieSendUpdateMessage;
            if (_SafeStr_1922 == -1)
            {
                return;
            };
            if (!storeTextFromField())
            {
                return;
            };
            if (messageListener != null)
            {
                _local_1 = new RoomWidgetStickieSendUpdateMessage("RWSUM_STICKIE_SEND_UPDATE", _SafeStr_1922, _text, _SafeStr_1928);
                messageListener.processWidgetMessage(_local_1);
            };
        }

        protected function sendSetColor(_arg_1:uint):void
        {
            var _local_3:RoomWidgetStickieSendUpdateMessage;
            if (_SafeStr_1922 == -1)
            {
                return;
            };
            storeTextFromField();
            var _local_2:String = _arg_1.toString(16).toUpperCase();
            if (_local_2.length > 6)
            {
                _local_2 = _local_2.slice((_local_2.length - 6), _local_2.length);
            };
            if (_local_2 == _SafeStr_1928)
            {
                return;
            };
            _SafeStr_1928 = _local_2;
            if (messageListener != null)
            {
                _local_3 = new RoomWidgetStickieSendUpdateMessage("RWSUM_STICKIE_SEND_UPDATE", _SafeStr_1922, _text, _SafeStr_1928);
                messageListener.processWidgetMessage(_local_3);
            };
            showInterface();
        }

        protected function sendDelete():void
        {
            var _local_1:RoomWidgetStickieSendUpdateMessage;
            if (_SafeStr_1922 == -1)
            {
                return;
            };
            if (((!(messageListener == null)) && (_SafeStr_1284)))
            {
                _local_1 = new RoomWidgetStickieSendUpdateMessage("RWSUM_STICKIE_SEND_DELETE", _SafeStr_1922);
                messageListener.processWidgetMessage(_local_1);
            };
        }

        private function onTextWindowEvent(_arg_1:WindowEvent):void
        {
            var _local_2:ITextFieldWindow;
            _local_2 = (_window.findChildByName("text") as ITextFieldWindow);
            if (_local_2 == null)
            {
                return;
            };
            _local_2.maxChars = 500;
            if (_local_2.numLines < 14)
            {
                return;
            };
            _local_2.text = _local_2.text.slice(0, (_local_2.text.length - 1));
            _local_2.maxChars = _local_2.length;
        }

        protected function onMouseEvent(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_3:String = _local_2.name;
            switch (_local_3)
            {
                case "blue":
                case "purple":
                case "green":
                case "yellow":
                    sendSetColor(_local_2.color);
                    return;
                case "close":
                    hideInterface();
                    return;
                case "delete":
                    sendDelete();
                    hideInterface(false);
                    return;
            };
        }


    }
}