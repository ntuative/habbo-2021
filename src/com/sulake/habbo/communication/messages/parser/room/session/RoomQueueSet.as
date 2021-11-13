package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.utils.Map;

        public class RoomQueueSet 
    {

        private var _name:String;
        private var _target:int;
        private var _SafeStr_2086:Map;

        public function RoomQueueSet(_arg_1:String, _arg_2:int)
        {
            _name = _arg_1;
            _target = _arg_2;
            _SafeStr_2086 = new Map();
        }

        public function get name():String
        {
            return (_name);
        }

        public function get target():int
        {
            return (_target);
        }

        public function get queueTypes():Array
        {
            return (_SafeStr_2086.getKeys());
        }

        public function getQueueSize(_arg_1:String):int
        {
            return (_SafeStr_2086.getValue(_arg_1));
        }

        public function addQueue(_arg_1:String, _arg_2:int):void
        {
            _SafeStr_2086.add(_arg_1, _arg_2);
        }


    }
}

