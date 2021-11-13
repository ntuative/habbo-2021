package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class MountPetMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1915:int;
        private var _SafeStr_1923:Boolean;

        public function MountPetMessageComposer(_arg_1:int, _arg_2:Boolean)
        {
            _SafeStr_1915 = _arg_1;
            _SafeStr_1923 = _arg_2;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1915, _SafeStr_1923]);
        }


    }
}

