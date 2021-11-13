package com.sulake.habbo.window.utils
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components._SafeStr_101;

    public class AlertDialogWithLink extends AlertDialog implements IAlertDialogWithLink 
    {

        protected var _linkTitle:String = "";
        protected var _SafeStr_4396:String = "";

        public function AlertDialogWithLink(_arg_1:IHabboWindowManager, _arg_2:XML, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:String, _arg_7:uint, _arg_8:Function)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_7, _arg_8, false);
            this.linkTitle = _arg_5;
            this.linkUrl = _arg_6;
        }

        override protected function dialogEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "_alert_button_link":
                        HabboWebTools.navigateToURL(_SafeStr_4396, "_empty");
                        return;
                };
            };
            super.dialogEventProc(_arg_1, _arg_2);
        }

        public function set linkTitle(_arg_1:String):void
        {
            _linkTitle = _arg_1;
            if (_window)
            {
                _SafeStr_101(_window.findChildByTag("LINK")).caption = _linkTitle;
            };
        }

        public function get linkTitle():String
        {
            return (_linkTitle);
        }

        public function set linkUrl(_arg_1:String):void
        {
            _SafeStr_4396 = _arg_1;
        }

        public function get linkUrl():String
        {
            return (_SafeStr_4396);
        }


    }
}

