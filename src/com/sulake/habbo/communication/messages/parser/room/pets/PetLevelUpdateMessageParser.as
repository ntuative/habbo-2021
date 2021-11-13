package com.sulake.habbo.communication.messages.parser.room.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PetLevelUpdateMessageParser implements IMessageParser 
    {

        private var _roomIndex:int;
        private var _petId:int;
        private var _level:int;


        public function get roomIndex():int
        {
            return (_roomIndex);
        }

        public function get petId():int
        {
            return (_petId);
        }

        public function get level():int
        {
            return (_level);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _roomIndex = _arg_1.readInteger();
            _petId = _arg_1.readInteger();
            _level = _arg_1.readInteger();
            return (true);
        }


    }
}