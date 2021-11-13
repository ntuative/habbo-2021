package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FriendRequestsMessageParser implements IMessageParser 
    {

        private var _SafeStr_1974:int;
        private var _SafeStr_1975:Array;


        public function flush():Boolean
        {
            this._SafeStr_1975 = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            this._SafeStr_1974 = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            Logger.log(((("Received friend requests: " + _SafeStr_1974) + ", ") + _local_2));
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                this._SafeStr_1975.push(new FriendRequestData(_arg_1));
                _local_3++;
            };
            return (true);
        }

        public function get totalReqCount():int
        {
            return (this._SafeStr_1974);
        }

        public function get reqs():Array
        {
            return (this._SafeStr_1975);
        }


    }
}

