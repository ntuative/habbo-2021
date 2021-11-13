package com.sulake.habbo.help
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.incoming.help.GuideTicketResolutionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.GuideTicketCreationResultMessageEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class ChatReviewReporterFeedbackCtrl implements IDisposable 
    {

        private var _habboHelp:HabboHelp;
        private var _window:IFrameWindow;

        public function ChatReviewReporterFeedbackCtrl(_arg_1:HabboHelp)
        {
            _habboHelp = _arg_1;
            _habboHelp.communicationManager.addHabboConnectionMessageEvent(new GuideTicketResolutionMessageEvent(onTicketResolved));
            _habboHelp.communicationManager.addHabboConnectionMessageEvent(new GuideTicketCreationResultMessageEvent(onCreateResult));
        }

        public function dispose():void
        {
            _habboHelp = null;
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_habboHelp == null);
        }

        private function onTicketResolved(_arg_1:GuideTicketResolutionMessageEvent):void
        {
            show(_arg_1.getParser().localizationCode);
        }

        private function onCreateResult(_arg_1:GuideTicketCreationResultMessageEvent):void
        {
            show(_arg_1.getParser().localizationCode);
        }

        public function show(_arg_1:String):void
        {
            if (!enabled)
            {
                return;
            };
            prepare();
            setText("caption_txt", _arg_1, "caption");
            setText("body_txt", _arg_1, "body");
            setText("note_txt", _arg_1, "note");
            var _local_2:ITextWindow = ITextWindow(_window.findChildByName("caption_txt"));
            _window.findChildByName("body_txt").y = ((_local_2.y + _local_2.textHeight) + 5);
            _window.visible = true;
        }

        private function setText(_arg_1:String, _arg_2:String, _arg_3:String):void
        {
            var _local_4:String = ((("guide.bully.request.reporter." + _arg_2) + ".") + _arg_3);
            if (_habboHelp.localization.getLocalization(_local_4, "") == "")
            {
                _local_4 = ("guide.bully.request.reporter." + _arg_3);
            };
            _window.findChildByName(_arg_1).caption = (("${" + _local_4) + "}");
        }

        private function prepare():void
        {
            if (_window != null)
            {
                return;
            };
            _window = IFrameWindow(_habboHelp.getXmlWindow("chat_review_reporter_feedback"));
            _window.procedure = windowProcedure;
            _window.center();
        }

        private function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if ((((!(_arg_1.type == "WME_CLICK")) || (_window == null)) || (_window.disposed)))
            {
                return;
            };
            if (((_arg_2.name == "close_button") || (_arg_2.name == "header_button_close")))
            {
                _window.visible = false;
            };
        }

        private function get enabled():Boolean
        {
            return (_habboHelp.getBoolean("chatreviewreporterfeedbackctrl.enabled"));
        }


    }
}