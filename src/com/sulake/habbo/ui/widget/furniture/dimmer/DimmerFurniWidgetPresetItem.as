package com.sulake.habbo.ui.widget.furniture.dimmer
{
    public class DimmerFurniWidgetPresetItem 
    {

        private var _id:int = 0;
        private var _type:int = 0;
        private var _color:uint = 0;
        private var _light:uint = 0;

        public function DimmerFurniWidgetPresetItem(_arg_1:int, _arg_2:int, _arg_3:uint, _arg_4:uint)
        {
            _id = _arg_1;
            _type = _arg_2;
            _color = _arg_3;
            _light = _arg_4;
        }

        public function get id():int
        {
            return (_id);
        }

        public function get type():int
        {
            return (_type);
        }

        public function get color():uint
        {
            return (_color);
        }

        public function get light():uint
        {
            return (_light);
        }

        public function set type(_arg_1:int):void
        {
            _type = _arg_1;
        }

        public function set color(_arg_1:uint):void
        {
            _color = _arg_1;
        }

        public function set light(_arg_1:uint):void
        {
            _light = _arg_1;
        }


    }
}