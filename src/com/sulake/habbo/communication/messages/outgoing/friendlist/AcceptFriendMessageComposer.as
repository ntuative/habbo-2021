package com.sulake.habbo.communication.messages.outgoing.friendlist
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

        public class AcceptFriendMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_1876:Array = [];


        public function getMessageArray():Array
        {
            var _local_2:int;
            var _local_1:Array = [];
            _local_1.push(this._SafeStr_1876.length);
            _local_2 = 0;
            while (_local_2 < this._SafeStr_1876.length)
            {
                _local_1.push(this._SafeStr_1876[_local_2]);
                _local_2++;
            };
            return (_local_1);
        }

        public function addAcceptedRequest(_arg_1:int):void
        {
            this._SafeStr_1876.push(_arg_1);
        }

        public function dispose():void
        {
            this._SafeStr_1876 = null;
        }

        public function get disposed():Boolean
        {
            return (false);
        }


    }
}

