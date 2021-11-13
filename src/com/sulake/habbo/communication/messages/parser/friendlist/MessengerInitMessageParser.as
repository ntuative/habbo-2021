package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendCategoryData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class MessengerInitMessageParser implements IMessageParser 
    {

        private var _SafeStr_1979:int;
        private var _SafeStr_1980:int;
        private var _SafeStr_1981:int;
        private var _SafeStr_575:Array;


        public function flush():Boolean
        {
            this._SafeStr_575 = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            this._SafeStr_1979 = _arg_1.readInteger();
            this._SafeStr_1980 = _arg_1.readInteger();
            this._SafeStr_1981 = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                this._SafeStr_575.push(new FriendCategoryData(_arg_1));
                _local_3++;
            };
            return (true);
        }

        public function get userFriendLimit():int
        {
            return (this._SafeStr_1979);
        }

        public function get normalFriendLimit():int
        {
            return (this._SafeStr_1980);
        }

        public function get extendedFriendLimit():int
        {
            return (this._SafeStr_1981);
        }

        public function get categories():Array
        {
            return (this._SafeStr_575);
        }


    }
}

