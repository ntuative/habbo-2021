package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendCategoryData;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FriendListUpdateMessageParser implements IMessageParser 
    {

        private var _SafeStr_1970:Array;
        private var _SafeStr_1971:Array;
        private var _SafeStr_1972:Array;
        private var _SafeStr_1973:Array;


        public function flush():Boolean
        {
            this._SafeStr_1970 = [];
            this._SafeStr_1971 = [];
            this._SafeStr_1972 = [];
            this._SafeStr_1973 = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_5:int;
            var _local_6:int;
            var _local_4:int;
            var _local_2:int = _arg_1.readInteger();
            _local_5 = 0;
            while (_local_5 < _local_2)
            {
                this._SafeStr_1970.push(new FriendCategoryData(_arg_1));
                _local_5++;
            };
            var _local_3:int = _arg_1.readInteger();
            _local_5 = 0;
            while (_local_5 < _local_3)
            {
                _local_6 = _arg_1.readInteger();
                if (_local_6 == -1)
                {
                    _local_4 = _arg_1.readInteger();
                    this._SafeStr_1971.push(_local_4);
                }
                else
                {
                    if (_local_6 == 0)
                    {
                        this._SafeStr_1973.push(new FriendData(_arg_1));
                    }
                    else
                    {
                        if (_local_6 == 1)
                        {
                            this._SafeStr_1972.push(new FriendData(_arg_1));
                        };
                    };
                };
                _local_5++;
            };
            return (true);
        }

        public function get cats():Array
        {
            return (this._SafeStr_1970);
        }

        public function get removedFriendIds():Array
        {
            return (this._SafeStr_1971);
        }

        public function get addedFriends():Array
        {
            return (this._SafeStr_1972);
        }

        public function get updatedFriends():Array
        {
            return (this._SafeStr_1973);
        }


    }
}

