package com.sulake.habbo.navigator
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class SimpleAlertView extends AlertView 
    {

        private var _text:String;

        public function SimpleAlertView(_arg_1:IHabboTransitionalNavigator, _arg_2:String, _arg_3:String)
        {
            super(_arg_1, "nav_simple_alert", _arg_2);
            _text = _arg_3;
        }

        override internal function setupAlertWindow(_arg_1:IFrameWindow):void
        {
            var _local_3:IWindowContainer = _arg_1.content;
            ITextWindow(_local_3.findChildByName("body_text")).text = _text;
            var _local_2:IWindow = _local_3.findChildByName("ok");
            if (_local_2 != null)
            {
                _local_2.addEventListener("WME_CLICK", onOk);
            };
            _arg_1.tags.push("SimpleAlertView");
        }

        private function onOk(_arg_1:WindowMouseEvent):void
        {
            dispose();
        }


    }
}