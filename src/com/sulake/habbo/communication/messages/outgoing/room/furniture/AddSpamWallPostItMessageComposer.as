package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class AddSpamWallPostItMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1929:int;
        private var _location:String;
        private var _SafeStr_835:String;
        private var _SafeStr_1928:String;

        public function AddSpamWallPostItMessageComposer(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:String)
        {
            _SafeStr_1929 = _arg_1;
            _location = _arg_2;
            _SafeStr_835 = _arg_4;
            _SafeStr_1928 = _arg_3;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1929, _location, _SafeStr_1928, _SafeStr_835]);
        }


    }
}

