package com.sulake.habbo.moderation
{
    import com.sulake.core.window.IWindow;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import com.sulake.core.window.events.WindowEvent;

    public class OpenExternalLink 
    {

        private var _SafeStr_780:String;

        public function OpenExternalLink(_arg_1:ModerationManager, _arg_2:IWindow, _arg_3:String)
        {
            _arg_2.procedure = onClick;
            _SafeStr_780 = _arg_3;
        }

        private function onClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            navigateToURL(new URLRequest(_SafeStr_780), "_blank"); //not popped
        }


    }
}

