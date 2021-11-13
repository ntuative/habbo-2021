package com.sulake.habbo.catalog.targetedoffers
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.catalog.targetedoffers.data.TargetedOffer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class TargetedOfferMinimizedView extends OfferView 
    {

        private static const IMAGE_DEFAULT_URL:String = "targetedoffers/offer_default_icon.png";

        public function TargetedOfferMinimizedView(_arg_1:OfferController, _arg_2:TargetedOffer)
        {
            super(_arg_1, _arg_2);
            var _local_6:IItemListWindow = null;
            _window = IWindowContainer(_SafeStr_1284.catalog.windowManager.buildFromXML(XML(_SafeStr_1284.catalog.assets.getAssetByName("targeted_offer_minimized_xml").content)));
            var _local_5:ITextWindow = ITextWindow(_window.findChildByName("txt_title"));
            if (_local_5)
            {
                _local_5.text = getLocalization(_arg_2.title);
            };
            var _local_3:String = (_SafeStr_1284.catalog as ICoreConfiguration).getProperty("image.library.url");
            var _local_4:String = (((_arg_2.iconImageUrl) && (_arg_2.iconImageUrl.length > 0)) ? _arg_2.iconImageUrl : "targetedoffers/offer_default_icon.png");
            IStaticBitmapWrapperWindow(_window.findChildByName("bmp_icon")).assetUri = (_local_3 + _local_4);
            _SafeStr_1508 = getLocalization("targeted.offer.minimized.timeleft", "");
            if (_offer.expirationTime == 0)
            {
                _local_6 = (_window.findChildByName("itemlist") as IItemListWindow);
                if (_local_6)
                {
                    _local_6.removeListItem(_window.findChildByName("cnt_time_left"));
                };
            }
            else
            {
                startUpdateTimer();
            };
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
                _SafeStr_1284.maximizeOffer(_offer);
                _arg_2.name;
            };
        }

        public function get window():IWindow
        {
            return (_window);
        }


    }
}

