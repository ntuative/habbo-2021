package com.sulake.habbo.session.events
{
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionQueueEvent extends RoomSessionEvent 
    {

        public static const QUEUE_STATUS:String = "RSQE_QUEUE_STATUS";
        public static const _SafeStr_3687:String = "c";
        public static const QUEUE_TYPE_NORMAL:String = "d";
        public static const _SafeStr_3688:int = 2;
        public static const _SafeStr_3689:int = 1;

        private var _queueSetName:String;
        private var _queueSetTarget:int;
        private var _SafeStr_2086:Map;
        private var _isActive:Boolean;
        private var _SafeStr_3690:String;

        public function RoomSessionQueueEvent(_arg_1:IRoomSession, _arg_2:String, _arg_3:int, _arg_4:Boolean=false, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super("RSQE_QUEUE_STATUS", _arg_1, _arg_5, _arg_6);
            _queueSetName = _arg_2;
            _queueSetTarget = _arg_3;
            _SafeStr_2086 = new Map();
            _isActive = _arg_4;
        }

        public function get isActive():Boolean
        {
            return (_isActive);
        }

        public function get queueSetName():String
        {
            return (_queueSetName);
        }

        public function get queueSetTarget():int
        {
            return (_queueSetTarget);
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

