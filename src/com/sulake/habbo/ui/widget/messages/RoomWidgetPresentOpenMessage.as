package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetPresentOpenMessage extends RoomWidgetMessage 
    {

        public static const _SafeStr_4201:String = "RWPOM_OPEN_PRESENT";

        private var _objectId:int;

        public function RoomWidgetPresentOpenMessage(_arg_1:String, _arg_2:int)
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

