package com.sulake.habbo.communication.messages.outgoing.room.action
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class UnbanUserFromRoomMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_875:Array = [];

        public function UnbanUserFromRoomMessageComposer(_arg_1:int, _arg_2:int)
        {
            _SafeStr_875.push(_arg_1);
            _SafeStr_875.push(_arg_2);
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_875);
        }

        public function dispose():void
        {
            _SafeStr_875 = null;
        }


    }
}

