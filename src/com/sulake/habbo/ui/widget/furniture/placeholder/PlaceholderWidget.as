package com.sulake.habbo.ui.widget.furniture.placeholder
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.events.RoomWidgetShowPlaceholderEvent;

    public class PlaceholderWidget extends RoomWidgetBase 
    {

        private var _SafeStr_570:PlaceholderView;

        public function PlaceholderWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null, _arg_4:IHabboLocalizationManager=null)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        override public function dispose():void
        {
            if (_SafeStr_570 != null)
            {
                _SafeStr_570.dispose();
                _SafeStr_570 = null;
            };
            super.dispose();
        }

        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addEventListener("RWSPE_SHOW_PLACEHOLDER", onShowEvent);
            super.registerUpdateEvents(_arg_1);
        }

        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.removeEventListener("RWSPE_SHOW_PLACEHOLDER", onShowEvent);
        }

        private function onShowEvent(_arg_1:RoomWidgetShowPlaceholderEvent):void
        {
            showInterface();
        }

        private function showInterface():void
        {
            if (_SafeStr_570 == null)
            {
                _SafeStr_570 = new PlaceholderView(assets, windowManager);
            };
            _SafeStr_570.showWindow();
        }

        private function hideInterface():void
        {
            if (_SafeStr_570 != null)
            {
                _SafeStr_570.dispose();
                _SafeStr_570 = null;
            };
        }


    }
}

