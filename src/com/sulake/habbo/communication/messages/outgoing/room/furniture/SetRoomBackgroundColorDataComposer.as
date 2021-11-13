package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class SetRoomBackgroundColorDataComposer implements IMessageComposer 
    {

        private var _SafeStr_1936:int;
        private var _SafeStr_1937:int;
        private var _saturation:int;
        private var _SafeStr_1938:int;

        public function SetRoomBackgroundColorDataComposer(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int)
        {
            _SafeStr_1936 = _arg_1;
            _SafeStr_1937 = _arg_2;
            _saturation = _arg_3;
            _SafeStr_1938 = _arg_4;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1936, _SafeStr_1937, _saturation, _SafeStr_1938]);
        }

        public function dispose():void
        {
        }


    }
}

