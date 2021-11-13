package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class SelectClubGiftComposer implements IMessageComposer 
    {

        private var _SafeStr_1718:String;

        public function SelectClubGiftComposer(_arg_1:String)
        {
            _SafeStr_1718 = _arg_1;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1718]);
        }

        public function dispose():void
        {
            _SafeStr_1718 = null;
        }


    }
}

