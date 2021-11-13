package com.sulake.habbo.avatar.view
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.avatar.AvatarEditorView;
    import com.sulake.habbo.avatar.HabboAvatarEditorManager;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class AvatarEditorNameChangeView 
    {

        private static var NAME_SUGGESTION_BG_COLOR:uint = 13232628;
        private static var NAME_SUGGESTION_BG_COLOR_OVER:uint = 11129827;

        private var _window:IFrameWindow;
        private var _SafeStr_461:AvatarEditorView;
        private var _SafeStr_825:HabboAvatarEditorManager;
        private var _SafeStr_1351:AvatarEditorNameSuggestionListRenderer;
        private var _checkedName:String;
        private var _pendingName:String;
        private var _SafeStr_1352:Boolean = false;

        public function AvatarEditorNameChangeView(_arg_1:AvatarEditorView, _arg_2:int, _arg_3:int)
        {
            _SafeStr_461 = _arg_1;
            _SafeStr_825 = _SafeStr_461.editor.manager;
            _window = IFrameWindow(_SafeStr_825.windowManager.buildFromXML(XML(new HabboAvatarEditorCom.avatar_editor_name_change())));
            _window.x = _arg_2;
            var _local_4:int = _SafeStr_825.windowManager.getDesktop(1).width;
            if ((_window.x + _window.width) > _local_4)
            {
                _window.x = (_local_4 - _window.width);
            };
            _window.y = _arg_3;
            initControls();
        }

        private function initControls():void
        {
            _window.procedure = windowEventHandler;
            var _local_1:_SafeStr_101 = (_window.findChildByName("select_name_button") as _SafeStr_101);
            if (_local_1)
            {
                _local_1.disable();
            };
        }

        public function focus():void
        {
            _window.activate();
        }

        public function nameCheckWaitBegin():void
        {
            var _local_1:IWindow;
            if (((_window) && (!(_window.disposed))))
            {
                _local_1 = _window.findChildByName("select_name_button");
                if (_local_1)
                {
                    _local_1.disable();
                };
                _local_1 = _window.findChildByName("check_name_button");
                if (_local_1)
                {
                    _local_1.disable();
                };
                _local_1 = _window.findChildByName("input");
                if (_local_1)
                {
                    _local_1.disable();
                };
                _local_1 = _window.findChildByName("info_text");
                if (_local_1)
                {
                    _local_1.caption = _SafeStr_825.localization.getLocalization("help.tutorial.name.wait_while_checking");
                };
            };
            _SafeStr_1352 = true;
        }

        private function windowEventHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:IWindow;
            var _local_4:ITextFieldWindow;
            if (!_SafeStr_1352)
            {
                if (_arg_1.type == "WE_CHANGE")
                {
                    if (_arg_2.name == "input")
                    {
                        _local_3 = _window.findChildByName("select_name_button");
                        _local_4 = (_arg_2 as ITextFieldWindow);
                        if (((_local_3) && (_local_4)))
                        {
                            if (_local_4.text.length > 2)
                            {
                                _local_3.enable();
                            }
                            else
                            {
                                _local_3.disable();
                            };
                        };
                    };
                };
            };
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "check_name_button":
                    _SafeStr_825.handler.checkName(getName());
                    nameCheckWaitBegin();
                    return;
            };
        }

        private function getName():String
        {
            var _local_1:ITextFieldWindow;
            if (_window)
            {
                _local_1 = (_window.findChildByName("input") as ITextFieldWindow);
                if (_local_1)
                {
                    return (_local_1.text);
                };
            };
            return (null);
        }

        public function set checkedName(_arg_1:String):void
        {
            _checkedName = _arg_1;
            if (_pendingName == _checkedName)
            {
                return;
            };
            setNameAvailableView();
        }

        public function setNameAvailableView():void
        {
            if (_window == null)
            {
                return;
            };
            nameCheckWaitEnd(true);
            var _local_2:ITextWindow = (_window.findChildByName("info_text") as ITextWindow);
            if (_local_2 == null)
            {
                return;
            };
            _SafeStr_825.localization.registerParameter("help.tutorial.name.available", "name", _checkedName);
            _local_2.text = _SafeStr_825.localization.getLocalization("help.tutorial.name.available");
            var _local_3:ITextFieldWindow = (_window.findChildByName("input") as ITextFieldWindow);
            if (_local_3 == null)
            {
                return;
            };
            _local_3.text = _checkedName;
            var _local_1:IWindowContainer = (_window.findChildByName("suggestions") as IWindowContainer);
            if (_local_1 == null)
            {
                return;
            };
            _local_1.visible = false;
        }

        public function setNameNotAvailableView(_arg_1:int, _arg_2:String, _arg_3:Array):void
        {
            var _local_8:int;
            var _local_6:IWindow;
            nameCheckWaitEnd(false);
            _pendingName = null;
            _checkedName = null;
            if (_window == null)
            {
                return;
            };
            var _local_5:ITextWindow = (_window.findChildByName("info_text") as ITextWindow);
            if (_local_5 == null)
            {
                return;
            };
            switch (_arg_1)
            {
                case ChangeUserNameResultMessageEvent._SafeStr_633:
                    _SafeStr_825.localization.registerParameter("help.tutorial.name.taken", "name", _arg_2);
                    _local_5.text = _SafeStr_825.localization.getLocalization("help.tutorial.name.taken");
                    break;
                case ChangeUserNameResultMessageEvent._SafeStr_634:
                    _SafeStr_825.localization.registerParameter("help.tutorial.name.invalid", "name", _arg_2);
                    _local_5.text = _SafeStr_825.localization.getLocalization("help.tutorial.name.invalid");
                    break;
                case ChangeUserNameResultMessageEvent._SafeStr_635:
                    break;
                case ChangeUserNameResultMessageEvent._SafeStr_636:
                    _local_5.text = _SafeStr_825.localization.getLocalization("help.tutorial.name.long");
                    break;
                case ChangeUserNameResultMessageEvent._SafeStr_637:
                    _local_5.text = _SafeStr_825.localization.getLocalization("help.tutorial.name.short");
                    break;
                case ChangeUserNameResultMessageEvent._SafeStr_638:
                    _local_5.text = _SafeStr_825.localization.getLocalization("help.tutorial.name.change_not_allowed");
                    break;
                case ChangeUserNameResultMessageEvent._SafeStr_639:
                    _local_5.text = _SafeStr_825.localization.getLocalization("help.tutorial.name.merge_hotel_down");
            };
            var _local_4:IWindowContainer = (_window.findChildByName("suggestions") as IWindowContainer);
            if (_local_4 == null)
            {
                return;
            };
            if (((_arg_1 == ChangeUserNameResultMessageEvent._SafeStr_639) || (_arg_1 == ChangeUserNameResultMessageEvent._SafeStr_638)))
            {
                _local_4.visible = false;
                return;
            };
            _local_4.visible = true;
            _SafeStr_1351 = new AvatarEditorNameSuggestionListRenderer(_SafeStr_825);
            var _local_7:int = _SafeStr_1351.render(_arg_3, _local_4);
            _local_8 = 0;
            while (_local_8 < _local_4.numChildren)
            {
                _local_6 = _local_4.getChildAt(_local_8);
                _local_6.color = NAME_SUGGESTION_BG_COLOR;
                _local_6.addEventListener("WME_CLICK", nameSelected);
                _local_6.addEventListener("WME_OVER", nameOver);
                _local_6.addEventListener("WME_OUT", nameOut);
                _local_8++;
            };
        }

        public function nameCheckWaitEnd(_arg_1:Boolean):void
        {
            var _local_2:IWindow;
            if (((_window) && (!(_window.disposed))))
            {
                if (_arg_1)
                {
                    _local_2 = _window.findChildByName("select_name_button");
                    if (_local_2)
                    {
                        _local_2.enable();
                    };
                };
                _local_2 = _window.findChildByName("check_name_button");
                if (_local_2)
                {
                    _local_2.enable();
                };
                _local_2 = _window.findChildByName("input");
                if (_local_2)
                {
                    _local_2.enable();
                };
            };
            _SafeStr_1352 = false;
        }

        public function setNormalView():void
        {
            if (_window == null)
            {
                return;
            };
            var _local_2:ITextWindow = (_window.findChildByName("info_text") as ITextWindow);
            if (_local_2 == null)
            {
                return;
            };
            _local_2.text = _SafeStr_825.localization.getLocalization("help.tutorial.name.info");
            var _local_1:IWindowContainer = (_window.findChildByName("suggestions") as IWindowContainer);
            if (_local_1 == null)
            {
                return;
            };
            _local_1.visible = false;
        }

        private function nameSelected(_arg_1:WindowMouseEvent):void
        {
            nameCheckWaitEnd(true);
            var _local_4:ITextWindow = (_arg_1.target as ITextWindow);
            if (!_local_4)
            {
                return;
            };
            var _local_3:String = _local_4.text;
            setNormalView();
            var _local_2:ITextFieldWindow = (_window.findChildByName("input") as ITextFieldWindow);
            if (_local_2 == null)
            {
                return;
            };
            _local_2.text = _local_3;
        }

        private function nameOver(_arg_1:WindowMouseEvent):void
        {
            var _local_2:ITextWindow = (_arg_1.target as ITextWindow);
            if (_local_2 != null)
            {
                _local_2.color = NAME_SUGGESTION_BG_COLOR_OVER;
            };
        }

        private function nameOut(_arg_1:WindowMouseEvent):void
        {
            var _local_2:ITextWindow = (_arg_1.target as ITextWindow);
            if (_local_2 != null)
            {
                _local_2.color = NAME_SUGGESTION_BG_COLOR;
            };
        }


    }
}

