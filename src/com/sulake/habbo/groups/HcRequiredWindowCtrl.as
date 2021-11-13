package com.sulake.habbo.groups
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class HcRequiredWindowCtrl implements IDisposable 
    {

        private var _SafeStr_825:HabboGroupsManager;
        private var _window:IFrameWindow;

        public function HcRequiredWindowCtrl(_arg_1:HabboGroupsManager)
        {
            _SafeStr_825 = _arg_1;
        }

        public function dispose():void
        {
            _SafeStr_825 = null;
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_825 == null);
        }

        public function show(_arg_1:Boolean):void
        {
            prepareWindow();
            _window.findChildByName("info_txt").caption = ((_arg_1) ? "${group.hcrequired.info.manage}" : "${group.hcrequired.info.join}");
            _window.visible = true;
            _window.activate();
        }

        private function prepareWindow():void
        {
            if (_window != null)
            {
                return;
            };
            _window = IFrameWindow(_SafeStr_825.getXmlWindow("club_required"));
            _window.findChildByTag("close").procedure = onClose;
            _window.findChildByName("cancel_link_region").procedure = onClose;
            _window.findChildByName("join_button").procedure = onOpenCatalog;
            _window.findChildByName("more_info_link_region").procedure = onOpenCatalog;
            _window.center();
        }

        private function onClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                close();
            };
        }

        private function onOpenCatalog(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _SafeStr_825.openVipPurchase("HcRequiredWindowCtrl");
                close();
            };
        }

        public function close():void
        {
            if (_window != null)
            {
                _window.visible = false;
            };
        }


    }
}

