package com.sulake.habbo.catalog.club
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.catalog.purse.IPurse;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components._SafeStr_108;
    import com.sulake.core.window.events.WindowEvent;

    public class ClubBuyConfirmationDialog
    {

        private var _offer:ClubBuyOfferData;
        private var _SafeStr_1284:ClubBuyController;
        private var _SafeStr_570:IFrameWindow;
        private var _SafeStr_1425:int;

        public function ClubBuyConfirmationDialog(_arg_1:ClubBuyController, _arg_2:ClubBuyOfferData, _arg_3:int)
        {
            _offer = _arg_2;
            _SafeStr_1284 = _arg_1;
            _SafeStr_1425 = _arg_3;
            showConfirmation();
        }

        public function dispose():void
        {
            _SafeStr_1284 = null;
            _offer = null;
            if (_SafeStr_570)
            {
                _SafeStr_570.dispose();
                _SafeStr_570 = null;
            };
        }

        public function showConfirmation():void
        {
            if (((!(_offer)) || (!(_SafeStr_1284))))
            {
                return;
            };
            _SafeStr_570 = (_SafeStr_1284.catalog.utils.createWindow("club_buy_confirmation") as IFrameWindow);
            if (!_SafeStr_570)
            {
                return;
            };
            _SafeStr_570.procedure = windowEventHandler;
            _SafeStr_570.center();
            if (_SafeStr_1284.catalog.getBoolean("disclaimer.credit_spending.enabled"))
            {
                setDisclaimerAccepted(false);
            }
            else
            {
                _SafeStr_570.findChildByName("disclaimer").dispose();
                setDisclaimerAccepted(true);
            };
            var _local_1:IHabboLocalizationManager = _SafeStr_1284.localization;
            var _local_4:IPurse = _SafeStr_1284.getPurse();
            var _local_5:String = (((_local_4.hasClubLeft) && (_local_4.isVIP)) ? "extension." : "subscription.");
            var _local_3:String = ((_offer.months == 0) ? "days" : "months");
            var _local_2:String = (("catalog.vip.buy.confirm." + _local_5) + _local_3);
            _local_1.registerParameter(_local_2, ("num_" + _local_3), String(((_offer.months == 0)
                    ? _offer.extraDays
                    : _offer.months)));
            _SafeStr_570.findChildByName("subscription_name").caption = _local_1.getLocalization(_local_2);
            _local_1.registerParameter("catalog.vip.buy.confirm.end_date", "day", String(_offer.day));
            _local_1.registerParameter("catalog.vip.buy.confirm.end_date", "month", String(_offer.month));
            _local_1.registerParameter("catalog.vip.buy.confirm.end_date", "year", String(_offer.year));
            _SafeStr_1284.catalog.utils.showPriceInContainer((_SafeStr_570.findChildByName("purchase_cost_box") as IWindowContainer), _offer);
        }

        private function setDisclaimerAccepted(_arg_1:Boolean):void
        {
            if (_SafeStr_570 == null)
            {
                return;
            };
            var _local_2:IWindow = _SafeStr_570.findChildByName("select_button");
            if (_local_2 == null)
            {
                return;
            };
            if (_arg_1)
            {
                _local_2.enable();
            }
            else
            {
                _local_2.disable();
            };
        }

        private function windowEventHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((((!(_arg_1)) || (!(_arg_2))) || (!(_SafeStr_1284))) || (!(_offer))))
            {
                return;
            };
            if (((!(_arg_1.type == "WME_CLICK")) && (!(_arg_1.type == "WME_DOUBLE_CLICK"))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "spending_disclaimer":
                    setDisclaimerAccepted(_SafeStr_108(_arg_2).isSelected);
                    return;
                case "select_button":
                    _SafeStr_1284.catalog.doNotCloseAfterVipPurchase();
                    _SafeStr_1284.confirmSelection(_offer, _SafeStr_1425);
                    return;
                case "header_button_close":
                case "cancel_button":
                    _SafeStr_1284.catalog.forgetPageDuringVipPurchase();
                    _SafeStr_1284.closeConfirmation();
                    return;
            };
        }


    }
}