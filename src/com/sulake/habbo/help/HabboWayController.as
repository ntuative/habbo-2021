package com.sulake.habbo.help
{
    import com.sulake.habbo.window.utils.IModalDialog;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.widgets.IProgressIndicatorWidget;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;

    public class HabboWayController 
    {

        private const START_PAGE:int = 0;

        private var _SafeStr_2693:int = 0;
        private var _SafeStr_2271:int = 0;
        private var _habboHelp:HabboHelp;
        private var _SafeStr_1665:IModalDialog;
        private var _window:IWindowContainer;
        private var _disposed:Boolean = false;

        public function HabboWayController(_arg_1:HabboHelp)
        {
            _habboHelp = _arg_1;
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                closeWindow();
                if (_habboHelp)
                {
                    _habboHelp = null;
                };
                _disposed = true;
            };
        }

        private function get finalPage():int
        {
            return (_habboHelp.getInteger("help.habboway.page.count", 6));
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function showHabboWay():void
        {
            closeWindow();
            _SafeStr_1665 = _habboHelp.getModalXmlWindow("habbo_way");
            _window = IWindowContainer(_SafeStr_1665.rootWindow);
            _window.procedure = onWindowEvent;
            IProgressIndicatorWidget(IWidgetWindow(_window.findChildByName("page_widget")).widget).size = finalPage;
            setCurrentPage(0);
        }

        public function closeWindow():void
        {
            _window = null;
            if (_SafeStr_1665)
            {
                _SafeStr_1665.dispose();
                _SafeStr_1665 = null;
            };
        }

        private function onWindowEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if ((((_disposed) || (!(_window))) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "header_button_close":
                    closeWindow();
                    return;
                case "next_button":
                    setCurrentPage(Math.min(finalPage, (_SafeStr_2271 + 1)));
                    _habboHelp.trackGoogle("habboWay", ("clickNextPage_" + _SafeStr_2271));
                    return;
                case "back_button":
                case "previous_button":
                    setCurrentPage(Math.max(0, (_SafeStr_2271 - 1)));
                    _habboHelp.trackGoogle("habboWay", ("clickPrevPage_" + _SafeStr_2271));
                    return;
                case "quiz_button":
                    _habboHelp.trackGoogle("habboWay", "clickQuiz");
                    _habboHelp.showHabboWayQuiz();
                    return;
            };
        }

        private function setCurrentPage(_arg_1:int):void
        {
            _SafeStr_2271 = _arg_1;
            if (_SafeStr_2271 < finalPage)
            {
                if (_SafeStr_2271 == 0)
                {
                    _window.findChildByName("previous_button").visible = false;
                }
                else
                {
                    _window.findChildByName("previous_button").visible = true;
                };
                IStaticBitmapWrapperWindow(_window.findChildByName("illustration")).assetUri = (("${image.library.url}habboway/page_" + _SafeStr_2271) + ".png");
                IStaticBitmapWrapperWindow(_window.findChildByName("dove_image")).assetUri = "help_habboway_dove_off";
                IProgressIndicatorWidget(IWidgetWindow(_window.findChildByName("page_widget")).widget).position = (_SafeStr_2271 + 1);
                _window.findChildByName("correct_title").caption = (("${habbo.way.page." + _SafeStr_2271) + ".correct.title}");
                _window.findChildByName("correct_description").caption = (("${habbo.way.page." + _SafeStr_2271) + ".correct.description}");
                _window.findChildByName("wrong_title").caption = (("${habbo.way.page." + _SafeStr_2271) + ".wrong.title}");
                _window.findChildByName("wrong_description").caption = (("${habbo.way.page." + _SafeStr_2271) + ".wrong.description}");
                _window.findChildByName("page_container").visible = true;
                _window.findChildByName("final_page").visible = false;
                _window.findChildByName("page_container").invalidate();
            }
            else
            {
                IStaticBitmapWrapperWindow(_window.findChildByName("illustration")).assetUri = "${image.library.url}habboway/page_end.png";
                IStaticBitmapWrapperWindow(_window.findChildByName("dove_image")).assetUri = "help_habboway_dove_on";
                IProgressIndicatorWidget(IWidgetWindow(_window.findChildByName("page_widget")).widget).position = 0;
                _window.findChildByName("page_container").visible = false;
                _window.findChildByName("final_page").visible = true;
                _window.findChildByName("final_page").invalidate();
            };
        }


    }
}

