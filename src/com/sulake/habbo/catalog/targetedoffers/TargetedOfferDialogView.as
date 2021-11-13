package com.sulake.habbo.catalog.targetedoffers
{
    import com.sulake.habbo.catalog.targetedoffers.data.TargetedOffer;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.catalog.purse._SafeStr_139;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import flash.text.StyleSheet;

    public class TargetedOfferDialogView extends OfferView 
    {

        private static const IMAGE_DEFAULT_URL:String = "targetedoffers/offer_default.png";

        private var _SafeStr_1482:int = 1;

        public function TargetedOfferDialogView(_arg_1:OfferController, _arg_2:TargetedOffer)
        {
            super(_arg_1, _arg_2);
        }

        public function buildWindow(_arg_1:String):void
        {
            var _local_2:String;
            var _local_4:String;
            if (((!(_SafeStr_1284.catalog)) || (!(_SafeStr_1284.catalog.windowManager))))
            {
                return;
            };
            _window = IWindowContainer(_SafeStr_1284.catalog.windowManager.buildFromXML(XML(_SafeStr_1284.catalog.assets.getAssetByName(_arg_1).content)));
            if (IFrameWindow(_window))
            {
                IFrameWindow(_window).title.text = getLocalization(_offer.title);
            };
            var _local_5:ITextWindow = ITextWindow(_window.findChildByName("txt_title"));
            if (_local_5)
            {
                _local_5.text = getLocalization(_offer.title);
            };
            _local_5 = ITextWindow(_window.findChildByName("txt_description"));
            if (_local_5)
            {
                _local_5.text = getLocalization(_offer.description);
                setLinkStyle(_local_5);
            };
            _local_5 = ITextWindow(_window.findChildByName("txt_price_label"));
            if (_local_5)
            {
                _local_5.text = getLocalization("targeted.offer.price.label");
            };
            var _local_6:Map = _SafeStr_1284.catalog.utils.getPriceMap(_offer, _SafeStr_1482);
            renderPrice(_window, _local_6);
            var _local_3:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_window.findChildByName("bmp_illustration"));
            if (_local_3)
            {
                _local_2 = (_SafeStr_1284.catalog as ICoreConfiguration).getProperty("image.library.url");
                _local_4 = getPreviewImageOverride(_offer);
                if (((_local_4 == null) || (_local_4.length == 0)))
                {
                    _local_4 = (((_offer.imageUrl) && (_offer.imageUrl.length > 0)) ? _offer.imageUrl : "targetedoffers/offer_default.png");
                };
                _local_3.assetUri = (_local_2 + _local_4);
            };
            _SafeStr_1508 = getLocalization("targeted.offer.timeleft", "");
            if (_offer.expirationTime == 0)
            {
                if (_window.findChildByName("cnt_time_left"))
                {
                    _window.findChildByName("cnt_time_left").visible = false;
                };
            }
            else
            {
                startUpdateTimer();
            };
            var _local_7:ITextFieldWindow = (_window.findChildByName("quantity_input") as ITextFieldWindow);
            if (_local_7)
            {
                _local_7.addEventListener("WKE_KEY_UP", onQuantityInputEvent);
            };
            _window.procedure = onInput;
            _window.center();
            updatePriceText();
            updateButtonStates();
        }

        private function renderPrice(_arg_1:IWindowContainer, _arg_2:Map):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            var _local_3:* = _arg_2.getValue("credit");
            _arg_1.findChildByName("txt_price_credits").caption = _local_3.amount;
            var _local_4:* = _arg_2.getValue("activityPoint");
            if (_local_4 != null)
            {
                _arg_1.findChildByName("txt_price_activityPoints").caption = _local_4.amount;
                setActivityPointIconStyle("activityPoints_icon", _arg_1, _local_4.activityPointType);
            }
            else
            {
                _arg_1.findChildByName("txt_price_activityPoints").caption = "0";
                setActivityPointIconStyle("activityPoints_icon", _arg_1, 5);
            };
        }

        private function setActivityPointIconStyle(_arg_1:String, _arg_2:IWindowContainer, _arg_3:int):void
        {
            var _local_4:IWindow = _arg_2.findChildByName(_arg_1);
            _local_4.style = _SafeStr_139.getIconStyleFor(_arg_3, _SafeStr_1284.catalog, true);
        }

        override protected function setTimeLeft(_arg_1:String):void
        {
            var _local_3:ITextWindow = ITextWindow(_window.findChildByName("txt_time_left"));
            if (!_local_3)
            {
                return;
            };
            _local_3.text = _arg_1;
            if (!_SafeStr_1508)
            {
                return;
            };
            var _local_4:int = Math.max(_SafeStr_1508.indexOf("%timeleft%"), 0);
            var _local_2:ITextWindow = ITextWindow(_window.findChildByName("txt_time_left_label_1"));
            if (_local_2)
            {
                _local_2.text = _SafeStr_1508.substr(0, (_local_4 - 1));
            };
            _local_2 = ITextWindow(_window.findChildByName("txt_time_left_label_2"));
            if (_local_2)
            {
                _local_2.text = _SafeStr_1508.substr((_local_4 + 10), _SafeStr_1508.length);
            };
        }

        public function updateButtonStates():void
        {
            var _local_4:ITextWindow = ITextWindow(_window.findChildByName("txt_status"));
            if (!_local_4)
            {
                return;
            };
            var _local_1:Boolean = _offer.checkPurseBalance(_SafeStr_1284.catalog.getPurse(), _SafeStr_1482);
            if (_local_1)
            {
                _local_4.text = "";
            }
            else
            {
                if (_window.findChildByName("btn_buy"))
                {
                    _window.findChildByName("btn_buy").disable();
                };
            };
            if (_window.findChildByName("cnt_quantity"))
            {
                _window.findChildByName("cnt_quantity").visible = (_offer.purchaseLimit > 1);
            };
            if (_window.findChildByName("btn_get_credits"))
            {
                _window.findChildByName("btn_get_credits").visible = (!(_local_1));
            };
            var _local_2:IWindow = _window.findChildByName("btn_buy");
            if (_local_2)
            {
                if (((_local_1) && (isQuantityValid())))
                {
                    _local_2.enable();
                }
                else
                {
                    _local_2.disable();
                };
            };
            var _local_3:IItemListWindow = IItemListWindow(_window.findChildByName("itemlist_buttonbar"));
            if (_local_3)
            {
                _local_3.arrangeListItems();
                _local_3.arrangeListItems();
            };
        }

        private function updatePriceText():void
        {
            var _local_2:ITextWindow = ITextWindow(_window.findChildByName("txt_price_credits"));
            if (_local_2)
            {
                _local_2.text = ((_SafeStr_1482 * _offer.priceInCredits) + "");
            };
            var _local_1:ITextWindow = ITextWindow(_window.findChildByName("txt_price_activityPoints"));
            if (_local_1)
            {
                _local_1.text = ((_SafeStr_1482 * _offer.priceInActivityPoints) + "");
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
                    case "header_button_close":
                        _SafeStr_1284.minimizeOffer(_offer);
                        return;
                    case "btn_get_credits":
                        _SafeStr_1284.purchaseCredits(_offer);
                        return;
                    case "btn_buy":
                        if (!isQuantityValid())
                        {
                            return;
                        };
                        _SafeStr_1284.showConfirmation(_offer, _SafeStr_1482);
                        return;
                };
            };
        }

        private function isQuantityValid():Boolean
        {
            return ((_SafeStr_1482 >= 1) && (_SafeStr_1482 <= _offer.purchaseLimit));
        }

        private function onQuantityInputEvent(_arg_1:WindowKeyboardEvent):void
        {
            var _local_2:int = parseInt(_arg_1.target.caption);
            if (((((_local_2 == 0) && (!(_arg_1.target.caption == ""))) || (_local_2 > 999)) || (_local_2 > _offer.purchaseLimit)))
            {
                _arg_1.target.caption = _SafeStr_1482.toString();
                return;
            };
            _SafeStr_1482 = _local_2;
            updatePriceText();
            updateButtonStates();
        }

        private function setLinkStyle(_arg_1:ITextWindow):void
        {
            if (!_arg_1)
            {
                return;
            };
            var _local_3:StyleSheet = new StyleSheet();
            var _local_2:Object = {};
            _local_2.textDecoration = "underline";
            _local_3.setStyle("a:link", _local_2);
            _arg_1.styleSheet = _local_3;
        }

        private function getPreviewImageOverride(_arg_1:TargetedOffer):String
        {
            return (_SafeStr_1284.catalog.getProperty(("targeted.offer.override.preview_image." + _arg_1.id)));
        }


    }
}

