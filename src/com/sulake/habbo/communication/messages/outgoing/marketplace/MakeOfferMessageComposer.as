package com.sulake.habbo.communication.messages.outgoing.marketplace
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

        public class MakeOfferMessageComposer implements IMessageComposer, IDisposable 
    {

        public static const _SafeStr_1900:int = 1;
        public static const _SafeStr_1901:int = 2;

        private var _SafeStr_875:Array = [];

        public function MakeOfferMessageComposer(_arg_1:int, _arg_2:int, _arg_3:int)
        {
            this._SafeStr_875.push(_arg_1);
            this._SafeStr_875.push(_arg_2);
            this._SafeStr_875.push(_arg_3);
        }

        public function getMessageArray():Array
        {
            return (this._SafeStr_875);
        }

        public function dispose():void
        {
            this._SafeStr_875 = null;
        }

        public function get disposed():Boolean
        {
            return (false);
        }


    }
}

