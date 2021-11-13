package com.sulake.habbo.avatar.legs
{
    import com.sulake.habbo.avatar.common.CategoryBaseView;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryView;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class LegsView extends CategoryBaseView implements IAvatarEditorCategoryView 
    {

        public function LegsView(_arg_1:IAvatarEditorCategoryModel)
        {
            super(_arg_1);
        }

        override public function init():void
        {
            if (!_window)
            {
                _window = (_SafeStr_1275.controller.view.getCategoryContainer("legs") as IWindowContainer);
                _window.visible = false;
                _window.procedure = windowEventProc;
            };
            _SafeStr_573 = true;
            if (((_SafeStr_1275) && (_SafeStr_1285 == "")))
            {
                _SafeStr_1275.switchCategory("lg");
            };
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
                case "lg":
                    _currentTabName = "tab_pants";
                    break;
                case "sh":
                    _currentTabName = "tab_shoes";
                    break;
                case "wa":
                    _currentTabName = "tab_belts";
                    break;
                default:
                    throw (new Error((('[LegsView] Unknown item category: "' + _arg_1) + '"')));
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
                    case "tab_pants":
                        switchCategory("lg");
                        break;
                    case "tab_shoes":
                        switchCategory("sh");
                        break;
                    case "tab_belts":
                        switchCategory("wa");
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
                        case "tab_pants":
                        case "tab_shoes":
                        case "tab_belts":
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
                            case "tab_pants":
                            case "tab_shoes":
                            case "tab_belts":
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

