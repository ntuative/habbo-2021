package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class PlacePostItMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1929:int;
        private var _location:String;

        public function PlacePostItMessageComposer(_arg_1:int, _arg_2:String)
        {
            _SafeStr_1929 = _arg_1;
            _location = _arg_2;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1929, _location]);
        }


    }
}

