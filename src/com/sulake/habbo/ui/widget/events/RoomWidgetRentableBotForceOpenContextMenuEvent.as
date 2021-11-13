package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetRentableBotForceOpenContextMenuEvent extends RoomWidgetUpdateEvent 
    {

        public static const _SafeStr_4045:String = "RWRBFOCME_OPEN";

        private var _botId:int;

        public function RoomWidgetRentableBotForceOpenContextMenuEvent(_arg_1:int)
        {
            _botId = _arg_1;
            super("RWRBFOCME_OPEN");
        }

        public function get botId():int
        {
            return (_botId);
        }


    }
}

