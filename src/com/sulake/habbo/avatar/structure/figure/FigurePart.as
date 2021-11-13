package com.sulake.habbo.avatar.structure.figure
{
    public class FigurePart implements IFigurePart
    {

        private var _id:int;
        private var _type:String;
        private var _breed:int = -1;
        private var _colorLayerIndex:int;
        private var _index:int;
        private var _paletteMap:int = -1;

        public function FigurePart(_arg_1:XML)
        {
            _id = parseInt(_arg_1.@id);
            _type = String(_arg_1.@type);
            _index = parseInt(_arg_1.@index);
            _colorLayerIndex = parseInt(_arg_1.@colorindex);
            var _local_2:String = _arg_1.@palettemapid;
            if (_local_2 != "")
            {
                _paletteMap = int(_local_2);
            };
            var _local_3:String = _arg_1.@breed;
            if (_local_3 != "")
            {
                _breed = int(_local_3);
            };
        }

        public function dispose():void
        {
        }

        public function get id():int
        {
            return (_id);
        }

        public function get type():String
        {
            return (_type);
        }

        public function get breed():int
        {
            return (_breed);
        }

        public function get colorLayerIndex():int
        {
            return (_colorLayerIndex);
        }

        public function get index():int
        {
            return (_index);
        }

        public function get paletteMap():int
        {
            return (_paletteMap);
        }


    }
}
