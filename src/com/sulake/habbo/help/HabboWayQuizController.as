package com.sulake.habbo.help
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.window.utils.IModalDialog;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ISelectorListWindow;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.incoming.help.QuizDataMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.QuizResultsMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.help.GetQuizQuestionsComposer;
    import com.sulake.habbo.communication.messages.parser.help.QuizDataMessageParser;
    import com.sulake.habbo.communication.messages.parser.help.QuizResultsMessageParser;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.help.PostQuizAnswersComposer;

    public class HabboWayQuizController implements IDisposable 
    {

        private static const HABBO_WAY_QUIZ_CODE:String = "HabboWay1";
        private static const SAFETY_QUIZ_CODE:String = "SafetyQuiz1";
        private static const PAGE_QUESTION:int = 1;
        private static const PAGE_SUCCESS:int = 2;
        private static const PAGE_FAILURE:int = 3;
        private static const PAGE_ANALYSIS:int = 4;

        private var _disposed:Boolean;
        private var _habboHelp:HabboHelp;
        private var _SafeStr_1665:IModalDialog;
        private var _window:IWindowContainer;
        private var _SafeStr_2694:IWindowContainer;
        private var _SafeStr_2695:ISelectorListWindow;
        private var _SafeStr_2696:ISelectableWindow;
        private var _SafeStr_2697:IItemListWindow;
        private var _SafeStr_2698:IWindow;
        private var _SafeStr_2699:String;
        private var _SafeStr_2700:Array;
        private var _SafeStr_2701:Array;
        private var _answerOrders:Array;
        private var _questionIdsForWrongAnswers:Array;
        private var _currentQuestion:int;

        public function HabboWayQuizController(_arg_1:HabboHelp)
        {
            _habboHelp = _arg_1;
            _habboHelp.communicationManager.addHabboConnectionMessageEvent(new QuizDataMessageEvent(onQuizData));
            _habboHelp.communicationManager.addHabboConnectionMessageEvent(new QuizResultsMessageEvent(onQuizResults));
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                _SafeStr_2694 = null;
                _SafeStr_2695 = null;
                if (_SafeStr_2696 != null)
                {
                    _SafeStr_2696.dispose();
                    _SafeStr_2696 = null;
                };
                _SafeStr_2697 = null;
                if (_SafeStr_2698 != null)
                {
                    _SafeStr_2698.dispose();
                    _SafeStr_2698 = null;
                };
                closeWindow();
                _disposed = true;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function showHabboWayQuiz():void
        {
            _habboHelp.sendMessage(new GetQuizQuestionsComposer("HabboWay1"));
        }

        public function showSafetyQuiz():void
        {
            _habboHelp.sendMessage(new GetQuizQuestionsComposer("SafetyQuiz1"));
        }

        private function onQuizData(_arg_1:QuizDataMessageEvent):void
        {
            var _local_2:QuizDataMessageParser = _arg_1.getParser();
            _habboHelp.closeHabboWay();
            _habboHelp.closeSafetyBooklet();
            showWindow(_local_2.quizCode, _local_2.questionIds);
        }

        private function onQuizResults(_arg_1:QuizResultsMessageEvent):void
        {
            var _local_2:QuizResultsMessageParser = _arg_1.getParser();
            _questionIdsForWrongAnswers = _local_2.questionIdsForWrongAnswers;
            if (_questionIdsForWrongAnswers.length == 0)
            {
                showPage(2);
            }
            else
            {
                showPage(3);
            };
        }

        private function showWindow(_arg_1:String, _arg_2:Array):void
        {
            closeWindow();
            _SafeStr_1665 = _habboHelp.getModalXmlWindow("habbo_way_quiz");
            _window = IWindowContainer(_SafeStr_1665.rootWindow);
            _window.procedure = onWindowEvent;
            _SafeStr_2694 = IWindowContainer(_window.findChildByName("question_pane"));
            _SafeStr_2695 = ISelectorListWindow(_SafeStr_2694.findChildByName("answer_list"));
            _SafeStr_2696 = _SafeStr_2695.getSelectableAt(0);
            _SafeStr_2695.removeSelectable(_SafeStr_2696);
            _SafeStr_2697 = IItemListWindow(_window.findChildByName("analysis_pane"));
            _SafeStr_2698 = _SafeStr_2697.getListItemAt(0);
            _SafeStr_2697.removeListItems();
            _SafeStr_2697.spacing = 4;
            _SafeStr_2699 = _arg_1;
            _SafeStr_2700 = _arg_2;
            _SafeStr_2701 = new Array(questionCount);
            _answerOrders = new Array(questionCount);
            setCurrentQuestion(0);
            var _local_3:IWindowContainer = IWindowContainer(IItemListWindow(_SafeStr_2698).getListItemByName("explanation_container"));
            switch (_SafeStr_2699)
            {
                case "HabboWay1":
                    IStaticBitmapWrapperWindow(_window.findChildByName("question_illustration")).assetUri = "${image.library.url}habboway/quiz_question.png";
                    IStaticBitmapWrapperWindow(_window.findChildByName("indicator_image")).assetUri = "help_habboway_dove_on";
                    IStaticBitmapWrapperWindow(_window.findChildByName("success_illustration")).assetUri = "${image.library.url}habboway/quiz_success.png";
                    IStaticBitmapWrapperWindow(_local_3.findChildByName("explanation_illustration")).assetUri = "help_habboway_dove_quizz";
                    break;
                case "SafetyQuiz1":
                    IStaticBitmapWrapperWindow(_window.findChildByName("question_illustration")).assetUri = "${image.library.url}safetyquiz/question_illustration.png";
                    IStaticBitmapWrapperWindow(_window.findChildByName("indicator_image")).assetUri = "${image.library.url}safetyquiz/safety_on.png";
                    IStaticBitmapWrapperWindow(_window.findChildByName("failure_illustration")).assetUri = "${image.library.url}safetyquiz/result_failure.png";
                    IStaticBitmapWrapperWindow(_window.findChildByName("success_illustration")).assetUri = "${image.library.url}safetyquiz/result_success.png";
                    IStaticBitmapWrapperWindow(_local_3.findChildByName("explanation_illustration")).assetUri = "${image.library.url}safetyquiz/safety_on.png";
                    break;
                default:
            };
            showPage(1);
        }

        private function closeWindow():void
        {
            _window = null;
            if (_SafeStr_1665 != null)
            {
                _SafeStr_1665.dispose();
                _SafeStr_1665 = null;
            };
        }

        private function showPage(_arg_1:int):void
        {
            var _local_5:int;
            var _local_2:int;
            var _local_8:IItemListWindow;
            var _local_6:String;
            var _local_9:String;
            _window.findChildByName("question_pane").visible = (_arg_1 == 1);
            _window.findChildByName("success_pane").visible = (_arg_1 == 2);
            _window.findChildByName("failure_pane").visible = (_arg_1 == 3);
            _SafeStr_2697.visible = (_arg_1 == 4);
            _window.findChildByName("prev_next_buttons").visible = (_arg_1 == 1);
            _window.findChildByName("failure_buttons").visible = (_arg_1 == 3);
            _window.findChildByName("exit_button_container").visible = ((_arg_1 == 2) || (_arg_1 == 4));
            var _local_3:IWindow = _window.findChildByName("top_indicator");
            var _local_7:IWindow = _window.findChildByName("indicator_image");
            switch (_arg_1)
            {
                case 1:
                    _window.caption = getFullLocalizationKey("question.title");
                    _local_7.visible = true;
                    _local_3.visible = true;
                    _local_3.caption = _habboHelp.localization.getLocalizationWithParams(getRawLocalizationKey("question.page"), "", "current_page", 1, "page_count", questionCount.toString());
                    _local_3.caption = getFullLocalizationKey("question.page");
                    return;
                case 2:
                    _window.caption = getFullLocalizationKey("success.title");
                    _window.findChildByName("failure_advice").caption = getFullLocalizationKey("failure.advice");
                    _window.findChildByName("success_results").caption = _habboHelp.localization.getLocalizationWithParams(getRawLocalizationKey("success.results"), "", "question_count", questionCount.toString());
                    _local_7.visible = false;
                    _local_3.visible = false;
                    _local_3.caption = "";
                    return;
                case 3:
                    _local_5 = (_SafeStr_2700.length - _questionIdsForWrongAnswers.length);
                    _window.caption = getFullLocalizationKey("failure.title");
                    _window.findChildByName("failure_advice").caption = getFullLocalizationKey("failure.advice");
                    _window.findChildByName("failure_results").caption = _habboHelp.localization.getLocalizationWithParams(getRawLocalizationKey("failure.results"), "", "correct_count", _local_5.toString(), "total_count", questionCount.toString());
                    _local_7.visible = false;
                    _local_3.visible = false;
                    _local_3.caption = "";
                    return;
                case 4:
                    _window.caption = getFullLocalizationKey("analysis.title");
                    _local_7.visible = true;
                    _local_3.visible = true;
                    _local_3.caption = getFullLocalizationKey("analysis.top");
                    for each (var _local_4:int in _questionIdsForWrongAnswers)
                    {
                        _local_2 = _SafeStr_2701[_SafeStr_2700.indexOf(_local_4)];
                        _local_8 = IItemListWindow(_SafeStr_2698.clone());
                        _local_6 = (("${quiz." + _SafeStr_2699) + ".");
                        _local_9 = (((("." + _local_4) + ".") + _local_2) + "}");
                        _local_8.getListItemByName("question").caption = (((_local_6 + "question.") + _local_4) + "}");
                        IWindowContainer(_local_8.getListItemByName("answer_container")).findChildByName("answer").caption = ((_local_6 + "answer") + _local_9);
                        IWindowContainer(_local_8.getListItemByName("explanation_container")).findChildByName("explanation").caption = ((_local_6 + "explanation") + _local_9);
                        _SafeStr_2697.addListItem(_local_8);
                    };
                    IItemListWindow(_SafeStr_2697.getListItemAt((_SafeStr_2697.numListItems - 1))).getListItemByName("separator").dispose();
                default:
            };
        }

        private function onWindowEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if ((((_disposed) || (_window == null)) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            if ((_arg_2 is ISelectableWindow))
            {
                _SafeStr_2701[_currentQuestion] = _arg_2.name;
                _window.findChildByName("next_dimmer").visible = false;
            }
            else
            {
                switch (_arg_2.name)
                {
                    case "header_button_close":
                    case "exit_button":
                        closeWindow();
                        return;
                    case "prev_button":
                        setCurrentQuestion((_currentQuestion - 1));
                        return;
                    case "next_button":
                        setCurrentQuestion((_currentQuestion + 1));
                        return;
                    case "review_button":
                        showPage(4);
                        return;
                };
            };
        }

        private function setCurrentQuestion(_arg_1:int):void
        {
            var _local_3:int;
            var _local_10:Array;
            var _local_2:int;
            var _local_4:String;
            var _local_6:ISelectableWindow;
            var _local_7:int;
            var _local_5:ISelectableWindow;
            var _local_9:ISelectableWindow;
            if (_arg_1 >= questionCount)
            {
                _habboHelp.sendMessage(new PostQuizAnswersComposer(_SafeStr_2699, _SafeStr_2701));
            }
            else
            {
                if (_arg_1 >= 0)
                {
                    _currentQuestion = _arg_1;
                    _window.findChildByName("prev_dimmer").visible = (_arg_1 <= 0);
                    _window.findChildByName("next_dimmer").visible = (_SafeStr_2701[_currentQuestion] == null);
                    _window.findChildByName("top_indicator").caption = _habboHelp.localization.getLocalizationWithParams(getRawLocalizationKey("question.page"), "", "current_page", (_arg_1 + 1), "page_count", questionCount.toString());
                    while (_SafeStr_2695.numSelectables > 0)
                    {
                        _SafeStr_2695.removeSelectable(_SafeStr_2695.getSelectableAt(0)).dispose();
                    };
                    _local_3 = _SafeStr_2700[_currentQuestion];
                    _local_10 = [];
                    _SafeStr_2694.findChildByName("question").caption = (((("${quiz." + _SafeStr_2699) + ".question.") + _local_3) + "}");
                    _local_2 = 0;
                    while (true)
                    {
                        _local_4 = _habboHelp.localization.getLocalization(((((("quiz." + _SafeStr_2699) + ".answer.") + _local_3) + ".") + _local_2), "");
                        if (_local_4.length > 0)
                        {
                            _local_6 = ISelectableWindow(_SafeStr_2696.clone());
                            _local_6.caption = _local_4;
                            _local_6.name = _local_2.toString();
                            _local_10.push(_local_6);
                        }
                        else
                        {
                            break;
                        };
                        _local_2++;
                    };
                    if (_answerOrders[_currentQuestion] == null)
                    {
                        _answerOrders[_currentQuestion] = [];
                        _local_7 = 0;
                        while (_local_7 < _local_2)
                        {
                            _local_5 = _local_10.splice(int((Math.random() * _local_10.length)), 1)[0];
                            _SafeStr_2695.addSelectable(_local_5);
                            _answerOrders[_currentQuestion].push(_local_5.name);
                            _local_7++;
                        };
                    }
                    else
                    {
                        for each (var _local_8:int in _answerOrders[_currentQuestion])
                        {
                            _SafeStr_2695.addSelectable(_local_10[_local_8]);
                        };
                    };
                    _local_9 = _SafeStr_2695.getSelectableByName(_SafeStr_2701[_currentQuestion]);
                    if (_local_9 != null)
                    {
                        _local_9.select();
                    };
                };
            };
        }

        private function get questionCount():int
        {
            return ((_SafeStr_2700 != null) ? _SafeStr_2700.length : 0);
        }

        private function getFullLocalizationKey(_arg_1:String):String
        {
            return (("${" + getRawLocalizationKey(_arg_1)) + "}");
        }

        private function getRawLocalizationKey(_arg_1:String):String
        {
            switch (_SafeStr_2699)
            {
                case "HabboWay1":
                    return ("habbo.way.quiz." + _arg_1);
                default:
                    return ((("quiz." + _SafeStr_2699) + ".") + _arg_1);
            };
        }


    }
}

