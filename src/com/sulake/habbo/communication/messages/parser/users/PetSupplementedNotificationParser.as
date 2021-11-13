package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PetSupplementedNotificationParser implements IMessageParser 
    {

        private var _petId:int;
        private var _userId:int;
        private var _supplementType:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _petId = _arg_1.readInteger();
            _userId = _arg_1.readInteger();
            _supplementType = _arg_1.readInteger();
            return (true);
        }

        public function get petId():int
        {
            return (_petId);
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get supplementType():int
        {
            return (_supplementType);
        }


    }
}