package com.sulake.habbo.communication.messages.outgoing.inventory.pets
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class ConfirmPetBreedingComposer implements IMessageComposer 
    {

        private var _SafeStr_690:Array = [];

        public function ConfirmPetBreedingComposer(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:int)
        {
            _SafeStr_690.push(_arg_1);
            _SafeStr_690.push(_arg_2);
            _SafeStr_690.push(_arg_3);
            _SafeStr_690.push(_arg_4);
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_690);
        }

        public function dispose():void
        {
            _SafeStr_690 = null;
        }


    }
}

