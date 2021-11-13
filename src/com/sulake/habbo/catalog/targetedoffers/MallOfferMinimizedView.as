package com.sulake.habbo.catalog.targetedoffers
{
    import com.sulake.habbo.catalog.targetedoffers.data.HabboMallOffer;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class MallOfferMinimizedView extends OfferView 
    {

        private static const IMAGE_DEFAULT_URL:String = "targetedoffers/offer_default_icon.png";

        private var _SafeStr_1504:HabboMallOffer;

        public function MallOfferMinimizedView(_arg_1:OfferController, _arg_2:HabboMallOffer)
        {
            super(_arg_1, null);
            _SafeStr_1504 = _arg_2;
            _window = IWindowContainer(_SafeStr_1284.catalog.windowManager.buildFromXML(XML(_SafeStr_1284.catalog.assets.getAssetByName("targeted_offer_minimized_xml").content)));
            var _local_4:ITextWindow = ITextWindow(_window.findChildByName("txt_title"));
            if (_local_4)
            {
                _local_4.text = getLocalization(_arg_2.title);
            };
            var _local_3:String = (_SafeStr_1284.catalog as ICoreConfiguration).getProperty("image.library.url");
            IStaticBitmapWrapperWindow(_window.findChildByName("bmp_icon")).assetUri = (_local_3 + "targetedoffers/offer_default_icon.png");
            _window.procedure = onInput;
            _SafeStr_1284.attachExtension(_window);
        }

        private function onInput(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (!_SafeStr_1284)
            {
                return;
            };
            if (_arg_1.type == "WME_DOWN")
            {
                _SafeStr_1284.maximizeMallOffer(_SafeStr_1504);
                _arg_2.name;
            };
        }

        public function get window():IWindow
        {
            return (_window);
        }


    }
}

