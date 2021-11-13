package com.sulake.habbo.quest.seasonalcalendar
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.quest.HabboQuestEngine;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.utils.WindowToggle;
    import com.sulake.habbo.quest.events.QuestsListEvent;
    import com.sulake.habbo.quest.events.QuestCompletedEvent;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class MainWindow implements IDisposable 
    {

        private var _questEngine:HabboQuestEngine;
        private var _window:IFrameWindow;
        private var _SafeStr_2929:WindowToggle;
        private var _calendar:Calendar;
        private var _catalogPromo:CatalogPromo;
        private var _SafeStr_3089:RareTeaser;
        private var _SafeStr_3090:Boolean = false;
        private var _currentDay:int;

        public function MainWindow(_arg_1:HabboQuestEngine)
        {
            _questEngine = _arg_1;
            _calendar = new Calendar(_questEngine, this);
            _catalogPromo = new CatalogPromo(_questEngine, this);
            _SafeStr_3089 = new RareTeaser(_questEngine);
            _questEngine.events.addEventListener("qe_quests_seasonal", onSeasonalQuests);
            _questEngine.events.addEventListener("qce_seasonal", onSeasonalQuestCompleted);
        }

        public function dispose():void
        {
            if (_questEngine)
            {
                _questEngine.events.removeEventListener("qe_quests_seasonal", onSeasonalQuests);
                _questEngine.events.removeEventListener("qce_seasonal", onSeasonalQuestCompleted);
                _questEngine = null;
            };
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            if (_SafeStr_2929)
            {
                _SafeStr_2929.dispose();
                _SafeStr_2929 = null;
            };
            if (_calendar)
            {
                _calendar.close();
                _calendar.dispose();
                _calendar = null;
            };
            if (_catalogPromo)
            {
                _catalogPromo.dispose();
                _catalogPromo = null;
            };
            if (_SafeStr_3089)
            {
                _SafeStr_3089.dispose();
                _SafeStr_3089 = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_questEngine == null);
        }

        public function isVisible():Boolean
        {
            return ((_window) && (_window.visible));
        }

        public function close():void
        {
            if (_calendar)
            {
                _calendar.close();
            };
            if (_window)
            {
                _window.visible = false;
            };
        }

        public function onRoomExit():void
        {
            this.close();
        }

        public function onToolbarClick():void
        {
            if (!_window)
            {
                _questEngine.requestSeasonalQuests();
                return;
            };
            if (((!(_SafeStr_2929)) || (_SafeStr_2929.disposed)))
            {
                _SafeStr_2929 = new WindowToggle(_window, _window.desktop, _questEngine.requestSeasonalQuests, close);
            };
            _SafeStr_2929.toggle();
        }

        public function getCalendarImageGalleryHost():String
        {
            var _local_1:String = _questEngine.getSeasonalCampaignCodePrefix();
            return ((_questEngine.configuration.getProperty("image.library.url") + _local_1) + "_quest_calendar/");
        }

        public function onQuests(_arg_1:Array, _arg_2:Boolean):void
        {
            if (((!(this.isVisible())) && (!(_arg_2))))
            {
                return;
            };
            _currentDay = resolveCurrentDay(_arg_1);
            _calendar.onQuests(_arg_1);
            refresh();
            if (_arg_2)
            {
                this._window.visible = true;
                this._window.activate();
            };
        }

        private function onSeasonalQuests(_arg_1:QuestsListEvent):void
        {
            this.onQuests(_arg_1.quests, true);
        }

        private function onSeasonalQuestCompleted(_arg_1:QuestCompletedEvent):void
        {
            _questEngine.questController.questTracker.forceWindowCloseAfterAnimationsFinished();
            _questEngine.requestSeasonalQuests();
        }

        public function onActivityPoints(_arg_1:int, _arg_2:int):void
        {
            _catalogPromo.onActivityPoints(_arg_1, _arg_2);
        }

        private function resolveCurrentDay(_arg_1:Array):int
        {
            var _local_2:int;
            for each (var _local_3:QuestMessageData in _arg_1)
            {
                if (_questEngine.isSeasonalQuest(_local_3))
                {
                    _local_2 = Math.max(_local_2, _local_3.sortOrder);
                };
            };
            return (_local_2);
        }

        private function refresh():void
        {
            prepareWindow();
            _calendar.refresh();
            _catalogPromo.refresh();
            _SafeStr_3089.refresh();
        }

        private function prepareWindow():void
        {
            if (this._window != null)
            {
                return;
            };
            _window = IFrameWindow(_questEngine.getXmlWindow("SeasonalCalendar"));
            var _local_1:String = (("quests." + _questEngine.getSeasonalCampaignCodePrefix()) + ".title");
            _window.caption = _questEngine.localization.getLocalizationWithParams(_local_1, _local_1);
            _window.findChildByTag("close").procedure = onWindowClose;
            _calendar.prepare(_window);
            _catalogPromo.prepare(_window);
            _SafeStr_3089.prepare(_window);
            _window.center();
        }

        private function onWindowClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                close();
            };
        }

        public function get currentDay():int
        {
            return (_currentDay);
        }

        public function get catalogPromo():CatalogPromo
        {
            return (_catalogPromo);
        }

        public function update(_arg_1:uint):void
        {
            if (((((!(_questEngine.configuration == null)) && (_questEngine.isFirstLoginOfDay)) && (!(_SafeStr_3090))) && (_questEngine.isSeasonalCalendarEnabled())))
            {
                _questEngine.requestSeasonalQuests();
                _SafeStr_3090 = true;
            };
        }


    }
}

