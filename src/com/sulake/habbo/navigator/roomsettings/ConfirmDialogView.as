package com.sulake.habbo.navigator.roomsettings
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.navigator.Util;
    import flash.geom.Rectangle;
    import com.sulake.habbo.navigator.IHabboTransitionalNavigator;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class ConfirmDialogView implements IDisposable 
    {

        private var _window:IFrameWindow;
        private var _SafeStr_2935:Function;

        public function ConfirmDialogView(_arg_1:IHabboTransitionalNavigator, _arg_2:Function, _arg_3:String, _arg_4:String)
        {
            this._window = IFrameWindow(_arg_1.getXmlWindow("ros_confirm"));
            this._SafeStr_2935 = _arg_2;
            _window.findChildByTag("close").addEventListener("WME_CLICK", onCancel);
            _window.findChildByName("ok").addEventListener("WME_CLICK", onOk);
            _window.caption = _arg_3;
            _window.findChildByName("message").caption = _arg_4;
            var _local_5:Rectangle = Util.getLocationRelativeTo(_window.desktop, _window.width, _window.height);
            _window.x = _local_5.x;
            _window.y = _local_5.y;
            _window.visible = true;
            _window.activate();
        }

        private function onCancel(_arg_1:WindowMouseEvent):void
        {
            dispose();
        }

        private function onOk(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_2935.apply();
            dispose();
        }

        public function dispose():void
        {
            if (_window != null)
            {
                _window.destroy();
                _window = null;
            };
            _SafeStr_2935 = null;
        }

        public function get disposed():Boolean
        {
            return (_window == null);
        }


    }
}

