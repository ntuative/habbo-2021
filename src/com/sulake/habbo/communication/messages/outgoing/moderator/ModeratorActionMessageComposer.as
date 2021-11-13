package com.sulake.habbo.communication.messages.outgoing.moderator
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

        public class ModeratorActionMessageComposer implements IMessageComposer, IDisposable 
    {

        public static const _SafeStr_1902:int = 0;
        public static const _SafeStr_1903:int = 1;
        public static const _SafeStr_1904:int = 3;
        public static const _SafeStr_1905:int = 4;

        private var _SafeStr_875:Array = [];

        public function ModeratorActionMessageComposer(_arg_1:int, _arg_2:String, _arg_3:String)
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

