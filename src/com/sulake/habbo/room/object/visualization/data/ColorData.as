package com.sulake.habbo.room.object.visualization.data
{
    public class ColorData 
    {

        public static const DEFAULT_COLOR:uint = 0xFFFFFF;

        private var _colors:Array = [];

        public function ColorData(_arg_1:int)
        {
            var _local_2:int;
            super();
            _local_2 = 0;
            while (_local_2 < _arg_1)
            {
                _colors.push(0xFFFFFF);
                _local_2++;
            };
        }

        public function dispose():void
        {
            _colors = null;
        }

        public function setColor(_arg_1:uint, _arg_2:int):void
        {
            if (((_arg_2 < 0) || (_arg_2 >= _colors.length)))
            {
                return;
            };
            _colors[_arg_2] = _arg_1;
        }

        public function getColor(_arg_1:int):uint
        {
            if (((_arg_1 < 0) || (_arg_1 >= _colors.length)))
            {
                return (0xFFFFFF);
            };
            return (_colors[_arg_1]);
        }


    }
}