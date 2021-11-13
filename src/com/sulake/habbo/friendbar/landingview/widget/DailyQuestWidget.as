package com.sulake.habbo.friendbar.landingview.widget
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
    import com.sulake.habbo.friendbar.landingview.interfaces.ISlotAwareWidget;
    import com.sulake.habbo.friendbar.landingview.interfaces.IConfigurationCodeAwareWidget;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestDailyMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.quest.GetDailyQuestMessageComposer;
    import com.sulake.habbo.communication.messages.parser.quest.QuestDailyMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.quest.ActivateQuestMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.quest.CancelQuestMessageComposer;

    public class DailyQuestWidget implements IDisposable, ILandingViewWidget, ISlotAwareWidget, IConfigurationCodeAwareWidget 
    {

        private var _landingView:HabboLandingView;
        private var _container:IWindowContainer;
        private var _SafeStr_690:QuestMessageData;
        private var _SafeStr_2338:int;
        private var _SafeStr_2339:int;
        private var _index:int;
        private var _SafeStr_2364:int;
        private var _SafeStr_2365:int;
        private var _SafeStr_2345:String;

        public function DailyQuestWidget(_arg_1:HabboLandingView)
        {
            _landingView = _arg_1;
        }

        public static function moveChildrenToRow(_arg_1:IWindowContainer, _arg_2:int):void
        {
            var _local_3:int;
            var _local_5:IWindow;
            var _local_4:int;
            _local_3 = 0;
            while (_local_3 < _arg_1.numChildren)
            {
                _local_5 = _arg_1.getChildAt(_local_3);
                _local_5.x = _local_4;
                _local_4 = (_local_4 + (_local_5.width + _arg_2));
                _local_3++;
            };
        }


        public function set configurationCode(_arg_1:String):void
        {
            _SafeStr_2345 = _arg_1;
        }

        public function set slot(_arg_1:int):void
        {
            _SafeStr_2365 = _arg_1;
        }

        public function get container():IWindow
        {
            return (_container);
        }

        public function dispose():void
        {
            _landingView = null;
            _container = null;
            _SafeStr_690 = null;
        }

        public function initialize():void
        {
            _container = IWindowContainer(_landingView.getXmlWindow("daily_quest"));
            _landingView.communicationManager.addHabboConnectionMessageEvent(new QuestDailyMessageEvent(onDailyQuest));
            _container.findChildByName("accept_button").procedure = onAcceptButton;
            _container.findChildByName("go_button").procedure = onGoButton;
            _container.findChildByName("next_quest_region").procedure = onNextQuest;
            _container.findChildByName("cancel_quest_region").procedure = onCancelQuest;
            _container.findChildByName("easy_region").procedure = onEasyRegion;
            _container.findChildByName("hard_region").procedure = onHardRegion;
            var _local_1:IWindow = _container.findChildByName("hdr_line");
            _SafeStr_2364 = (_local_1.x + _local_1.width);
            GenericWidget.configureLayout(_landingView, _SafeStr_2365, _SafeStr_2345, _container);
        }

        public function refresh():void
        {
            _index = 0;
            _landingView.send(new GetDailyQuestMessageComposer(true, 0));
        }

        public function get disposed():Boolean
        {
            return (_landingView == null);
        }

        private function onDailyQuest(_arg_1:IMessageEvent):void
        {
            var _local_2:QuestDailyMessageParser = QuestDailyMessageParser(_arg_1.parser);
            _SafeStr_690 = _local_2.quest;
            _SafeStr_2338 = _local_2.easyQuestCount;
            _SafeStr_2339 = _local_2.hardQuestCount;
            refreshContent();
        }

        private function refreshContent():void
        {
            _container.findChildByName("caption_txt").caption = ((_SafeStr_690) ? getChainSpecificText("chaincaption") : getText("landing.view.quest.currenttask.alldone.caption"));
            _container.findChildByName("info_txt").caption = ((_SafeStr_690) ? getChainSpecificText("chaininfo") : getText("landing.view.quest.currenttask.alldone.info"));
            _container.findChildByName("accept_button").visible = ((_SafeStr_690) && (!(_SafeStr_690.accepted)));
            _container.findChildByName("next_quest_region").visible = (((_SafeStr_690) && (!(_SafeStr_690.accepted))) && (((_SafeStr_690.easy) ? _SafeStr_2338 : _SafeStr_2339) > 1));
            _container.findChildByName("next_quest_txt").caption = getText(("landing.view.quest.nextquest." + (((_SafeStr_690) && (_SafeStr_690.easy)) ? "easy" : "hard")));
            _container.findChildByName("title_txt").caption = getText(("landing.view.quest.title." + (((_SafeStr_690) && (_SafeStr_690.accepted)) ? "accepted" : "notaccepted")));
            HabboLandingView.positionAfterAndStretch(_container, "title_txt", "hdr_line");
            _container.findChildByName("cancel_quest_region").visible = ((_SafeStr_690) && (_SafeStr_690.accepted));
            _container.findChildByName("current_quest_border").visible = ((_SafeStr_690) && (_SafeStr_690.accepted));
            if (_SafeStr_690)
            {
                _landingView.localizationManager.registerParameter("landing.view.quest.currenttask", "task", getQuestName());
            };
            var _local_1:IWindowContainer = IWindowContainer(_container.findChildByName("difficulty_container"));
            var _local_2:int = (_local_1.x + _local_1.width);
            _local_1.visible = ((((_SafeStr_690) && (!(_SafeStr_690.accepted))) && (_SafeStr_2338 > 0)) && (_SafeStr_2339 > 0));
            setupDifficultyText("easy_region", ((_SafeStr_690) && (!(_SafeStr_690.easy))));
            setupDifficultyText("hard_region", ((_SafeStr_690) && (_SafeStr_690.easy)));
            moveChildrenToRow(_local_1, 5);
            _local_1.width = (_local_1.findChildByName("hard_region").x + _local_1.findChildByName("hard_region").width);
            _local_1.x = (_local_2 - _local_1.width);
            var _local_4:IWindow = _container.findChildByName("hdr_line");
            var _local_3:int = ((_local_1.visible) ? (_local_1.x - 5) : _SafeStr_2364);
            _local_4.width = (_local_3 - _local_4.x);
        }

        private function setupDifficultyText(_arg_1:String, _arg_2:Boolean):void
        {
            var _local_4:IWindowContainer = IWindowContainer(_container.findChildByName(_arg_1));
            var _local_3:ITextWindow = ITextWindow(_local_4.findChildByName("label_txt"));
            _local_3.width = _local_3.textWidth;
            _local_3.underline = _arg_2;
            _local_4.width = _local_3.width;
        }

        private function getChainSpecificKey(_arg_1:String):String
        {
            return ((((("quests." + _SafeStr_690.campaignCode) + ".") + _SafeStr_690.chainCode) + ".") + _arg_1);
        }

        private function getChainSpecificText(_arg_1:String):String
        {
            var _local_2:String = getChainSpecificKey(_arg_1);
            return (("${" + _local_2) + "}");
        }

        private function getText(_arg_1:String):String
        {
            return (("${" + _arg_1) + "}");
        }

        private function onGoButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _landingView.goToRoom();
            };
        }

        private function onEasyRegion(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                sendGetDailyQuest(true);
            };
        }

        private function onHardRegion(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                sendGetDailyQuest(false);
            };
        }

        public function getQuestName():String
        {
            var _local_1:String = (_SafeStr_690.getQuestLocalizationKey() + ".name");
            return (("${" + _local_1) + "}");
        }

        private function onAcceptButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _landingView.send(new ActivateQuestMessageComposer(_SafeStr_690.id));
            };
        }

        private function onNextQuest(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _index++;
                sendGetDailyQuest(_SafeStr_690.easy);
            };
        }

        private function onCancelQuest(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _landingView.send(new CancelQuestMessageComposer());
            };
        }

        private function sendGetDailyQuest(_arg_1:Boolean):void
        {
            _landingView.send(new GetDailyQuestMessageComposer(_arg_1, _index));
        }


    }
}

