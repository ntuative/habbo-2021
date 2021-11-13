package com.sulake.habbo.ui.widget.wordquiz
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import flash.utils.Timer;
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.IWindow;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.handler.WordQuizWidgetHandler;
    import com.sulake.habbo.ui.widget.events.RoomWidgetWordQuizUpdateEvent;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components._SafeStr_124;
    import flash.events.TimerEvent;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPollMessage;

    public class WordQuizWidget extends RoomWidgetBase
    {

        private static const ASSET_NAME_LIKE:String = "wordquiz_like_xml";
        private static const ASSET_NAME_DISLIKE:String = "wordquiz_unlike_xml";
        private static const SIGN_FADE_IN_TIME:int = 750;
        private static const SIGN_FADE_OUT_TIME:int = 750;
        private static const UPDATE_FREQUENCY:int = 40;
        public static const VALUE_KEY_DISLIKE:String = "0";
        public static const VALUE_KEY_LIKE:String = "1";

        private var _SafeStr_570:WordQuizView;
        private var _SafeStr_4308:Timer;
        private var _SafeStr_4309:Timer;
        private var _SafeStr_4310:Timer;
        private var _SafeStr_4311:int = 0;
        private var _showResultTime:int;
        private var _countdown:int = 0;
        private var _SafeStr_4312:int;
        private var _question:Dictionary;
        private var _SafeStr_4313:int;
        private var _showSignCounters:Dictionary = new Dictionary();
        private var _answerWindows:Vector.<IWindowContainer> = new Vector.<IWindowContainer>(0);
        private var _SafeStr_4314:Vector.<IWindowContainer> = new Vector.<IWindowContainer>(0);
        private var _SafeStr_4315:Vector.<IWindowContainer> = new Vector.<IWindowContainer>(0);
        private var _SafeStr_4316:Boolean;

        public function WordQuizWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager)
        {
            super(handler, _arg_2, _arg_3, _arg_4);
            _SafeStr_3915 = _arg_1;
            _SafeStr_570 = new WordQuizView(this);
            _showResultTime = (handler.container.config.getInteger("poll.word.quiz.answer.bubble.seconds", 3) * 1000);
        }

        override public function get mainWindow():IWindow
        {
            return ((_SafeStr_570) ? _SafeStr_570.mainWindow : null);
        }

        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addEventListener("RWPUW_NEW_QUESTION", newQuestion);
            _arg_1.addEventListener("RWPUW_QUESTION_ANSWERED", answeredQuestion);
            _arg_1.addEventListener("RWPUW_QUESION_FINSIHED", questionFinished);
            super.registerUpdateEvents(_arg_1);
        }

        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.removeEventListener("RWPUW_NEW_QUESTION", newQuestion);
            _arg_1.removeEventListener("RWPUW_QUESTION_ANSWERED", answeredQuestion);
            _arg_1.removeEventListener("RWPUW_QUESION_FINSIHED", questionFinished);
            super.unregisterUpdateEvents(_arg_1);
        }

        public function get handler():WordQuizWidgetHandler
        {
            return (_SafeStr_3915 as WordQuizWidgetHandler);
        }

        override public function dispose():void
        {
            var _local_2:IWindowContainer;
            var _local_1:int;
            if (disposed)
            {
                return;
            };
            if (_SafeStr_570)
            {
                _SafeStr_570.dispose();
                _SafeStr_570 = null;
            };
            if (_SafeStr_4308)
            {
                _SafeStr_4308.reset();
                _SafeStr_4308 = null;
            };
            if (_SafeStr_4309)
            {
                _SafeStr_4309.reset();
                _SafeStr_4309 = null;
            };
            if (_SafeStr_4310)
            {
                _SafeStr_4310.reset();
                _SafeStr_4310 = null;
            };
            if (windowManager)
            {
                if (_answerWindows)
                {
                    _local_1 = 0;
                    while (_local_1 < _answerWindows.length)
                    {
                        _local_2 = (_answerWindows[_local_1] as IWindowContainer);
                        if (_local_2)
                        {
                            windowManager.removeWindow(_local_2.name);
                        };
                        _local_1++;
                    };
                };
                for each (_local_2 in _SafeStr_4314)
                {
                    _local_2.destroy();
                };
                _SafeStr_4314.length = 0;
                for each (_local_2 in _SafeStr_4315)
                {
                    _local_2.destroy();
                };
                _SafeStr_4315.length = 0;
            };
            super.dispose();
        }

        private function newQuestion(_arg_1:RoomWidgetWordQuizUpdateEvent):void
        {
            _SafeStr_4312 = _arg_1.id;
            _question = _arg_1.question;
            _SafeStr_4316 = false;
            _showSignCounters = new Dictionary();
            showNewQuestion(_question, _arg_1.duration);
        }

        private function questionFinished(_arg_1:RoomWidgetWordQuizUpdateEvent):void
        {
            var _local_2:int;
            clearTimers();
            if ((((_SafeStr_570) && (_question)) && (_question.id == _arg_1.questionId)))
            {
                _SafeStr_570.displayResults(_arg_1.answerCounts);
            };
            _local_2 = 0;
            while (_local_2 < _answerWindows.length)
            {
                poolWindow(_answerWindows[_local_2].name);
                _local_2++;
            };
            _answerWindows.length = 0;
        }

        private function poolWindow(_arg_1:String):void
        {
            if (windowManager == null)
            {
                return;
            };
            windowManager.removeWindow(_arg_1);
        }

        private function answeredQuestion(_arg_1:RoomWidgetWordQuizUpdateEvent):void
        {
            var _local_7:IWindowContainer;
            if (_SafeStr_570)
            {
                _SafeStr_570.updateResults(_arg_1.answerCounts);
            };
            var _local_8:int = _arg_1.userId;
            var _local_9:String = _arg_1.value;
            var _local_3:Vector.<IWindowContainer> = ((_local_9 == "1") ? _SafeStr_4314 : _SafeStr_4315);
            var _local_4:String = ((_local_9 == "1") ? "wordquiz_like_xml" : "wordquiz_unlike_xml");
            var _local_5:String = ((((_SafeStr_4312 + "_") + _local_8) + "_") + _local_4);
            if (_local_3.length)
            {
                _local_7 = _local_3.pop();
            }
            else
            {
                _local_7 = (windowManager.buildFromXML((assets.getAssetByName(_local_4).content as XML)) as IWindowContainer);
            };
            _local_7.name = _local_5;
            _answerWindows.push(_local_7);
            _showSignCounters[_local_5] = ((_showResultTime + 750) + 750);
            var _local_6:Rectangle = getAvatarRect(_local_8);
            if (_local_6)
            {
                _local_7.x = (_local_6.left + 20);
                _local_7.y = (_local_6.top - 20);
            };
            if (!_SafeStr_4310)
            {
                _SafeStr_4310 = new Timer(40);
                _SafeStr_4310.addEventListener("timer", onLocationTimer);
                _SafeStr_4310.start();
            };
            var _local_2:_SafeStr_124 = (_local_7.getChildByName("colored") as _SafeStr_124);
            if (_local_2)
            {
                _local_2.blend = 0;
            };
        }

        private function onLocationTimer(_arg_1:TimerEvent):void
        {
            var _local_3:int;
            var _local_5:IWindowContainer;
            var _local_2:Array;
            var _local_6:int;
            var _local_4:Rectangle;
            _local_3 = 0;
            while (_local_3 < _answerWindows.length)
            {
                _local_5 = _answerWindows[_local_3];
                if (_local_5)
                {
                    _local_2 = _answerWindows[_local_3].name.split("_");
                    if (_local_2.length > 1)
                    {
                        _local_6 = _local_2[1];
                        _local_4 = getAvatarRect(_local_6);
                        if (_local_4)
                        {
                            _local_5.x = (_local_4.left + 29);
                            _local_5.y = (_local_4.top - 11);
                        }
                        else
                        {
                            poolWindow(_answerWindows[_local_3].name);
                            return;
                        };
                        handleSignWindowVisibility(_local_5);
                    };
                };
                _local_3++;
            };
        }

        private function handleSignWindowVisibility(_arg_1:IWindowContainer):void
        {
            var _local_5:Number;
            var _local_4:int;
            var _local_2:_SafeStr_124 = (_arg_1.getChildByName("colored") as _SafeStr_124);
            var _local_3:IRegionWindow = (_arg_1.getChildByName("button_like") as IRegionWindow);
            if ((((_showSignCounters.hasOwnProperty(_arg_1.name)) && (_local_2)) && (_local_3)))
            {
                _local_4 = _showSignCounters[_arg_1.name];
                _local_4 = (_local_4 - 40);
                _showSignCounters[_arg_1.name] = _local_4;
                if (_local_4 > (_showResultTime + 750))
                {
                    _local_5 = 0.1875;
                    _local_2.blend = (_local_2.blend + _local_5);
                    _local_3.blend = _local_2.blend;
                }
                else
                {
                    if (_local_4 > 750)
                    {
                        _local_2.blend = 1;
                        _local_3.blend = 1;
                    }
                    else
                    {
                        if (((_local_4 < 750) && (_local_4 > 0)))
                        {
                            _local_5 = (750 / 40);
                            _arg_1.blend = (_arg_1.blend - (_local_5 * 0.01));
                            _arg_1.y = (_arg_1.y - (20 + (70 - (_arg_1.blend * 120))));
                        }
                        else
                        {
                            if (_local_4 < 0)
                            {
                                _arg_1.y = (_arg_1.y - (20 + (70 - (_arg_1.blend * 120))));
                                poolWindow(_arg_1.name);
                            };
                        };
                    };
                };
            };
        }

        private function getAvatarRect(_arg_1:int):Rectangle
        {
            if (((((!(handler)) || (!(handler.container))) || (!(handler.container.roomSession))) || (!(handler.container.roomEngine))))
            {
                return (null);
            };
            var _local_3:int = handler.container.roomSession.roomId;
            var _local_2:IUserData = handler.container.roomSessionManager.getSession(_local_3).userDataManager.getUserData(_arg_1);
            if (_local_2)
            {
                return (handler.container.roomEngine.getRoomObjectBoundingRectangle(_local_3, _local_2.roomObjectId, 100, handler.container.getFirstCanvasId()));
            };
            return (null);
        }

        private function onCountdownDownTimer(_arg_1:TimerEvent):void
        {
            if (_SafeStr_4309 == null)
            {
                return;
            };
            _countdown--;
            _SafeStr_570.updateCounter(String(_countdown));
            if (_countdown == 0)
            {
                clearTimers();
                _SafeStr_570.removeWindow();
            };
        }

        private function showNewQuestion(_arg_1:Dictionary, _arg_2:int):void
        {
            if (!_arg_1)
            {
                return;
            };
            _SafeStr_570.createWindow(0, _arg_1.content);
            _SafeStr_4311++;
            _countdown = 4;
            _SafeStr_4313 = _arg_1.id;
            if (_arg_2 > 0)
            {
                _SafeStr_4309 = new Timer(1000);
                _countdown = (_arg_2 / 1000);
                _SafeStr_4309.addEventListener("timer", onCountdownDownTimer);
                _SafeStr_4309.start();
                _SafeStr_4310 = new Timer(40);
                _SafeStr_4310.addEventListener("timer", onLocationTimer);
                _SafeStr_4310.start();
                _SafeStr_570.updateCounter(String(_countdown));
            };
        }

        private function clearTimers():void
        {
            if (_SafeStr_4309)
            {
                _SafeStr_4309.reset();
                _SafeStr_4309 = null;
            };
            if (_SafeStr_4310)
            {
                _SafeStr_4310.reset();
                _SafeStr_4310 = null;
            };
        }

        public function sendAnswer(_arg_1:int):void
        {
            _SafeStr_570.removeWindow();
            if (_SafeStr_4316)
            {
                return;
            };
            var _local_3:RoomWidgetPollMessage = new RoomWidgetPollMessage("RWPM_ANSWER", _SafeStr_4312);
            _local_3.questionId = (_question["id"] as int);
            var _local_2:Array = [];
            _local_2.push(("" + _arg_1));
            _local_3.answers = _local_2;
            messageListener.processWidgetMessage(_local_3);
            _SafeStr_4316 = true;
            _SafeStr_570.createWindow(1);
        }


    }
}