package com.sulake.habbo.avatar.structure.figure
{
    import flash.utils.Dictionary;

    public class Palette implements IPalette 
    {

        private var _id:int;
        private var _colors:Dictionary;

        public function Palette(_arg_1:XML)
        {
            _id = parseInt(_arg_1.@id);
            _colors = new Dictionary();
            append(_arg_1);
        }

        public function append(_arg_1:XML):void
        {
            for each (var _local_2:XML in _arg_1.color)
            {
                _colors[String(_local_2.@id)] = new PartColor(_local_2);
            };
        }

        public function get id():int
        {
            return (_id);
        }

        public function getColor(_arg_1:int):IPartColor
        {
            return (_colors[String(_arg_1)]);
        }

        public function get colors():Dictionary
        {
            return (_colors);
        }


    }
}