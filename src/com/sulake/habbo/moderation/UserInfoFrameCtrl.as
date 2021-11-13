package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;

    public class UserInfoFrameCtrl implements IDisposable, ITrackedWindow 
    {

        private var _main:ModerationManager;
        private var _SafeStr_1887:int;
        private var _frame:IFrameWindow;
        private var _disposed:Boolean;
        private var _SafeStr_2884:UserInfoCtrl;
        private var _SafeStr_2823:IssueMessageData;

        public function UserInfoFrameCtrl(_arg_1:ModerationManager, _arg_2:int, _arg_3:IssueMessageData=null)
        {
            _main = _arg_1;
            _SafeStr_1887 = _arg_2;
            _SafeStr_2823 = _arg_3;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function show():void
        {
            _frame = IFrameWindow(_main.getXmlWindow("user_info_frame"));
            _frame.caption = "User Info";
            var _local_1:IWindow = _frame.findChildByTag("close");
            _local_1.procedure = onClose;
            _SafeStr_2884 = new UserInfoCtrl(_frame, _main, _SafeStr_2823, null, true);
            _SafeStr_2884.load(_frame.content, _SafeStr_1887);
            _frame.visible = true;
        }

        public function getType():int
        {
            return (1);
        }

        public function getId():String
        {
            return ("" + _SafeStr_1887);
        }

        public function getFrame():IFrameWindow
        {
            return (_frame);
        }

        private function onClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            dispose();
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
            if (_SafeStr_2884 != null)
            {
                _SafeStr_2884.dispose();
                _SafeStr_2884 = null;
            };
            _SafeStr_2823 = null;
            _main = null;
        }


    }
}

