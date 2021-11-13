package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class GetPetCommandsMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1915:int;

        public function GetPetCommandsMessageComposer(_arg_1:int)
        {
            _SafeStr_1915 = _arg_1;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1915]);
        }


    }
}

