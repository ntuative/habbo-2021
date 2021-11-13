package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.tracking.HabboTracking;
    import com.sulake.habbo.communication.messages.outgoing.users.GetGuildCreationInfoMessageComposer;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class BuyGuildWidget extends CatalogWidget implements ICatalogWidget 
    {

        private var _button:_SafeStr_101;

        public function BuyGuildWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
            if (_button)
            {
                _button.removeEventListener("WME_CLICK", onButtonClicked);
            };
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            _button = (window.findChildByName("start_guild_purchase") as _SafeStr_101);
            _button.addEventListener("WME_CLICK", onButtonClicked);
            return (true);
        }

        private function onButtonClicked(_arg_1:WindowMouseEvent):void
        {
            if (HabboTracking.getInstance() != null)
            {
                HabboTracking.getInstance().trackGoogle("groupPurchase", "catalogBuyClicked");
            };
            page.viewer.catalog.connection.send(new GetGuildCreationInfoMessageComposer());
            page.viewer.catalog.toggleCatalog("NORMAL");
        }


    }
}

