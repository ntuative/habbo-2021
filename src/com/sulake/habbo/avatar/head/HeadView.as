package com.sulake.habbo.avatar.head
{
    import com.sulake.habbo.avatar.common.CategoryBaseView;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryView;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class HeadView extends CategoryBaseView implements IAvatarEditorCategoryView 
    {

        public function HeadView(_arg_1:IAvatarEditorCategoryModel)
        {
            super(_arg_1);
        }

        override public function init():void
        {
            if (!_window)
            {
                _window = (_SafeStr_1275.controller.view.getCategoryContainer("head") as IWindowContainer);
                _window.visible = false;
                _window.procedure = windowEventProc;
            };
            _SafeStr_573 = true;
            if (((_SafeStr_1275) && (_SafeStr_1285 == "")))
            {
                _SafeStr_1275.switchCategory("hr");
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
            inactivateTab(_currentTabName);
            _arg_1 = ((_arg_1 == "") ? _SafeStr_1285 : _arg_1);
            switch (_arg_1)
            {
                case "hr":
                    _currentTabName = "tab_hair";
                    break;
                case "ha":
                    _currentTabName = "tab_hat";
                    break;
                case "he":
                    _currentTabName = "tab_accessories";
                    break;
                case "ea":
                    _currentTabName = "tab_eyewear";
                    break;
                case "fa":
                    _currentTabName = "tab_masks";
                    break;
                default:
                    throw (new Error((('[HeadView] Unknown item category: "' + _arg_1) + '"')));
            };
            _SafeStr_1285 = _arg_1;
            activateTab(_currentTabName);
            if (!_SafeStr_573)
            {
                init();
            };
            updateGridView(_arg_1);
        }

        private function windowEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "tab_hair":
                        switchCategory("hr");
                        break;
                    case "tab_hat":
                        switchCategory("ha");
                        break;
                    case "tab_accessories":
                        switchCategory("he");
                        break;
                    case "tab_eyewear":
                        switchCategory("ea");
                        break;
                    case "tab_masks":
                        switchCategory("fa");
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
                        case "tab_hair":
                        case "tab_hat":
                        case "tab_accessories":
                        case "tab_eyewear":
                        case "tab_masks":
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
                            case "tab_hair":
                            case "tab_hat":
                            case "tab_accessories":
                            case "tab_eyewear":
                            case "tab_masks":
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

