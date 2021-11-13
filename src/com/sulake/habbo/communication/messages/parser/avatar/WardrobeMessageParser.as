package com.sulake.habbo.communication.messages.parser.avatar
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.avatar.OutfitData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class WardrobeMessageParser implements IMessageParser 
    {

        private var _state:int;
        private var _outfits:Array;


        public function flush():Boolean
        {
            _state = 0;
            _outfits = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:int;
            var _local_2:OutfitData;
            _state = _arg_1.readInteger();
            var _local_3:int = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_2 = new OutfitData(_arg_1);
                _outfits.push(_local_2);
                _local_4++;
            };
            return (true);
        }

        public function get outfits():Array
        {
            return (_outfits);
        }

        public function get state():int
        {
            return (_state);
        }


    }
}