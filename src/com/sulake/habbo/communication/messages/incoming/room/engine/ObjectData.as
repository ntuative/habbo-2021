package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.habbo.room.IStuffData;
    import com.sulake.habbo.room.object.data.LegacyStuffData;

        public class ObjectData 
    {

        private var _id:int = 0;
        private var _state:int = 0;
        private var _data:IStuffData = new LegacyStuffData();

        public function ObjectData(_arg_1:int, _arg_2:int, _arg_3:IStuffData)
        {
            _id = _arg_1;
            _state = _arg_2;
            _data = _arg_3;
        }

        public function get id():int
        {
            return (_id);
        }

        public function get state():int
        {
            return (_state);
        }

        public function get data():IStuffData
        {
            return (_data);
        }


    }
}