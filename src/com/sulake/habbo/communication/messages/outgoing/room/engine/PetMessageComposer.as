package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class PetMessageComposer implements IMessageComposer 
    {

        protected var _SafeStr_690:Array = [];

        public function PetMessageComposer(_arg_1:int)
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

