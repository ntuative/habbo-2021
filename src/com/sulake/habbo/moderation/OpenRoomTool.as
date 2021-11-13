package com.sulake.habbo.moderation
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.window.utils.IAlertDialog;

    public class OpenRoomTool 
    {

        private var _frame:IFrameWindow;
        private var _main:ModerationManager;
        private var _SafeStr_1907:int;

        public function OpenRoomTool(_arg_1:IFrameWindow, _arg_2:ModerationManager, _arg_3:IWindow, _arg_4:int)
        {
            _frame = _arg_1;
            _main = _arg_2;
            _SafeStr_1907 = _arg_4;
            _arg_3.procedure = onClick;
        }

        private function onClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            _main.windowTracker.show(new RoomToolCtrl(_main, _SafeStr_1907), _frame, false, false, true);
        }

        private function onAlertClose(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }


    }
}

