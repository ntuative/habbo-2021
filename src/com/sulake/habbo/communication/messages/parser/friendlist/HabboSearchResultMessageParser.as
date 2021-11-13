package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.HabboSearchResultData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class HabboSearchResultMessageParser implements IMessageParser 
    {

        private var _SafeStr_1479:Array;
        private var _others:Array;


        public function flush():Boolean
        {
            this._SafeStr_1479 = [];
            this._others = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                this._SafeStr_1479.push(new HabboSearchResultData(_arg_1));
                _local_3++;
            };
            var _local_4:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_4)
            {
                this._others.push(new HabboSearchResultData(_arg_1));
                _local_3++;
            };
            return (true);
        }

        public function get friends():Array
        {
            return (this._SafeStr_1479);
        }

        public function get others():Array
        {
            return (this._others);
        }


    }
}

