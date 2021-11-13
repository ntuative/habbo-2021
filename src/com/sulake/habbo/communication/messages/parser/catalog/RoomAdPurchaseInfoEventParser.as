package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.users.RoomEntryData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomAdPurchaseInfoEventParser implements IMessageParser 
    {

        private var _isVip:Boolean;
        private var _rooms:Array;


        public function flush():Boolean
        {
            return (false);
        }

        public function get rooms():Array
        {
            return (_rooms);
        }

        public function get isVip():Boolean
        {
            return (_isVip);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_5:int;
            var _local_6:String;
            var _local_4:Boolean;
            var _local_7:RoomEntryData;
            _rooms = [];
            _isVip = _arg_1.readBoolean();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _local_5 = _arg_1.readInteger();
                _local_6 = _arg_1.readString();
                _local_4 = _arg_1.readBoolean();
                _local_7 = new RoomEntryData(_local_5, _local_6, _local_4);
                _rooms.push(_local_7);
                _local_3++;
            };
            return (true);
        }


    }
}