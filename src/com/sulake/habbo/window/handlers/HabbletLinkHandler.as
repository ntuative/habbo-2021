package com.sulake.habbo.window.handlers
{
    import com.sulake.core.runtime.events.ILinkEventTracker;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.habbo.utils.HabboWebTools;

    public class HabbletLinkHandler implements ILinkEventTracker, IDisposable 
    {

        private var _windowManager:HabboWindowManagerComponent;

        public function HabbletLinkHandler(_arg_1:HabboWindowManagerComponent)
        {
            _windowManager = _arg_1;
        }

        public function get linkPattern():String
        {
            return ("habblet/");
        }

        public function linkReceived(_arg_1:String):void
        {
            var _local_3:String;
            var _local_2:Array = _arg_1.split("/");
            if (_local_2.length < 2)
            {
                return;
            };
            switch (_local_2[1])
            {
                case "open":
                    if (_local_2.length > 2)
                    {
                        _local_3 = _local_2[2];
                        if (_local_3 == "credits")
                        {
                            HabboWebTools.openWebPageAndMinimizeClient(_windowManager.getProperty("web.shop.relativeUrl"));
                        }
                        else
                        {
                            HabboWebTools.openWebHabblet(_local_3);
                        };
                    };
                    return;
            };
        }

        public function dispose():void
        {
            _windowManager = null;
        }

        public function get disposed():Boolean
        {
            return (_windowManager == null);
        }


    }
}