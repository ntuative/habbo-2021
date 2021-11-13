package com.sulake.habbo.communication.messages.parser.room.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PetRespectFailedParser implements IMessageParser 
    {

        private var _requiredDays:int;
        private var _avatarAgeInDays:int;


        public function get requiredDays():int
        {
            return (_requiredDays);
        }

        public function get avatarAgeInDays():int
        {
            return (_avatarAgeInDays);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _requiredDays = _arg_1.readInteger();
            _avatarAgeInDays = _arg_1.readInteger();
            return (true);
        }


    }
}