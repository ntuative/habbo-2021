package com.sulake.habbo.friendbar.landingview.widget
{
    import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
    import com.sulake.habbo.friendbar.landingview.interfaces.ISlotAwareWidget;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Dictionary;
    import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
    import com.sulake.habbo.friendbar.landingview.layout.WidgetContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.parser.competition.CurrentTimingCodeMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.competition.GetCurrentTimingCodeMessageComposer;
    import com.sulake.habbo.friendbar.landingview.layout.LandingViewWidgetType;
    import com.sulake.habbo.friendbar.landingview.interfaces.IConfigurationCodeAwareWidget;
    import com.sulake.habbo.friendbar.landingview.*;

    public class WidgetContainerWidget implements ILandingViewWidget, ISlotAwareWidget 
    {

        private var _landingView:HabboLandingView;
        private var _container:IWindowContainer;
        private var _SafeStr_1647:Dictionary = new Dictionary();
        private var _SafeStr_2309:CommonWidgetSettings;
        private var _SafeStr_2365:int;
        private var _SafeStr_2327:String;
        private var _SafeStr_2381:WidgetContainer;

        public function WidgetContainerWidget(_arg_1:HabboLandingView)
        {
            _landingView = _arg_1;
        }

        public static function hideChildren(_arg_1:IWindowContainer):void
        {
            var _local_2:int;
            _local_2 = 0;
            while (_local_2 < _arg_1.numChildren)
            {
                _arg_1.getChildAt(_local_2).visible = false;
                _local_2++;
            };
        }


        public function set slot(_arg_1:int):void
        {
            _SafeStr_2365 = _arg_1;
        }

        public function get container():IWindow
        {
            return (_container);
        }

        public function dispose():void
        {
            _landingView = null;
            _container = null;
        }

        public function initialize():void
        {
            _container = IWindowContainer(_landingView.getXmlWindow("widget_container_widget"));
            _SafeStr_2309 = new CommonWidgetSettings(_landingView);
            _landingView.communicationManager.addHabboConnectionMessageEvent(new CurrentTimingCodeMessageEvent(onTimingCode));
            _SafeStr_2327 = _landingView.getProperty((("landing.view.dynamic.slot." + _SafeStr_2365) + ".conf"));
        }

        public function refresh():void
        {
            _landingView.send(new GetCurrentTimingCodeMessageComposer(_SafeStr_2327));
        }

        public function get disposed():Boolean
        {
            return (_landingView == null);
        }

        private function refreshContent():void
        {
            hideChildren(_container);
            if (_SafeStr_2381 != null)
            {
                _SafeStr_2381.refresh(_container);
                _SafeStr_2381.container.visible = true;
                _container.height = _SafeStr_2381.container.height;
                _container.width = _SafeStr_2381.container.width;
            };
        }

        private function createWidgetContainer(_arg_1:String):WidgetContainer
        {
            var _local_3:String = _landingView.getProperty((("landing.view." + _arg_1) + ".widget"));
            var _local_2:ILandingViewWidget = LandingViewWidgetType.getWidgetForType(_local_3, _landingView);
            if (_local_2 == null)
            {
                return (null);
            };
            if ((_local_2 is ISlotAwareWidget))
            {
                ISlotAwareWidget(_local_2).slot = _SafeStr_2365;
            };
            if ((_local_2 is IConfigurationCodeAwareWidget))
            {
                IConfigurationCodeAwareWidget(_local_2).configurationCode = _arg_1;
            };
            var _local_4:WidgetContainer = new WidgetContainer(_local_2, null, _SafeStr_2309, _container);
            _SafeStr_1647[_arg_1] = _local_4;
            return (_local_4);
        }

        private function onTimingCode(_arg_1:CurrentTimingCodeMessageEvent):void
        {
            if (((_arg_1.getParser().schedulingStr == _SafeStr_2327) && (!(disposed))))
            {
                switchCurrentWidget(_arg_1.getParser().code);
                refreshContent();
            };
        }

        private function switchCurrentWidget(_arg_1:String):void
        {
            if (_arg_1 == "")
            {
                _SafeStr_2381 = null;
                return;
            };
            var _local_2:WidgetContainer = _SafeStr_1647[_arg_1];
            if (_local_2 == null)
            {
                _local_2 = createWidgetContainer(_arg_1);
            };
            _SafeStr_2381 = _local_2;
        }


    }
}

