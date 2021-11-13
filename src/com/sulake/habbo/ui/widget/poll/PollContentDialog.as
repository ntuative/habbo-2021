package com.sulake.habbo.ui.widget.poll
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.parser.poll.PollQuestion;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.parser.poll.PollChoice;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.core.window.components._SafeStr_108;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPollMessage;

    public class PollContentDialog implements IPollDialog 
    {

        private var _SafeStr_698:int = -1;
        private var _disposed:Boolean = false;
        private var _window:IFrameWindow;
        private var _SafeStr_1324:PollWidget;
        private var _SafeStr_4226:IFrameWindow;
        private var _SafeStr_4227:Boolean = false;
        private var _SafeStr_4228:Array;
        private var _question:int = -1;
        private var _SafeStr_4229:int = 0;
        private var _SafeStr_4230:int = -1;
        private var _SafeStr_4231:Boolean = false;
        private var _SafeStr_4232:int = 0;
        private var _currentQuestion:PollQuestion = null;

        public function PollContentDialog(_arg_1:int, _arg_2:String, _arg_3:Array, _arg_4:PollWidget, _arg_5:Boolean)
        {
            super();
            var _local_8:ITextWindow = null;
            var _local_7:IWindow = null;
            var _local_9:IWindow = null;
            var _local_6:IWindow = null;
            _SafeStr_698 = _arg_1;
            _SafeStr_4228 = _arg_3;
            _SafeStr_1324 = _arg_4;
            _SafeStr_4231 = _arg_5;
            answerableQuestionCount();
            var _local_10:XmlAsset = (_SafeStr_1324.assets.getAssetByName("poll_question") as XmlAsset);
            if (_local_10 != null)
            {
                _window = (_SafeStr_1324.windowManager.buildFromXML((_local_10.content as XML)) as IFrameWindow);
                _local_8 = (_window.findChildByName("poll_question_headline") as ITextWindow);
                if (_local_8)
                {
                    _local_8.text = _arg_2;
                };
                _window.center();
                _local_7 = _window.findChildByName("header_button_close");
                if (_local_7 != null)
                {
                    _local_7.addEventListener("WME_CLICK", onClose);
                };
                _local_9 = _window.findChildByName("poll_question_button_ok");
                if (_local_9 != null)
                {
                    _local_9.addEventListener("WME_CLICK", onOk);
                };
                _local_6 = _window.findChildByName("poll_question_cancel");
                if (_local_6 != null)
                {
                    _local_6.addEventListener("WME_CLICK", onCancel);
                };
            };
        }

        public function start():void
        {
            if (!_SafeStr_4227)
            {
                _SafeStr_4227 = true;
                nextQuestion();
            };
        }

        private function onClose(_arg_1:WindowEvent):void
        {
            showCancelConfirm();
        }

        private function onOk(_arg_1:WindowEvent):void
        {
            answerPollQuestion();
        }

        private function onCancel(_arg_1:WindowEvent):void
        {
            showCancelConfirm();
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _disposed = true;
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            if (_SafeStr_4226)
            {
                _SafeStr_4226.dispose();
                _SafeStr_4226 = null;
            };
            _SafeStr_1324 = null;
            _SafeStr_4228 = null;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        private function nextQuestion():void
        {
            var _local_5:ITextWindow;
            var _local_1:IWindowContainer;
            var _local_2:String;
            var _local_4:IItemListWindow;
            var _local_3:int;
            _currentQuestion = getNextQuestion();
            if (_currentQuestion)
            {
                if (_window != null)
                {
                    _local_5 = (_window.findChildByName("poll_question_text") as ITextWindow);
                    if (_local_5 != null)
                    {
                        _local_5.text = _currentQuestion.questionText;
                    };
                    _local_5 = (_window.findChildByName("poll_question_number") as ITextWindow);
                    if (_local_5 != null)
                    {
                        _local_5.text = "${poll_question_number}";
                        _local_2 = _local_5.text;
                        _local_2 = _local_2.replace("%number%", (_question + 1));
                        _local_2 = _local_2.replace("%count%", _SafeStr_4229);
                        _local_5.text = _local_2;
                    };
                    _local_1 = (_window.findChildByName("poll_question_answer_container") as IWindowContainer);
                    if (_local_1 != null)
                    {
                        while (_local_1.numChildren > 0)
                        {
                            _local_1.getChildAt(0).dispose();
                        };
                        _local_1.invalidate();
                    };
                    switch (_currentQuestion.questionType)
                    {
                        case 1:
                            populateRadionButtonType(_local_1, _currentQuestion.questionChoices);
                            break;
                        case 2:
                            populateCheckBoxType(_local_1, _currentQuestion.questionChoices);
                            break;
                        case 3:
                            populateTextLineType(_local_1);
                            break;
                        case 4:
                            populateTextAreaType(_local_1);
                            break;
                        default:
                            nextQuestion();
                    };
                    _local_4 = (_window.findChildByName("poll_content_wrapper") as IItemListWindow);
                    if (_local_4 != null)
                    {
                        _local_3 = (_local_4.scrollableRegion.height - _local_4.visibleRegion.height);
                        _window.height = (_window.height + _local_3);
                        _window.center();
                    };
                };
            }
            else
            {
                _SafeStr_1324.pollFinished(_SafeStr_698);
            };
        }

        private function getNextQuestion():PollQuestion
        {
            var _local_1:PollQuestion;
            var _local_3:int;
            var _local_2:PollQuestion;
            if ((((_SafeStr_4231) && (_SafeStr_4230 >= 0)) && (!(_SafeStr_4232 == 0))))
            {
                _local_1 = _SafeStr_4228[_SafeStr_4230];
                _local_3 = 0;
                while (_local_3 < _local_1.children.length)
                {
                    _local_2 = _local_1.children[_local_3];
                    if (((_local_2) && (_local_2.questionCategory == _SafeStr_4232)))
                    {
                        _SafeStr_4230 = -1;
                        return (_local_2);
                    };
                    _local_3++;
                };
            };
            _question++;
            if (_question < _SafeStr_4228.length)
            {
                _SafeStr_4230 = _question;
                return (_SafeStr_4228[_question]);
            };
            return (null);
        }

        private function populateRadionButtonType(_arg_1:IWindowContainer, _arg_2:Vector.<PollChoice>):void
        {
            var _local_3:XmlAsset = (_SafeStr_1324.assets.getAssetByName("poll_answer_radiobutton_input") as XmlAsset);
            if (!_local_3)
            {
                throw (new Error('Asset for poll widget hot found: "poll_answer_radiobutton_input"!'));
            };
            var _local_4:IWindowContainer = (_SafeStr_1324.windowManager.buildFromXML((_local_3.content as XML)) as IWindowContainer);
            if (_local_4 != null)
            {
                populateSelectionList(_arg_2, _local_4);
                _arg_1.addChild(_local_4);
            };
        }

        private function resolveRadionButtonTypeAnswer(_arg_1:PollQuestion):Array
        {
            var _local_3:ISelectorWindow;
            var _local_4:ISelectableWindow;
            var _local_5:PollChoice;
            var _local_2:Array = [];
            if (_window != null)
            {
                _local_3 = (_window.findChildByName("poll_answer_selector") as ISelectorWindow);
                if (_local_3)
                {
                    _local_4 = _local_3.getSelected();
                    if (_local_4)
                    {
                        _local_5 = _arg_1.questionChoices[_local_4.id];
                        if (_SafeStr_4231)
                        {
                            _SafeStr_4232 = _local_5.choiceType;
                        }
                        else
                        {
                            _SafeStr_4232 = 0;
                        };
                        _local_2.push(_local_5.value);
                    };
                };
            };
            return (_local_2);
        }

        private function populateCheckBoxType(_arg_1:IWindowContainer, _arg_2:Vector.<PollChoice>):void
        {
            var _local_3:XmlAsset = (_SafeStr_1324.assets.getAssetByName("poll_answer_checkbox_input") as XmlAsset);
            if (!_local_3)
            {
                throw (new Error('Asset for poll widget hot found: "poll_answer_checkbox_input"!'));
            };
            var _local_4:IWindowContainer = (_SafeStr_1324.windowManager.buildFromXML((_local_3.content as XML)) as IWindowContainer);
            if (_local_4 != null)
            {
                populateSelectionList(_arg_2, _local_4);
                _arg_1.addChild(_local_4);
            };
        }

        private function resolveCheckBoxTypeAnswer(_arg_1:PollQuestion):Array
        {
            var _local_5:IItemListWindow;
            var _local_3:int;
            var _local_6:IWindowContainer;
            var _local_4:_SafeStr_108;
            var _local_2:Array = [];
            if (_window != null)
            {
                _local_5 = (_window.findChildByName("poll_answer_itemlist") as IItemListWindow);
                if (_local_5 != null)
                {
                    _local_3 = 0;
                    while (_local_3 < _local_5.numListItems)
                    {
                        _local_6 = (_local_5.getListItemAt(_local_3) as IWindowContainer);
                        if (_local_6 != null)
                        {
                            _local_4 = (_local_6.findChildByName("poll_answer_checkbox") as _SafeStr_108);
                            if (_local_4 != null)
                            {
                                if (_local_4.testStateFlag(8))
                                {
                                    _local_2.push(_arg_1.questionChoices[_local_3].value);
                                };
                            };
                        };
                        _local_3++;
                    };
                };
            };
            return (_local_2);
        }

        private function populateSelectionList(_arg_1:Vector.<PollChoice>, _arg_2:IWindowContainer):void
        {
            var _local_7:IWindowContainer;
            var _local_4:int;
            var _local_5:ITextWindow;
            var _local_3:IWindow;
            var _local_6:IItemListWindow = (_arg_2.findChildByName("poll_answer_itemlist") as IItemListWindow);
            if (_local_6 != null)
            {
                _local_7 = (_arg_2.findChildByName("poll_answer_entity") as IWindowContainer);
                if (_local_7 != null)
                {
                    _local_4 = 0;
                    while (_local_4 < (_arg_1.length - 1))
                    {
                        _local_4++;
                        _local_6.addListItem(_local_7.clone());
                    };
                    _local_4 = 0;
                    while (_local_4 < _arg_1.length)
                    {
                        _local_7 = (_local_6.getListItemAt(_local_4) as IWindowContainer);
                        _local_5 = (_local_7.findChildByName("poll_answer_entity_text") as ITextWindow);
                        if (_local_5)
                        {
                            _local_5.text = _arg_1[_local_4].choiceText;
                        };
                        _local_3 = _local_7.findChildByTag("POLL_SELECTABLE_ITEM");
                        if (_local_3)
                        {
                            _local_3.id = _local_4;
                        };
                        _local_4++;
                    };
                };
            };
        }

        private function populateTextLineType(_arg_1:IWindowContainer):void
        {
            var _local_2:XmlAsset = (_SafeStr_1324.assets.getAssetByName("poll_answer_text_input") as XmlAsset);
            if (!_local_2)
            {
                throw (new Error('Asset for poll widget hot found: "poll_answer_text_input"!'));
            };
            _arg_1.addChild(_SafeStr_1324.windowManager.buildFromXML((_local_2.content as XML)));
        }

        private function resolveTextLineTypeAnswer():Array
        {
            var _local_2:ITextWindow;
            var _local_1:Array = [];
            if (_window != null)
            {
                _local_2 = (_window.findChildByName("poll_answer_input") as ITextWindow);
                if (_local_2 != null)
                {
                    _local_1.push(_local_2.text);
                };
            }
            else
            {
                throw (new Error("Invalid or disposed poll dialog!"));
            };
            return (_local_1);
        }

        private function populateTextAreaType(_arg_1:IWindowContainer):void
        {
            populateTextLineType(_arg_1);
        }

        private function resolveTextAreaTypeAnswer():Array
        {
            return (resolveTextLineTypeAnswer());
        }

        private function cancelPoll():void
        {
            _SafeStr_1324.pollCancelled(_SafeStr_698);
        }

        private function answerPollQuestion():void
        {
            var question:PollQuestion;
            if (((_SafeStr_4231) && (_currentQuestion)))
            {
                question = _currentQuestion;
            }
            else
            {
                question = _SafeStr_4228[_question];
            };
            _SafeStr_4232 = 0;
            switch (question.questionType)
            {
                case 1:
                    var answerArray:Array = resolveRadionButtonTypeAnswer(question);
                    break;
                case 2:
                    answerArray = resolveCheckBoxTypeAnswer(question);
                    if (answerArray.length < 0)
                    {
                        _SafeStr_1324.windowManager.alert("${win_error}", "${poll_alert_answer_missing}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                        {
                            _arg_1.dispose();
                        });
                        return;
                    };
                    if (answerArray.length > question.questionChoices.length)
                    {
                        _SafeStr_1324.windowManager.alert("${win_error}", "${poll_alert_invalid_selection}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                        {
                            _arg_1.dispose();
                        });
                        return;
                    };
                    break;
                case 3:
                    answerArray = resolveTextLineTypeAnswer();
                    break;
                case 4:
                    answerArray = resolveTextAreaTypeAnswer();
                    break;
                default:
                    throw (new Error((("Unknown poll question type: " + question.questionType) + "!")));
            };
            var answers:Array = [];
            var message:RoomWidgetPollMessage = new RoomWidgetPollMessage("RWPM_ANSWER", _SafeStr_698);
            message.questionId = question.questionId;
            if (question.questionChoices.length > 0)
            {
                for each (var answerValue:int in answerArray)
                {
                    answers.push(answerValue);
                };
            }
            else
            {
                answers.push(answerArray);
            };
            message.answers = answers;
            _SafeStr_1324.messageListener.processWidgetMessage(message);
            nextQuestion();
        }

        private function showCancelConfirm():void
        {
            var _local_4:XmlAsset;
            var _local_2:IWindow;
            var _local_3:IWindow;
            var _local_1:IWindow;
            if (!_SafeStr_4226)
            {
                _local_4 = (_SafeStr_1324.assets.getAssetByName("poll_cancel_confirm") as XmlAsset);
                _SafeStr_4226 = (_SafeStr_1324.windowManager.buildFromXML((_local_4.content as XML), 2) as IFrameWindow);
                _SafeStr_4226.center();
                _local_2 = _SafeStr_4226.findChildByName("header_button_close");
                if (_local_2 != null)
                {
                    _local_2.addEventListener("WME_CLICK", onCancelPollClose);
                };
                _local_3 = _SafeStr_4226.findChildByName("poll_cancel_confirm_button_ok");
                if (_local_3 != null)
                {
                    _local_3.addEventListener("WME_CLICK", onCancelPollOk);
                };
                _local_1 = _SafeStr_4226.findChildByName("poll_cancel_confirm_button_cancel");
                if (_local_1 != null)
                {
                    _local_1.addEventListener("WME_CLICK", onCancelPollCancel);
                };
            };
        }

        private function hideCancelConfirm():void
        {
            if (_SafeStr_4226 != null)
            {
                _SafeStr_4226.dispose();
                _SafeStr_4226 = null;
            };
        }

        private function onCancelPollClose(_arg_1:WindowEvent):void
        {
            hideCancelConfirm();
        }

        private function onCancelPollOk(_arg_1:WindowEvent):void
        {
            hideCancelConfirm();
            cancelPoll();
        }

        private function onCancelPollCancel(_arg_1:WindowEvent):void
        {
            hideCancelConfirm();
        }

        private function answerableQuestionCount():void
        {
            _SafeStr_4229 = _SafeStr_4228.length;
            for each (var _local_1:PollQuestion in _SafeStr_4228)
            {
                if (_local_1.children.length > 0)
                {
                    _SafeStr_4229++;
                };
            };
        }


    }
}

