package com.sulake.habbo.groups
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class GroupCreatedWindowCtrl implements IDisposable 
    {

        private var _SafeStr_825:HabboGroupsManager;
        private var _window:IFrameWindow;
        private var _groupId:int;

        public function GroupCreatedWindowCtrl(_arg_1:HabboGroupsManager)
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

        public function show(_arg_1:int):void
        {
            _groupId = _arg_1;
            prepareWindow();
            _window.visible = true;
            _window.activate();
        }

        private function prepareWindow():void
        {
            if (_window != null)
            {
                return;
            };
            _window = IFrameWindow(_SafeStr_825.getXmlWindow("group_created_window"));
            _window.findChildByTag("close").procedure = onClose;
            _window.findChildByName("ok_button").procedure = onClose;
            _window.center();
        }

        private function onClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                close();
                _SafeStr_825.send(new GetHabboGroupDetailsMessageComposer(_groupId, false));
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

