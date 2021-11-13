package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PetData 
    {

        private var _id:int;
        private var _name:String;
        private var _figureData:PetFigureData;
        private var _level:int;

        public function PetData(_arg_1:IMessageDataWrapper)
        {
            _id = _arg_1.readInteger();
            _name = _arg_1.readString();
            _figureData = new PetFigureData(_arg_1);
            _level = _arg_1.readInteger();
        }

        public function get id():int
        {
            return (_id);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get typeId():int
        {
            return (_figureData.typeId);
        }

        public function get paletteId():int
        {
            return (_figureData.paletteId);
        }

        public function get color():String
        {
            return (_figureData.color);
        }

        public function get breedId():int
        {
            return (_figureData.breedId);
        }

        public function get customPartCount():int
        {
            return (_figureData.customPartCount);
        }

        public function get figureString():String
        {
            return (_figureData.figureString);
        }

        public function get figureData():PetFigureData
        {
            return (_figureData);
        }

        public function get level():int
        {
            return (_level);
        }


    }
}