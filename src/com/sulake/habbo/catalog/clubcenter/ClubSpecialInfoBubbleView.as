package com.sulake.habbo.catalog.clubcenter
{
    import com.sulake.habbo.communication.messages.incoming.users.ScrKickbackData;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Timer;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.IWindow;
    import flash.events.TimerEvent;
    import com.sulake.core.window.events.WindowEvent;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import com.sulake.core.window.components.IBubbleWindow;
    import com.sulake.core.window.components.ITextWindow;

    public class ClubSpecialInfoBubbleView 
    {

        private static const MARGIN:int = 8;

        private var _SafeStr_690:ScrKickbackData;
        private var _SafeStr_1284:HabboClubCenter;
        private var _window:IWindowContainer;
        private var _SafeStr_1438:Timer;

        public function ClubSpecialInfoBubbleView(_arg_1:HabboClubCenter, _arg_2:IHabboWindowManager, _arg_3:ScrKickbackData, _arg_4:IWindow):void
        {
            _SafeStr_690 = _arg_3;
            _SafeStr_1284 = _arg_1;
            _window = (_arg_2.buildFromXML(XML(_SafeStr_1284.assets.getAssetByName("club_center_special_info_xml").content)) as IWindowContainer);
            if (!_window)
            {
                return;
            };
            _window.procedure = onInput;
            positionWindow(_arg_4);
            setElementText("info_creditsspent", getLocalization("hccenter.breakdown.creditsspent").replace("%credits%", _SafeStr_690.totalCreditsSpent));
            var _local_6:int = (_SafeStr_690.kickbackPercentage * 100);
            setElementText("info_factor", getLocalization("hccenter.breakdown.paydayfactor").replace("%percent%", _local_6).replace("%multiplier%", _SafeStr_690.kickbackPercentage));
            _local_6 = (_SafeStr_690.kickbackPercentage * 100);
            var _local_5:String = _SafeStr_1284.localization.getLocalization("hccenter.breakdown.paydayfactor.percent");
            if (((_local_5) && (_local_5.length > 0)))
            {
                _local_5 = _local_5.replace("%percent%", _local_6).replace("%multiplier%", _SafeStr_690.kickbackPercentage);
            }
            else
            {
                _local_5 = getLocalization("hccenter.breakdown.paydayfactor").replace("%percent%", _SafeStr_690.kickbackPercentage);
            };
            setElementText("info_factor", _local_5);
            setElementText("info_streakbonus", getLocalization("hccenter.breakdown.streakbonus").replace("%credits%", _SafeStr_690.creditRewardForStreakBonus));
            var _local_8:Number = ((((_SafeStr_690.kickbackPercentage * _SafeStr_690.totalCreditsSpent) + _SafeStr_690.creditRewardForStreakBonus) * 100) / 100);
            var _local_7:int = int((((_SafeStr_690.creditRewardForMonthlySpent + _SafeStr_690.creditRewardForStreakBonus) * 100) / 100));
            setElementText("info_total", getLocalization("hccenter.breakdown.total").replace("%credits%", _local_7).replace("%actual%", _local_8));
            _window.activate();
            _SafeStr_1438 = new Timer(80, 1);
            _SafeStr_1438.addEventListener("timer", onTimerEvent);
            _SafeStr_1438.start();
            if (_SafeStr_1284.stage)
            {
                _SafeStr_1284.stage.addEventListener("click", onStageClick);
            };
        }

        private function onTimerEvent(_arg_1:TimerEvent):void
        {
            _SafeStr_1438.stop();
            _SafeStr_1438.removeEventListener("timer", onTimerEvent);
            _SafeStr_1438 = null;
            _window.activate();
        }

        public function dispose():void
        {
            if (((_SafeStr_1284) && (_SafeStr_1284.stage)))
            {
                _SafeStr_1284.stage.removeEventListener("click", onStageClick);
            };
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            _SafeStr_1284 = null;
        }

        private function onInput(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((!(_arg_1.type == "WME_DOWN")) || (!(_SafeStr_1284))))
            {
                return;
            };
            _arg_1.stopImmediatePropagation();
            switch (_arg_2.name)
            {
                case "special_infolink":
                    _SafeStr_1284.openPaydayHelpPage();
            };
            _SafeStr_1284.removeBreakdown();
        }

        private function onStageClick(_arg_1:MouseEvent):void
        {
            if (_SafeStr_1284)
            {
                _SafeStr_1284.removeBreakdown();
            };
        }

        private function positionWindow(_arg_1:IWindow):void
        {
            if (((((!(_arg_1)) || (!(_window))) || (!(_SafeStr_1284))) || (!(_SafeStr_1284.stage))))
            {
                return;
            };
            var _local_2:Point = new Point();
            _arg_1.getGlobalPosition(_local_2);
            if (((_SafeStr_1284.stage.stageWidth < (((_local_2.x + _arg_1.width) + _window.width) + 8)) && (_local_2.x > (_window.width + 8))))
            {
                (_window as IBubbleWindow).direction = "right";
                _local_2.x = (_local_2.x - (_window.width + 8));
            }
            else
            {
                _local_2.x = (_local_2.x + (_arg_1.width + 8));
            };
            _local_2.y = (_local_2.y + ((_arg_1.height * 0.5) - (_window.height * 0.5)));
            _window.position = _local_2;
        }

        private function setElementText(_arg_1:String, _arg_2:String):void
        {
            if (!_window)
            {
                return;
            };
            var _local_3:ITextWindow = (_window.findChildByName(_arg_1) as ITextWindow);
            if (_local_3)
            {
                _local_3.text = _arg_2;
            };
        }

        private function getLocalization(_arg_1:String):String
        {
            if (((!(_SafeStr_1284)) || (!(_SafeStr_1284.localization))))
            {
                return ("");
            };
            return (_SafeStr_1284.localization.getLocalization(_arg_1, _arg_1));
        }


    }
}

