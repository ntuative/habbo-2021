package com.sulake.habbo.communication.messages.parser.room.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PetExperienceParser implements IMessageParser 
    {

        private var _petId:int = -1;
        private var _petRoomIndex:int = -1;
        private var _gainedExperience:int = 0;


        public function get petId():int
        {
            return (_petId);
        }

        public function get petRoomIndex():int
        {
            return (_petRoomIndex);
        }

        public function get gainedExperience():int
        {
            return (_gainedExperience);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            _petId = _arg_1.readInteger();
            _petRoomIndex = _arg_1.readInteger();
            _gainedExperience = _arg_1.readInteger();
            return (true);
        }


    }
}