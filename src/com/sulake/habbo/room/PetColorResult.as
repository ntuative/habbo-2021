package com.sulake.habbo.room
{
    public class PetColorResult 
    {

        private static const COLOR_TAGS:Array = ["Null", "Black", "White", "Grey", "Red", "Orange", "Pink", "Green", "Lime", "Blue", "Light-Blue", "Dark-Blue", "Yellow", "Brown", "Dark-Brown", "Beige", "Cyan", "Purple", "Gold"];

        private var _breed:int;
        private var _tag:String;
        private var _id:String;
        private var _primaryColor:int = 0;
        private var _secondaryColor:int = 0;
        private var _isMaster:Boolean = false;
        private var _layerTags:Array = [];

        public function PetColorResult(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:String, _arg_6:Boolean, _arg_7:Array)
        {
            _primaryColor = (_arg_1 & 0xFFFFFF);
            _secondaryColor = (_arg_2 & 0xFFFFFF);
            _breed = _arg_3;
            _tag = (((_arg_4 > -1) && (_arg_4 < COLOR_TAGS.length)) ? COLOR_TAGS[_arg_4] : "");
            _id = _arg_5;
            _isMaster = _arg_6;
            _layerTags = _arg_7;
        }

        public function get primaryColor():int
        {
            return (_primaryColor);
        }

        public function get secondaryColor():int
        {
            return (_secondaryColor);
        }

        public function get breed():int
        {
            return (_breed);
        }

        public function get tag():String
        {
            return (_tag);
        }

        public function get id():String
        {
            return (_id);
        }

        public function get isMaster():Boolean
        {
            return (_isMaster);
        }

        public function get layerTags():Array
        {
            return (_layerTags);
        }


    }
}