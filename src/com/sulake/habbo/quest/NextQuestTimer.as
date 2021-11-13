package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.utils.FriendlyTime;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class NextQuestTimer implements IDisposable 
    {

        public static const REFRESH_PERIOD_IN_MSECS:int = 1000;
        private static const TOOLBAR_EXTENSION_ID:String = "next_quest";

        private var _questEngine:HabboQuestEngine;
        private var _SafeStr_3125:QuestMessageData;
        private var _window:IWindowContainer;
        private var _expanded:Boolean = false;
        private var _msecsToRefresh:int;

        public function NextQuestTimer(_arg_1:HabboQuestEngine)
        {
            _questEngine = _arg_1;
        }

        public function dispose():void
        {
            if (_questEngine)
            {
                _questEngine.toolbar.extensionView.detachExtension("next_quest");
            };
            _questEngine = null;
            _SafeStr_3125 = null;
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_questEngine == null);
        }

        public function onQuestCancelled():void
        {
            _SafeStr_3125 = null;
            close();
        }

        public function onRoomExit():void
        {
            if (((!(_window == null)) && (_window.visible)))
            {
                _window.findChildByName("more_info_region").visible = false;
                _window.findChildByName("more_info_txt").visible = false;
            };
        }

        public function onQuest(_arg_1:QuestMessageData):void
        {
            if (_arg_1.waitPeriodSeconds < 1)
            {
                close();
                return;
            };
            _SafeStr_3125 = _arg_1;
            prepareWindow();
            refreshVisibility();
            this._window.visible = true;
            _questEngine.toolbar.extensionView.attachExtension("next_quest", _window);
        }

        private function prepareWindow():void
        {
            if (this._window != null)
            {
                return;
            };
            _window = IWindowContainer(_questEngine.getXmlWindow("NextQuestTimer"));
            _window.x = 0;
            _window.y = 0;
            _window.findChildByName("more_info_region").procedure = onMoreInfo;
            _window.findChildByName("quest_timer_expanded").procedure = onToggleExpanded;
            _window.findChildByName("quest_timer_contracted").procedure = onToggleExpanded;
            refreshVisibility();
        }

        private function refresh():void
        {
            var _local_1:int = _SafeStr_3125.waitPeriodSeconds;
            if (_local_1 < 1)
            {
                close();
                _SafeStr_3125.waitPeriodSeconds = 0;
                _questEngine.questController.onQuest(_SafeStr_3125);
            };
            var _local_3:String = FriendlyTime.getFriendlyTime(_questEngine.localization, _local_1);
            var _local_2:String = (_SafeStr_3125.getCampaignLocalizationKey() + ".delayedmsg");
            _questEngine.localization.registerParameter("quests.nextquesttimer.caption.contracted", "time", _local_3);
            _questEngine.localization.registerParameter(_local_2, "time", _local_3);
            _window.findChildByName("quest_header_txt").caption = _questEngine.localization.getLocalization(("quests.nextquesttimer.caption." + ((_expanded) ? "expanded" : "contracted")));
            _window.findChildByName("desc_txt").caption = _questEngine.localization.getLocalization(_local_2, _local_2);
        }

        private function refreshVisibility():void
        {
            _window.findChildByName("quest_timer_expanded").visible = _expanded;
            _window.findChildByName("quest_timer_contracted").visible = (!(_expanded));
            _window.findChildByName("more_info_txt").visible = ((_expanded) && (_questEngine.currentlyInRoom));
            _window.findChildByName("more_info_region").visible = ((_expanded) && (_questEngine.currentlyInRoom));
            _window.findChildByName("quest_pic_bitmap").visible = _expanded;
            _window.findChildByName("desc_txt").visible = _expanded;
            refresh();
        }

        private function onMoreInfo(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _questEngine.questController.questDetails.showDetails(_SafeStr_3125);
            };
        }

        private function onToggleExpanded(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _expanded = (!(_expanded));
                refreshVisibility();
            };
        }

        public function update(_arg_1:uint):void
        {
            if (((_window == null) || (!(_window.visible))))
            {
                return;
            };
            _msecsToRefresh = (_msecsToRefresh - _arg_1);
            if (_msecsToRefresh > 0)
            {
                return;
            };
            _msecsToRefresh = 1000;
            refresh();
        }

        private function getDefaultLocationX():int
        {
            return (0);
        }

        public function isVisible():Boolean
        {
            return ((_window) && (_window.visible));
        }

        public function close():void
        {
            if (((!(_window == null)) && (_window.visible)))
            {
                _window.visible = false;
                _questEngine.toolbar.extensionView.detachExtension("next_quest");
            };
        }

        private function setQuestImageVisible(_arg_1:Boolean):void
        {
            _window.findChildByName("quest_pic_bitmap").visible = _arg_1;
        }


    }
}

