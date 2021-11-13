package com.sulake.habbo.communication.messages.outgoing.vault
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.util.Byte;

        public class IncomeRewardClaimMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_875:Array = [];

        public function IncomeRewardClaimMessageComposer(_arg_1:int)
        {
            _SafeStr_875.push(new Byte(_arg_1));
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

