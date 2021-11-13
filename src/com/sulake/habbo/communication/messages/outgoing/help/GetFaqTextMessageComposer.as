package com.sulake.habbo.communication.messages.outgoing.help
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class GetFaqTextMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1894:int;

        public function GetFaqTextMessageComposer(_arg_1:int)
        {
            _SafeStr_1894 = _arg_1;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1894]);
        }

        public function dispose():void
        {
        }


    }
}

