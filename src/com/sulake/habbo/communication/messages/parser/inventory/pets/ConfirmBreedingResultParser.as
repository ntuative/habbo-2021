package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ConfirmBreedingResultParser implements IMessageParser 
    {

        private var _breedingNestStuffId:int;
        private var _result:int;


        public function flush():Boolean
        {
            _breedingNestStuffId = 0;
            _result = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _breedingNestStuffId = _arg_1.readInteger();
            _result = _arg_1.readInteger();
            return (true);
        }

        public function get breedingNestStuffId():int
        {
            return (_breedingNestStuffId);
        }

        public function get result():int
        {
            return (_result);
        }


    }
}