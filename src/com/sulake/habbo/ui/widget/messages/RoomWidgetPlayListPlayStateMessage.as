package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetPlayListPlayStateMessage extends RoomWidgetMessage 
    {

        public static const TOGGLE_PLAY_PAUSE:String = "RWPLPS_TOGGLE_PLAY_PAUSE";

        private var _furniId:int;
        private var _position:int;

        public function RoomWidgetPlayListPlayStateMessage(_arg_1:String, _arg_2:int, _arg_3:int=-1)
        {
            super(_arg_1);
            _furniId = _arg_2;
            _position = _arg_3;
        }

        public function get furniId():int
        {
            return (_furniId);
        }

        public function get position():int
        {
            return (_position);
        }


    }
}