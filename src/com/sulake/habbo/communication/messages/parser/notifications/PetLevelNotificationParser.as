package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetFigureData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PetLevelNotificationParser implements IMessageParser 
    {

        private var _petId:int;
        private var _petName:String;
        private var _level:int;
        private var _figureData:PetFigureData;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _petId = _arg_1.readInteger();
            _petName = _arg_1.readString();
            _level = _arg_1.readInteger();
            _figureData = new PetFigureData(_arg_1);
            return (true);
        }

        public function get petId():int
        {
            return (_petId);
        }

        public function get petName():String
        {
            return (_petName);
        }

        public function get level():int
        {
            return (_level);
        }

        public function get figureData():PetFigureData
        {
            return (_figureData);
        }


    }
}