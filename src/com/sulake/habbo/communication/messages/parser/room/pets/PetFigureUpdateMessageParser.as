package com.sulake.habbo.communication.messages.parser.room.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetFigureData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PetFigureUpdateMessageParser implements IMessageParser 
    {

        private var _roomIndex:int;
        private var _petId:int;
        private var _figureData:PetFigureData;
        private var _hasSaddle:Boolean;
        private var _isRiding:Boolean;


        public function get roomIndex():int
        {
            return (_roomIndex);
        }

        public function get petId():int
        {
            return (_petId);
        }

        public function get figureData():PetFigureData
        {
            return (_figureData);
        }

        public function get hasSaddle():Boolean
        {
            return (_hasSaddle);
        }

        public function get isRiding():Boolean
        {
            return (_isRiding);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _roomIndex = _arg_1.readInteger();
            _petId = _arg_1.readInteger();
            _figureData = new PetFigureData(_arg_1);
            _hasSaddle = _arg_1.readBoolean();
            _isRiding = _arg_1.readBoolean();
            return (true);
        }


    }
}