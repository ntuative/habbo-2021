package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetChangePostureMessage extends RoomWidgetMessage 
    {

        public static const WIDGET_MESSAGE_CHANGE_POSTURE:String = "RWCPM_MESSAGE_CHANGE_POSTURE";
        public static const POSTURE_STAND:int = 0;
        public static const POSTURE_SIT:int = 1;

        private var _posture:int = 0;

        public function RoomWidgetChangePostureMessage(_arg_1:int)
        {
            super("RWCPM_MESSAGE_CHANGE_POSTURE");
            _posture = _arg_1;
        }

        public function get posture():int
        {
            return (_posture);
        }


    }
}