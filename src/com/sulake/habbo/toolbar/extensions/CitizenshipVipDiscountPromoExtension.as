package com.sulake.habbo.toolbar.extensions
{
    import com.sulake.habbo.toolbar.HabboToolbar;
    import com.sulake.core.window.components._SafeStr_124;
    import flash.utils.Timer;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.toolbar.IExtensionView;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetHabboClubExtendOfferMessageComposer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
    import flash.events.TimerEvent;

    public class CitizenshipVipDiscountPromoExtension 
    {

        private var _toolbar:HabboToolbar;
        private var _SafeStr_570:_SafeStr_124;
        private var _expanded:Boolean = true;
        private var _SafeStr_2392:int = 216;
        private var _SafeStr_3786:Timer;

        public function CitizenshipVipDiscountPromoExtension(_arg_1:HabboToolbar)
        {
            _toolbar = _arg_1;
        }

        private function createWindow():_SafeStr_124
        {
            var _local_1:_SafeStr_124;
            var _local_2:IAsset = _toolbar.assets.getAssetByName("vip_discount_promotion_v2_xml");
            if (_local_2)
            {
                _local_1 = (_toolbar.windowManager.buildFromXML((_local_2.content as XML), 1) as _SafeStr_124);
                if (_local_1)
                {
                    (_SafeStr_101(_local_1.findChildByName("extend_button").addEventListener("WME_CLICK", onButtonClicked)));
                    IRegionWindow(_local_1.findChildByName("minimize_region")).addEventListener("WME_CLICK", onMinMax);
                    IRegionWindow(_local_1.findChildByName("maximize_region")).addEventListener("WME_CLICK", onMinMax);
                    _SafeStr_2392 = _local_1.height;
                };
            };
            return (_local_1);
        }

        private function destroyWindow():void
        {
            if (_SafeStr_570)
            {
                _SafeStr_570.dispose();
                _SafeStr_570 = null;
            };
            destroyExpirationTimer();
        }

        private function get extensionView():IExtensionView
        {
            return (_toolbar.extensionView);
        }

        public function dispose():void
        {
            if (_toolbar == null)
            {
                return;
            };
            if (extensionView != null)
            {
                extensionView.detachExtension("club_promo");
            };
            destroyWindow();
            _toolbar = null;
        }

        private function onButtonClicked(_arg_1:WindowMouseEvent):void
        {
            if (_toolbar.inventory.clubLevel == 2)
            {
                _toolbar.connection.send(new EventLogMessageComposer("DiscountPromo", "citizenshipdiscount", "client.club.extend.discount.clicked"));
                _toolbar.connection.send(new GetHabboClubExtendOfferMessageComposer());
            };
        }

        private function assignState():void
        {
            _SafeStr_570.findChildByName("content_itemlist").visible = _expanded;
            _SafeStr_570.findChildByName("promo_img").visible = _expanded;
            _SafeStr_570.height = ((_expanded) ? _SafeStr_2392 : 33);
        }

        public function onClubChanged(_arg_1:HabboInventoryHabboClubEvent):void
        {
            if ((((_toolbar.inventory.citizenshipVipIsExpiring) && (_SafeStr_570 == null)) && (isExtensionEnabled())))
            {
                _SafeStr_570 = createWindow();
                if (_SafeStr_3786 != null)
                {
                    destroyExpirationTimer();
                };
                if (((_toolbar.inventory.clubMinutesUntilExpiration < 1440) && (_toolbar.inventory.clubMinutesUntilExpiration > 0)))
                {
                    _SafeStr_3786 = new Timer(((_toolbar.inventory.clubMinutesUntilExpiration * 60) * 1000), 1);
                    _SafeStr_3786.addEventListener("timerComplete", onExtendOfferExpire);
                    _SafeStr_3786.start();
                };
                assignState();
                if (!_toolbar.extensionView.hasExtension("vip_quests"))
                {
                    _toolbar.extensionView.attachExtension("club_promo", _SafeStr_570, 10);
                };
            }
            else
            {
                _toolbar.extensionView.detachExtension("vip_quests");
                destroyWindow();
            };
        }

        private function destroyExpirationTimer():void
        {
            if (_SafeStr_3786)
            {
                _SafeStr_3786.stop();
                _SafeStr_3786.removeEventListener("timerComplete", onExtendOfferExpire);
                _SafeStr_3786 = null;
            };
        }

        private function onExtendOfferExpire(_arg_1:TimerEvent):void
        {
            _toolbar.extensionView.detachExtension("club_promo");
            destroyWindow();
        }

        private function isExtensionEnabled():Boolean
        {
            return ((_toolbar.inventory.clubLevel == 2) && (_toolbar.getBoolean("club.membership.extend.vip.promotion.enabled")));
        }

        private function onMinMax(_arg_1:WindowMouseEvent):void
        {
            _expanded = (!(_expanded));
            assignState();
        }


    }
}

