package com.sulake.habbo.navigator
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class ClubPromoAlertView extends AlertView 
    {

        private var _text:String;
        private var _SafeStr_2994:String;

        public function ClubPromoAlertView(_arg_1:IHabboTransitionalNavigator, _arg_2:String, _arg_3:String, _arg_4:String)
        {
            super(_arg_1, "nav_promo_alert", _arg_2);
            _text = _arg_3;
            _SafeStr_2994 = _arg_4;
        }

        override internal function setupAlertWindow(_arg_1:IFrameWindow):void
        {
            var _local_4:IWindowContainer = _arg_1.content;
            _local_4.findChildByName("body_text").caption = _text;
            _local_4.findChildByName("promo_text").caption = _SafeStr_2994;
            var _local_3:IWindow = _local_4.findChildByName("ok");
            if (_local_3 != null)
            {
                _local_3.addEventListener("WME_CLICK", onOk);
            };
            var _local_2:IWindow = _local_4.findChildByName("promo_container");
            if (_local_2 != null)
            {
                _local_2.addEventListener("WME_CLICK", onPromo);
            };
        }

        private function onOk(_arg_1:WindowMouseEvent):void
        {
            dispose();
        }

        private function onPromo(_arg_1:WindowMouseEvent):void
        {
            navigator.openCatalogClubPage("ClubPromoAlertView");
            dispose();
        }


    }
}

