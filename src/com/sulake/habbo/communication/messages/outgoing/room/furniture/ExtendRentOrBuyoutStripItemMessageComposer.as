package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class ExtendRentOrBuyoutStripItemMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_690:Array;

        public function ExtendRentOrBuyoutStripItemMessageComposer(_arg_1:int, _arg_2:Boolean)
        {
            _SafeStr_690 = [_arg_1, _arg_2];
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_690);
        }

        public function dispose():void
        {
            _SafeStr_690 = null;
        }


    }
}

