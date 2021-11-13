package com.sulake.habbo.communication.messages.outgoing.navigator
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class ForwardToSomeRoomMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_741:String;

        public function ForwardToSomeRoomMessageComposer(_arg_1:String):void
        {
            _SafeStr_741 = _arg_1;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_741]);
        }

        public function dispose():void
        {
            _SafeStr_741 = null;
        }


    }
}

