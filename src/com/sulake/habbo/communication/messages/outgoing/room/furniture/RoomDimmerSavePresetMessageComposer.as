package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class RoomDimmerSavePresetMessageComposer implements IMessageComposer 
    {

        private var _presetNumber:int;
        private var _SafeStr_1932:int;
        private var _SafeStr_1933:String;
        private var _SafeStr_1934:int;
        private var _SafeStr_1935:Boolean;

        public function RoomDimmerSavePresetMessageComposer(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:Boolean)
        {
            _presetNumber = _arg_1;
            _SafeStr_1932 = _arg_2;
            _SafeStr_1933 = _arg_3;
            _SafeStr_1934 = _arg_4;
            _SafeStr_1935 = _arg_5;
        }

        public function getMessageArray():Array
        {
            return ([_presetNumber, _SafeStr_1932, _SafeStr_1933, _SafeStr_1934, _SafeStr_1935]);
        }

        public function dispose():void
        {
        }


    }
}

