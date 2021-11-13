package com.sulake.habbo.friendbar.groupforums
{
    import flash.utils.Timer;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.parser.groupforums.ForumData;
    import com.sulake.habbo.communication.messages.parser.groupforums.ThreadData;
    import com.sulake.habbo.communication.messages.parser.groupforums.MessageData;
    import com.sulake.core.window.components.IRegionWindow;
    import flash.events.TimerEvent;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.utils.getTimer;
    import com.sulake.habbo.utils.FriendlyTime;

    public class ComposeMessageView 
    {

        public static const SUBJECT_MIN_LENGTH:int = 10;
        public static const SUBJECT_MAX_LENGTH:int = 120;
        public static const MESSAGE_MIN_LENGTH:int = 10;
        public static const MESSAGE_MAX_LENGTH:int = 4000;
        public static const _SafeStr_2233:int = 30000;

        private var _SafeStr_1284:GroupForumController;
        private var _SafeStr_461:GroupForumView;
        private var _SafeStr_1163:Timer;
        private var _window:IFrameWindow;
        private var _SafeStr_2234:ITextFieldWindow;
        private var _SafeStr_1982:ITextFieldWindow;
        private var _postButton:IWindow;
        private var _status:IWindow;
        private var _SafeStr_2235:ForumData;
        private var _SafeStr_2236:ThreadData;
        private var _hasErrors:Boolean = false;
        private var _SafeStr_2237:Boolean = false;

        public function ComposeMessageView(_arg_1:GroupForumView, _arg_2:int, _arg_3:int, _arg_4:ForumData, _arg_5:ThreadData, _arg_6:MessageData)
        {
            _SafeStr_461 = _arg_1;
            _SafeStr_1284 = _SafeStr_461.controller;
            _SafeStr_2235 = _arg_4;
            _SafeStr_2236 = _arg_5;
            _window = IFrameWindow(_SafeStr_1284.windowManager.buildFromXML(XML(new HabboFriendBarCom.groupforum_compose_message_xml())));
            _window.x = _arg_2;
            var _local_7:int = _SafeStr_1284.windowManager.getDesktop(1).width;
            if ((_window.x + _window.width) > _local_7)
            {
                _window.x = (_local_7 - _window.width);
            };
            _window.y = _arg_3;
            initControls(_arg_6);
            if (_status.caption.length == 0)
            {
                _status.caption = _SafeStr_1284.localizationManager.getLocalization("groupforum.compose.reply_hint");
            };
            _SafeStr_1163 = new Timer(1000, 0);
            _SafeStr_1163.addEventListener("timer", onTimerEvent);
            _SafeStr_1163.start();
        }

        public function focus(_arg_1:ForumData, _arg_2:ThreadData, _arg_3:MessageData):void
        {
            if (!_SafeStr_2237)
            {
                _SafeStr_2235 = _arg_1;
                if (((!(_SafeStr_2236 == null)) && (_arg_2 == null)))
                {
                    _SafeStr_2234.text = "";
                };
                _SafeStr_2236 = _arg_2;
                initControls(_arg_3);
            };
            _window.activate();
        }

        private function initControls(_arg_1:MessageData):void
        {
            var _local_3:IRegionWindow = GroupForumView.initTopAreaForForum(_window, _SafeStr_2235);
            _local_3.removeEventListener("WME_CLICK", onTopAreaClick);
            _local_3.addEventListener("WME_CLICK", onTopAreaClick);
            var _local_5:IWindow = _window.findChildByName("thread_subject_header");
            _SafeStr_2234 = (_window.findChildByName("thread_subject") as ITextFieldWindow);
            if (_SafeStr_2236)
            {
                _local_5.caption = _SafeStr_1284.localizationManager.getLocalization("groupforum.compose.subject_replying_to");
                _SafeStr_2234.text = _SafeStr_2236.header;
                _SafeStr_2234.disable();
            }
            else
            {
                _local_5.caption = _SafeStr_1284.localizationManager.getLocalization("groupforum.compose.subject");
                _SafeStr_2234.addEventListener("WKE_KEY_UP", onHeaderKeyUpEvent);
                _SafeStr_2234.maxChars = 120;
                _SafeStr_2234.enable();
            };
            _SafeStr_1982 = (_window.findChildByName("message_text") as ITextFieldWindow);
            _SafeStr_1982.removeEventListener("WKE_KEY_UP", onMessageKeyUpEvent);
            _SafeStr_1982.addEventListener("WKE_KEY_UP", onMessageKeyUpEvent);
            _SafeStr_1982.maxChars = 4000;
            if (_arg_1 != null)
            {
                addQuote(_arg_1);
            };
            var _local_2:IWindow = _window.findChildByName("cancel_btn");
            _local_2.removeEventListener("WME_CLICK", onCancelButtonClick);
            _local_2.addEventListener("WME_CLICK", onCancelButtonClick);
            var _local_4:IWindow = _window.findChildByName("header_button_close");
            _local_4.removeEventListener("WME_CLICK", onCancelButtonClick);
            _local_4.addEventListener("WME_CLICK", onCancelButtonClick);
            _postButton = _window.findChildByName("post_btn");
            _postButton.removeEventListener("WME_CLICK", onPostButtonClick);
            _postButton.addEventListener("WME_CLICK", onPostButtonClick);
            _status = _window.findChildByName("status_text");
            validateInputs();
        }

        private function addQuote(_arg_1:MessageData):void
        {
            var _local_2:*;
            var _local_4:StringBuffer = new StringBuffer();
            _local_4.add(_SafeStr_1982.text);
            if (_local_4.length > 0)
            {
                _local_4.add("\r\r");
            };
            _local_4.add(_SafeStr_1284.localizationManager.getLocalizationWithParams("groupforum.compose.reply_template", "", "author_name", _arg_1.authorName, "creation_time", _SafeStr_461.getAsDaysHoursMinutes(_arg_1.creationTimeAsSecondsAgo)));
            _local_4.add("\r");
            var _local_5:Array = _arg_1.messageText.split("\r");
            var _local_6:Boolean;
            for each (var _local_3:String in _local_5)
            {
                _local_2 = MessageListView._SafeStr_631.exec(_local_3);
                if (_local_2 != null)
                {
                    if (!_local_6)
                    {
                        _local_6 = true;
                        _local_4.add("> ").add(_SafeStr_1284.localizationManager.getLocalization("groupforum.compose.skipped_quote")).add("\r");
                    };
                }
                else
                {
                    _local_4.add("> ").add(_local_3).add("\r");
                    _local_6 = false;
                };
            };
            _local_4.add("\r");
            _SafeStr_1982.text = _local_4.toString();
        }

        public function dispose():void
        {
            _SafeStr_1163.stop();
            _SafeStr_1163.removeEventListener("timer", onTimerEvent);
            _SafeStr_1163 = null;
            _SafeStr_1284.composeMessageView = null;
            _window.dispose();
            _window = null;
        }

        private function onTimerEvent(_arg_1:TimerEvent):void
        {
            validateInputs();
        }

        private function onHeaderKeyUpEvent(_arg_1:WindowKeyboardEvent):void
        {
            validateInputs();
        }

        private function onMessageKeyUpEvent(_arg_1:WindowKeyboardEvent):void
        {
            validateInputs();
        }

        private function onTopAreaClick(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1284.context.createLinkEvent(("group/" + _SafeStr_2235.groupId));
        }

        private function onPostButtonClick(_arg_1:WindowMouseEvent):void
        {
            if (_SafeStr_2237)
            {
                return;
            };
            validateInputs();
            if (_hasErrors)
            {
                return;
            };
            _SafeStr_2237 = true;
            _SafeStr_2234.disable();
            _SafeStr_1982.disable();
            _postButton.disable();
            _status.caption = _SafeStr_1284.localizationManager.getLocalization("groupforum.compose.posting");
            if (_SafeStr_2236)
            {
                _SafeStr_1284.postNewMessage(_SafeStr_2235.groupId, _SafeStr_2236.threadId, _SafeStr_1982.text);
            }
            else
            {
                _SafeStr_1284.postNewThread(_SafeStr_2235.groupId, _SafeStr_2234.text, _SafeStr_1982.text);
            };
        }

        private function onCancelButtonClick(_arg_1:WindowMouseEvent):void
        {
            dispose();
        }

        private function validateInputs():void
        {
            var _local_1:int;
            _hasErrors = false;
            if (!_SafeStr_2236)
            {
                if (_SafeStr_2234.text.length <= 10)
                {
                    _hasErrors = true;
                    _status.caption = _SafeStr_1284.localizationManager.getLocalization("groupforum.compose.subject_too_short");
                };
            };
            if (((!(_hasErrors)) && (_SafeStr_1982.text.length <= 10)))
            {
                _hasErrors = true;
                _status.caption = _SafeStr_1284.localizationManager.getLocalization("groupforum.compose.message_too_short");
            };
            if (((!(_hasErrors)) && (!(_SafeStr_2237))))
            {
                _local_1 = (getTimer() - _SafeStr_1284.lastPostTime);
                if (_local_1 < 30000)
                {
                    _hasErrors = true;
                    _status.caption = _SafeStr_1284.localizationManager.getLocalizationWithParams("groupforum.compose.post_cooldown", "", "time_remaining", FriendlyTime.getFriendlyTime(_SafeStr_1284.localizationManager, (((30000 - _local_1) / 1000) + 1), "", 1));
                };
            };
            if (((!(_SafeStr_2237)) && (!(_hasErrors))))
            {
                _postButton.enable();
                _status.caption = "";
            }
            else
            {
                _postButton.disable();
            };
        }


    }
}

