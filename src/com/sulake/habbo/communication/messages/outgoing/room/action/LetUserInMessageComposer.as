package com.sulake.habbo.communication.messages.outgoing.room.action
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class LetUserInMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_835:Array;

        public function LetUserInMessageComposer(_arg_1:String, _arg_2:Boolean)
        {
            _SafeStr_835 = [_arg_1, _arg_2];
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

