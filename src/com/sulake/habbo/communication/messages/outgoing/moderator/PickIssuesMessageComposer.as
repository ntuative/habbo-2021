package com.sulake.habbo.communication.messages.outgoing.moderator
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

        public class PickIssuesMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_875:Array = [];

        public function PickIssuesMessageComposer(_arg_1:Array, _arg_2:Boolean, _arg_3:int, _arg_4:String)
        {
            var _local_5:int;
            super();
            this._SafeStr_875.push(_arg_1.length);
            _local_5 = 0;
            while (_local_5 < _arg_1.length)
            {
                this._SafeStr_875.push(_arg_1[_local_5]);
                _local_5++;
            };
            this._SafeStr_875.push(_arg_2);
            this._SafeStr_875.push(_arg_3);
            this._SafeStr_875.push(_arg_4);
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

