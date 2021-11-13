package com.sulake.habbo.ui.widget.events
{
    import flash.display.BitmapData;

    public class RoomWidgetEcotronBoxDataUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const UPDATE_PACKAGEINFO:String = "RWEBDUE_PACKAGEINFO";
        public static const _SafeStr_4033:String = "RWEBDUE_CONTENTS";

        private var _objectId:int = -1;
        private var _text:String;
        private var _furniTypeName:String;
        private var _controller:Boolean;
        private var _iconBitmapData:BitmapData;

        public function RoomWidgetEcotronBoxDataUpdateEvent(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:Boolean=false, _arg_6:BitmapData=null, _arg_7:Boolean=false, _arg_8:Boolean=false)
        {
            super(_arg_1, _arg_7, _arg_8);
            _objectId = _arg_2;
            _text = _arg_3;
            _furniTypeName = _arg_4;
            _controller = _arg_5;
            _iconBitmapData = _arg_6;
        }

        public function get objectId():int
        {
            return (_objectId);
        }

        public function get text():String
        {
            return (_text);
        }

        public function get controller():Boolean
        {
            return (_controller);
        }

        public function get iconBitmapData():BitmapData
        {
            return (_iconBitmapData);
        }

        public function get furniTypeName():String
        {
            return (_furniTypeName);
        }


    }
}

