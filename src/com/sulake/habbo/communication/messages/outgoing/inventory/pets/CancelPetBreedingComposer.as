package com.sulake.habbo.communication.messages.outgoing.inventory.pets
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class CancelPetBreedingComposer implements IMessageComposer 
    {

        private var _SafeStr_690:Array = [];

        public function CancelPetBreedingComposer(_arg_1:int)
        {
            _SafeStr_690.push(_arg_1);
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

