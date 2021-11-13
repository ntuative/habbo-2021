package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PetFigureData 
    {

        private var _typeId:int;
        private var _paletteId:int;
        private var _color:String;
        private var _breedId:int;
        private var _customPartCount:int;
        private var _customParts:Array;

        public function PetFigureData(_arg_1:IMessageDataWrapper)
        {
            var _local_2:int;
            super();
            _typeId = _arg_1.readInteger();
            _paletteId = _arg_1.readInteger();
            _color = _arg_1.readString();
            _breedId = _arg_1.readInteger();
            _customParts = [];
            _customPartCount = _arg_1.readInteger();
            _local_2 = 0;
            while (_local_2 < _customPartCount)
            {
                _customParts.push(_arg_1.readInteger());
                _customParts.push(_arg_1.readInteger());
                _customParts.push(_arg_1.readInteger());
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

        public function get color():String
        {
            return (_color);
        }

        public function get breedId():int
        {
            return (_breedId);
        }

        public function get figureString():String
        {
            var _local_2:String = ((((typeId + " ") + paletteId) + " ") + color);
            _local_2 = (_local_2 + (" " + customPartCount));
            for each (var _local_1:int in customParts)
            {
                _local_2 = (_local_2 + (" " + _local_1));
            };
            return (_local_2);
        }

        public function get customParts():Array
        {
            return (_customParts);
        }

        public function get customPartCount():int
        {
            return (_customPartCount);
        }


    }
}