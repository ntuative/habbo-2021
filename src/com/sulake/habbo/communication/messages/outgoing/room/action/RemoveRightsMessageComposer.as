package com.sulake.habbo.communication.messages.outgoing.room.action
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

        public class RemoveRightsMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_875:Array = [];

        public function RemoveRightsMessageComposer(_arg_1:Array)
        {
            var _local_2:int;
            super();
            this._SafeStr_875.push(_arg_1.length);
            _local_2 = 0;
            while (_local_2 < _arg_1.length)
            {
                this._SafeStr_875.push(_arg_1[_local_2]);
                _local_2++;
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

