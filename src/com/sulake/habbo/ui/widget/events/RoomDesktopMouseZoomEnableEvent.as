package com.sulake.habbo.ui.widget.events
{
    import flash.events.Event;

    public class RoomDesktopMouseZoomEnableEvent extends Event 
    {

        public static const _SafeStr_3174:String = "RDMZEE_ENABLED";

        private var _SafeStr_1608:Boolean;

        public function RoomDesktopMouseZoomEnableEvent(_arg_1:Boolean)
        {
            super("RDMZEE_ENABLED");
            _SafeStr_1608 = _arg_1;
        }

    }
}

