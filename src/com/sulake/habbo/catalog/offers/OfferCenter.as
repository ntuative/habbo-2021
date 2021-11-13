package com.sulake.habbo.catalog.offers
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.core.window.IWindowContainer;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.IWindow;
    import flash.utils.Timer;
    import com.sulake.habbo.communication.messages.incoming.notifications.OfferRewardDeliveredMessageEvent;
    import flash.events.TimerEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.OfferRewardDeliveredMessageParser;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.core.window.components.IBitmapWrapperWindow;

    public class OfferCenter implements IOfferCenter, IDisposable 
    {

        private static const PROVIDER_POLLING_FREQUENCY:int = 1800000;

        private var _disposed:Boolean;
        private var _windowManager:IHabboWindowManager;
        private var _assets:IAssetLibrary;
        private var _catalog:IHabboCatalog;
        private var _offerExtension:IOfferExtension;
        private var _window:IWindowContainer;
        private var _SafeStr_1468:IOfferProvider;
        private var _providers:Vector.<IOfferProvider>;
        private var _SafeStr_1469:Vector.<OfferReward>;
        private var _SafeStr_1470:IWindow;
        private var _SafeStr_1467:Timer;
        private var _offerRewardDeliveredMessageEvent:OfferRewardDeliveredMessageEvent;

        public function OfferCenter(_arg_1:IHabboWindowManager, _arg_2:IAssetLibrary, _arg_3:IHabboCatalog)
        {
            _windowManager = _arg_1;
            _assets = _arg_2;
            _catalog = _arg_3;
            _offerRewardDeliveredMessageEvent = new OfferRewardDeliveredMessageEvent(onOfferRewardDelivered);
            _catalog.connection.addMessageEvent(_offerRewardDeliveredMessageEvent);
            _providers = new Vector.<IOfferProvider>(0);
            _providers.push(new SupersonicProvider(this));
            _providers.push(new SponsorPayProvider(this));
            _SafeStr_1469 = new Vector.<OfferReward>(0);
            _SafeStr_1467 = new Timer(1800000);
            _SafeStr_1467.addEventListener("timer", onPollTimer);
            _SafeStr_1467.start();
            onPollTimer(null);
        }

        private function onPollTimer(_arg_1:TimerEvent):void
        {
            if (_providers == null)
            {
                return;
            };
            for each (var _local_2:IOfferProvider in _providers)
            {
                if (_local_2.enabled)
                {
                    _local_2.load();
                };
            };
        }

        private function getNextProvider():IOfferProvider
        {
            if (_providers == null)
            {
                return (null);
            };
            for each (var _local_1:IOfferProvider in _providers)
            {
                if (((_local_1.enabled) && (_local_1.videoAvailable)))
                {
                    return (_local_1);
                };
            };
            return (null);
        }

        private function onOfferRewardDelivered(_arg_1:OfferRewardDeliveredMessageEvent):void
        {
            var _local_2:OfferRewardDeliveredMessageParser = _arg_1.getParser();
            addReward(_local_2.name, _local_2.contentType, _local_2.classId);
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
            if (_providers != null)
            {
                for each (var _local_1:IOfferProvider in _providers)
                {
                    _local_1.dispose();
                };
                _providers = null;
            };
            if (_SafeStr_1467 != null)
            {
                _SafeStr_1467.stop();
                _SafeStr_1467 = null;
            };
            _catalog.connection.removeMessageEvent(_offerRewardDeliveredMessageEvent);
            _offerRewardDeliveredMessageEvent = null;
            _SafeStr_1469 = null;
            _offerExtension = null;
            _windowManager = null;
            _catalog = null;
            _assets = null;
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function set offerExtension(_arg_1:IOfferExtension):void
        {
            _offerExtension = _arg_1;
        }

        public function showRewards():void
        {
            hide();
            _window = (_windowManager.buildFromXML((_assets.getAssetByName("offer_center_xml").content as XML)) as IWindowContainer);
            _window.procedure = windowProcedure;
            _window.center();
            _SafeStr_1470 = IItemListWindow(_window.findChildByName("reward_list")).removeListItemAt(0);
            populateRewardList();
        }

        public function showVideo():void
        {
            if (_SafeStr_1468 != null)
            {
                _SafeStr_1468.showVideo();
            };
        }

        public function get showingVideo():Boolean
        {
            return ((!(_SafeStr_1468 == null)) && (_SafeStr_1468.showingPopup));
        }

        private function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((!(_arg_1.type == "WME_CLICK")) || (!(visible))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "header_button_close":
                    hide();
                    return;
            };
        }

        private function hide():void
        {
            if (_window != null)
            {
                _SafeStr_1470.dispose();
                _SafeStr_1470 = null;
                _window.dispose();
                _window = null;
            };
        }

        private function addReward(_arg_1:String, _arg_2:String, _arg_3:int):void
        {
            var _local_4:OfferReward = new OfferReward(_arg_1, _arg_2, _arg_3);
            _SafeStr_1469.unshift(_local_4);
            if (visible)
            {
                IItemListWindow(_window.findChildByName("reward_list")).addListItemAt(createRewardItem(_local_4), 0);
            }
            else
            {
                if (_offerExtension != null)
                {
                    _offerExtension.indicateRewards();
                };
            };
        }

        public function get configuration():ICoreConfiguration
        {
            return (_catalog as ICoreConfiguration);
        }

        public function updateVideoStatus():void
        {
            if (_offerExtension != null)
            {
                _SafeStr_1468 = getNextProvider();
                _offerExtension.indicateVideoAvailable(((!(_SafeStr_1468 == null)) && (_SafeStr_1468.videoAvailable)));
            };
        }

        private function populateRewardList():void
        {
            if (!visible)
            {
                return;
            };
            var _local_2:IItemListWindow = (_window.findChildByName("reward_list") as IItemListWindow);
            _local_2.destroyListItems();
            for each (var _local_1:OfferReward in _SafeStr_1469)
            {
                _local_2.addListItem(createRewardItem(_local_1));
            };
        }

        private function createRewardItem(_arg_1:OfferReward):IWindow
        {
            var _local_2:IWindowContainer = (_SafeStr_1470.clone() as IWindowContainer);
            _local_2.findChildByName("reward_date").caption = new Date().toLocaleString();
            _local_2.findChildByName("reward_name").caption = _arg_1.name;
            _catalog.displayProductIcon(_arg_1.contentType, _arg_1.classId, IBitmapWrapperWindow(_local_2.findChildByName("reward_icon")));
            return (_local_2);
        }

        private function get visible():Boolean
        {
            return (((!(_window == null)) && (!(_window.disposed))) && (_window.visible));
        }

        public function showSuccess():void
        {
        }


    }
}

