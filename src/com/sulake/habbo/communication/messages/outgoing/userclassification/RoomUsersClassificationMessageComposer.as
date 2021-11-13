package com.sulake.habbo.communication.messages.outgoing.userclassification
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class RoomUsersClassificationMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1948:String;

        public function RoomUsersClassificationMessageComposer(_arg_1:String)
        {
            _SafeStr_1948 = _arg_1;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1948]);
        }

        public function dispose():void
        {
            _SafeStr_1948 = null;
        }


    }
}

