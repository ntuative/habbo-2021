package com.sulake.habbo.catalog.club
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.ICatalogPage;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.localization.ILocalization;

    public class ClubBuyItem
    {

        private var _offer:ClubBuyOfferData;
        private var _window:IWindowContainer;
        private var _SafeStr_1426:ICatalogPage;

        public function ClubBuyItem(_arg_1:ClubBuyOfferData, _arg_2:ICatalogPage)
        {
            super();
            var _local_5:XML = null;
            var _local_3:ILocalization = null;
            _offer = _arg_1;
            _SafeStr_1426 = _arg_2;
            if (_arg_1.vip)
            {
                _local_5 = getAssetXML("club_buy_vip_item");
            }
            else
            {
                _local_5 = getAssetXML("club_buy_hc_item");
            };
            _window = (_SafeStr_1426.viewer.catalog.windowManager.buildFromXML(_local_5) as IWindowContainer);
            var _local_4:IHabboLocalizationManager = (_arg_2.viewer.catalog as HabboCatalog).localization;
            _local_4.registerParameter("catalog.club.item.header", "months", String(_arg_1.months));
            _local_3 = _local_4.getLocalizationRaw("catalog.club.item.header");
            _window.findChildByName("item_header").caption = _local_3.value;
            _local_4.registerParameter("catalog.club.price", "price", String(_arg_1.priceCredits));
            _local_3 = _local_4.getLocalizationRaw("catalog.club.price");
            _window.findChildByName("item_price").caption = _local_3.value;
            var _local_6:_SafeStr_101 = (_window.findChildByName("item_buy") as _SafeStr_101);
            if (_local_6 != null)
            {
                _local_6.addEventListener("WME_CLICK", onBuy);
            };
        }

        public function dispose():void
        {
            _window.dispose();
        }

        private function onBuy(_arg_1:WindowMouseEvent):void
        {
            HabboCatalog(_SafeStr_1426.viewer.catalog).showPurchaseConfirmation(_offer, _SafeStr_1426.pageId);
        }

        private function getAssetXML(_arg_1:String):XML
        {
            if (((((!(_SafeStr_1426)) || (!(_SafeStr_1426.viewer))) || (!(_SafeStr_1426.viewer.catalog))) || (!(_SafeStr_1426.viewer.catalog.assets))))
            {
                return (null);
            };
            var _local_2:XmlAsset = (_SafeStr_1426.viewer.catalog.assets.getAssetByName(_arg_1) as XmlAsset);
            if (_local_2 == null)
            {
                return (null);
            };
            return (_local_2.content as XML);
        }

        public function get window():IWindow
        {
            return (_window);
        }


    }
}