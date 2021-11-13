package com.sulake.habbo.window.utils
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class ConfirmDialog extends AlertDialog implements _SafeStr_126 
    {

        public function ConfirmDialog(_arg_1:IHabboWindowManager, _arg_2:XML, _arg_3:String, _arg_4:String, _arg_5:uint, _arg_6:Function, _arg_7:Boolean)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7);
        }

        override protected function dialogEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:WindowEvent;
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "_alert_button_ok":
                        if (_callback != null)
                        {
                            _local_3 = WindowEvent.allocate("WE_OK", null, null);
                            (_callback(this, _local_3));
                            _local_3.recycle();
                        };
                        return;
                    case "_alert_button_cancel":
                    case "header_button_close":
                        if (_callback != null)
                        {
                            _local_3 = WindowEvent.allocate("WE_CANCEL", null, null);
                            (_callback(this, _local_3));
                            _local_3.recycle();
                        };
                        return;
                };
            };
        }


    }
}

