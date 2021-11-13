package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class RentableSpaceCancelRentMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_875:Array;

        public function RentableSpaceCancelRentMessageComposer(_arg_1:int)
        {
            _SafeStr_875 = [_arg_1];
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

