package com.sulake.habbo.moderation
{
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;

    public class OpenDiscussionMessage 
    {

        private var _main:ModerationManager;
        private var _groupId:int;
        private var _SafeStr_2825:int;
        private var _SafeStr_2826:int;

        public function OpenDiscussionMessage(_arg_1:ModerationManager, _arg_2:IWindow, _arg_3:int, _arg_4:int, _arg_5:int)
        {
            _main = _arg_1;
            _groupId = _arg_3;
            _SafeStr_2825 = _arg_4;
            _SafeStr_2826 = _arg_5;
            _arg_2.procedure = onClick;
        }

        private function onClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            _main.openThreadMessage(_groupId, _SafeStr_2825, _SafeStr_2826);
        }


    }
}

