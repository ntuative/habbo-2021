package com.sulake.habbo.friendbar.landingview.widget
{
    import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
    import com.sulake.habbo.session.product.IProductDataListener;
    import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.catalog.BonusRareInfoMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.catalog._SafeStr_38;
    import com.sulake.core.window.IWindow;
    import flash.display.BitmapData;
    import com.sulake.habbo.room.events.RoomEngineEvent;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
    import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;

    public class BonusRarePromoWidget implements ILandingViewWidget, IProductDataListener, ISettingsAwareWidget, IGetImageListener 
    {

        private var _landingView:HabboLandingView;
        private var _container:IWindowContainer;
        private var _SafeStr_2353:String;
        private var _SafeStr_2354:int = -1;
        private var _totalCoinsForBonus:int;
        private var _SafeStr_2355:int;

        public function BonusRarePromoWidget(_arg_1:HabboLandingView)
        {
            _landingView = _arg_1;
        }

        public function dispose():void
        {
            if (!disposed)
            {
                _landingView.roomEngine.events.removeEventListener("REE_ENGINE_INITIALIZED", onRoomEngineInitialized);
                _landingView.communicationManager.removeHabboConnectionMessageEvent(new BonusRareInfoMessageEvent(onBonusRareInfoMessage));
                _landingView = null;
                _container = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_container == null);
        }

        public function initialize():void
        {
            _container = IWindowContainer(_landingView.getXmlWindow("bonus_rare_promo"));
            _container.findChildByName("buy_button").procedure = onOpenCreditsPageButton;
            _container.visible = false;
            _landingView.communicationManager.addHabboConnectionMessageEvent(new BonusRareInfoMessageEvent(onBonusRareInfoMessage));
            _landingView.roomEngine.events.addEventListener("REE_ENGINE_INITIALIZED", onRoomEngineInitialized);
            requestBonusRareInfo();
        }

        private function requestBonusRareInfo():void
        {
            _landingView.communicationManager.connection.send(new _SafeStr_38());
        }

        public function refresh():void
        {
            requestBonusRareInfo();
        }

        public function get container():IWindow
        {
            return (_container);
        }

        public function productDataReady():void
        {
            refreshContent();
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            refreshContent();
        }

        public function imageFailed(_arg_1:int):void
        {
        }

        private function onRoomEngineInitialized(_arg_1:RoomEngineEvent):void
        {
            refreshContent();
        }

        private function refreshContent():void
        {
            if (disposed)
            {
                return;
            };
            _container.visible = (!(_SafeStr_2354 == -1));
            var _local_1:IProductData = _landingView.getProductData(_SafeStr_2353, this);
            if (_local_1 != null)
            {
                IStaticBitmapWrapperWindow(_container.findChildByName("promo_image")).assetUri = _landingView.getProperty("landing.view.bonus.rare.image.uri");
                _container.findChildByName("header").caption = _landingView.localizationManager.getLocalizationWithParams("landing.view.bonus.rare.header", "", "rarename", _local_1.name, "amount", _totalCoinsForBonus);
                _container.findChildByName("status").caption = _landingView.localizationManager.getLocalizationWithParams("landing.view.bonus.rare.status", "", "amount", _SafeStr_2355, "total", _totalCoinsForBonus);
                setProgress((_totalCoinsForBonus - _SafeStr_2355), _totalCoinsForBonus);
            };
        }

        private function onBonusRareInfoMessage(_arg_1:BonusRareInfoMessageEvent):void
        {
            _SafeStr_2353 = _arg_1.getParser().productType;
            _SafeStr_2354 = _arg_1.getParser().productClassId;
            _totalCoinsForBonus = _arg_1.getParser().totalCoinsForBonus;
            _SafeStr_2355 = _arg_1.getParser().coinsStillRequiredToBuy;
            refreshContent();
        }

        private function onOpenCreditsPageButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _landingView.tracking.trackGoogle("landingView", "click_bonusRarePromoOpenCreditsPage");
                _landingView.catalog.openCreditsHabblet();
            };
        }

        public function set settings(_arg_1:CommonWidgetSettings):void
        {
            WidgetContainerLayout.applyCommonWidgetSettings(_container, _arg_1);
        }

        private function setProgress(_arg_1:int, _arg_2:int):void
        {
            var _local_5:int = _container.findChildByName("bar_a_bkg").width;
            var _local_4:int = _container.findChildByName("bar_a_bkg").x;
            var _local_3:int = int(((_arg_1 / _arg_2) * _local_5));
            _container.findChildByName("bar_a_c").width = _local_3;
            _container.findChildByName("bar_a_r").x = (_local_3 + _local_4);
        }


    }
}

