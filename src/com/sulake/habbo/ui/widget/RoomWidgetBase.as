package com.sulake.habbo.ui.widget
{
    import com.sulake.core.runtime.events.EventDispatcherWrapper;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import flash.events.IEventDispatcher;
    import com.sulake.core.window.IWindow;

    public class RoomWidgetBase implements IRoomWidget 
    {

        private var _disposed:Boolean = false;
        private var _SafeStr_913:EventDispatcherWrapper;
        private var _messageListener:IRoomWidgetMessageListener;
        private var _windowManager:IHabboWindowManager;
        protected var _assets:IAssetLibrary;
        protected var _SafeStr_819:IHabboLocalizationManager;
        protected var _SafeStr_3915:IRoomWidgetHandler;

        public function RoomWidgetBase(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null, _arg_4:IHabboLocalizationManager=null)
        {
            _SafeStr_3915 = _arg_1;
            _windowManager = _arg_2;
            _assets = _arg_3;
            _SafeStr_819 = _arg_4;
        }

        public function get state():int
        {
            return (0);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function initialize(_arg_1:int=0):void
        {
        }

        public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            _messageListener = null;
            _windowManager = null;
            if (((!(_SafeStr_913 == null)) && (!(_SafeStr_913.disposed))))
            {
                unregisterUpdateEvents(_SafeStr_913);
            };
            if (_SafeStr_3915)
            {
                _SafeStr_3915.dispose();
                _SafeStr_3915 = null;
            };
            _SafeStr_913 = null;
            _assets = null;
            _SafeStr_819 = null;
            _disposed = true;
        }

        public function set messageListener(_arg_1:IRoomWidgetMessageListener):void
        {
            _messageListener = _arg_1;
        }

        public function get messageListener():IRoomWidgetMessageListener
        {
            return (_messageListener);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function get assets():IAssetLibrary
        {
            return (_assets);
        }

        public function get localizations():IHabboLocalizationManager
        {
            return (_SafeStr_819);
        }

        public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if ((_arg_1 is EventDispatcherWrapper))
            {
                _SafeStr_913 = (_arg_1 as EventDispatcherWrapper);
            };
        }

        public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
        }

        public function get mainWindow():IWindow
        {
            return (null);
        }


    }
}

