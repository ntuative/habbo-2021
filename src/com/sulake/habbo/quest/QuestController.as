package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.quest.seasonalcalendar.MainWindow;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;

    public class QuestController implements IDisposable, IUpdateReceiver 
    {

        private var _questEngine:HabboQuestEngine;
        private var _questsList:QuestsList;
        private var _questDetails:QuestDetails;
        private var _SafeStr_3131:QuestCompleted;
        private var _questTracker:QuestTracker;
        private var _SafeStr_3132:NextQuestTimer;
        private var _seasonalCalendarWindow:MainWindow;

        public function QuestController(_arg_1:HabboQuestEngine)
        {
            _questEngine = _arg_1;
            _questTracker = new QuestTracker(_questEngine);
            _questsList = new QuestsList(_questEngine);
            _questDetails = new QuestDetails(_questEngine);
            _SafeStr_3131 = new QuestCompleted(_questEngine);
            _SafeStr_3132 = new NextQuestTimer(_questEngine);
            _seasonalCalendarWindow = new MainWindow(_questEngine);
        }

        public function onToolbarClick():void
        {
            if (_questEngine.isSeasonalCalendarEnabled())
            {
                _seasonalCalendarWindow.onToolbarClick();
                _questsList.close();
            }
            else
            {
                _questsList.onToolbarClick();
            };
        }

        public function onQuest(_arg_1:QuestMessageData):void
        {
            _questTracker.onQuest(_arg_1);
            _questDetails.onQuest(_arg_1);
            _SafeStr_3131.onQuest(_arg_1);
            _SafeStr_3132.onQuest(_arg_1);
        }

        public function onQuestCompleted(_arg_1:QuestMessageData, _arg_2:Boolean):void
        {
            _questTracker.onQuestCompleted(_arg_1, _arg_2);
            _questDetails.onQuestCompleted(_arg_1);
            _SafeStr_3131.onQuestCompleted(_arg_1, _arg_2);
        }

        public function onQuestCancelled():void
        {
            _questTracker.onQuestCancelled();
            _questDetails.onQuestCancelled();
            _SafeStr_3131.onQuestCancelled();
            _SafeStr_3132.onQuestCancelled();
        }

        public function onRoomEnter():void
        {
            _questTracker.onRoomEnter();
        }

        public function onRoomExit():void
        {
            _questsList.onRoomExit();
            _seasonalCalendarWindow.onRoomExit();
            _questTracker.onRoomExit();
            _questDetails.onRoomExit();
            _SafeStr_3132.onRoomExit();
        }

        public function update(_arg_1:uint):void
        {
            _SafeStr_3131.update(_arg_1);
            _questTracker.update(_arg_1);
            _SafeStr_3132.update(_arg_1);
            _questsList.update(_arg_1);
            _questDetails.update(_arg_1);
            _seasonalCalendarWindow.update(_arg_1);
        }

        public function dispose():void
        {
            _questEngine = null;
            if (_questsList)
            {
                _questsList.dispose();
                _questsList = null;
            };
            if (_questTracker)
            {
                _questTracker.dispose();
                _questTracker = null;
            };
            if (_questDetails)
            {
                _questDetails.dispose();
                _questDetails = null;
            };
            if (_SafeStr_3131)
            {
                _SafeStr_3131.dispose();
                _SafeStr_3131 = null;
            };
            if (_SafeStr_3132)
            {
                _SafeStr_3132.dispose();
                _SafeStr_3132 = null;
            };
            if (_seasonalCalendarWindow)
            {
                _seasonalCalendarWindow.dispose();
                _seasonalCalendarWindow = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_questEngine == null);
        }

        public function get questsList():QuestsList
        {
            return (_questsList);
        }

        public function get questDetails():QuestDetails
        {
            return (_questDetails);
        }

        public function get questTracker():QuestTracker
        {
            return (_questTracker);
        }

        public function get seasonalCalendarWindow():MainWindow
        {
            return (_seasonalCalendarWindow);
        }

        public function onActivityPoints(_arg_1:int, _arg_2:int):void
        {
            if (_seasonalCalendarWindow)
            {
                _seasonalCalendarWindow.onActivityPoints(_arg_1, _arg_2);
            };
        }


    }
}

