package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetStickieDataUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const UPDATE_STICKIE_DATA:String = "RWSDUE_STICKIE_DATA";

        private var _objectId:int = -1;
        private var _objectType:String;
        private var _text:String;
        private var _colorHex:String;
        private var _controller:Boolean;

        public function RoomWidgetStickieDataUpdateEvent(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:Boolean, _arg_7:Boolean=false, _arg_8:Boolean=false)
        {
            super(_arg_1, _arg_7, _arg_8);
            _objectId = _arg_2;
            _objectType = _arg_3;
            _text = _arg_4;
            _colorHex = _arg_5;
            _controller = _arg_6;
        }

        public function get objectId():int
        {
            return (_objectId);
        }

        public function get objectType():String
        {
            return (_objectType);
        }

        public function get text():String
        {
            return (_text);
        }

        public function get colorHex():String
        {
            return (_colorHex);
        }

        public function get controller():Boolean
        {
            return (_controller);
        }


    }
}