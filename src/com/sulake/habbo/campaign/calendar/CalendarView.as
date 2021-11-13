package com.sulake.habbo.campaign.calendar
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.campaign.HabboCampaigns;
    import com.sulake.habbo.window.utils.IModalDialog;
    import com.sulake.core.window.IWindowContainer;
    import flash.display.Stage;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.session.product.IProductData;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import flash.events.Event;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.communication.messages.parser.campaign.CampaignCalendarData;

    public class CalendarView implements IGetImageListener 
    {

        private static const MARGIN:int = 75;

        private var _SafeStr_1284:HabboCampaigns;
        private var _SafeStr_1421:IModalDialog;
        private var _SafeStr_1290:int = -1;
        private var _itemsOnScreen:int;

        public function CalendarView(_arg_1:HabboCampaigns, _arg_2:IHabboWindowManager)
        {
            super();
            var _local_7:int;
            var _local_5:IWindowContainer = null;
            _SafeStr_1284 = _arg_1;
            _SafeStr_1421 = _arg_2.buildModalDialogFromXML(XML(_SafeStr_1284.assets.getAssetByName("campaign_calendar_xml").content));
            if ((((!(_SafeStr_1421)) || (!(_SafeStr_1421.rootWindow))) || (!(itemList))))
            {
                return;
            };
            var _local_3:IWindowContainer = (itemList.getListItemAt(0) as IWindowContainer);
            itemList.removeListItems();
            itemList.disableAutodrag = true;
            var _local_6:int = calendarData.campaignDays;
            _local_7 = 0;
            while (_local_7 < _local_6)
            {
                _local_5 = CalendarItem.populateItem(_local_3, calendarData, _local_7);
                _local_5.procedure = onInput;
                itemList.addListItem(_local_5);
                _local_7++;
            };
            itemList.scrollStepH = (_local_3.width / itemList.maxScrollH);
            var _local_4:Stage = _SafeStr_1284.context.displayObjectContainer.stage;
            _local_4.addEventListener("resize", onResize);
            window.procedure = onInput;
            onResize(null);
            setSelectedIndex(_SafeStr_1284.calendarData.currentDay);
        }

        public function dispose():void
        {
            var _local_1:Stage;
            if (_SafeStr_1421 != null)
            {
                _local_1 = _SafeStr_1284.context.displayObjectContainer.stage;
                _local_1.removeEventListener("resize", onResize);
                _SafeStr_1421.dispose();
                _SafeStr_1421 = null;
            };
        }

        public function setReceivedProduct(_arg_1:IProductData, _arg_2:String=null):void
        {
            setInfoText("${campaign.calendar.heading.product.received}", _arg_1.name);
            updateThumbnail(_arg_2);
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            updateThumbnail(_arg_2);
        }

        private function updateThumbnail(_arg_1:Object):void
        {
            var _local_2:IWindowContainer = (itemList.getListItemAt(_SafeStr_1290) as IWindowContainer);
            if (!_local_2)
            {
                return;
            };
            CalendarItem.updateThumbnail(_local_2, _arg_1);
        }

        public function imageFailed(_arg_1:int):void
        {
        }

        public function hide():void
        {
            _SafeStr_1284.hideCalendar();
        }

        private function onResize(_arg_1:Event):void
        {
            var _local_2:Stage = _SafeStr_1284.context.displayObjectContainer.stage;
            _itemsOnScreen = Math.floor(((_local_2.stageWidth - (75 * 2)) / (itemWidth + itemGap)));
            _SafeStr_1421.rootWindow.width = calculateItemListWidth(_itemsOnScreen);
            var _local_3:IWindow = window.findChildByName("btn_forward");
            if (_local_3)
            {
                _local_3.x = ((scrollerWidth - window.findChildByName("btn_back").x) - _local_3.width);
            };
            _local_3 = window.findChildByName("calendar_scrollbar");
            if (_local_3)
            {
                _local_3.width = scrollerWidth;
            };
            window.center();
            if (_SafeStr_1290 > -1)
            {
                setSelectedIndex(_SafeStr_1290);
            };
        }

        private function onInput(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:int;
            if (_arg_1.type != "WME_DOWN")
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "btn_present":
                    _local_3 = itemList.getListItemIndex(_arg_1.target.parent);
                    if (_local_3 < 0)
                    {
                        return;
                    };
                    if (_local_3 != _SafeStr_1290)
                    {
                        setSelectedIndex(_local_3);
                    }
                    else
                    {
                        _SafeStr_1284.openPackage(_SafeStr_1290);
                    };
                    return;
                case "btn_back":
                    setSelectedIndex((_SafeStr_1290 - 1));
                    return;
                case "btn_forward":
                    setSelectedIndex((_SafeStr_1290 + 1));
                    return;
                case "btn_force_open":
                    _SafeStr_1284.openPackageAsStaff(_SafeStr_1290);
                    return;
                case "header_button_close":
                    hide();
                    return;
            };
        }

        private function setSelectedIndex(_arg_1:int):void
        {
            var _local_6:int;
            var _local_2:IWindowContainer;
            var _local_7:_SafeStr_101;
            var _local_5:String;
            var _local_4:String;
            if (((_arg_1 < 0) || (_arg_1 >= calendarData.campaignDays)))
            {
                return;
            };
            _SafeStr_1290 = _arg_1;
            itemList.scrollH = calculateCenteredItemScrollH(_SafeStr_1290);
            _local_6 = 0;
            while (_local_6 < calendarData.campaignDays)
            {
                _local_2 = (itemList.getListItemAt(_local_6) as IWindowContainer);
                CalendarItem.updateState(_local_2, calendarData, _local_6, _arg_1);
                _local_6++;
            };
            CalendarSpinnerUtil.createGradients(this, _SafeStr_1290);
            if (_SafeStr_1284.isAnyRoomController)
            {
                _local_7 = (window.findChildByName("btn_force_open") as _SafeStr_101);
                _local_7.visible = true;
            };
            var _local_3:int = CalendarItem.resolveDayState(calendarData, _arg_1);
            if (_SafeStr_1290 < 0)
            {
                setInfoText(null, null);
                if (_local_7)
                {
                    _local_7.disable();
                };
            }
            else
            {
                switch (_local_3)
                {
                    case 2:
                        _local_5 = "${campaign.calendar.info.available.desktop}";
                        break;
                    case 3:
                        _local_5 = "${campaign.calendar.info.expired}";
                        break;
                    case 4:
                        _local_5 = "${campaign.calendar.info.future}";
                        break;
                    case 1:
                        _local_5 = "${campaign.calendar.info.unlocked}";
                    default:
                };
                _local_4 = ((_SafeStr_1284.localizationManager.getLocalization("campaign.calendar.heading.day")) || (""));
                _local_4 = _local_4.replace("%number%", (_SafeStr_1290 + 1));
                setInfoText(_local_4, _local_5);
                if (_local_7)
                {
                    if (_local_3 != 1)
                    {
                        _local_7.enable();
                    }
                    else
                    {
                        _local_7.disable();
                    };
                };
            };
        }

        private function setInfoText(_arg_1:String, _arg_2:String):void
        {
            (window.findChildByName("info_heading") as ITextWindow).text = ((_arg_1) || (""));
            (window.findChildByName("info_body") as ITextWindow).text = ((_arg_2) || (""));
        }

        private function startItemWiggle(_arg_1:int):void
        {
        }

        public function get window():IFrameWindow
        {
            return ((_SafeStr_1421) ? (_SafeStr_1421.rootWindow as IFrameWindow) : null);
        }

        private function getItemIndexAt(_arg_1:int):int
        {
            return (Math.floor((((itemList.scrollH * itemList.maxScrollH) + _arg_1) / ((itemList.maxScrollH + scrollerWidth) / itemList.numListItems))));
        }

        private function calculateCenteredItemScrollH(_arg_1:int):Number
        {
            return ((calculateItemListWidth(_arg_1) - ((scrollerWidth - itemWidth) * 0.5)) / itemList.maxScrollH);
        }

        public function calculateItemListWidth(_arg_1:int):Number
        {
            return ((_arg_1 * itemWidth) + (Math.max(0, (_arg_1 - 1)) * itemGap));
        }

        public function get itemList():IItemListWindow
        {
            return ((window) ? (window.findChildByName("calendar_itemlist") as IItemListWindow) : null);
        }

        public function get itemWidth():int
        {
            return (((itemList) && (itemList.numListItems > 0)) ? itemList.getListItemAt(0).width : 0);
        }

        public function get itemGap():int
        {
            return ((itemList) ? itemList.spacing : 0);
        }

        public function get scrollerWidth():int
        {
            return (((window) && (window.content)) ? window.content.width : 0);
        }

        private function get calendarData():CampaignCalendarData
        {
            return (_SafeStr_1284.calendarData);
        }


    }
}

