package com.sulake.habbo.catalog.club
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.localization.ILocalization;

    public class VipBuyItem implements IDisposable
    {

        private var _offer:ClubBuyOfferData;
        private var _window:IWindowContainer;
        private var _catalog:HabboCatalog;
        private var _disposed:Boolean = false;
        private var _SafeStr_1436:String;

        public function VipBuyItem(_arg_1:ClubBuyOfferData, _arg_2:HabboCatalog, _arg_3:String)
        {
            super();
            var _local_4:ILocalization = null;
            _offer = _arg_1;
            _catalog = _arg_2;
            _SafeStr_1436 = _arg_3;
            _window = (_catalog.utils.createWindow("vip_buy_item") as IWindowContainer);
            var _local_5:IHabboLocalizationManager = _catalog.localization;
            if (_arg_1.months > 0)
            {
                _local_5.registerParameter("catalog.vip.item.header.months", "num_months", String(_arg_1.months));
                _local_4 = _local_5.getLocalizationRaw("catalog.vip.item.header.months");
            }
            else
            {
                _local_5.registerParameter("catalog.vip.item.header.days", "num_days", String(_arg_1.extraDays));
                _local_4 = _local_5.getLocalizationRaw("catalog.vip.item.header.days");
            };
            _window.findChildByName("item_header").caption = ((_local_4 != null) ? _local_4.value : "-");
            _catalog.utils.showPriceInContainer((_window.findChildByName("item_price") as IWindowContainer), _offer);
            _window.findChildByName("item_buy").addEventListener("WME_CLICK", onBuy);
            if (_arg_1.giftable)
            {
                _window.findChildByName("item_gift").addEventListener("WME_CLICK", onGift);
            }
            else
            {
                _window.findChildByName("item_gift").visible = false;
            };
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                _window.dispose();
                _window = null;
                _disposed = true;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        private function onBuy(_arg_1:WindowMouseEvent):void
        {
            _catalog.purchaseWillBeGift(false);
            _catalog.showPurchaseConfirmation(_offer, ((_offer.page == null) ? -1 : _offer.page.pageId));
        }

        private function onGift(_arg_1:WindowMouseEvent):void
        {
            _catalog.purchaseWillBeGift(true);
            _catalog.showPurchaseConfirmation(_offer, ((_offer.page == null) ? -1 : _offer.page.pageId));
        }

        public function get window():IWindow
        {
            return (_window);
        }


    }
}