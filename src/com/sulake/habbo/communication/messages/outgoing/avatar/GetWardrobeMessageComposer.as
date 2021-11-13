package com.sulake.habbo.communication.messages.outgoing.avatar
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class GetWardrobeMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_690:Array = [];


        public function dispose():void
        {
            _SafeStr_690 = null;
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_690);
        }


    }
}

