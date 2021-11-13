package com.sulake.habbo.util
{
    import com.sulake.habbo.moderation.ModerationManager;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer;
    import com.sulake.core.window.events.WindowEvent;

    public class VisitUserUtil 
    {

        private var _main:ModerationManager;
        private var _SafeStr_1887:int;

        public function VisitUserUtil(_arg_1:ModerationManager, _arg_2:IWindow, _arg_3:int)
        {
            _main = _arg_1;
            _SafeStr_1887 = _arg_3;
            _arg_2.procedure = onClick;
        }

        private function onClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            _main.connection.send(new FollowFriendMessageComposer(_SafeStr_1887));
        }


    }
}

