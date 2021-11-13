package com.sulake.habbo.communication.messages.outgoing.advertisement
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class InterstitialShownMessageComposer implements IMessageComposer 
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

