package com.sulake.habbo.ui.widget.wordquiz
{
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Timer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ILabelWindow;
    import com.sulake.core.utils.Map;
    import flash.events.TimerEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class WordQuizView 
    {

        public static const STATE_QUESTION:int = 0;
        public static const STATE_RESULT:int = 1;
        private static const CONTAINER_IN_BOTTOM:Boolean = false;

        private static var _displayResultDuration:int;

        private var _SafeStr_1324:WordQuizWidget;
        private var _mainWindow:IWindowContainer;
        private var _SafeStr_3057:Timer;
        private var _SafeStr_4307:String;

        public function WordQuizView(_arg_1:WordQuizWidget)
        {
            _SafeStr_1324 = _arg_1;
            _displayResultDuration = (_SafeStr_1324.handler.container.config.getInteger("poll.word.quiz.result.view.seconds", 4) * 1000);
        }

        public function dispose():void
        {
            _SafeStr_1324 = null;
            removeWindow();
            if (_mainWindow)
            {
                if (_mainWindow.desktop)
                {
                    _mainWindow.desktop.removeEventListener("WE_RESIZED", onDesktopResized);
                };
                _mainWindow.dispose();
                _mainWindow = null;
            };
        }

        private function getCorrectTextWidth(_arg_1:int, _arg_2:String=null):int
        {
            var _local_4:String;
            var _local_5:IWindowContainer;
            if (_arg_1 == 0)
            {
                _local_4 = "wordquiz_question_xml";
            }
            else
            {
                _local_4 = "wordquiz_result_xml";
            };
            _local_5 = (_SafeStr_1324.windowManager.buildFromXML((_SafeStr_1324.assets.getAssetByName(_local_4).content as XML)) as IWindowContainer);
            if (_local_5 == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
            _local_5.findChildByName("quiz_topic").caption = _arg_2;
            _local_5.findChildByName("quiz_topic").width = 660;
            var _local_3:int = ITextWindow(_local_5.findChildByName("quiz_topic")).textWidth;
            _local_5.dispose();
            return (_local_3);
        }

        public function createWindow(_arg_1:int, _arg_2:String=null):void
        {
            var _local_3:String;
            removeWindow();
            if (_arg_1 == 0)
            {
                _local_3 = "wordquiz_question_xml";
            }
            else
            {
                _local_3 = "wordquiz_result_xml";
            };
            _mainWindow = (_SafeStr_1324.windowManager.buildFromXML((_SafeStr_1324.assets.getAssetByName(_local_3).content as XML)) as IWindowContainer);
            if (_mainWindow == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
            var _local_4:IWindow = _mainWindow.findChildByName("button_like");
            if (_local_4)
            {
                _local_4.addEventListener("WME_CLICK", onLike);
            };
            _local_4 = _mainWindow.findChildByName("button_dislike");
            if (_local_4)
            {
                _local_4.addEventListener("WME_CLICK", onDislike);
            };
            if (_arg_2 != null)
            {
                _SafeStr_4307 = _arg_2;
            };
            _mainWindow.findChildByName("quiz_topic").caption = _SafeStr_4307;
            _mainWindow.findChildByName("quiz_topic").width = Math.min(660, (getCorrectTextWidth(_arg_1, _SafeStr_4307) + 6));
            _mainWindow.findChildByName("quiz_topic").y = 3;
            positionWindow();
            _mainWindow.desktop.addEventListener("WE_RESIZED", onDesktopResized);
        }

        public function removeWindow():void
        {
            if (((!(_mainWindow)) || (_mainWindow.numChildren == 0)))
            {
                return;
            };
            _mainWindow.desktop.addEventListener("WE_RESIZED", onDesktopResized);
            _mainWindow.dispose();
            _mainWindow = null;
            if (_SafeStr_3057)
            {
                _SafeStr_3057.reset();
                _SafeStr_3057 = null;
            };
        }

        public function get mainWindow():IWindow
        {
            return (_mainWindow);
        }

        public function updateCounter(_arg_1:String):void
        {
            if (((!(_mainWindow)) || (!(_mainWindow.findChildByName("countdown")))))
            {
                return;
            };
            if (_arg_1 == "0")
            {
                _arg_1 = "";
            };
            _mainWindow.findChildByName("countdown").caption = _arg_1;
        }

        public function updateResults(_arg_1:Map):void
        {
            if (((!(_mainWindow)) || (!(_arg_1))))
            {
                return;
            };
            var _local_3:int = ((_arg_1["0"] != null) ? _arg_1.getValue("0") : 0);
            var _local_2:ILabelWindow = (_mainWindow.findChildByName("lbl_dislike_count") as ILabelWindow);
            if (_local_2)
            {
                _local_2.text = _local_3.toString();
            };
            _local_3 = ((_arg_1["1"] != null) ? _arg_1.getValue("1") : 0);
            _local_2 = (_mainWindow.findChildByName("lbl_like_count") as ILabelWindow);
            if (_local_2)
            {
                _local_2.text = _local_3.toString();
            };
        }

        public function displayResults(_arg_1:Map):void
        {
            createWindow(1);
            updateResults(_arg_1);
            _SafeStr_3057 = new Timer(_displayResultDuration);
            _SafeStr_3057.addEventListener("timer", onWaitTimer);
            _SafeStr_3057.start();
        }

        private function onWaitTimer(_arg_1:TimerEvent):void
        {
            removeWindow();
        }

        private function onLike(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1324.sendAnswer(1);
        }

        private function onDislike(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1324.sendAnswer(0);
        }

        private function onDesktopResized(_arg_1:WindowEvent):void
        {
            positionWindow();
        }

        private function positionWindow():void
        {
            if (((!(_mainWindow)) || (_mainWindow.numChildren == 0)))
            {
                return;
            };
            var _local_1:IWindow = _mainWindow.getChildAt(0);
            _mainWindow.x = ((_mainWindow.desktop.width / 2) - (_local_1.width / 2));
            _mainWindow.y = 6;
        }


    }
}

