package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class GetDirectClubBuyAvailableComposer implements IMessageComposer 
    {

        private var _SafeStr_1871:int;

        public function GetDirectClubBuyAvailableComposer(_arg_1:int)
        {
            _SafeStr_1871 = _arg_1;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1871]);
        }

        public function dispose():void
        {
        }


    }
}

