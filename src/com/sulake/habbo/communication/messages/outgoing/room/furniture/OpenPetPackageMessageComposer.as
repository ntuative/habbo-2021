package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class OpenPetPackageMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1922:int;
        private var _SafeStr_1931:String;

        public function OpenPetPackageMessageComposer(_arg_1:int, _arg_2:String)
        {
            _SafeStr_1922 = _arg_1;
            _SafeStr_1931 = _arg_2;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1922, _SafeStr_1931]);
        }

        public function dispose():void
        {
        }


    }
}

