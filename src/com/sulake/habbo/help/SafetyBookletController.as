package com.sulake.habbo.help
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.window.utils.IModalDialog;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.habbo.window.widgets.IProgressIndicatorWidget;
    import com.sulake.core.window.components.IWidgetWindow;

    public class SafetyBookletController implements IDisposable 
    {

        private const START_PAGE:int = 0;
        private const FINAL_PAGE:int = 7;

        private var _habboHelp:HabboHelp;
        private var _SafeStr_1665:IModalDialog;
        private var _window:IWindowContainer;
        private var _disposed:Boolean = false;
        private var _SafeStr_2271:int = 0;

        public function SafetyBookletController(_arg_1:HabboHelp)
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

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function openSafetyBooklet():void
        {
            closeWindow();
            _SafeStr_1665 = _habboHelp.getModalXmlWindow("safety_booklet");
            _window = IWindowContainer(_SafeStr_1665.rootWindow);
            _window.procedure = onWindowEvent;
            setCurrentPage(0);
            _habboHelp.tracking.trackEventLog("Quiz", "", "talent.quiz.open");
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
                    setCurrentPage(Math.min(7, (_SafeStr_2271 + 1)));
                    _habboHelp.tracking.trackEventLog("Quiz", ("" + _SafeStr_2271), "talent.quiz.change_page");
                    _habboHelp.trackGoogle("safetyBooklet", ("clickNextPage_" + _SafeStr_2271));
                    return;
                case "back_button":
                case "previous_button":
                    setCurrentPage(Math.max(0, (_SafeStr_2271 - 1)));
                    _habboHelp.tracking.trackEventLog("Quiz", ("" + _SafeStr_2271), "talent.quiz.change_page");
                    _habboHelp.trackGoogle("safetyBooklet", ("clickPrevPage_" + _SafeStr_2271));
                    return;
                case "quiz_button":
                    _habboHelp.trackGoogle("safetyBooklet", "clickQuiz");
                    _habboHelp.showSafetyQuiz();
                    return;
                case "ok_button":
                    _habboHelp.trackGoogle("safetyBooklet", "clickOk");
                    _habboHelp.showSafetyQuiz();
                    _habboHelp.closeSafetyBooklet();
                    return;
            };
        }

        private function setCurrentPage(_arg_1:int):void
        {
            _SafeStr_2271 = _arg_1;
            _window.findChildByName("safety.quiz.explanation").visible = (!(_habboHelp.safetyQuizDisabled));
            if (_SafeStr_2271 < 7)
            {
                if (_SafeStr_2271 == 0)
                {
                    _window.findChildByName("previous_button").visible = false;
                }
                else
                {
                    _window.findChildByName("previous_button").visible = true;
                };
                IStaticBitmapWrapperWindow(_window.findChildByName("illustration")).assetUri = (("${image.library.url}safetyquiz/page_" + _SafeStr_2271) + ".png");
                IStaticBitmapWrapperWindow(_window.findChildByName("safety_image")).assetUri = "${image.library.url}safetyquiz/safety_off.png";
                IProgressIndicatorWidget(IWidgetWindow(_window.findChildByName("page_widget")).widget).position = (_SafeStr_2271 + 1);
                _window.findChildByName("title").caption = (("${safety.booklet.page." + _SafeStr_2271) + ".title}");
                _window.findChildByName("description").caption = (("${safety.booklet.page." + _SafeStr_2271) + ".description}");
                _window.findChildByName("page_container").visible = true;
                _window.findChildByName("final_page").visible = false;
                _window.findChildByName("final_page_no_questions").visible = false;
                _window.findChildByName("page_container").invalidate();
            }
            else
            {
                IStaticBitmapWrapperWindow(_window.findChildByName("illustration")).assetUri = "${image.library.url}safetyquiz/page_end.png";
                IStaticBitmapWrapperWindow(_window.findChildByName("safety_image")).assetUri = "${image.library.url}safetyquiz/safety_on.png";
                IProgressIndicatorWidget(IWidgetWindow(_window.findChildByName("page_widget")).widget).position = 0;
                _window.findChildByName("page_container").visible = false;
                if (_habboHelp.safetyQuizDisabled)
                {
                    _window.findChildByName("final_page_no_questions").visible = true;
                    _window.findChildByName("final_page_no_questions").invalidate();
                }
                else
                {
                    _window.findChildByName("final_page").visible = true;
                    _window.findChildByName("final_page").invalidate();
                };
            };
        }


    }
}

