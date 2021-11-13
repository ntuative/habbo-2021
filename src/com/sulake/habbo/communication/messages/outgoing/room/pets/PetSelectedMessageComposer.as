package com.sulake.habbo.communication.messages.outgoing.room.pets
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class PetSelectedMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1915:int;

        public function PetSelectedMessageComposer(_arg_1:int)
        {
            _SafeStr_1915 = _arg_1;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1915]);
        }

        public function dispose():void
        {
        }


    }
}

