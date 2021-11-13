package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

        public class GetHabboClubExtendOfferMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_690:Array = [];


        public function getMessageArray():Array
        {
            return (_SafeStr_690);
        }

        public function dispose():void
        {
            _SafeStr_690 = null;
        }

        public function get disposed():Boolean
        {
            return (false);
        }


    }
}

