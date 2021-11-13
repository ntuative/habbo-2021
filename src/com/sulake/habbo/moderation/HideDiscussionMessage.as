package com.sulake.habbo.moderation
{
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.groupforums.ModerateMessageMessageComposer;
    import com.sulake.core.window.events.WindowEvent;

    public class HideDiscussionMessage 
    {

        private var _main:ModerationManager;
        private var _popup:ChatlogCtrl;
        private var _groupId:int;
        private var _SafeStr_2825:int;
        private var _SafeStr_2826:int;

        public function HideDiscussionMessage(_arg_1:ModerationManager, _arg_2:ChatlogCtrl, _arg_3:IWindow, _arg_4:int, _arg_5:int, _arg_6:int)
        {
            _main = _arg_1;
            _popup = _arg_2;
            _groupId = _arg_4;
            _SafeStr_2825 = _arg_5;
            _SafeStr_2826 = _arg_6;
            _arg_3.procedure = onClick;
        }

        private function onClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            _popup.dispose();
            _main.connection.send(new ModerateMessageMessageComposer(_groupId, _SafeStr_2825, _SafeStr_2826, 20));
        }


    }
}

