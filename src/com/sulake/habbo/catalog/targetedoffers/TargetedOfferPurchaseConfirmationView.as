package com.sulake.habbo.catalog.targetedoffers
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.catalog.targetedoffers.data.TargetedOffer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components._SafeStr_108;
    import com.sulake.core.window.events.WindowEvent;

    public class TargetedOfferPurchaseConfirmationView extends OfferView 
    {

        private var _SafeStr_1482:int;

        public function TargetedOfferPurchaseConfirmationView(_arg_1:OfferController, _arg_2:TargetedOffer, _arg_3:int)
        {
            super(_arg_1, _arg_2);
            _SafeStr_1482 = _arg_3;
            _window = IWindowContainer(_SafeStr_1284.catalog.windowManager.buildFromXML(XML(_SafeStr_1284.catalog.assets.getAssetByName("targeted_offer_purchase_confirmation_xml").content)));
            var _local_4:HabboCatalog = (_SafeStr_1284.catalog as HabboCatalog);
            if (_local_4.getBoolean("disclaimer.credit_spending.enabled"))
            {
                setDisclaimerAccepted(false);
            }
            else
            {
                _window.findChildByName("disclaimer").dispose();
                setDisclaimerAccepted(true);
            };
            ITextWindow(_window.findChildByName("product_name")).text = getLocalization(_arg_2.title);
            var _local_5:IWindowContainer = (_window.findChildByName("purchase_cost_box") as IWindowContainer);
            _local_4.utils.showPriceInContainer(_local_5, _arg_2, _arg_3);
            var _local_6:ITextWindow = (_window.findChildByName("quantity") as ITextWindow);
            if (_local_6 != null)
            {
                if (((_arg_1.catalog.multiplePurchaseEnabled) && (_SafeStr_1482 > 1)))
                {
                    _local_6.text = ("X " + _SafeStr_1482);
                };
            };
            _window.procedure = onInput;
            _window.center();
        }

        private function setDisclaimerAccepted(_arg_1:Boolean):void
        {
            if (_window == null)
            {
                return;
            };
            var _local_2:IWindow = _window.findChildByName("select_button");
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

        private function onInput(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (!_SafeStr_1284)
            {
                return;
            };
            if (_arg_1.type == "WME_DOWN")
            {
                switch (_arg_2.name)
                {
                    case "spending_disclaimer":
                        setDisclaimerAccepted(_SafeStr_108(_arg_2).isSelected);
                        return;
                    case "header_button_close":
                    case "cancel_button":
                        _SafeStr_1284.maximizeOffer(_offer);
                        return;
                    case "buy_button":
                        _SafeStr_1284.purchaseTargetedOffer(_offer, _SafeStr_1482);
                        return;
                };
            };
        }


    }
}

