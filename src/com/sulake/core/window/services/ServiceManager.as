package com.sulake.core.window.services
{
    import com.sulake.core.runtime.IDisposable;
    import flash.display.DisplayObject;
    import com.sulake.core.window.IWindowContext;

    public class ServiceManager implements IInternalWindowServices, IDisposable 
    {

        private var _SafeStr_1164:uint;
        private var _SafeStr_1165:DisplayObject;
        private var _disposed:Boolean = false;
        private var _SafeStr_442:IWindowContext;
        private var _SafeStr_1166:IMouseDraggingService;
        private var _SafeStr_1167:IMouseScalingService;
        private var _SafeStr_1168:IMouseListenerService;
        private var _SafeStr_1169:IFocusManagerService;
        private var _SafeStr_1170:IToolTipAgentService;
        private var _SafeStr_1171:IGestureAgentService;

        public function ServiceManager(_arg_1:IWindowContext, _arg_2:DisplayObject)
        {
            _SafeStr_1164 = 0;
            _SafeStr_1165 = _arg_2;
            _SafeStr_442 = _arg_1;
            _SafeStr_1166 = new WindowMouseDragger(_arg_2);
            _SafeStr_1167 = new WindowMouseScaler(_arg_2);
            _SafeStr_1168 = new WindowMouseListener(_arg_2);
            _SafeStr_1169 = new FocusManager(_arg_2);
            _SafeStr_1170 = new WindowToolTipAgent(_arg_2);
            _SafeStr_1171 = new GestureAgentService();
        }

        public function dispose():void
        {
            if (_SafeStr_1166 != null)
            {
                _SafeStr_1166.dispose();
                _SafeStr_1166 = null;
            };
            if (_SafeStr_1167 != null)
            {
                _SafeStr_1167.dispose();
                _SafeStr_1167 = null;
            };
            if (_SafeStr_1168 != null)
            {
                _SafeStr_1168.dispose();
                _SafeStr_1168 = null;
            };
            if (_SafeStr_1169 != null)
            {
                _SafeStr_1169.dispose();
                _SafeStr_1169 = null;
            };
            if (_SafeStr_1170 != null)
            {
                _SafeStr_1170.dispose();
                _SafeStr_1170 = null;
            };
            if (_SafeStr_1171 != null)
            {
                _SafeStr_1171.dispose();
                _SafeStr_1171 = null;
            };
            _SafeStr_1165 = null;
            _SafeStr_442 = null;
            _disposed = true;
        }

        public function getMouseDraggingService():IMouseDraggingService
        {
            return (_SafeStr_1166);
        }

        public function getMouseScalingService():IMouseScalingService
        {
            return (_SafeStr_1167);
        }

        public function getMouseListenerService():IMouseListenerService
        {
            return (_SafeStr_1168);
        }

        public function getFocusManagerService():IFocusManagerService
        {
            return (_SafeStr_1169);
        }

        public function getToolTipAgentService():IToolTipAgentService
        {
            return (_SafeStr_1170);
        }

        public function getGestureAgentService():IGestureAgentService
        {
            return (_SafeStr_1171);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }


    }
}

