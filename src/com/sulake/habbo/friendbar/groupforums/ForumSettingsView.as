package com.sulake.habbo.friendbar.groupforums
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.habbo.communication.messages.parser.groupforums.ExtendedForumData;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class ForumSettingsView
    {

        private static const _SafeStr_2238:Number = 0.5;

        private var _SafeStr_1284:GroupForumController;
        private var _SafeStr_461:GroupForumView;
        private var _window:IFrameWindow;
        private var _SafeStr_2239:ISelectorWindow;
        private var _SafeStr_2240:ISelectorWindow;
        private var _SafeStr_2241:ISelectorWindow;
        private var _SafeStr_2242:ISelectorWindow;
        private var _SafeStr_2235:ExtendedForumData;
        private var _SafeStr_2243:int;
        private var _SafeStr_2244:int;
        private var _SafeStr_2245:int;
        private var _SafeStr_2246:int;

        public function ForumSettingsView(_arg_1:GroupForumView, _arg_2:int, _arg_3:int, _arg_4:ExtendedForumData)
        {
            _SafeStr_461 = _arg_1;
            _SafeStr_1284 = _SafeStr_461.controller;
            _SafeStr_2235 = _arg_4;
            _window = IFrameWindow(_SafeStr_1284.windowManager.buildFromXML(XML(new HabboFriendBarCom.groupforum_forum_settings_xml())));
            _window.x = _arg_2;
            var _local_5:int = _SafeStr_1284.windowManager.getDesktop(1).width;
            if ((_window.x + _window.width) > _local_5)
            {
                _window.x = (_local_5 - _window.width);
            };
            _window.y = _arg_3;
            initControls();
        }

        private static function setSelectorState(_arg_1:ISelectorWindow, _arg_2:int, _arg_3:int):int
        {
            var _local_5:int;
            var _local_6:ISelectableWindow;
            var _local_4:IWindow;
            if (_arg_3 < _arg_2)
            {
                _arg_3 = _arg_2;
            };
            _local_5 = 0;
            while (_local_5 < _arg_2)
            {
                _local_6 = _arg_1.getSelectableByName(String(_local_5));
                if (_local_6 != null)
                {
                    _local_6.disable();
                    _local_6.blend = 0.5;
                    _local_4 = IWindowContainer(_arg_1.parent).findChildByName(("label" + _local_5));
                    if (_local_4 != null)
                    {
                        _local_4.blend = 0.5;
                    };
                };
                _local_5++;
            };
            _local_5 = _arg_2;
            while (_local_5 < 4)
            {
                _local_6 = _arg_1.getSelectableByName(String(_local_5));
                if (_local_6 != null)
                {
                    _local_6.enable();
                    _local_6.blend = 1;
                    _local_4 = IWindowContainer(_arg_1.parent).findChildByName(("label" + _local_5));
                    if (_local_4 != null)
                    {
                        _local_4.blend = 1;
                    };
                    if (_local_5 == _arg_3)
                    {
                        _arg_1.setSelected(_local_6);
                    };
                };
                _local_5++;
            };
            return (_arg_3);
        }

        private static function getSelectorState(_arg_1:ISelectorWindow):int
        {
            var _local_2:ISelectableWindow = _arg_1.getSelected();
            if (_local_2 == null)
            {
                return (0);
            };
            return int((_local_2.name));
        }


        public function focus(_arg_1:ExtendedForumData):void
        {
            if (_SafeStr_2235 != _arg_1)
            {
                _SafeStr_2235 = _arg_1;
                initControls();
            };
            _window.activate();
        }

        private function initControls():void
        {
            var _local_2:IRegionWindow = GroupForumView.initTopAreaForForum(_window, _SafeStr_2235);
            _local_2.removeEventListener("WME_CLICK", onTopAreaClick);
            _local_2.addEventListener("WME_CLICK", onTopAreaClick);
            var _local_1:IWindow = _window.findChildByName("cancel_btn");
            _local_1.removeEventListener("WME_CLICK", onCancelButtonClick);
            _local_1.addEventListener("WME_CLICK", onCancelButtonClick);
            var _local_3:IWindow = _window.findChildByName("header_button_close");
            _local_3.removeEventListener("WME_CLICK", onCancelButtonClick);
            _local_3.addEventListener("WME_CLICK", onCancelButtonClick);
            var _local_4:IWindow = _window.findChildByName("ok_btn");
            _local_4.removeEventListener("WME_CLICK", onPostButtonClick);
            _local_4.addEventListener("WME_CLICK", onPostButtonClick);
            _SafeStr_2239 = ISelectorWindow(_window.findChildByName("read_selector"));
            _SafeStr_2239.addEventListener("WME_OVER", onReadSelectorHover);
            addSelectorListeners(_SafeStr_2239);
            _SafeStr_2240 = ISelectorWindow(_window.findChildByName("post_message_selector"));
            _SafeStr_2240.addEventListener("WME_OVER", onPostMessageSelectorHover);
            addSelectorListeners(_SafeStr_2240);
            _SafeStr_2241 = ISelectorWindow(_window.findChildByName("post_thread_selector"));
            _SafeStr_2241.addEventListener("WME_OVER", onPostThreadSelectorHover);
            addSelectorListeners(_SafeStr_2241);
            _SafeStr_2242 = ISelectorWindow(_window.findChildByName("moderate_selector"));
            _SafeStr_2242.addEventListener("WME_OVER", onModerateSelectorHover);
            addSelectorListeners(_SafeStr_2242);
            _SafeStr_2243 = setSelectorState(_SafeStr_2239, 0, _SafeStr_2235.readPermissions);
            _SafeStr_2244 = setSelectorState(_SafeStr_2240, _SafeStr_2243, _SafeStr_2235.postMessagePermissions);
            _SafeStr_2245 = setSelectorState(_SafeStr_2241, _SafeStr_2244, _SafeStr_2235.postThreadPermissions);
            _SafeStr_2246 = setSelectorState(_SafeStr_2242, 2, _SafeStr_2235.moderatePermissions);
        }

        public function dispose():void
        {
            _SafeStr_1284.forumSettingsView = null;
            _window.dispose();
            _window = null;
        }

        private function onTopAreaClick(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1284.context.createLinkEvent(("group/" + _SafeStr_2235.groupId));
        }

        private function onPostButtonClick(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1284.updateForumSettings(_SafeStr_2235.groupId, _SafeStr_2243, _SafeStr_2244, _SafeStr_2245, _SafeStr_2246);
            dispose();
        }

        private function onCancelButtonClick(_arg_1:WindowMouseEvent):void
        {
            dispose();
        }

        private function addSelectorListeners(_arg_1:ISelectorWindow):void
        {
            var _local_2:int;
            var _local_3:ISelectableWindow;
            _local_2 = 0;
            while (_local_2 < _arg_1.numSelectables)
            {
                _local_3 = _arg_1.getSelectableAt(_local_2);
                _local_3.removeEventListener("WE_SELECTED", onSelectionChanged);
                _local_3.addEventListener("WE_SELECTED", onSelectionChanged);
                _local_2++;
            };
        }

        private function onSelectionChanged(_arg_1:WindowEvent):void
        {
            _SafeStr_2243 = getSelectorState(_SafeStr_2239);
            _SafeStr_2244 = setSelectorState(_SafeStr_2240, _SafeStr_2243, getSelectorState(_SafeStr_2240));
            _SafeStr_2245 = setSelectorState(_SafeStr_2241, _SafeStr_2244, getSelectorState(_SafeStr_2241));
            _SafeStr_2246 = getSelectorState(_SafeStr_2242);
        }

        private function onReadSelectorHover(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1284.tracking.trackEventLogOncePerSession("InterfaceExplorer", "hover", "forum.can.read.seen");
        }

        private function onPostMessageSelectorHover(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1284.tracking.trackEventLogOncePerSession("InterfaceExplorer", "hover", "forum.can.post.seen");
        }

        private function onPostThreadSelectorHover(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1284.tracking.trackEventLogOncePerSession("InterfaceExplorer", "hover", "forum.can.start.thread.seen");
        }

        private function onModerateSelectorHover(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1284.tracking.trackEventLogOncePerSession("InterfaceExplorer", "hover", "forum.can.moderate.seen");
        }


    }
}