package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class SetClothingChangeDataMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1922:int;
        private var _SafeStr_1926:String;
        private var _SafeStr_1927:String;

        public function SetClothingChangeDataMessageComposer(_arg_1:int, _arg_2:String, _arg_3:String="")
        {
            _SafeStr_1922 = _arg_1;
            _SafeStr_1926 = _arg_2;
            _SafeStr_1927 = _arg_3;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1922, _SafeStr_1926, _SafeStr_1927]);
        }


    }
}

