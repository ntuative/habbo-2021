package com.sulake.habbo.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import flash.utils.Dictionary;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindow;
    import flash.geom.Rectangle;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class AlertView implements IDisposable 
    {

        private static var _SafeStr_2465:Dictionary = new Dictionary();

        private var _navigator:IHabboTransitionalNavigator;
        protected var _SafeStr_2993:IFrameWindow;
        protected var _xmlFileName:String;
        protected var _SafeStr_906:String;
        protected var _disposed:Boolean;

        public function AlertView(_arg_1:IHabboTransitionalNavigator, _arg_2:String, _arg_3:String=null)
        {
            _navigator = _arg_1;
            _xmlFileName = _arg_2;
            _SafeStr_906 = _arg_3;
        }

        public static function findAlertView(_arg_1:IWindow):AlertView
        {
            if (_SafeStr_2465 != null)
            {
                for each (var _local_2:AlertView in _SafeStr_2465)
                {
                    if (_local_2._SafeStr_2993 == _arg_1)
                    {
                        return (_local_2);
                    };
                };
            };
            return (null);
        }


        public function show():void
        {
            var _local_2:AlertView = (_SafeStr_2465[_xmlFileName] as AlertView);
            if (_local_2 != null)
            {
                _local_2.dispose();
            };
            _SafeStr_2993 = getAlertWindow();
            if (_SafeStr_906 != null)
            {
                _SafeStr_2993.caption = _SafeStr_906;
            };
            setupAlertWindow(_SafeStr_2993);
            var _local_1:Rectangle = Util.getLocationRelativeTo(_SafeStr_2993.desktop, _SafeStr_2993.width, _SafeStr_2993.height);
            _SafeStr_2993.x = _local_1.x;
            _SafeStr_2993.y = _local_1.y;
            _SafeStr_2465[_xmlFileName] = this;
            _SafeStr_2993.activate();
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            if (_SafeStr_2465[_xmlFileName] == this)
            {
                _SafeStr_2465[_xmlFileName] = null;
            };
            _disposed = true;
            if (_SafeStr_2993 != null)
            {
                _SafeStr_2993.destroy();
                _SafeStr_2993 = null;
            };
            _navigator = null;
        }

        internal function setupAlertWindow(_arg_1:IFrameWindow):void
        {
        }

        internal function onClose(_arg_1:WindowMouseEvent):void
        {
            dispose();
        }

        private function getAlertWindow():IFrameWindow
        {
            var _local_2:IFrameWindow = (_navigator.getXmlWindow(this._xmlFileName, 2) as IFrameWindow);
            var _local_1:IWindow = _local_2.findChildByTag("close");
            if (_local_1 != null)
            {
                _local_1.addEventListener("WME_CLICK", onClose);
            };
            return (_local_2);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get navigator():IHabboTransitionalNavigator
        {
            return (_navigator);
        }


    }
}

