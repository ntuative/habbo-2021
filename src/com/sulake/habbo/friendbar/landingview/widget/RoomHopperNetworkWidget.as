package com.sulake.habbo.friendbar.landingview.widget
{
    import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
    import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
    import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
    import com.sulake.core.window.events.WindowEvent;

    public class RoomHopperNetworkWidget implements ILandingViewWidget, ISettingsAwareWidget 
    {

        private var _landingView:HabboLandingView;
        private var _container:IWindowContainer;
        private var _disposed:Boolean = false;
        private var _SafeStr_2377:int;
        private var _SafeStr_2376:Array = [];

        public function RoomHopperNetworkWidget(_arg_1:HabboLandingView)
        {
            _landingView = _arg_1;
            _SafeStr_2376.push("title");
            _SafeStr_2376.push("header");
            _SafeStr_2376.push("info");
        }

        protected static function get xmlAssetName():String
        {
            return ("room_hopper_network");
        }


        public function initialize():void
        {
            _container = IWindowContainer(_landingView.getXmlWindow(xmlAssetName));
            _SafeStr_2377 = _landingView.getInteger("landing.view.roomhopper.network.id", 0);
            var _local_1:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_container.findChildByName("bitmap"));
            _local_1.assetUri = _landingView.getProperty("landing.view.roomhopper.image.uri");
            _container.findChildByName("button").procedure = onRoomForwardButton;
        }

        public function refresh():void
        {
        }

        public function get container():IWindow
        {
            return (_container);
        }

        public function dispose():void
        {
            if (!disposed)
            {
                if (_container)
                {
                    _container.dispose();
                    _container = null;
                };
                _disposed = true;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function set settings(_arg_1:CommonWidgetSettings):void
        {
            WidgetContainerLayout.applyCommonWidgetSettings(_container, _arg_1);
        }

        private function onRoomForwardButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _landingView.navigator.goToRoomNetwork(_SafeStr_2377, false);
            };
        }


    }
}

