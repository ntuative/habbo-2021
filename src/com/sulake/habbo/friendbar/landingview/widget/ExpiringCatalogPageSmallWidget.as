package com.sulake.habbo.friendbar.landingview.widget
{
    import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
    import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageWithEarliestExpiryMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.catalog._SafeStr_18;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.ICountdownWidget;
    import com.sulake.habbo.communication.messages.parser.catalog.CatalogPageWithEarliestExpiryMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
    import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;

    public class ExpiringCatalogPageSmallWidget implements ILandingViewWidget, ISettingsAwareWidget 
    {

        private static const REFRESH_PERIOD_IN_MILLIS:Number = 30000;

        private var _landingView:HabboLandingView;
        private var _container:IWindowContainer;
        private var _pageName:String = "";
        private var _lastRequestTime:Date;
        private var _SafeStr_2366:int;

        public function ExpiringCatalogPageSmallWidget(_arg_1:HabboLandingView)
        {
            _landingView = _arg_1;
        }

        public function get container():IWindow
        {
            return (_container);
        }

        public function dispose():void
        {
            _landingView = null;
            _container = null;
        }

        public function initialize():void
        {
            _container = IWindowContainer(_landingView.getXmlWindow("expiring_catalog_page_small"));
            _container.findChildByName("open_catalog_button").procedure = onOpenCatalogButton;
            _container.visible = false;
            _landingView.communicationManager.addHabboConnectionMessageEvent(new CatalogPageWithEarliestExpiryMessageEvent(onCatalogPage));
        }

        public function refresh():void
        {
            if (((_lastRequestTime == null) || ((_lastRequestTime.time + 30000) < new Date().time)))
            {
                _landingView.send(new _SafeStr_18());
                _lastRequestTime = new Date();
            };
        }

        private function refreshContent():void
        {
            if (_pageName == "")
            {
                _container.visible = false;
                return;
            };
            _container.visible = true;
            _container.findChildByName("page_header_txt").caption = getText((("landing.view.pageexpiry.page." + _pageName) + ".header"));
            _container.findChildByName("page_desc_txt").caption = getText((("landing.view.pageexpiry.page." + _pageName) + ".desc"));
            var _local_1:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_container.findChildByName("promo_bitmap"));
            _local_1.assetUri = (("${image.library.url}reception/catalog_teaser_" + _pageName) + ".png");
            refreshTimer();
        }

        private function getText(_arg_1:String):String
        {
            return (("${" + _arg_1) + "}");
        }

        private function onOpenCatalogButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _landingView.catalog.openCatalogPage(_pageName);
                _landingView.tracking.trackGoogle("landingView", "click_goToExpiringCatalogPage");
            };
        }

        public function get disposed():Boolean
        {
            return (_landingView == null);
        }

        private function refreshTimer():void
        {
            var _local_1:IWidgetWindow = IWidgetWindow(_container.findChildByName("countdown_widget"));
            var _local_2:ICountdownWidget = ICountdownWidget(_local_1.widget);
            _local_2.seconds = _SafeStr_2366;
        }

        private function onCatalogPage(_arg_1:IMessageEvent):void
        {
            var _local_2:CatalogPageWithEarliestExpiryMessageParser = CatalogPageWithEarliestExpiryMessageParser(_arg_1.parser);
            _pageName = _local_2.pageName;
            _SafeStr_2366 = _local_2.secondsToExpiry;
            refreshContent();
        }

        public function set settings(_arg_1:CommonWidgetSettings):void
        {
            WidgetContainerLayout.applyCommonWidgetSettings(_container, _arg_1);
        }


    }
}

