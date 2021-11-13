package com.sulake.habbo.notifications.singular
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.help.IHabboHelp;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;

    public class HabboAlertDialogManager
    {

        private var _windowManager:IHabboWindowManager;
        private var _localization:IHabboLocalizationManager;
        private var _habboHelp:IHabboHelp;

        public function HabboAlertDialogManager(_arg_1:IHabboWindowManager, _arg_2:IHabboLocalizationManager, _arg_3:IHabboHelp)
        {
            _windowManager = _arg_1;
            _localization = _arg_2;
            _habboHelp = _arg_3;
        }

        private static function getTimeZeroPadded(_arg_1:int):String
        {
            var _local_2:String = ("0" + String(_arg_1));
            return (_local_2.substr((_local_2.length - 2), _local_2.length));
        }


        public function dispose():void
        {
            _windowManager = null;
            _localization = null;
            _habboHelp = null;
        }

        public function handleModeratorCaution(_arg_1:String, _arg_2:String=""):void
        {
            showModerationMessage(_arg_1, _arg_2);
        }

        public function handleModeratorMessage(_arg_1:String, _arg_2:String=""):void
        {
            showModerationMessage(_arg_1, _arg_2, false);
        }

        public function handleUserBannedMessage(_arg_1:String):void
        {
            showModerationMessage(_arg_1, "");
        }

        private function showModerationMessage(_arg_1:String, _arg_2:String, _arg_3:Boolean=true):void
        {
            var message:String = _arg_1;
            var url:String = _arg_2;
            var showHabboWay:Boolean = _arg_3;
            var p:RegExp = /\\r/g;
            message = message.replace(p, "\r");
            _windowManager.simpleAlert("", "${mod.alert.title}", message, "${mod.alert.link}", url, null, "illumina_alert_illustrations_frank_neutral_png", null, function ():void
            {
                if (((!(_habboHelp == null)) && (showHabboWay)))
                {
                    _habboHelp.showHabboWay();
                };
            });
        }

        public function handleHotelClosingMessage(_arg_1:int):void
        {
            _localization.registerParameter("opening.hours.shutdown", "m", String(_arg_1));
            _windowManager.simpleAlert("", "${opening.hours.title}", "${opening.hours.shutdown}");
        }

        public function handleHotelMaintenanceMessage(_arg_1:int, _arg_2:int):void
        {
            _localization.registerParameter("maintenance.shutdown", "m", String(_arg_1));
            _localization.registerParameter("maintenance.shutdown", "d", String(_arg_2));
            _windowManager.simpleAlert("", "${opening.hours.title}", "${maintenance.shutdown}");
        }

        public function handleHotelClosedMessage(_arg_1:int, _arg_2:int, _arg_3:Boolean):void
        {
            var openHour:int = _arg_1;
            var openMinute:int = _arg_2;
            var userThrownOutAtClose:Boolean = _arg_3;
            if (userThrownOutAtClose)
            {
                _localization.registerParameter("opening.hours.disconnected", "h", getTimeZeroPadded(openHour));
                _localization.registerParameter("opening.hours.disconnected", "m", getTimeZeroPadded(openMinute));
                _windowManager.alert("${opening.hours.title}", "${opening.hours.disconnected}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                {
                    _arg_1.dispose();
                });
            }
            else
            {
                _localization.registerParameter("opening.hours.closed", "h", getTimeZeroPadded(openHour));
                _localization.registerParameter("opening.hours.closed", "m", getTimeZeroPadded(openMinute));
                _windowManager.alert("${opening.hours.title}", "${opening.hours.closed}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                {
                    _arg_1.dispose();
                });
            };
        }

        public function handleLoginFailedHotelClosedMessage(_arg_1:int, _arg_2:int):void
        {
            var openHour:int = _arg_1;
            var openMinute:int = _arg_2;
            _localization.registerParameter("opening.hours.disconnected", "h", getTimeZeroPadded(openHour));
            _localization.registerParameter("opening.hours.disconnected", "m", getTimeZeroPadded(openMinute));
            _windowManager.alert("${opening.hours.title}", "${opening.hours.disconnected}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
            {
                _arg_1.dispose();
            });
        }


    }
}
