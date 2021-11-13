package com.sulake.habbo.communication.messages.parser.room.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetBreedingResultData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PetBreedingResultMessageParser implements IMessageParser 
    {

        private var _resultData:PetBreedingResultData;
        private var _otherResultData:PetBreedingResultData;


        public function get resultData():PetBreedingResultData
        {
            return (_resultData);
        }

        public function get otherResultData():PetBreedingResultData
        {
            return (_otherResultData);
        }

        public function flush():Boolean
        {
            return (true);
        }

        private function parseResultData(_arg_1:IMessageDataWrapper):PetBreedingResultData
        {
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int = _arg_1.readInteger();
            var _local_4:String = _arg_1.readString();
            var _local_7:int = _arg_1.readInteger();
            var _local_6:String = _arg_1.readString();
            var _local_5:int = _arg_1.readInteger();
            var _local_8:Boolean = _arg_1.readBoolean();
            return (new PetBreedingResultData(_local_2, _local_3, _local_4, _local_7, _local_6, _local_5, _local_8));
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _resultData = parseResultData(_arg_1);
            _otherResultData = parseResultData(_arg_1);
            return (true);
        }


    }
}