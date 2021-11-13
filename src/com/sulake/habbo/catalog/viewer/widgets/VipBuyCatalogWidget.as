package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.catalog.club.ClubBuyController;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.club.VipBuyItem;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.catalog.purse.IPurse;
    import com.sulake.core.window.components.ITextWindow;
    import flash.text.TextFormat;
    import com.sulake.core.window.IWindow;
    import flash.text.StyleSheet;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.habbo.catalog.viewer.CatalogPage;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.catalog.club.ClubBuyOfferData;

    public class VipBuyCatalogWidget extends CatalogWidget implements ICatalogWidget, IVipBuyCatalogWidget
    {

        private var _SafeStr_1284:ClubBuyController;
        private var _offers:Array;
        private var _catalog:HabboCatalog;
        private var _isGift:Boolean;

        public function VipBuyCatalogWidget(_arg_1:IWindowContainer, _arg_2:HabboCatalog, _arg_3:Boolean=false)
        {
            super(_arg_1);
            _catalog = _arg_2;
            _isGift = _arg_3;
        }

        public function get isGift():Boolean
        {
            return (_isGift);
        }

        override public function dispose():void
        {
            if (_SafeStr_1284 != null)
            {
                _SafeStr_1284.unRegisterVisualization(this);
                _SafeStr_1284 = null;
            };
            reset();
            super.dispose();
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            _offers = [];
            _SafeStr_1284 = _catalog.getClubBuyController();
            _SafeStr_1284.registerVisualization(this);
            _SafeStr_1284.requestOffers(((_isGift) ? 2 : 1));
            return (true);
        }

        public function reset():void
        {
            for each (var _local_1:VipBuyItem in _offers)
            {
                _local_1.dispose();
            };
            _offers = [];
        }

        public function initClubType(_arg_1:int):void
        {
            var _local_5:int;
            var _local_4:int;
            var _local_3:int;
            if (disposed)
            {
                return;
            };
            var _local_2:IHabboLocalizationManager = _catalog.localization;
            var _local_6:IPurse = _catalog.getPurse();
            if (((!(_local_6 == null)) && (!(_local_2 == null))))
            {
                _local_5 = _local_6.clubDays;
                _local_4 = _local_6.clubPeriods;
                _local_3 = ((_local_4 * 31) + _local_5);
                _local_2.registerParameter("catalog.vip.extend.info", "days", String(_local_3));
            };
            if ((((!(_window == null)) && (_arg_1 == 2)) && (!(_isGift))))
            {
                _window.findChildByName("vip_title").caption = "${catalog.vip.extend.title}";
                _window.findChildByName("vip_info").caption = "${catalog.vip.extend.info}";
            };
            if (_window != null)
            {
                fixFormatting((_window.findChildByName("vip_title") as ITextWindow));
                fixFormatting((_window.findChildByName("vip_info") as ITextWindow), 3);
            };
            initLinks();
        }

        private function fixFormatting(_arg_1:ITextWindow, _arg_2:Number=0):void
        {
            var _local_3:TextFormat = _arg_1.getTextFormat();
            _local_3.align = "center";
            _local_3.leading = _arg_2;
            _arg_1.setTextFormat(_local_3);
        }

        private function initLinks():void
        {
            var _local_2:IWindow;
            var _local_1:ITextWindow;
            if (_window)
            {
                _local_2 = _window.findChildByName("vip_link");
                if (_local_2)
                {
                    _local_2.addEventListener("WME_CLICK", onBenefits);
                    _local_2.mouseThreshold = 0;
                };
                _local_1 = (_window.findChildByName("hccenter_link") as ITextWindow);
                if (((_local_1) && (_SafeStr_1284)))
                {
                    _local_1.text = _SafeStr_1284.localization.getLocalization("catalog.vip.buy.hccenter", "catalog.vip.buy.hccenter");
                    setLinkStyle(_local_1);
                };
            };
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

        public function onBenefits(_arg_1:WindowMouseEvent):void
        {
            _catalog.utils.showVipBenefits();
        }

        public function showOffer(_arg_1:ClubBuyOfferData):void
        {
            var _local_2:VipBuyItem;
            if (((disposed) || (!(_arg_1.vip))))
            {
                return;
            };
            Logger.log(("Offer: " + [_arg_1.offerId, _arg_1.productCode, _arg_1.priceCredits, _arg_1.vip, _arg_1.months, _arg_1.daysLeftAfterPurchase, _arg_1.year, _arg_1.month, _arg_1.day, _arg_1.upgradeHcPeriodToVip]));
            _arg_1.page = page;
            try
            {
                _local_2 = new VipBuyItem(_arg_1, _catalog, ((_isGift) ? "HabboCatalogGift" : "HabboCatalogBuy"));
            }
            catch(e:Error)
            {
                ErrorReportStorage.addDebugData("ClubBuyCatalogWidget", (((("showOffer - new ClubBuyItem(" + String(_arg_1)) + ", ") + (page as CatalogPage)) + ") crashed!"));
                return;
            };
            var _local_3:IItemListWindow = (_window.findChildByName("item_list_vip") as IItemListWindow);
            if (_local_3 != null)
            {
                _local_3.addListItem(_local_2.window);
            };
            _offers.push(_local_2);
        }


    }
}