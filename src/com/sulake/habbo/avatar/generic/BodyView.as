package com.sulake.habbo.avatar.generic
{
    import com.sulake.habbo.avatar.common.CategoryBaseView;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryView;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class BodyView extends CategoryBaseView implements IAvatarEditorCategoryView 
    {

        private const TAB_BOY_ID:String = "tab_boy";
        private const TAB_GIRL_ID:String = "tab_girl";

        public function BodyView(_arg_1:IAvatarEditorCategoryModel)
        {
            super(_arg_1);
            _SafeStr_1285 = "hd";
        }

        override public function reset():void
        {
            super.reset();
            _SafeStr_1285 = "hd";
        }

        override public function init():void
        {
            if (!_window)
            {
                _window = (_SafeStr_1275.controller.view.getCategoryContainer("generic") as IWindowContainer);
                _window.visible = false;
                _window.procedure = windowEventProc;
            };
            updateGridView("hd");
            _SafeStr_573 = true;
            updateGenderTab();
        }

        override public function getWindowContainer():IWindowContainer
        {
            if (!_SafeStr_573)
            {
                init();
            };
            updateGenderTab();
            return (_window);
        }

        public function updateGenderTab():void
        {
            if (_SafeStr_1275 == null)
            {
                return;
            };
            switch (_SafeStr_1275.controller.gender)
            {
                case "M":
                    activateTab("tab_boy");
                    inactivateTab("tab_girl");
                    return;
                case "F":
                    activateTab("tab_girl");
                    inactivateTab("tab_boy");
                    return;
                default:
                    return;
            };
        }

        public function switchCategory(_arg_1:String):void
        {
            updateGenderTab();
            updateGridView(((_arg_1 == "") ? _SafeStr_1285 : _arg_1));
        }

        private function windowEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "tab_boy":
                        _SafeStr_1275.controller.gender = "M";
                        _arg_1.stopPropagation();
                        break;
                    case "tab_girl":
                        _SafeStr_1275.controller.gender = "F";
                        _arg_1.stopPropagation();
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
                        case "tab_boy":
                        case "tab_girl":
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
                            case "tab_boy":
                            case "tab_girl":
                                updateGenderTab();
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

