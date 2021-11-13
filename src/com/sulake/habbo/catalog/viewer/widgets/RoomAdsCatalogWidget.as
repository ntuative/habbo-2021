package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.incoming.catalog.RoomAdPurchaseInfoEvent;
    import com.sulake.habbo.catalog.purchase.RoomAdPurchaseData;
    import com.sulake.habbo.communication.messages.incoming.navigator.EventCategory;
    import com.sulake.habbo.room.events.RoomEngineEvent;
    import com.sulake.habbo.communication.messages.incoming.users.RoomEntryData;
    import com.sulake.habbo.communication.messages.parser.catalog.RoomAdPurchaseInfoEventParser;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.catalog.viewer.Offer;
    import __AS3__.vec.Vector;

    public class RoomAdsCatalogWidget extends CatalogWidget implements ICatalogWidget
    {

        private var _catalog:HabboCatalog;
        private var _SafeStr_1610:IMessageEvent = null;
        private var _name:String;
        private var _description:String;
        private var _rooms:Array;
        private var _SafeStr_1611:Boolean;
        private var _SafeStr_1612:IDropMenuWindow;

        public function RoomAdsCatalogWidget(_arg_1:IWindowContainer, _arg_2:HabboCatalog)
        {
            super(_arg_1);
            _catalog = _arg_2;
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            if (_catalog == null)
            {
                return (false);
            };
            var _local_4:IConnection = _catalog.connection;
            if (_SafeStr_1610 == null)
            {
                _SafeStr_1610 = new RoomAdPurchaseInfoEvent(onPurchaseInfoEvent);
                _local_4.addMessageEvent(_SafeStr_1610);
            };
            _catalog.getRoomAdsPurchaseInfo();
            window.findChildByName("name_input_text").addEventListener("WE_CHANGE", onNameWindowEvent);
            window.findChildByName("desc_input_text").addEventListener("WE_CHANGE", onDescWindowEvent);
            events.addEventListener("PURCHASE", onPurchaseConfirmationEvent);
            var _local_2:RoomAdPurchaseData = _catalog.roomAdPurchaseData;
            var _local_3:int = _catalog.getInteger("room_ad.duration.minutes", 120);
            var _local_1:int = getExtensionMinutes(_local_2, _local_3);
            _catalog.localization.registerParameter("roomad.catalog_text", "duration", String(_local_1));
            _catalog.roomEngine.events.addEventListener("REE_INITIALIZED", onRoomInitialized);
            populateEventCategories();
            return (true);
        }

        private function getExtensionMinutes(_arg_1:RoomAdPurchaseData, _arg_2:int):int
        {
            var _local_6:Boolean = _catalog.getBoolean("roomad.limited_extension");
            if ((((!(_local_6)) || (_arg_1 == null)) || (_arg_1.expirationTime == null)))
            {
                return (_arg_2);
            };
            var _local_8:Date = new Date();
            var _local_3:Number = _local_8.getTime();
            var _local_7:Number = _arg_1.expirationTime.getTime();
            var _local_5:Number = (_local_3 - _local_7);
            var _local_4:Number = (_local_5 / 60000);
            _local_4 = (_local_4 + _arg_2);
            return (_local_4);
        }

        private function populateEventCategories():void
        {
            if (window == null)
            {
                return;
            };
            _SafeStr_1612 = (window.findChildByName("categories_list") as IDropMenuWindow);
            var _local_2:Array = [];
            for each (var _local_1:EventCategory in _catalog.navigator.visibleEventCategories)
            {
                _local_2.push((("${navigator.searchcode.title.eventcategory__" + _local_1.categoryId) + "}"));
            };
            _SafeStr_1612.populate(_local_2);
            _SafeStr_1612.selection = 0;
            _SafeStr_1612.addEventListener("WE_SELECTED", onEventCategoryMenuEvent);
        }

        private function onRoomInitialized(_arg_1:RoomEngineEvent):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            setDefaultRoom(_arg_1.roomId, false);
        }

        private function setDefaultRoom(_arg_1:int, _arg_2:Boolean=false):void
        {
            var _local_6:int;
            var _local_3:RoomEntryData;
            var _local_9:String;
            var _local_7:RoomAdPurchaseData;
            if (window == null)
            {
                return;
            };
            var _local_8:IDropMenuWindow = (window.findChildByName("room_drop_menu") as IDropMenuWindow);
            if (_rooms == null)
            {
                if (_local_8.numMenuItems > 0)
                {
                    _local_8.selection = 0;
                };
                return;
            };
            var _local_5:int;
            var _local_4:Array = [];
            _local_6 = 0;
            while (_local_6 < _rooms.length)
            {
                _local_3 = (_rooms[_local_6] as RoomEntryData);
                if (_arg_2)
                {
                    if (_local_3.roomName.length > 25)
                    {
                        _local_9 = (_local_3.roomName.substr(0, 25) + "...");
                        _local_4.push(_local_9);
                    }
                    else
                    {
                        _local_4.push(_local_3.roomName);
                    };
                };
                if (_local_3.roomId == _arg_1)
                {
                    _local_5 = _local_6;
                };
                _local_6++;
            };
            if (_arg_2)
            {
                if (_local_4.length == 0)
                {
                    _local_4.push(_catalog.localization.getLocalization("roomad.no.available.room", "roomad.no.available.room"));
                };
                _local_8.populate(_local_4);
            };
            var _local_10:RoomEntryData = (_rooms[_local_5] as RoomEntryData);
            if (_local_10 != null)
            {
                _local_8.selection = _local_5;
                _local_7 = _catalog.roomAdPurchaseData;
                if (_local_7 == null)
                {
                    _local_7 = new RoomAdPurchaseData();
                    _catalog.roomAdPurchaseData = _local_7;
                };
                _local_7.flatId = _local_10.roomId;
            }
            else
            {
                _local_8.selection = 0;
            };
        }

        private function setExtendData():void
        {
            var _local_1:RoomEntryData;
            var _local_2:RoomAdPurchaseData = _catalog.roomAdPurchaseData;
            if (((!(_local_2 == null)) && (_local_2.extended)))
            {
                window.findChildByName("name_input_text").caption = _local_2.name;
                window.findChildByName("desc_input_text").caption = _local_2.description;
                _local_1 = new RoomEntryData(_local_2.flatId, _local_2.roomName, false);
                if (_rooms != null)
                {
                    _rooms.push(_local_1);
                };
                if (_SafeStr_1612 == null)
                {
                    _SafeStr_1612 = (window.findChildByName("categories_list") as IDropMenuWindow);
                };
                _SafeStr_1612.selection = (_local_2.categoryId - 1);
            };
        }

        public function onPurchaseInfoEvent(_arg_1:IMessageEvent):void
        {
            var _local_5:RoomAdPurchaseData;
            var _local_4:IWindowContainer;
            if (((!(window)) || (window.disposed)))
            {
                return;
            };
            var _local_7:RoomAdPurchaseInfoEvent = (_arg_1 as RoomAdPurchaseInfoEvent);
            var _local_3:RoomAdPurchaseInfoEventParser = _local_7.getParser();
            var _local_6:IDropMenuWindow = (window.findChildByName("room_drop_menu") as IDropMenuWindow);
            _rooms = _local_3.rooms;
            _SafeStr_1611 = _local_3.isVip;
            var _local_8:int = _catalog.roomEngine.activeRoomId;
            setExtendData();
            populateEventCategories();
            setDefaultRoom(_local_8, true);
            var _local_2:IPurchasableOffer = selectedOffer();
            if (_local_2 != null)
            {
                events.dispatchEvent(new SelectProductEvent(_local_2));
                _local_5 = _catalog.roomAdPurchaseData;
                if (_local_5 == null)
                {
                    _local_5 = new RoomAdPurchaseData();
                    _catalog.roomAdPurchaseData = _local_5;
                };
                _local_5.offerId = _local_2.offerId;
                _catalog.roomAdPurchaseData = _local_5;
                _local_4 = (window.findChildByName("price_container") as IWindowContainer);
                _catalog.utils.showPriceInContainer(_local_4, _local_2);
            };
        }

        private function onPurchaseConfirmationEvent(_arg_1:CatalogWidgetEvent):void
        {
            _catalog.getRoomAdsPurchaseInfo();
            window.findChildByName("name_input_text").caption = "";
            window.findChildByName("desc_input_text").caption = "";
            if (_catalog.roomAdPurchaseData)
            {
                _catalog.roomAdPurchaseData.clear();
            };
        }

        private function onNameWindowEvent(_arg_1:WindowEvent):void
        {
            var _local_3:ITextFieldWindow = (_arg_1.target as ITextFieldWindow);
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:RoomAdPurchaseData = _catalog.roomAdPurchaseData;
            if (_local_2 != null)
            {
                _local_2.name = _local_3.text;
            };
        }

        private function onDescWindowEvent(_arg_1:WindowEvent):void
        {
            var _local_3:ITextFieldWindow = (_arg_1.target as ITextFieldWindow);
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:RoomAdPurchaseData = _catalog.roomAdPurchaseData;
            if (_local_2 != null)
            {
                _local_2.description = _local_3.text;
            };
        }

        private function onRoomDropMenuEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_5:int;
            var _local_4:RoomEntryData;
            var _local_6:RoomAdPurchaseData;
            var _local_3:int;
            var _local_7:IWindow;
            var _local_8:String;
            if (((_arg_1.type == "WE_SELECTED") && (_rooms.length > 0)))
            {
                _local_5 = IDropMenuWindow(_arg_2).selection;
                _local_4 = (_rooms[_local_5] as RoomEntryData);
                _local_6 = _catalog.roomAdPurchaseData;
                if (_local_6)
                {
                    _local_6.flatId = _local_4.roomId;
                    _local_3 = _catalog.getInteger("room_ad.duration.minutes", 120);
                    if (_local_4.roomId == _local_6.extendedFlatId)
                    {
                        _local_3 = getExtensionMinutes(_local_6, _local_3);
                    };
                    _local_7 = window.findChildByName("ctlg_text_1");
                    _local_7.caption = "${roomad.catalog_text}";
                    _catalog.localization.registerParameter("roomad.catalog_text", "duration", String(_local_3));
                    _local_8 = _catalog.localization.getLocalization("roomad.catalog_text");
                    _local_7.caption = _local_8;
                };
            };
        }

        private function onEventCategoryMenuEvent(_arg_1:WindowEvent):void
        {
            var _local_3:int;
            var _local_5:int = -1;
            var _local_6:int = _SafeStr_1612.selection;
            for each (var _local_2:EventCategory in _catalog.navigator.visibleEventCategories)
            {
                if (_local_2.visible)
                {
                    if (_local_6 == _local_3)
                    {
                        _local_5 = _local_2.categoryId;
                        break;
                    };
                    _local_3++;
                };
            };
            var _local_4:RoomAdPurchaseData = _catalog.roomAdPurchaseData;
            if (_local_4)
            {
                _local_4.categoryId = _local_5;
            };
        }

        private function selectedOffer():IPurchasableOffer
        {
            var _local_3:int;
            var _local_2:Offer;
            var _local_1:Vector.<IPurchasableOffer> = page.offers;
            if (((!(_local_1 == null)) && (_local_1)))
            {
                if (_local_1.length == 1)
                {
                    return (_local_1[0]);
                };
                _local_3 = 0;
                while (_local_3 < _local_1.length)
                {
                    _local_2 = (_local_1[_local_3] as Offer);
                    if ((((_local_2.clubLevel == 2) && (_SafeStr_1611)) || ((!(_local_2.clubLevel == 2)) && (!(_SafeStr_1611)))))
                    {
                        return (_local_2);
                    };
                    _local_3++;
                };
            };
            return (null);
        }

        override public function dispose():void
        {
            var _local_1:IConnection;
            super.dispose();
            if (_catalog != null)
            {
                _local_1 = _catalog.connection;
                if (_SafeStr_1610 != null)
                {
                    _local_1.removeMessageEvent(_SafeStr_1610);
                    _SafeStr_1610 = null;
                };
                _catalog.roomEngine.events.removeEventListener("REE_INITIALIZED", onRoomInitialized);
                _catalog = null;
            };
        }


    }
}