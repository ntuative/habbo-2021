package com.sulake.habbo.communication.messages.parser.room.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PetStatusUpdateMessageParser implements IMessageParser 
    {

        private var _roomIndex:int;
        private var _petId:int;
        private var _canBreed:Boolean;
        private var _canHarvest:Boolean;
        private var _canRevive:Boolean;
        private var _hasBreedingPermission:Boolean;


        public function get roomIndex():int
        {
            return (_roomIndex);
        }

        public function get petId():int
        {
            return (_petId);
        }

        public function get canBreed():Boolean
        {
            return (_canBreed);
        }

        public function get canHarvest():Boolean
        {
            return (_canHarvest);
        }

        public function get canRevive():Boolean
        {
            return (_canRevive);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function get hasBreedingPermission():Boolean
        {
            return (_hasBreedingPermission);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _roomIndex = _arg_1.readInteger();
            _petId = _arg_1.readInteger();
            _canBreed = _arg_1.readBoolean();
            _canHarvest = _arg_1.readBoolean();
            _canRevive = _arg_1.readBoolean();
            _hasBreedingPermission = _arg_1.readBoolean();
            return (true);
        }


    }
}