package com.sulake.habbo.communication.messages.outgoing.moderator
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

        public class ModerateRoomMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_875:Array = [];

        public function ModerateRoomMessageComposer(_arg_1:int, _arg_2:Boolean, _arg_3:Boolean, _arg_4:Boolean)
        {
            this._SafeStr_875.push(_arg_1);
            this._SafeStr_875.push(((_arg_2) ? 1 : 0));
            this._SafeStr_875.push(((_arg_3) ? 1 : 0));
            this._SafeStr_875.push(((_arg_4) ? 1 : 0));
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

