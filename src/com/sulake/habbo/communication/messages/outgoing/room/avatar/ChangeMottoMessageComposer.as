package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class ChangeMottoMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1911:String;

        public function ChangeMottoMessageComposer(_arg_1:String)
        {
            _SafeStr_1911 = _arg_1;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1911]);
        }


    }
}

