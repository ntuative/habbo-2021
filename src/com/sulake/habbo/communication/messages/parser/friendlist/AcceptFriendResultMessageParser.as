package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.AcceptFriendFailureData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class AcceptFriendResultMessageParser implements IMessageParser 
    {

        private var _SafeStr_1969:Array;


        public function flush():Boolean
        {
            this._SafeStr_1969 = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                this._SafeStr_1969.push(new AcceptFriendFailureData(_arg_1));
                _local_3++;
            };
            return (true);
        }

        public function get failures():Array
        {
            return (this._SafeStr_1969);
        }


    }
}

