package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModMessageMessageComposer;
    import com.sulake.habbo.window.utils.IAlertDialog;

    public class SendMsgsCtrl implements IDisposable, ITrackedWindow 
    {

        private static const TOPIC_ID_NOT_SELECTED:int = -999;

        private var _main:ModerationManager;
        private var _SafeStr_2866:int;
        private var _targetUserName:String;
        private var _SafeStr_2823:IssueMessageData;
        private var _frame:IFrameWindow;
        private var _SafeStr_2872:IDropMenuWindow;
        private var _SafeStr_2868:ITextFieldWindow;
        private var _disposed:Boolean;
        private var _placeHolderMessage:Boolean = true;

        public function SendMsgsCtrl(_arg_1:ModerationManager, _arg_2:int, _arg_3:String, _arg_4:IssueMessageData)
        {
            _main = _arg_1;
            _SafeStr_2866 = _arg_2;
            _targetUserName = _arg_3;
            _SafeStr_2823 = _arg_4;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function show():void
        {
            _frame = IFrameWindow(_main.getXmlWindow("send_msgs"));
            _frame.caption = ("Msg To: " + _targetUserName);
            _frame.findChildByName("send_message_but").procedure = onSendMessageButton;
            _SafeStr_2868 = ITextFieldWindow(_frame.findChildByName("message_input"));
            _SafeStr_2868.procedure = onInputClick;
            _SafeStr_2872 = IDropMenuWindow(_frame.findChildByName("msgTemplatesSelect"));
            prepareMessageSelection(_SafeStr_2872);
            _SafeStr_2872.procedure = onSelectTemplate;
            var _local_1:IWindow = _frame.findChildByTag("close");
            _local_1.procedure = onClose;
            _frame.visible = true;
        }

        public function getType():int
        {
            return (2);
        }

        public function getId():String
        {
            return (_targetUserName);
        }

        public function getFrame():IFrameWindow
        {
            return (_frame);
        }

        private function prepareMessageSelection(_arg_1:IDropMenuWindow):void
        {
            Logger.log(("MSG TEMPLATES: " + _main.initMsg.messageTemplates.length));
            _arg_1.populate(_main.initMsg.messageTemplates);
        }

        private function onSelectTemplate(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WE_SELECTED")
            {
                return;
            };
            var _local_3:String = _main.initMsg.messageTemplates[_SafeStr_2872.selection];
            if (_local_3 != null)
            {
                _placeHolderMessage = false;
                _SafeStr_2868.text = _local_3;
            };
        }

        private function onSendMessageButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            if (((_placeHolderMessage) || (_SafeStr_2868.text == "")))
            {
                _main.windowManager.alert("Alert", "You must input a message to the user", 0, onAlertClose);
                return;
            };
            Logger.log("Sending message...");
            _main.connection.send(new ModMessageMessageComposer(_SafeStr_2866, _SafeStr_2868.text, -999, ((_SafeStr_2823 != null) ? _SafeStr_2823.issueId : -1)));
            this.dispose();
        }

        private function onClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            dispose();
        }

        private function onInputClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WE_FOCUSED")
            {
                return;
            };
            if (_placeHolderMessage)
            {
                _SafeStr_2868.text = "";
                _placeHolderMessage = false;
            };
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _disposed = true;
            if (_frame != null)
            {
                _frame.destroy();
                _frame = null;
            };
            _SafeStr_2872 = null;
            _SafeStr_2868 = null;
            _main = null;
        }

        private function onAlertClose(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }


    }
}

