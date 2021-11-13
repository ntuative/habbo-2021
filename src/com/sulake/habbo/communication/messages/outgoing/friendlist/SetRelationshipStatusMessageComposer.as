package com.sulake.habbo.communication.messages.outgoing.friendlist
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class SetRelationshipStatusMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1880:int;
        private var _SafeStr_1881:int;

        public function SetRelationshipStatusMessageComposer(_arg_1:int, _arg_2:int)
        {
            _SafeStr_1880 = _arg_1;
            _SafeStr_1881 = _arg_2;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1880, _SafeStr_1881]);
        }

        public function dispose():void
        {
        }


    }
}

