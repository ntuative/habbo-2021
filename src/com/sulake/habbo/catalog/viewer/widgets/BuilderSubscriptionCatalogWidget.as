package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetBuilderSubscriptionUpdatedEvent;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.events.WindowEvent;

    public class BuilderSubscriptionCatalogWidget extends CatalogWidget implements ICatalogWidget, IDisposable 
    {

        private var _catalog:HabboCatalog;
        private var _SafeStr_1542:String;

        public function BuilderSubscriptionCatalogWidget(_arg_1:IWindowContainer, _arg_2:HabboCatalog)
        {
            super(_arg_1);
            _catalog = _arg_2;
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            _SafeStr_1542 = _catalog.getProperty("builders_club.buy_membership_page");
            updateSubscriptionInfo();
            _window.procedure = windowProcedure;
            events.addEventListener("CWE_BUILDER_SUBSCRIPTION_UPDATED", onBuilderSubscriptionUpdated);
            return (true);
        }

        private function updateSubscriptionInfo():void
        {
            var _local_4:Number = _catalog.builderSecondsLeft;
            var _local_2:IWindow = _window.findChildByName("subscribe_button");
            var _local_3:IWindow = _window.findChildByName("subscribe_button_sms");
            var _local_1:IWindow = _window.findChildByName("subscribe_button_big");
            var _local_5:IWindow = _window.findChildByName("try_button");
            if ((((!(!(_local_5 == null))) || (!(!(_local_2 == null)))) || (!(!(_local_1 == null)))))
            {
                return;
            };
            if (((_local_4 > 0) || (_catalog.getCatalogNavigator("BUILDERS_CLUB").getOptionalNodeByName(_catalog.getProperty("builders_club.try_page")) == null)))
            {
                _local_1.visible = true;
                _local_2.visible = false;
                _local_5.visible = false;
                _local_3.visible = false;
            }
            else
            {
                _local_1.visible = false;
                _local_2.visible = false;
                _local_5.visible = true;
                _local_3.visible = false;
            };
            if (((!(_SafeStr_1542 == null)) && (!(_SafeStr_1542 == ""))))
            {
                _local_3.visible = true;
                if (!_local_5.visible)
                {
                    _local_3.x = _local_5.x;
                    _local_3.y = _local_5.y;
                };
                if (_local_1.visible)
                {
                    _local_1.visible = false;
                    _local_2.visible = false;
                };
            };
        }

        private function onBuilderSubscriptionUpdated(_arg_1:CatalogWidgetBuilderSubscriptionUpdatedEvent):void
        {
            updateSubscriptionInfo();
        }

        private function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "subscribe_button_big":
                case "subscribe_button":
                    HabboWebTools.openWebPageAndMinimizeClient(_catalog.getProperty("web.shop.subscription.relativeUrl"));
                    return;
                case "subscribe_button_sms":
                    HabboWebTools.openWebPageAndMinimizeClient(_SafeStr_1542);
                    return;
                case "try_button":
                    _catalog.openCatalogPage(_catalog.getProperty("builders_club.try_page"), "BUILDERS_CLUB");
                    return;
            };
        }


    }
}

