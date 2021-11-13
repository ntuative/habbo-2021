package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetConversionPointMessage extends RoomWidgetMessage 
    {

        public static const _SafeStr_4184:String = "RWCPM_CONVERSION_POINT";

        private var _category:String;
        private var _pointType:String;
        private var _action:String;
        private var _extraString:String;
        private var _extraInt:int;

        public function RoomWidgetConversionPointMessage(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String="", _arg_6:int=0)
        {
            super(_arg_1);
            _category = _arg_2;
            _pointType = _arg_3;
            _action = _arg_4;
            _extraString = ((_arg_5) ? _arg_5 : "");
            _extraInt = ((_arg_6) ? _arg_6 : 0);
        }

        public function get category():String
        {
            return (_category);
        }

        public function get pointType():String
        {
            return (_pointType);
        }

        public function get action():String
        {
            return (_action);
        }

        public function get extraString():String
        {
            return (_extraString);
        }

        public function get extraInt():int
        {
            return (_extraInt);
        }


    }
}

