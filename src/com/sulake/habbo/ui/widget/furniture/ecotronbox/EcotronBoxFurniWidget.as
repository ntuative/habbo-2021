package com.sulake.habbo.ui.widget.furniture.ecotronbox
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.events.RoomWidgetEcotronBoxDataUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPresentDataUpdateEvent;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import flash.geom.Rectangle;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetEcotronBoxOpenMessage;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class EcotronBoxFurniWidget extends RoomWidgetBase 
    {

        private static const _SafeStr_4079:Number = 100;
        private static const _SafeStr_4080:Number = 100;

        private var _window:IWindowContainer;
        private var _SafeStr_1922:int = -1;
        private var _text:String;
        private var _SafeStr_1284:Boolean;
        private var _SafeStr_4088:Boolean = false;
        private var _furniTypeName:String = "ecotron_box";
        private var _interfaceMapByFurniTypeName:Map = new Map();

        public function EcotronBoxFurniWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            _interfaceMapByFurniTypeName.add("", "ecotronbox_card");
            _interfaceMapByFurniTypeName.add("ecotron_box", "ecotronbox_card");
            _interfaceMapByFurniTypeName.add("matic_box", "ecotronbox_card_furnimatic");
        }

        override public function dispose():void
        {
            hideInterface();
            super.dispose();
        }

        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addEventListener("RWEBDUE_PACKAGEINFO", onObjectUpdate);
            _arg_1.addEventListener("RWEBDUE_CONTENTS", onObjectUpdate);
            _arg_1.addEventListener("RWROUE_FURNI_REMOVED", onRoomObjectRemoved);
            _arg_1.addEventListener("RWPDUE_PACKAGEINFO", onPresentUpdate);
            super.registerUpdateEvents(_arg_1);
        }

        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.removeEventListener("RWEBDUE_PACKAGEINFO", onObjectUpdate);
            _arg_1.removeEventListener("RWEBDUE_CONTENTS", onObjectUpdate);
            _arg_1.removeEventListener("RWPDUE_PACKAGEINFO", onPresentUpdate);
            _arg_1.removeEventListener("RWROUE_FURNI_REMOVED", onRoomObjectRemoved);
        }

        private function onObjectUpdate(_arg_1:RoomWidgetEcotronBoxDataUpdateEvent):void
        {
            hideInterface();
            switch (_arg_1.type)
            {
                case "RWEBDUE_PACKAGEINFO":
                    _SafeStr_4088 = false;
                    _SafeStr_1922 = _arg_1.objectId;
                    _text = _arg_1.text;
                    _SafeStr_1284 = _arg_1.controller;
                    _furniTypeName = _arg_1.furniTypeName;
                    showInterface();
                    return;
                case "RWEBDUE_CONTENTS":
                    if (!_SafeStr_4088)
                    {
                        return;
                    };
                    _SafeStr_1922 = _arg_1.objectId;
                    showInterface();
                    showIcon(_arg_1.iconBitmapData);
                    showDescription(_arg_1.text);
                    setOpenButton(false);
                    return;
            };
        }

        private function onRoomObjectRemoved(_arg_1:RoomWidgetRoomObjectUpdateEvent):void
        {
            if (_arg_1.id == _SafeStr_1922)
            {
                hideInterface();
            };
        }

        private function onPresentUpdate(_arg_1:RoomWidgetPresentDataUpdateEvent):void
        {
            switch (_arg_1.type)
            {
                case "RWPDUE_PACKAGEINFO":
                    hideInterface();
                    return;
            };
        }

        private function showIcon(_arg_1:BitmapData):void
        {
            if (_arg_1 == null)
            {
                _arg_1 = new BitmapData(1, 1);
            };
            if (_window == null)
            {
                return;
            };
            var _local_4:IBitmapWrapperWindow = (_window.findChildByName("ecotronbox_card_preview") as IBitmapWrapperWindow);
            if (_local_4 == null)
            {
                return;
            };
            var _local_2:int = int(((_local_4.width - _arg_1.width) / 2));
            var _local_3:int = int(((_local_4.height - _arg_1.height) / 2));
            if (_local_4.bitmap == null)
            {
                _local_4.bitmap = new BitmapData(_local_4.width, _local_4.height, true, 0xFFFFFF);
            };
            _local_4.bitmap.fillRect(_local_4.bitmap.rect, 0xFFFFFF);
            _local_4.bitmap.copyPixels(_arg_1, _arg_1.rect, new Point(_local_2, _local_3), null, null, false);
        }

        private function showDescription(_arg_1:String):void
        {
            var _local_2:ITextWindow;
            _local_2 = (_window.findChildByName("ecotronbox_card_msg") as ITextWindow);
            if (((!(_local_2 == null)) && (!(_arg_1 == null))))
            {
                _local_2.caption = _arg_1;
            };
        }

        private function showInterface():void
        {
            var _local_3:ITextWindow;
            var _local_2:IWindow;
            if (_SafeStr_1922 < 0)
            {
                return;
            };
            var _local_4:IAsset = assets.getAssetByName(_interfaceMapByFurniTypeName.getValue(_furniTypeName));
            var _local_1:XmlAsset = XmlAsset(_local_4);
            if (_local_1 == null)
            {
                return;
            };
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
            _window = (windowManager.createWindow("ecotronboxcardui_container", "", 4, 0, (0x020000 | 0x01), new Rectangle(100, 100, 2, 2), null, 0) as IWindowContainer);
            _window.buildFromXML(XML(_local_1.content));
            _local_3 = (_window.findChildByName("ecotronbox_card_date") as ITextWindow);
            if (((!(_local_3 == null)) && (!(_text == null))))
            {
                _local_3.caption = _text;
            };
            _local_2 = _window.findChildByName("ecotronbox_card_btn_close");
            if (_local_2 != null)
            {
                _local_2.addEventListener("WME_CLICK", onMouseEvent);
            };
            setOpenButton(true);
        }

        private function setOpenButton(_arg_1:Boolean):void
        {
            var _local_2:IWindow;
            if (_window == null)
            {
                return;
            };
            _local_2 = _window.findChildByName("ecotronbox_card_btn_open");
            if (_local_2 != null)
            {
                if (((_SafeStr_1284) && (_arg_1)))
                {
                    _local_2.visible = true;
                    _local_2.addEventListener("WME_CLICK", onMouseEvent);
                }
                else
                {
                    _local_2.visible = false;
                };
            };
        }

        private function hideInterface():void
        {
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
            if (!_SafeStr_4088)
            {
                _SafeStr_1922 = -1;
            };
            _text = "";
            _SafeStr_1284 = false;
        }

        private function sendOpen():void
        {
            var _local_1:RoomWidgetEcotronBoxOpenMessage;
            if ((((_SafeStr_4088) || (_SafeStr_1922 == -1)) || (!(_SafeStr_1284))))
            {
                return;
            };
            _SafeStr_4088 = true;
            if (messageListener != null)
            {
                _local_1 = new RoomWidgetEcotronBoxOpenMessage("RWEBOM_OPEN_ECOTRONBOX", _SafeStr_1922);
                messageListener.processWidgetMessage(_local_1);
            };
        }

        private function onMouseEvent(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_3:String = _local_2.name;
            switch (_local_3)
            {
                case "ecotronbox_card_btn_open":
                    sendOpen();
                    return;
                case "ecotronbox_card_btn_close":
                default:
                    _SafeStr_4088 = false;
                    hideInterface();
                    return;
            };
        }


    }
}

