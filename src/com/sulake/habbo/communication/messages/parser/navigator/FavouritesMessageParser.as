package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FavouritesMessageParser implements IMessageParser 
    {

        private var _limit:int;
        private var _favouriteRoomIds:Array;


        public function flush():Boolean
        {
            _favouriteRoomIds = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            this._limit = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _favouriteRoomIds.push(_arg_1.readInteger());
                _local_3++;
            };
            return (true);
        }

        public function get limit():int
        {
            return (_limit);
        }

        public function get favouriteRoomIds():Array
        {
            return (_favouriteRoomIds);
        }


    }
}