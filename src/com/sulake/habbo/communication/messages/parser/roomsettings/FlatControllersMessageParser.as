package com.sulake.habbo.communication.messages.parser.roomsettings
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FlatControllersMessageParser implements IMessageParser 
    {

        private var _roomId:int;
        private var _controllers:Array;


        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            _roomId = _arg_1.readInteger();
            var _local_3:int = _arg_1.readInteger();
            _local_2 = 0;
            while (_local_2 < _local_3)
            {
                _controllers.push(new FlatControllerData(_arg_1));
                _local_2++;
            };
            return (true);
        }

        public function flush():Boolean
        {
            _controllers = [];
            return (true);
        }

        public function get roomId():int
        {
            return (_roomId);
        }

        public function get controllers():Array
        {
            return (_controllers);
        }


    }
}