package com.sulake.habbo.toolbar.offers
{
    import com.sulake.habbo.catalog.offers.IOfferExtension;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.toolbar.HabboToolbar;
    import com.sulake.habbo.catalog.offers.IOfferCenter;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class OfferExtension implements IOfferExtension, IDisposable 
    {

        private var _disposed:Boolean;
        private var _window:IWindowContainer;
        private var _toolbar:HabboToolbar;
        private var _offerCenter:IOfferCenter;
        private var _SafeStr_853:IItemListWindow;

        public function OfferExtension(_arg_1:HabboToolbar, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboCatalog)
        {
            _toolbar = _arg_1;
            _window = (_arg_2.buildFromXML((_arg_3.getAssetByName("offer_extension_xml").content as XML)) as IWindowContainer);
            _window.procedure = windowProcedure;
            _window.visible = false;
            _SafeStr_853 = (_window.findChildByName("list") as IItemListWindow);
            _offerCenter = _arg_4.getOfferCenter(this);
            _arg_1.extensionView.attachExtension("video_offers", window, 8);
            refresh();
        }

        private function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "start_video":
                    _offerCenter.showVideo();
                    return;
                case "check_rewards":
                    _offerCenter.showRewards();
                    return;
            };
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _SafeStr_853 = null;
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
            _toolbar = null;
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get window():IWindowContainer
        {
            return (_window);
        }

        public function indicateRewards():void
        {
            if (_window != null)
            {
                _window.visible = true;
                _window.findChildByName("check_rewards").visible = true;
                refresh();
            };
        }

        public function indicateVideoAvailable(_arg_1:Boolean):void
        {
            var _local_2:IWindow;
            if (_window != null)
            {
                _window.visible = ((_window.visible) || (_arg_1));
                _local_2 = _window.findChildByName("start_video");
                _local_2.visible = _arg_1;
                if (_offerCenter.showingVideo)
                {
                    _local_2.disable();
                    _local_2.color = 0x999999;
                }
                else
                {
                    _local_2.enable();
                    _local_2.color = 12932417;
                };
                refresh();
            };
        }

        private function refresh():void
        {
            _SafeStr_853.arrangeListItems();
            _window.visible = ((_SafeStr_853.getListItemAt(0).visible) || (_SafeStr_853.getListItemAt(1).visible));
            _toolbar.extensionView.refreshItemWindow();
        }


    }
}

