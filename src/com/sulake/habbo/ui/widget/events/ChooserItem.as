package com.sulake.habbo.ui.widget.events
{
    public class ChooserItem 
    {

        private var _id:int;
        private var _category:int;
        private var _name:String;

        public function ChooserItem(_arg_1:int, _arg_2:int, _arg_3:String)
        {
            _id = _arg_1;
            _category = _arg_2;
            _name = _arg_3;
        }

        public function get id():int
        {
            return (_id);
        }

        public function get category():int
        {
            return (_category);
        }

        public function get name():String
        {
            return (_name);
        }


    }
}