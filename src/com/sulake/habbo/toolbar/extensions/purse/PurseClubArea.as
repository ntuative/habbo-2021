package com.sulake.habbo.toolbar.extensions.purse
{
    import com.sulake.habbo.toolbar.HabboToolbar;
    import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.utils.FriendlyTime;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.core.window.motion.Motions;
    import com.sulake.core.window.motion.DropBounce;

    public class PurseClubArea extends CurrencyIndicatorBase 
    {

        private static const BG_COLOR_LIGHT:uint = 4286084205;
        private static const BG_COLOR_DARK:uint = 4283781966;
        private static const ICON_STYLE_CLUB:int = 13;
        private static const ICON_STYLE_VIP:int = 14;
        private static const ICON_ANIMATION:Array = ["toolbar_hc_icon_0", "toolbar_hc_icon_1", "toolbar_hc_icon_2", "toolbar_hc_icon_1", "toolbar_hc_icon_0"];

        private var _SafeStr_3780:int = -1;
        private var _toolbar:HabboToolbar;
        private var _SafeStr_3781:int;

        public function PurseClubArea(_arg_1:HabboToolbar, _arg_2:IWindowContainer)
        {
            super(_arg_1.windowManager, _arg_1.assets);
            _toolbar = _arg_1;
            _window = _arg_2;
            this.bgColorLight = 4286084205;
            this.bgColorDark = 4283781966;
            this.textElementName = "days";
            this.iconAnimationSequence = ICON_ANIMATION;
            this.iconAnimationDelay = 50;
            this.amountZeroText = _toolbar.localization.getLocalization("purse.clubdays.zero.amount.text", "Get");
            onClubChanged(new HabboInventoryHabboClubEvent());
        }

        override protected function setAmount(_arg_1:int, _arg_2:int=-1):void
        {
            if (_arg_1 < 1)
            {
                _window.findChildByName("days").visible = false;
                _window.findChildByName("join").visible = true;
                this.textElementName = "join";
                this.setText(this.amountZeroText);
            }
            else
            {
                _window.findChildByName("days").visible = true;
                _window.findChildByName("join").visible = false;
                this.textElementName = "days";
                if (((!(_arg_2 == -1)) && (_arg_2 < 1440)))
                {
                    this.setText(FriendlyTime.getShortFriendlyTime(_toolbar.catalog.localization, (_arg_2 * 60)));
                }
                else
                {
                    this.setText(FriendlyTime.getShortFriendlyTime(_toolbar.catalog.localization, (_arg_1 * 86400)));
                };
            };
        }

        private function setClubIcon(_arg_1:int):void
        {
            var _local_2:IIconWindow = (_window.findChildByName("club_icon") as IIconWindow);
            if (_local_2)
            {
                _local_2.style = _arg_1;
                _local_2.invalidate();
            };
        }

        override public function dispose():void
        {
            _toolbar = null;
            super.dispose();
        }

        public function onClubChanged(_arg_1:HabboInventoryHabboClubEvent=null):void
        {
            var _local_3:IWindowContainer;
            if (!_toolbar.inventory)
            {
                return;
            };
            var _local_4:int = ((_toolbar.inventory.clubPeriods * 31) + _toolbar.inventory.clubDays);
            var _local_2:int = _toolbar.inventory.clubMinutesUntilExpiration;
            if (((!(_SafeStr_3780 == -1)) && (!(_toolbar.inventory.clubLevel == 0))))
            {
                setAmount(_local_4, _local_2);
                _local_3 = (_window.findChildByName("hc_join_button") as IWindowContainer);
                if (Motions.getMotionByTarget(_local_3) == null)
                {
                    Motions.runMotion(new DropBounce(_local_3, 900, 16));
                };
            };
            _SafeStr_3780 = _local_4;
            _SafeStr_3781 = _local_2;
            switch (_toolbar.inventory.clubLevel)
            {
                case 0:
                    setClubIcon(14);
                    setText(this.amountZeroText);
                    return;
                case 1:
                    setClubIcon(13);
                    return;
                case 2:
                    setClubIcon(14);
                default:
            };
        }


    }
}

