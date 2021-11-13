package com.sulake.habbo.communication.messages.outgoing.groupforums
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

        public class UpdateThreadMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_875:Array = [];

        public function UpdateThreadMessageComposer(_arg_1:int, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean)
        {
            this._SafeStr_875 = [_arg_1, _arg_2, _arg_4, _arg_3];
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

        public function unwatch(_arg_1:String):void
        {
            // super.unwatch(_arg_1);
        }


    }
}

