package com.sulake.habbo.help.cfh.registry.user
{
    import com.sulake.core.utils.Map;

    public class UserRegistry 
    {

        private static const MAX_USERS_TO_STORE:int = 80;

        private var _registry:Map = new Map();
        private var _roomName:String = "";
        private var _roomId:int;
        private var _SafeStr_2657:Array = [];


        public function getRegistry():Map
        {
            return (_registry);
        }

        public function getEntry(_arg_1:int):UserRegistryItem
        {
            return (_registry[_arg_1]);
        }

        public function registerRoom(_arg_1:int, _arg_2:String):void
        {
            _roomId = _arg_1;
            _roomName = _arg_2;
            if (_roomName != "")
            {
                addRoomNameForMissing();
            };
        }

        public function registerUser(_arg_1:int, _arg_2:String, _arg_3:String=""):void
        {
            var _local_4:UserRegistryItem;
            if (_registry.getValue(_arg_1) != null)
            {
                _registry.remove(_arg_1);
            };
            _local_4 = new UserRegistryItem(_arg_1, _arg_2, _arg_3, _roomId, _roomName);
            if (_roomName == "")
            {
                _SafeStr_2657.push(_arg_1);
            };
            _registry.add(_arg_1, _local_4);
            purgeUserIndex();
        }

        private function purgeUserIndex():void
        {
            var _local_1:int;
            while (_registry.length > 80)
            {
                _local_1 = _registry.getKey(0);
                _registry.remove(_local_1);
            };
        }

        private function addRoomNameForMissing():void
        {
            var _local_1:UserRegistryItem;
            while (_SafeStr_2657.length > 0)
            {
                _local_1 = _registry.getValue(_SafeStr_2657.shift());
                if (((!(_local_1 == null)) && (_local_1.roomId == _roomId)))
                {
                    _local_1.roomName = _roomName;
                };
            };
        }

        public function get roomName():String
        {
            return (_roomName);
        }

        public function get roomId():int
        {
            return (_roomId);
        }


    }
}

