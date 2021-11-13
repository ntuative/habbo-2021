package com.sulake.habbo.communication.messages.outgoing.friendlist
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

        public class DeclineFriendMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_1877:Array = [];


        public function getMessageArray():Array
        {
            var _local_2:int;
            var _local_1:Array = [];
            if (this._SafeStr_1877.length == 0)
            {
                _local_1.push(true);
                _local_1.push(0);
            }
            else
            {
                _local_1.push(false);
                _local_1.push(this._SafeStr_1877.length);
                _local_2 = 0;
                while (_local_2 < this._SafeStr_1877.length)
                {
                    _local_1.push(this._SafeStr_1877[_local_2]);
                    _local_2++;
                };
            };
            return (_local_1);
        }

        public function addDeclinedRequest(_arg_1:int):void
        {
            this._SafeStr_1877.push(_arg_1);
        }

        public function dispose():void
        {
            this._SafeStr_1877 = null;
        }

        public function get disposed():Boolean
        {
            return (false);
        }


    }
}

