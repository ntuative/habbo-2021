package com.sulake.habbo.communication.messages.outgoing.moderator
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

        public class ModMuteMessageComposer implements IMessageComposer, IDisposable 
    {

        public static const _SafeStr_1885:int = -1;

        private var _SafeStr_875:Array = [];

        public function ModMuteMessageComposer(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:int)
        {
            this._SafeStr_875.push(_arg_1);
            this._SafeStr_875.push(_arg_2);
            this._SafeStr_875.push(_arg_3);
            if (_arg_4 != -1)
            {
                this._SafeStr_875.push(_arg_4);
            };
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

