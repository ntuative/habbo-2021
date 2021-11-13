package com.sulake.habbo.quest.seasonalcalendar
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.quest.HabboQuestEngine;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;

    public class RareTeaser implements IDisposable
    {

        private var _questEngine:HabboQuestEngine;
        private var _window:IWindowContainer;
        private var _SafeStr_3091:Array;
        private var _SafeStr_3092:Array;
        private var _SafeStr_2716:Array;

        public function RareTeaser(_arg_1:HabboQuestEngine)
        {
            _questEngine = _arg_1;
        }

        public function dispose():void
        {
            _questEngine = null;
            _window = null;
        }

        public function get disposed():Boolean
        {
            return (_questEngine == null);
        }

        public function prepare(_arg_1:IFrameWindow):void
        {
            var _local_2:int;
            _SafeStr_3091 = parseInts("quests.seasonalcalendar.rareteaser.days");
            _SafeStr_3092 = parseStrings("quests.seasonalcalendar.rareteaser.images");
            _SafeStr_2716 = parseStrings("quests.seasonalcalendar.rareteaser.pages");
            _window = IWindowContainer(_arg_1.findChildByName("rare_teaser_cont"));
            _local_2 = 1;
            while (_local_2 <= _SafeStr_3091.length)
            {
                getFurniPic(_local_2).assetUri = ((_questEngine.questController.seasonalCalendarWindow.getCalendarImageGalleryHost() + _SafeStr_3092[(_local_2 - 1)]) + ".png");
                _local_2++;
            };
            getClickRegion(1).procedure = onFirstSlot;
            getClickRegion(2).procedure = onSecondSlot;
            getClickRegion(3).procedure = onThirdSlot;
        }

        private function parseInts(_arg_1:String):Array
        {
            var _local_4:String = _questEngine.localization.getLocalization(_arg_1, "");
            var _local_3:Array = _local_4.split(",");
            var _local_2:Array = [];
            for each (var _local_5:String in _local_3)
            {
                if (!isNaN(Number(_local_5)))
                {
                    _local_2.push(_local_5);
                };
            };
            return (_local_2);
        }

        private function parseStrings(_arg_1:String):Array
        {
            var _local_4:String = _questEngine.localization.getLocalization(_arg_1, "");
            var _local_3:Array = _local_4.split(",");
            var _local_2:Array = [];
            for each (var _local_5:String in _local_3)
            {
                if (_local_5 != "")
                {
                    _local_2.push(_local_5);
                };
            };
            return (_local_2);
        }

        private function getFurniPic(_arg_1:int):IStaticBitmapWrapperWindow
        {
            return (getRare(_arg_1).findChildByName("furni_pic") as IStaticBitmapWrapperWindow);
        }

        private function getLockIcon(_arg_1:int):IWindow
        {
            return (getRare(_arg_1).findChildByName("locked_icon"));
        }

        private function getLockedBg(_arg_1:int):IWindow
        {
            return (getRare(_arg_1).findChildByName("locked_bg"));
        }

        private function getOpenBg(_arg_1:int):IWindow
        {
            return (getRare(_arg_1).findChildByName("open_bg"));
        }

        private function getClickRegion(_arg_1:int):IWindow
        {
            return (getRare(_arg_1).findChildByName("click_region"));
        }

        private function getRare(_arg_1:int):IWindowContainer
        {
            return (IWindowContainer(_window.findChildByName(("rare_cont_" + _arg_1))));
        }

        public function refresh():void
        {
            var _local_3:int;
            var _local_4:Boolean;
            var _local_1:int = _questEngine.questController.seasonalCalendarWindow.currentDay;
            var _local_2:int = -1;
            _local_3 = 1;
            while (_local_3 <= _SafeStr_3091.length)
            {
                _local_4 = (_SafeStr_3091[(_local_3 - 1)] > _local_1);
                getFurniPic(_local_3).visible = (!(_local_4));
                getLockIcon(_local_3).visible = _local_4;
                getOpenBg(_local_3).visible = (!(_local_4));
                getLockedBg(_local_3).visible = _local_4;
                getClickRegion(_local_3).visible = (!(_local_4));
                if (((_local_4) && (_local_2 == -1)))
                {
                    _local_2 = (_SafeStr_3091[(_local_3 - 1)] - _local_1);
                };
                _local_3++;
            };
            _window.findChildByName("teaser_info").visible = (!(_local_2 == -1));
            _questEngine.localization.registerParameter("quests.seasonalcalendar.rareteaser.info", "days", ("" + _local_2));
        }

        private function onFirstSlot(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            onSlot(_arg_1, 0);
        }

        private function onSecondSlot(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            onSlot(_arg_1, 1);
        }

        private function onThirdSlot(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            onSlot(_arg_1, 2);
        }

        private function onSlot(_arg_1:WindowEvent, _arg_2:int):void
        {
            if (((_arg_1.type == "WME_CLICK") && (!(_SafeStr_2716[_arg_2] == null))))
            {
                _questEngine.catalog.openCatalogPage(_SafeStr_2716[_arg_2]);
            };
        }


    }
}