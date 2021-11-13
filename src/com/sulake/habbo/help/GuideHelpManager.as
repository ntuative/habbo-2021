package com.sulake.habbo.help
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.help.guidehelp.HelpController;
    import com.sulake.habbo.help.guidehelp.GuideSessionController;
    import flash.utils.Timer;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import flash.events.TimerEvent;
    import com.sulake.habbo.communication.messages.parser.help.data.PendingGuideTicket;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;

    public class GuideHelpManager implements IDisposable 
    {

        private var _habboHelp:HabboHelp;
        private var _SafeStr_2686:HelpController;
        private var _SafeStr_2687:GuideSessionController;
        private var _SafeStr_2688:ChatReviewReporterFeedbackCtrl;
        private var _disposed:Boolean = false;
        private var _seenTourPopupDuringSession:Boolean;
        private var _SafeStr_2689:int;
        private var _panicRoomName:String;
        private var _SafeStr_2690:Timer;

        public function GuideHelpManager(_arg_1:HabboHelp)
        {
            _habboHelp = _arg_1;
            _SafeStr_2686 = new HelpController(this);
            _SafeStr_2687 = new GuideSessionController(this);
            _SafeStr_2688 = new ChatReviewReporterFeedbackCtrl(_habboHelp);
            _habboHelp.communicationManager.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
        }

        public function get habboHelp():HabboHelp
        {
            return (_habboHelp);
        }

        private function onRoomEnter(_arg_1:IMessageEvent):void
        {
            if (((((_habboHelp.newUserTourEnabled) && (_habboHelp.newIdentity)) && (!(_seenTourPopupDuringSession))) && (!(_habboHelp.sessionDataManager.isRealNoob))))
            {
                _SafeStr_2690 = new Timer(getTourPopupDelay(), 1);
                _SafeStr_2690.addEventListener("timer", onTourPopup);
                _SafeStr_2690.start();
                _habboHelp.tracking.trackEventLog("Help", "", "tour.new_user.create", "", getTourPopupDelay());
                _habboHelp.trackGoogle("newbieTourWindow", "timer_popupCreated");
            };
        }

        private function onTourPopup(_arg_1:TimerEvent):void
        {
            if (_disposed)
            {
                return;
            };
            _habboHelp.tracking.trackEventLog("Help", "", "tour.new_user.show", "", getTourPopupDelay());
            _habboHelp.trackGoogle("newbieTourWindow", "timer_popupShown");
            openTourPopup();
        }

        public function openTourPopup():void
        {
            _SafeStr_2686.openTourPopup();
            _seenTourPopupDuringSession = true;
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            if (_SafeStr_2686)
            {
                _SafeStr_2686.dispose();
                _SafeStr_2686 = null;
            };
            if (_SafeStr_2687)
            {
                _SafeStr_2687.dispose();
                _SafeStr_2687 = null;
            };
            if (_SafeStr_2688)
            {
                _SafeStr_2688.dispose();
                _SafeStr_2688 = null;
            };
            if (_SafeStr_2690)
            {
                _SafeStr_2690.reset();
                _SafeStr_2690 = null;
            };
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function showGuideTool():void
        {
            _SafeStr_2687.showGuideTool();
        }

        public function showPendingTicket(_arg_1:PendingGuideTicket):void
        {
            _SafeStr_2686.showPendingTicket(_arg_1);
        }

        public function createHelpRequest(_arg_1:uint):void
        {
            _SafeStr_2687.createHelpRequest(_arg_1);
        }

        public function openReportWindow():void
        {
            _SafeStr_2687.openReportWindow();
        }

        public function showFeedback(_arg_1:String):void
        {
            _SafeStr_2688.show(_arg_1);
        }

        private function getTourPopupDelay():int
        {
            return (_habboHelp.getInteger("guide.help.new.user.tour.popup.delay", 30) * 1000);
        }

        public function onHabboToolbarEvent(_arg_1:HabboToolbarEvent):void
        {
            if (_arg_1.type == "HTE_TOOLBAR_CLICK")
            {
                switch (_arg_1.iconId)
                {
                    case "HTIE_ICON_HELP":
                        _habboHelp.toggleNewHelpWindow();
                        return;
                    case "HTIE_ICON_GUIDE":
                        showGuideTool();
                        return;
                };
            };
        }


    }
}

