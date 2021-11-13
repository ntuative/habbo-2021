package com.sulake.habbo.communication.messages.outgoing.moderator
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

        public class CloseIssueDefaultActionMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_875:Array = [];

        public function CloseIssueDefaultActionMessageComposer(_arg_1:int, _arg_2:Array, _arg_3:int)
        {
            var _local_4:int;
            super();
            this._SafeStr_875.push(_arg_1);
            this._SafeStr_875.push(_arg_2.length);
            _local_4 = 0;
            while (_local_4 < _arg_2.length)
            {
                this._SafeStr_875.push(_arg_2[_local_4]);
                _local_4++;
            };
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

