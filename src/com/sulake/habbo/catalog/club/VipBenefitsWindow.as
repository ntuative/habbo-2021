package com.sulake.habbo.catalog.club
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class VipBenefitsWindow implements IDisposable 
    {

        private var _disposed:Boolean = false;
        private var _window:IWindowContainer;

        public function VipBenefitsWindow(_arg_1:HabboCatalog)
        {
            _window = (_arg_1.utils.createWindow("vip_benefits") as IWindowContainer);
            _window.findChildByName("header_button_close").addEventListener("WME_CLICK", onClose);
            _window.center();
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_window != null)
                {
                    _window.dispose();
                    _window = null;
                };
            };
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        private function onClose(_arg_1:WindowMouseEvent):void
        {
            dispose();
        }


    }
}