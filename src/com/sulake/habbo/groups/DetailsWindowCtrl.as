package com.sulake.habbo.groups
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsData;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class DetailsWindowCtrl implements IDisposable 
    {

        private var _SafeStr_825:HabboGroupsManager;
        private var _window:IFrameWindow;
        private var _SafeStr_2630:GroupDetailsCtrl;
        private var _groupId:int;

        public function DetailsWindowCtrl(_arg_1:HabboGroupsManager)
        {
            _SafeStr_825 = _arg_1;
            _SafeStr_2630 = new GroupDetailsCtrl(_arg_1, true);
        }

        public function dispose():void
        {
            _SafeStr_825 = null;
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            if (_SafeStr_2630)
            {
                _SafeStr_2630.dispose();
                _SafeStr_2630 = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_825 == null);
        }

        public function isDisplayingGroup(_arg_1:int):Boolean
        {
            return (((!(_window == null)) && (_window.visible)) && (_arg_1 == _groupId));
        }

        public function onGroupDetails(_arg_1:HabboGroupDetailsData):void
        {
            if (((((!(_window == null)) && (_window.visible)) && (_arg_1.groupId == _groupId)) || (_arg_1.openDetails)))
            {
                _groupId = _arg_1.groupId;
                prepareWindow();
                _SafeStr_2630.onGroupDetails(IWindowContainer(_window.findChildByName("group_cont")), _arg_1);
                if (_arg_1.openDetails)
                {
                    _window.visible = true;
                    _window.activate();
                };
            };
        }

        private function prepareWindow():void
        {
            if (_window != null)
            {
                return;
            };
            _window = IFrameWindow(_SafeStr_825.getXmlWindow("group_info_window"));
            _window.findChildByTag("close").procedure = onClose;
            _window.center();
        }

        private function onClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            close();
        }

        public function close():void
        {
            if (_window != null)
            {
                _groupId = 0;
                _window.visible = false;
            };
        }

        public function onGroupDeactivated(_arg_1:int):void
        {
            if (_groupId == _arg_1)
            {
                close();
            };
        }


    }
}

