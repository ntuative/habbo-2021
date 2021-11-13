package com.sulake.habbo.communication.messages.outgoing.avatar
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class ChangeUserNameMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_690:Array;

        public function ChangeUserNameMessageComposer(_arg_1:String)
        {
            _SafeStr_690 = [];
            _SafeStr_690.push(_arg_1);
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

