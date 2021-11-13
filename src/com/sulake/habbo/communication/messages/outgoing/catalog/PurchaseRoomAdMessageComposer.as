package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class PurchaseRoomAdMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_690:Array = [];

        public function PurchaseRoomAdMessageComposer(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:Boolean, _arg_6:String, _arg_7:int)
        {
            _SafeStr_690.push(_arg_1);
            _SafeStr_690.push(_arg_2);
            _SafeStr_690.push(_arg_3);
            _SafeStr_690.push(_arg_4);
            _SafeStr_690.push(_arg_5);
            _SafeStr_690.push(_arg_6);
            _SafeStr_690.push(_arg_7);
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_690);
        }

        public function dispose():void
        {
        }


    }
}

