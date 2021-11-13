package com.sulake.habbo.communication.messages.outgoing.users
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class ChangeEmailComposer implements IMessageComposer 
    {

        private var _SafeStr_1949:String;

        public function ChangeEmailComposer(_arg_1:String)
        {
            _SafeStr_1949 = _arg_1;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1949]);
        }


    }
}

