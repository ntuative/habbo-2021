package com.sulake.habbo.communication.messages.incoming.room.pets
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RarityCategoryData 
    {

        private var _chance:int;
        private var _breeds:Array;

        public function RarityCategoryData(_arg_1:IMessageDataWrapper)
        {
            var _local_3:int;
            super();
            _chance = _arg_1.readInteger();
            _breeds = [];
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _breeds.push(_arg_1.readInteger());
                _local_3++;
            };
        }

        public function dispose():void
        {
            _chance = -1;
            _breeds = [];
        }

        public function get chance():int
        {
            return (_chance);
        }

        public function get breeds():Array
        {
            return (_breeds);
        }


    }
}