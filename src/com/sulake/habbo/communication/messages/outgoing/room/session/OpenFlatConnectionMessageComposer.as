package com.sulake.habbo.communication.messages.outgoing.room.session
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class OpenFlatConnectionMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_835:Array;

        public function OpenFlatConnectionMessageComposer(_arg_1:int, _arg_2:String="", _arg_3:int=-1)
        {
            _SafeStr_835 = [_arg_1, _arg_2, _arg_3];
        }

        public function dispose():void
        {
            _SafeStr_835 = null;
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_835);
        }


    }
}

