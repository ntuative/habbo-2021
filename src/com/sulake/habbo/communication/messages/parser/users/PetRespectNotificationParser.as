package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PetRespectNotificationParser implements IMessageParser 
    {

        public static const _SafeStr_2116:int = 16;

        private var _respect:int;
        private var _petOwnerId:int;
        private var _petData:PetData;


        public function flush():Boolean
        {
            _petData = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _respect = _arg_1.readInteger();
            _petOwnerId = _arg_1.readInteger();
            _petData = new PetData(_arg_1);
            return (true);
        }

        public function get petOwnerId():int
        {
            return (_petOwnerId);
        }

        public function get respect():int
        {
            return (_respect);
        }

        public function get petData():PetData
        {
            return (_petData);
        }

        public function isTreat():Boolean
        {
            return (_petData.typeId == 16);
        }


    }
}

