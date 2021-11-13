package com.sulake.habbo.room.utils
{
    import __AS3__.vec.Vector;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.utils.IVector3d;

        public class TileObjectMap 
    {

        private var _SafeStr_3616:Vector.<Vector.<IRoomObject>>;
        private var _width:int = 0;
        private var _SafeStr_1113:int = 0;

        public function TileObjectMap(_arg_1:int, _arg_2:int)
        {
            var _local_3:int;
            super();
            _SafeStr_3616 = new Vector.<Vector.<IRoomObject>>(_arg_2, true);
            _local_3 = 0;
            while (_local_3 < _arg_2)
            {
                _SafeStr_3616[_local_3] = new Vector.<IRoomObject>(_arg_1, true);
                _local_3++;
            };
            _width = _arg_1;
            _SafeStr_1113 = _arg_2;
        }

        public function clear():void
        {
            var _local_2:int;
            for each (var _local_1:Vector.<IRoomObject> in _SafeStr_3616)
            {
                _local_2 = 0;
                while (_local_2 < _width)
                {
                    _local_1[_local_2] = null;
                    _local_2++;
                };
            };
        }

        public function populate(_arg_1:Array):void
        {
            clear();
            for each (var _local_2:IRoomObject in _arg_1)
            {
                addRoomObject(_local_2);
            };
        }

        public function dispose():void
        {
            _SafeStr_3616 = null;
            _width = 0;
            _SafeStr_1113 = 0;
        }

        public function getObjectIntTile(_arg_1:int, _arg_2:int):IRoomObject
        {
            if (((((_arg_1 >= 0) && (_arg_1 < _width)) && (_arg_2 >= 0)) && (_arg_2 < _SafeStr_1113)))
            {
                return (_SafeStr_3616[_arg_2][_arg_1]);
            };
            return (null);
        }

        public function setObjectInTile(_arg_1:int, _arg_2:int, _arg_3:IRoomObject):void
        {
            if (!_arg_3.isInitialized())
            {
                Logger.log("Assigning non initialized object to tile object map!");
                return;
            };
            if (((((_arg_1 >= 0) && (_arg_1 < _width)) && (_arg_2 >= 0)) && (_arg_2 < _SafeStr_1113)))
            {
                _SafeStr_3616[_arg_2][_arg_1] = _arg_3;
            };
        }

        public function addRoomObject(_arg_1:IRoomObject):void
        {
            var _local_4:IRoomObject;
            var _local_8:int;
            var _local_6:int;
            if ((((_arg_1 == null) || (_arg_1.getModel() == null)) || (!(_arg_1.isInitialized()))))
            {
                return;
            };
            var _local_2:IVector3d = _arg_1.getLocation();
            if (_local_2 == null)
            {
                return;
            };
            var _local_9:IVector3d = _arg_1.getDirection();
            if (_local_9 == null)
            {
                return;
            };
            var _local_5:int = _arg_1.getModel().getNumber("furniture_size_x");
            var _local_10:int = _arg_1.getModel().getNumber("furniture_size_y");
            if (_local_5 < 1)
            {
                _local_5 = 1;
            };
            if (_local_10 < 1)
            {
                _local_10 = 1;
            };
            var _local_3:int;
            var _local_7:int = int((((_local_9.x + 45) % 360) / 90));
            if (((_local_7 == 1) || (_local_7 == 3)))
            {
                _local_3 = _local_5;
                _local_5 = _local_10;
                _local_10 = _local_3;
            };
            _local_8 = _local_2.y;
            while (_local_8 < (_local_2.y + _local_10))
            {
                _local_6 = _local_2.x;
                while (_local_6 < (_local_2.x + _local_5))
                {
                    _local_4 = getObjectIntTile(_local_6, _local_8);
                    if (((!(_local_4)) || ((!(_local_4 == _arg_1)) && (_local_4.getLocation().z <= _local_2.z))))
                    {
                        setObjectInTile(_local_6, _local_8, _arg_1);
                    };
                    _local_6++;
                };
                _local_8++;
            };
        }

        public function toString():String
        {
            var _local_4:IRoomObject;
            var _local_3:int;
            var _local_2:int;
            var _local_1:String = "";
            _local_3 = 0;
            while (_local_3 < _SafeStr_1113)
            {
                _local_2 = 0;
                while (_local_2 < _width)
                {
                    _local_4 = _SafeStr_3616[_local_3][_local_2];
                    _local_1 = (_local_1 + (((_local_4) ? _local_4.getId() : "x") + "\t"));
                    _local_2++;
                };
                _local_1 = (_local_1 + "\n");
                _local_3++;
            };
            return (_local_1);
        }


    }
}

