package com.sulake.habbo.avatar.torso
{
    import com.sulake.habbo.avatar.common.CategoryBaseView;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class TorsoView extends CategoryBaseView implements IAvatarEditorCategoryView 
    {

        public function TorsoView(_arg_1:TorsoModel)
        {
            super(_arg_1);
        }

        override public function init():void
        {
            if (!_window)
            {
                _window = (_SafeStr_1275.controller.view.getCategoryContainer("torso") as IWindowContainer);
                _window.visible = false;
                _window.procedure = windowEventProc;
            };
            _SafeStr_573 = true;
            if (((_SafeStr_1275) && (_SafeStr_1285 == "")))
            {
                _SafeStr_1275.switchCategory("ch");
            };
        }

        override public function dispose():void
        {
            super.dispose();
            _SafeStr_1275 = null;
        }

        public function switchCategory(_arg_1:String):void
        {
            if (_window == null)
            {
                return;
            };
            if (_window.disposed)
            {
                return;
            };
            _arg_1 = ((_arg_1 == "") ? _SafeStr_1285 : _arg_1);
            inactivateTab(_currentTabName);
            switch (_arg_1)
            {
                case "ch":
                    _currentTabName = "tab_shirt";
                    break;
                case "cc":
                    _currentTabName = "tab_jacket";
                    break;
                case "cp":
                    _currentTabName = "tab_prints";
                    break;
                case "ca":
                    _currentTabName = "tab_accessories";
                    break;
                default:
                    throw (new Error((('[TorsoView] Unknown item category: "' + _arg_1) + '"')));
            };
            _SafeStr_1285 = _arg_1;
            activateTab(_currentTabName);
            if (!_SafeStr_573)
            {
                init();
            };
            updateGridView(_SafeStr_1285);
        }

        private function windowEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "tab_jacket":
                        switchCategory("cc");
                        break;
                    case "tab_shirt":
                        switchCategory("ch");
                        break;
                    case "tab_accessories":
                        switchCategory("ca");
                        break;
                    case "tab_prints":
                        switchCategory("cp");
                        break;
                    default:
                };
            }
            else
            {
                if (_arg_1.type == "WME_OVER")
                {
                    switch (_arg_2.name)
                    {
                        case "tab_jacket":
                        case "tab_prints":
                        case "tab_shirt":
                        case "tab_accessories":
                            activateTab(_arg_2.name);
                            break;
                        default:
                    };
                }
                else
                {
                    if (_arg_1.type == "WME_OUT")
                    {
                        switch (_arg_2.name)
                        {
                            case "tab_jacket":
                            case "tab_prints":
                            case "tab_shirt":
                            case "tab_accessories":
                                if (_currentTabName != _arg_2.name)
                                {
                                    inactivateTab(_arg_2.name);
                                };
                                return;
                            default:
                                return;
                        };
                    };
                };
            };
        }


    }
}

