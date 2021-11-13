package com.sulake.habbo.avatar.pets
{
    public class PetFigureData 
    {

        private var _typeId:int;
        private var _paletteId:int;
        private var _color:int;
        private var _customParts:Array;
        private var _customLayerIds:Array;
        private var _customPartIds:Array;
        private var _customPaletteIds:Array;
        private var _headOnly:Boolean;

        public function PetFigureData(_arg_1:String)
        {
            var _local_2:int;
            super();
            _typeId = getTypeId(_arg_1);
            _paletteId = getPaletteId(_arg_1);
            _color = getColor(_arg_1);
            _headOnly = getHeadOnly(_arg_1);
            var _local_3:Array = getCustomData(_arg_1);
            _customLayerIds = getCustomLayerIds(_local_3);
            _customPartIds = getCustomPartIds(_local_3);
            _customPaletteIds = getCustomPaletteIds(_local_3);
            _customParts = [];
            _local_2 = 0;
            while (_local_2 < _customLayerIds.length)
            {
                _customParts.push(new PetCustomPart(_customLayerIds[_local_2], _customPartIds[_local_2], _customPaletteIds[_local_2]));
                _local_2++;
            };
        }

        public function get typeId():int
        {
            return (_typeId);
        }

        public function get paletteId():int
        {
            return (_paletteId);
        }

        public function get color():int
        {
            return (_color);
        }

        public function get customLayerIds():Array
        {
            return (_customLayerIds);
        }

        public function get customPartIds():Array
        {
            return (_customPartIds);
        }

        public function get customPaletteIds():Array
        {
            return (_customPaletteIds);
        }

        public function get customParts():Array
        {
            return (_customParts);
        }

        public function getCustomPart(_arg_1:int):PetCustomPart
        {
            if (_customParts != null)
            {
                for each (var _local_2:PetCustomPart in _customParts)
                {
                    if (_local_2.layerId == _arg_1)
                    {
                        return (_local_2);
                    };
                };
            };
            return (null);
        }

        public function get hasCustomParts():Boolean
        {
            return ((!(_customLayerIds == null)) && (_customLayerIds.length > 0));
        }

        public function get headOnly():Boolean
        {
            return (_headOnly);
        }

        public function get figureString():String
        {
            var _local_2:String = ((((typeId + " ") + paletteId) + " ") + color.toString(16));
            _local_2 = (_local_2 + (" " + customParts.length));
            for each (var _local_1:PetCustomPart in customParts)
            {
                _local_2 = (_local_2 + (((((" " + _local_1.layerId) + " ") + _local_1.partId) + " ") + _local_1.paletteId));
            };
            return (_local_2);
        }

        private function getCustomData(_arg_1:String):Array
        {
            var _local_7:Array;
            var _local_4:int;
            var _local_5:int;
            var _local_2:int;
            var _local_6:int;
            var _local_3:Array = [];
            if (_arg_1 != null)
            {
                _local_7 = _arg_1.split(" ");
                _local_4 = ((_headOnly) ? 1 : 0);
                _local_5 = (4 + _local_4);
                if (_local_7.length > _local_5)
                {
                    _local_2 = (3 + _local_4);
                    _local_6 = parseInt(_local_7[_local_2]);
                    _local_3 = _local_7.slice(_local_5, (_local_5 + (_local_6 * 3)));
                };
            };
            return (_local_3);
        }

        private function getCustomLayerIds(_arg_1:Array):Array
        {
            var _local_3:int;
            var _local_2:Array = [];
            _local_3 = 0;
            while (_local_3 < _arg_1.length)
            {
                _local_2.push(parseInt(_arg_1[(_local_3 + 0)]));
                _local_3 = (_local_3 + 3);
            };
            return (_local_2);
        }

        private function getCustomPartIds(_arg_1:Array):Array
        {
            var _local_3:int;
            var _local_2:Array = [];
            _local_3 = 0;
            while (_local_3 < _arg_1.length)
            {
                _local_2.push(parseInt(_arg_1[(_local_3 + 1)]));
                _local_3 = (_local_3 + 3);
            };
            return (_local_2);
        }

        private function getCustomPaletteIds(_arg_1:Array):Array
        {
            var _local_3:int;
            var _local_2:Array = [];
            _local_3 = 0;
            while (_local_3 < _arg_1.length)
            {
                _local_2.push(parseInt(_arg_1[(_local_3 + 2)]));
                _local_3 = (_local_3 + 3);
            };
            return (_local_2);
        }

        private function getTypeId(_arg_1:String):int
        {
            var _local_2:Array;
            if (_arg_1 != null)
            {
                _local_2 = _arg_1.split(" ");
                if (_local_2.length >= 1)
                {
                    return (parseInt(_local_2[0]));
                };
            };
            return (0);
        }

        private function getPaletteId(_arg_1:String):int
        {
            var _local_2:Array;
            if (_arg_1 != null)
            {
                _local_2 = _arg_1.split(" ");
                if (_local_2.length >= 2)
                {
                    return (parseInt(_local_2[1]));
                };
            };
            return (0);
        }

        private function getColor(_arg_1:String):int
        {
            var _local_2:Array;
            if (_arg_1 != null)
            {
                _local_2 = _arg_1.split(" ");
                if (_local_2.length >= 3)
                {
                    return (parseInt(_local_2[2], 16));
                };
            };
            return (0xFFFFFF);
        }

        private function getHeadOnly(_arg_1:String):Boolean
        {
            var _local_2:Array;
            if (_arg_1 != null)
            {
                _local_2 = _arg_1.split(" ");
                if (_local_2.length >= 4)
                {
                    return (_local_2[3] == "head");
                };
            };
            return (false);
        }


    }
}