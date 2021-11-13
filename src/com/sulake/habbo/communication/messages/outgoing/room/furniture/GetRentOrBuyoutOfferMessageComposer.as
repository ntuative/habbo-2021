package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class GetRentOrBuyoutOfferMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_690:Array;

        public function GetRentOrBuyoutOfferMessageComposer(_arg_1:Boolean, _arg_2:String, _arg_3:Boolean)
        {
            _SafeStr_690 = [_arg_1, _arg_2, _arg_3];
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

