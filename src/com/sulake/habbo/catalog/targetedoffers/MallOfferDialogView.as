package com.sulake.habbo.catalog.targetedoffers
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.targetedoffers.data.HabboMallOffer;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class MallOfferDialogView 
    {

        private var _SafeStr_1284:OfferController;
        private var _window:IWindowContainer;
        private var _offer:HabboMallOffer;

        public function MallOfferDialogView(_arg_1:OfferController, _arg_2:HabboMallOffer)
        {
            super();
            var _local_3:String = null;
            _SafeStr_1284 = _arg_1;
            _offer = _arg_2;
            _window = IWindowContainer(_SafeStr_1284.catalog.windowManager.buildFromXML(XML(_SafeStr_1284.catalog.assets.getAssetByName("targeted_offer_habbomall_xml").content)));
            IFrameWindow(_window).title.text = getLocalization(_offer.title);
            ITextWindow(_window.findChildByName("txt_title")).text = getLocalization(_offer.title);
            if (((_arg_2.imageUrl) && (_arg_2.imageUrl.length > 0)))
            {
                _local_3 = (_SafeStr_1284.catalog as ICoreConfiguration).getProperty("image.library.url");
                IStaticBitmapWrapperWindow(_window.findChildByName("bmp_illustration")).assetUri = (_local_3 + _arg_2.imageUrl);
            };
            _window.procedure = onInput;
            _window.center();
        }

        public function dispose():void
        {
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
        }

        private function onInput(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((!(_SafeStr_1284)) || (!(_offer))))
            {
                return;
            };
            if (_arg_1.type == "WME_DOWN")
            {
                switch (_arg_2.name)
                {
                    case "header_button_close":
                        _SafeStr_1284.onHabboMallOfferClosed(_offer);
                        return;
                    case "btn_buy":
                        _SafeStr_1284.onHabboMallOfferOpened(_offer);
                        return;
                };
            };
        }

        private function getLocalization(_arg_1:String, _arg_2:String=null):String
        {
            return (_SafeStr_1284.catalog.localization.getLocalization(_arg_1, ((_arg_2) || (_arg_1))));
        }


    }
}

