package com.sulake.habbo.communication.messages.outgoing.room.action
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class AmbassadorAlertMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1887:int;

        public function AmbassadorAlertMessageComposer(_arg_1:int)
        {
            _SafeStr_1887 = _arg_1;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1887]);
        }

        public function dispose():void
        {
        }


    }
}

