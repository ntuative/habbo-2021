package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetEcotronBoxOpenMessage extends RoomWidgetMessage 
    {

        public static const _SafeStr_4189:String = "RWEBOM_OPEN_ECOTRONBOX";

        private var _objectId:int;

        public function RoomWidgetEcotronBoxOpenMessage(_arg_1:String, _arg_2:int)
        {
            super(_arg_1);
            _objectId = _arg_2;
        }

        public function get objectId():int
        {
            return (_objectId);
        }


    }
}

