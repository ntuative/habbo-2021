package com.sulake.habbo.communication.messages.outgoing.room.pets
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class BreedPetsMessageComposer implements IMessageComposer 
    {

        public static const _SafeStr_1939:int = 0;
        public static const _SafeStr_1940:int = 1;
        public static const _SafeStr_1941:int = 2;

        private var _SafeStr_690:Array = [];

        public function BreedPetsMessageComposer(_arg_1:int, _arg_2:int, _arg_3:int)
        {
            _SafeStr_690.push(_arg_1);
            _SafeStr_690.push(_arg_2);
            _SafeStr_690.push(_arg_3);
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

