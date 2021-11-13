package com.sulake.habbo.communication.messages.outgoing.help
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class GetFaqCategoryMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1283:int;

        public function GetFaqCategoryMessageComposer(_arg_1:int)
        {
            _SafeStr_1283 = _arg_1;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1283]);
        }

        public function dispose():void
        {
        }


    }
}

