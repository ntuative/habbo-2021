package com.sulake.habbo.communication.messages.parser.newnavigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.newnavigator.LiftedRoomData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class NavigatorLiftedRoomsParser implements IMessageParser 
    {

        private var _liftedRooms:Vector.<LiftedRoomData>;


        public function flush():Boolean
        {
            _liftedRooms = new Vector.<LiftedRoomData>();
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _liftedRooms.push(new LiftedRoomData(_arg_1));
                _local_3++;
            };
            return (true);
        }

        public function get liftedRooms():Vector.<LiftedRoomData>
        {
            return (_liftedRooms);
        }


    }
}