package com.sulake.habbo.avatar.pets
{
    public class PetCustomPart 
    {

        private var _layerId:int;
        private var _partId:int;
        private var _paletteId:int;

        public function PetCustomPart(_arg_1:int, _arg_2:int, _arg_3:int)
        {
            _layerId = _arg_1;
            _partId = _arg_2;
            _paletteId = _arg_3;
        }

        public function get paletteId():int
        {
            return (_paletteId);
        }

        public function set paletteId(_arg_1:int):void
        {
            _paletteId = _arg_1;
        }

        public function get partId():int
        {
            return (_partId);
        }

        public function set partId(_arg_1:int):void
        {
            _partId = _arg_1;
        }

        public function get layerId():int
        {
            return (_layerId);
        }

        public function set layerId(_arg_1:int):void
        {
            _layerId = _arg_1;
        }


    }
}