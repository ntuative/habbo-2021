package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.room.IStuffData;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetToggleEvent;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetPurchaseOverrideEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.catalog.viewer.widgets.utils.RentUtils;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.tracking.HabboTracking;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetInitPurchaseEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.SetRoomPreviewerStuffDataEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSpinnerEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;

    public class PurchaseCatalogWidget extends CatalogWidget implements ICatalogWidget
    {

        private var _stubPurchaseVipXML:XML;
        private var _SafeStr_1605:IWindowContainer;
        private var _offer:IPurchasableOffer;
        private var _additionalParameters:String = "";
        private var _SafeStr_1606:IStuffData = null;
        private var _SafeStr_1482:int = 1;
        private var _purchaseCallback:Function;
        private var _catalog:HabboCatalog;
        private var _noGiftOption:Boolean;
        private var _SafeStr_1607:Boolean = false;
        private var _SafeStr_1608:Boolean = true;

        public function PurchaseCatalogWidget(_arg_1:IWindowContainer, _arg_2:HabboCatalog)
        {
            super(_arg_1);
            _catalog = _arg_2;
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            events.removeEventListener("SELECT_PRODUCT", onSelectProduct);
            events.removeEventListener("CWE_SET_EXTRA_PARM", onSetParameter);
            events.removeEventListener("PURCHASE_OVERRIDE", onPurchaseOverride);
            events.removeEventListener("CWE_SET_PREVIEWER_STUFFDATA", onSetPreviewerStuffData);
            events.removeEventListener("CWE_TOGGLE", onToggleWidget);
            super.dispose();
        }

        private function onToggleWidget(_arg_1:CatalogWidgetToggleEvent):void
        {
            if (_arg_1.widgetId == "purchaseWidget")
            {
                _SafeStr_1608 = _arg_1.enabled;
                window.visible = _SafeStr_1608;
            };
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            if (_catalog.catalogType == "BUILDERS_CLUB")
            {
                _window.visible = false;
                return (true);
            };
            attachWidgetView("purchaseWidget");
            _window.findChildByName("selection_information").visible = true;
            _window.findChildByName("default_buttons").visible = false;
            _noGiftOption = false;
            if (window.tags.indexOf("ROOM_INITIATE_PURCHASE") > -1)
            {
                _catalog.sendRoomAdPurchaseInitiatedEvent();
            };
            _window.findChildByName("buy_button").addEventListener("WME_CLICK", onPurchase);
            var _local_2:_SafeStr_101 = (_window.findChildByName("gift_button") as _SafeStr_101);
            if (window.tags.indexOf("NO_GIFT_OPTION") > -1)
            {
                _noGiftOption = true;
                _local_2.visible = false;
            };
            _local_2.addEventListener("WME_CLICK", onGift);
            _local_2.disable();
            var _local_1:XmlAsset = (_catalog.assets.getAssetByName("purchaseWidgetBuyVipStub") as XmlAsset);
            if (_local_1 != null)
            {
                _stubPurchaseVipXML = (_local_1.content as XML);
            };
            events.addEventListener("SELECT_PRODUCT", onSelectProduct);
            events.addEventListener("CWE_SET_EXTRA_PARM", onSetParameter);
            events.addEventListener("PURCHASE_OVERRIDE", onPurchaseOverride);
            events.addEventListener("INIT_PURCHASE", initPurchase);
            events.addEventListener("CWE_SET_PREVIEWER_STUFFDATA", onSetPreviewerStuffData);
            events.addEventListener("CWSE_VALUE_CHANGED", onSpinnerValueChanged);
            events.addEventListener("CWE_EXTRA_PARAM_REQUIRED_FOR_BUY", onExtraParamRequired);
            events.addEventListener("CWE_TOGGLE", onToggleWidget);
            return (true);
        }

        private function onPurchaseOverride(_arg_1:CatalogWidgetPurchaseOverrideEvent):void
        {
            _purchaseCallback = _arg_1.callback;
        }

        private function attachStub(_arg_1:IPurchasableOffer):void
        {
            if (_SafeStr_1605 != null)
            {
                _SafeStr_1605.visible = false;
                _window.removeChild(_SafeStr_1605);
                _SafeStr_1605.dispose();
                _SafeStr_1605 = null;
            };
        }

        private function get extraParamRequirementsMet():Boolean
        {
            return (!((_SafeStr_1607) && (_additionalParameters == "")));
        }

        private function onSelectProduct(_arg_1:SelectProductEvent):void
        {
            var _local_2:IWindow;
            var _local_3:Boolean;
            _SafeStr_1482 = 1;
            _offer = _arg_1.offer;
            _window.findChildByName("selection_information").visible = false;
            _window.findChildByName("default_buttons").visible = true;
            attachStub(_offer);
            _catalog.purchaseWillBeGift(false);
            if (_SafeStr_1605 == null)
            {
                enableBuyButton(extraParamRequirementsMet);
                enableGiftButton(extraParamRequirementsMet);
                RentUtils.updateBuyCaption(_offer, _window.findChildByName("purchase_label"));
                _local_2 = _window.findChildByName("gift_button");
                if (_local_2 != null)
                {
                    _local_2.visible = ((!(_offer.isRentOffer)) && (!(_noGiftOption)));
                };
                if (!_offer.giftable)
                {
                    enableGiftButton(false);
                };
                _local_3 = isSoldOut(_offer);
                if (_local_3)
                {
                    enableBuyButton(false);
                    enableGiftButton(false);
                };
                window.visible = _SafeStr_1608;
            }
            else
            {
                enableBuyButton(false);
                enableGiftButton(false);
            };
        }

        private function isSoldOut(_arg_1:IPurchasableOffer):Boolean
        {
            var _local_2:IProduct;
            var _local_3:Boolean;
            if (_arg_1 != null)
            {
                if (_arg_1.pricingModel == "pricing_model_single")
                {
                    _local_2 = _offer.product;
                    if (((!(_local_2 == null)) && (_local_2.isUniqueLimitedItem)))
                    {
                        return (_local_2.uniqueLimitedItemsLeft == 0);
                    };
                };
            };
            return (false);
        }

        private function enableBuyButton(_arg_1:Boolean):void
        {
            if (_catalog.sessionDataManager.isAccountSafetyLocked())
            {
                _arg_1 = false;
            };
            enableButton("buy_button", _arg_1);
        }

        private function enableGiftButton(_arg_1:Boolean):void
        {
            if (_catalog.sessionDataManager.isAccountSafetyLocked())
            {
                _arg_1 = false;
            };
            enableButton("gift_button", _arg_1);
        }

        private function enableButton(_arg_1:String, _arg_2:Boolean):void
        {
            if (_window == null)
            {
                return;
            };
            var _local_3:IWindow = _window.findChildByName(_arg_1);
            if (_local_3 == null)
            {
                return;
            };
            if (_arg_2)
            {
                _local_3.enable();
                _local_3.blend = 1;
            }
            else
            {
                _local_3.disable();
                _local_3.blend = 0.5;
            };
        }

        private function onSetParameter(_arg_1:SetExtraPurchaseParameterEvent):void
        {
            _additionalParameters = _arg_1.parameter;
            enableBuyButton(extraParamRequirementsMet);
            enableGiftButton(((((!(_offer == null)) && (_offer.giftable)) && (extraParamRequirementsMet)) && (_SafeStr_1482 == 1)));
        }

        private function onPurchase(_arg_1:WindowMouseEvent, _arg_2:Boolean=false):void
        {
            var event:WindowMouseEvent = _arg_1;
            var isGift:Boolean = _arg_2;
            if (!_catalog.verifyClubLevel(_offer.clubLevel))
            {
                _catalog.openClubCenter();
                return;
            };
            _catalog.purchaseWillBeGift(isGift);
            if (_purchaseCallback == null)
            {
                if (_offer != null)
                {
                    if (((!(_catalog.roomAdPurchaseData == null)) && (_catalog.roomAdPurchaseData.offerId == _offer.offerId)))
                    {
                        if (_catalog.roomAdPurchaseData.flatId == 0)
                        {
                            _catalog.windowManager.alert("${roomad.error.title}", "${roomad.alert.no.available.room}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                            {
                                _arg_1.dispose();
                            });
                            return;
                        };
                        if ((((_catalog.roomAdPurchaseData.name == null) || (_catalog.roomAdPurchaseData.name.length < 5)) || (_catalog.roomAdPurchaseData.name.substr(0, 1) == " ")))
                        {
                            _catalog.windowManager.alert("${roomad.error.title}", "${roomad.alert.name.empty}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                            {
                                _arg_1.dispose();
                            });
                            return;
                        };
                    };
                    _catalog.showPurchaseConfirmation(_offer, page.pageId, _additionalParameters, _SafeStr_1482, _SafeStr_1606, null, true, null);
                };
            }
            else
            {
                (_purchaseCallback(event));
            };
        }

        private function onGift(_arg_1:WindowMouseEvent):void
        {
            onPurchase(_arg_1, true);
            HabboTracking.getInstance().trackEventLog("Catalog", "click", "client.buy_as_gift.clicked");
        }

        private function initPurchase(_arg_1:CatalogWidgetInitPurchaseEvent):void
        {
            if (_offer != null)
            {
                _catalog.showPurchaseConfirmation(_offer, page.pageId, _additionalParameters, _SafeStr_1482, _SafeStr_1606, null, true, null);
            };
        }

        private function onBuyClub(_arg_1:WindowMouseEvent):void
        {
            _catalog.rememberPageDuringVipPurchase(page.pageId);
            _catalog.openClubCenter();
            HabboTracking.getInstance().trackEventLog("Catalog", "click", "BUY_CLUB");
        }

        private function onSetPreviewerStuffData(_arg_1:SetRoomPreviewerStuffDataEvent):void
        {
            _SafeStr_1606 = _arg_1.stuffData;
        }

        private function onSpinnerValueChanged(_arg_1:CatalogWidgetSpinnerEvent):void
        {
            _SafeStr_1482 = _arg_1.value;
            if (_SafeStr_1482 > 1)
            {
                enableGiftButton(false);
            }
            else
            {
                if (((!(_offer == null)) && (extraParamRequirementsMet)))
                {
                    enableGiftButton(_offer.giftable);
                };
            };
        }

        private function onExtraParamRequired(_arg_1:CatalogWidgetEvent):void
        {
            _SafeStr_1607 = true;
            enableBuyButton(extraParamRequirementsMet);
            enableGiftButton((((!(_offer == null)) && (extraParamRequirementsMet)) && (_SafeStr_1482 == 1)));
        }


    }
}