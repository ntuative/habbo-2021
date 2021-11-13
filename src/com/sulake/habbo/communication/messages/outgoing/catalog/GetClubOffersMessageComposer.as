package com.sulake.habbo.communication.messages.outgoing.catalog
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

        public class GetClubOffersMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_690:Array = [];

        public function GetClubOffersMessageComposer(_arg_1:int)
        {
            _SafeStr_690 = [_arg_1];
        }

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
            return (_SafeStr_690 == null);
        }


    }
}

