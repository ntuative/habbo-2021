package com.sulake.habbo.communication.messages.outgoing.navigator
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class CancelEventMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_875:Array = [];

        public function CancelEventMessageComposer(_arg_1:int)
        {
            _SafeStr_875.push(_arg_1);
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_875);
        }


    }
}

