package com.sulake.habbo.help.guidehelp
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.help.HabboHelp;
    import com.sulake.habbo.help.GuideHelpManager;
    import com.sulake.habbo.window.utils.IModalDialog;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components._SafeStr_108;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.communication.messages.outgoing.room.session._SafeStr_23;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import flash.utils.getTimer;
    import com.sulake.habbo.window.widgets.IUpdatingTimeStampWidget;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.IAvatarImageWidget;
    import com.sulake.habbo.communication.messages.parser.help.data.PendingGuideTicket;

    public class HelpController implements IDisposable 
    {

        private var _habboHelp:HabboHelp;
        private var _guideHelp:GuideHelpManager;
        private var _disposed:Boolean = false;
        private var _SafeStr_2677:IModalDialog;
        private var _tourPopup:IWindowContainer;
        private var _tourPopupShowTime:int;
        private var _SafeStr_2678:IWindowContainer;

        public function HelpController(_arg_1:GuideHelpManager)
        {
            _habboHelp = _arg_1.habboHelp;
            _guideHelp = _arg_1;
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            closeWindow();
            closeTourPopup();
            _habboHelp = null;
            _guideHelp = null;
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        private function openWindow():void
        {
            if (((_SafeStr_2677 == null) && (!(disposed))))
            {
                _SafeStr_2677 = _guideHelp.habboHelp.getModalXmlWindow("main_help");
                _SafeStr_2677.rootWindow.procedure = windowEventProcedure;
            };
        }

        public function closeWindow():void
        {
            if (_SafeStr_2677 != null)
            {
                _SafeStr_2677.dispose();
                _SafeStr_2677 = null;
            };
        }

        private function windowEventProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:_SafeStr_108;
            if (((disposed) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "header_button_close":
                    closeWindow();
                    return;
                case "tour_button":
                    _guideHelp.createHelpRequest(((_habboHelp.newIdentity) ? 0 : 2));
                    _habboHelp.trackGoogle("helpWindow", "click_userTour");
                    closeWindow();
                    return;
                case "bully_button":
                    closeWindow();
                    _habboHelp.toggleNewHelpWindow();
                    _habboHelp.trackGoogle("helpWindow", "click_reportBully");
                    return;
                case "instructions_button":
                    _guideHelp.createHelpRequest(1);
                    _habboHelp.trackGoogle("helpWindow", "click_instructions");
                    closeWindow();
                    return;
                case "self_help_link":
                    HabboWebTools.openWebPage(_habboHelp.getProperty("zendesk.url"), "habboMain");
                    _habboHelp.trackGoogle("helpWindow", "click_selfHelp");
                    closeWindow();
                    return;
                case "habboway_link":
                    if (_habboHelp.getBoolean("habboway.enabled"))
                    {
                        _habboHelp.showHabboWay();
                    }
                    else
                    {
                        HabboWebTools.openWebPage(_habboHelp.getProperty("habboway.url"), "habboMain");
                    };
                    _habboHelp.trackGoogle("helpWindow", "click_habboWay");
                    closeWindow();
                    return;
                case "safetybooklet_link":
                    _habboHelp.showSafetyBooklet();
                    _habboHelp.trackGoogle("helpWindow", "click_showSafetyBooklet");
                    closeWindow();
                    return;
                case "emergency_button":
                    _local_3 = (IWindowContainer(_SafeStr_2677.rootWindow).findChildByName("leave_room") as _SafeStr_108);
                    if (((!(_local_3 == null)) && (_local_3.isSelected)))
                    {
                        _habboHelp.sendMessage(new _SafeStr_23());
                    };
                    closeWindow();
                    _habboHelp.startEmergencyRequest();
                    _habboHelp.trackGoogle("helpWindow", "click_emergency");
                    return;
                default:
                    return;
            };
        }

        public function openTourPopup():void
        {
            if (((_tourPopup == null) && (!(disposed))))
            {
                _tourPopupShowTime = getTimer();
                _tourPopup = (_guideHelp.habboHelp.getXmlWindow("welcome_tour_popup") as IWindowContainer);
                _tourPopup.center();
                _tourPopup.y = (_tourPopup.y * 0.25);
                _tourPopup.procedure = tourPopupEventProcedure;
            };
        }

        private function closeTourPopup():void
        {
            if (_tourPopup != null)
            {
                _tourPopup.dispose();
                _tourPopup = null;
            };
        }

        private function tourPopupEventProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((disposed) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            var _local_3:int = int(((_tourPopupShowTime - getTimer()) / 1000));
            switch (_arg_2.name)
            {
                case "refuse_tour":
                    _habboHelp.tracking.trackEventLog("Help", "", "tour.new_user.cancel", "", _local_3);
                    _habboHelp.trackGoogle("newbieTourWindow", "click_refuseTour");
                    closeTourPopup();
                    return;
                case "header_button_close":
                    _habboHelp.tracking.trackEventLog("Help", "", "tour.new_user.dismiss", "", _local_3);
                    _habboHelp.trackGoogle("newbieTourWindow", "click_closeWindow");
                    closeTourPopup();
                    return;
                case "take_tour":
                    _guideHelp.createHelpRequest(0);
                    _habboHelp.tracking.trackEventLog("Help", "", "tour.new_user.accept", "", _local_3);
                    _habboHelp.trackGoogle("newbieTourWindow", "click_acceptTour");
                    closeTourPopup();
                    return;
            };
        }

        public function showPendingTicket(_arg_1:PendingGuideTicket):void
        {
            var _local_2:String;
            if (_arg_1.isGuide)
            {
                _local_2 = "pending_guide_session";
            }
            else
            {
                switch (_arg_1.type)
                {
                    case 0:
                    case 2:
                        _local_2 = "pending_tour_request";
                        break;
                    case 1:
                        _local_2 = "pending_instructions_request";
                        break;
                    case 3:
                        _local_2 = "pending_bully_request";
                        break;
                    default:
                        return;
                };
            };
            _SafeStr_2678 = (_habboHelp.getXmlWindow(_local_2) as IWindowContainer);
            _SafeStr_2678.center();
            _SafeStr_2678.procedure = onPendingReuqestEvent;
            if (_arg_1.isGuide)
            {
                return;
            };
            switch (_arg_1.type)
            {
                case 1:
                    _SafeStr_2678.findChildByName("description").caption = _arg_1.description;
                    IUpdatingTimeStampWidget(IWidgetWindow(_SafeStr_2678.findChildByName("timestamp")).widget).timeStamp = (new Date().getTime() - (_arg_1.secondsAgo * 1000));
                    return;
                case 3:
                    _SafeStr_2678.findChildByName("user_name").caption = _arg_1.otherPartyName;
                    IAvatarImageWidget(IWidgetWindow(_SafeStr_2678.findChildByName("user_avatar")).widget).figure = _arg_1.otherPartyFigure;
                    IUpdatingTimeStampWidget(IWidgetWindow(_SafeStr_2678.findChildByName("timestamp")).widget).timeStamp = (new Date().getTime() - (_arg_1.secondsAgo * 1000));
                    _habboHelp.localization.registerParameter("guide.pending.bully.room", "room", _arg_1.roomName);
                default:
            };
        }

        private function onPendingReuqestEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "header_button_close":
                    case "close_button":
                        if (((!(_SafeStr_2678 == null)) && (!(_SafeStr_2678.disposed))))
                        {
                            _SafeStr_2678.dispose();
                            _SafeStr_2678 = null;
                        };
                        return;
                };
            };
        }


    }
}

