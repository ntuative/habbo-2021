package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class SetItemDataMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1922:int;
        private var _SafeStr_690:String;
        private var _SafeStr_1928:String;

        public function SetItemDataMessageComposer(_arg_1:int, _arg_2:String="", _arg_3:String="")
        {
            _SafeStr_1922 = _arg_1;
            _SafeStr_690 = _arg_3;
            _SafeStr_1928 = _arg_2;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1922, _SafeStr_1928, _SafeStr_690]);
        }


    }
}

