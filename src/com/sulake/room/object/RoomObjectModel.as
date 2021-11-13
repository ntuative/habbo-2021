package com.sulake.room.object
{
    import flash.utils.Dictionary;
    import com.sulake.core.utils.Map;

    public class RoomObjectModel implements IRoomObjectModelController 
    {

        private static const MAP_KEYS_PREFIX:String = "ROMC_MAP_KEYS_";
        private static const MAP_VALUES_PREFIX:String = "ROMC_MAP_VALUES_";

        private var _SafeStr_4468:Dictionary;
        private var _SafeStr_4469:Dictionary;
        private var _SafeStr_4470:Dictionary;
        private var _SafeStr_4471:Dictionary;
        private var _SafeStr_4472:Array;
        private var _SafeStr_4473:Array;
        private var _SafeStr_4474:Array;
        private var _SafeStr_4475:Array;
        private var _SafeStr_4463:int;

        public function RoomObjectModel()
        {
            _SafeStr_4468 = new Dictionary();
            _SafeStr_4469 = new Dictionary();
            _SafeStr_4470 = new Dictionary();
            _SafeStr_4471 = new Dictionary();
            _SafeStr_4472 = [];
            _SafeStr_4473 = [];
            _SafeStr_4474 = [];
            _SafeStr_4475 = [];
            _SafeStr_4463 = 0;
        }

        public function dispose():void
        {
            var _local_1:String;
            if (_SafeStr_4468 != null)
            {
                for (_local_1 in _SafeStr_4468)
                {
                    delete _SafeStr_4468[_local_1];
                };
                _SafeStr_4468 = null;
            };
            if (_SafeStr_4469 != null)
            {
                for (_local_1 in _SafeStr_4469)
                {
                    delete _SafeStr_4469[_local_1];
                };
                _SafeStr_4469 = null;
            };
            if (_SafeStr_4470 != null)
            {
                for (_local_1 in _SafeStr_4470)
                {
                    delete _SafeStr_4470[_local_1];
                };
                _SafeStr_4470 = null;
            };
            if (_SafeStr_4471 != null)
            {
                for (_local_1 in _SafeStr_4471)
                {
                    delete _SafeStr_4471[_local_1];
                };
                _SafeStr_4471 = null;
            };
            _SafeStr_4473 = [];
            _SafeStr_4472 = [];
            _SafeStr_4475 = [];
            _SafeStr_4474 = [];
        }

        public function hasNumber(_arg_1:String):Boolean
        {
            return (!(_SafeStr_4468[_arg_1] == null));
        }

        public function hasNumberArray(_arg_1:String):Boolean
        {
            return (!(_SafeStr_4470[_arg_1] == null));
        }

        public function hasString(_arg_1:String):Boolean
        {
            return (!(_SafeStr_4469[_arg_1] == null));
        }

        public function hasStringArray(_arg_1:String):Boolean
        {
            return (!(_SafeStr_4471[_arg_1] == null));
        }

        public function getNumber(_arg_1:String):Number
        {
            return (_SafeStr_4468[_arg_1]);
        }

        public function getString(_arg_1:String):String
        {
            return (_SafeStr_4469[_arg_1]);
        }

        public function getNumberArray(_arg_1:String):Array
        {
            var _local_2:Array = _SafeStr_4470[_arg_1];
            if (_local_2 != null)
            {
                _local_2 = _local_2.slice();
            };
            return (_local_2);
        }

        public function getStringArray(_arg_1:String):Array
        {
            var _local_2:Array = _SafeStr_4471[_arg_1];
            if (_local_2 != null)
            {
                _local_2 = _local_2.slice();
            };
            return (_local_2);
        }

        public function getStringToStringMap(_arg_1:String):Map
        {
            var _local_4:int;
            var _local_5:Map = new Map();
            var _local_2:Array = getStringArray(("ROMC_MAP_KEYS_" + _arg_1));
            var _local_3:Array = getStringArray(("ROMC_MAP_VALUES_" + _arg_1));
            if ((((!(_local_2 == null)) && (!(_local_3 == null))) && (_local_2.length == _local_3.length)))
            {
                _local_4 = 0;
                while (_local_4 < _local_2.length)
                {
                    _local_5.add(_local_2[_local_4], _local_3[_local_4]);
                    _local_4++;
                };
            };
            return (_local_5);
        }

        public function setNumber(_arg_1:String, _arg_2:Number, _arg_3:Boolean=false):void
        {
            if (_SafeStr_4472.indexOf(_arg_1) >= 0)
            {
                return;
            };
            if (_arg_3)
            {
                _SafeStr_4472.push(_arg_1);
            };
            if (_SafeStr_4468[_arg_1] != _arg_2)
            {
                _SafeStr_4468[_arg_1] = _arg_2;
                _SafeStr_4463++;
            };
        }

        public function setString(_arg_1:String, _arg_2:String, _arg_3:Boolean=false):void
        {
            if (_SafeStr_4473.indexOf(_arg_1) >= 0)
            {
                return;
            };
            if (_arg_3)
            {
                _SafeStr_4473.push(_arg_1);
            };
            if (_SafeStr_4469[_arg_1] != _arg_2)
            {
                _SafeStr_4469[_arg_1] = _arg_2;
                _SafeStr_4463++;
            };
        }

        public function setNumberArray(_arg_1:String, _arg_2:Array, _arg_3:Boolean=false):void
        {
            if (_arg_2 == null)
            {
                return;
            };
            if (_SafeStr_4474.indexOf(_arg_1) >= 0)
            {
                return;
            };
            if (_arg_3)
            {
                _SafeStr_4474.push(_arg_1);
            };
            var _local_6:Array = [];
            var _local_7:int;
            _local_7 = 0;
            while (_local_7 < _arg_2.length)
            {
                if ((_arg_2[_local_7] is Number))
                {
                    _local_6.push(_arg_2[_local_7]);
                };
                _local_7++;
            };
            var _local_5:Array = _SafeStr_4470[_arg_1];
            var _local_4:Boolean = true;
            if (((!(_local_5 == null)) && (_local_5.length == _local_6.length)))
            {
                _local_7 = (_local_6.length - 1);
                while (_local_7 >= 0)
                {
                    if ((_local_6[_local_7] as Number) != (_local_5[_local_7] as Number))
                    {
                        _local_4 = false;
                        break;
                    };
                    _local_7--;
                };
            }
            else
            {
                _local_4 = false;
            };
            if (_local_4)
            {
                return;
            };
            _SafeStr_4470[_arg_1] = _local_6;
            _SafeStr_4463++;
        }

        public function setStringArray(_arg_1:String, _arg_2:Array, _arg_3:Boolean=false):void
        {
            if (_arg_2 == null)
            {
                return;
            };
            if (_SafeStr_4475.indexOf(_arg_1) >= 0)
            {
                return;
            };
            if (_arg_3)
            {
                _SafeStr_4475.push(_arg_1);
            };
            var _local_6:Array = [];
            var _local_7:int;
            _local_7 = 0;
            while (_local_7 < _arg_2.length)
            {
                if ((_arg_2[_local_7] is String))
                {
                    _local_6.push(_arg_2[_local_7]);
                };
                _local_7++;
            };
            var _local_5:Array = _SafeStr_4471[_arg_1];
            var _local_4:Boolean = true;
            if (((!(_local_5 == null)) && (_local_5.length == _local_6.length)))
            {
                _local_7 = (_local_6.length - 1);
                while (_local_7 >= 0)
                {
                    if ((_local_6[_local_7] as String) != (_local_5[_local_7] as String))
                    {
                        _local_4 = false;
                        break;
                    };
                    _local_7--;
                };
            }
            else
            {
                _local_4 = false;
            };
            if (_local_4)
            {
                return;
            };
            _SafeStr_4471[_arg_1] = _local_6;
            _SafeStr_4463++;
        }

        public function setStringToStringMap(_arg_1:String, _arg_2:Map, _arg_3:Boolean=false):void
        {
            if (_arg_2 == null)
            {
                return;
            };
            setStringArray(("ROMC_MAP_KEYS_" + _arg_1), _arg_2.getKeys(), _arg_3);
            setStringArray(("ROMC_MAP_VALUES_" + _arg_1), _arg_2.getValues(), _arg_3);
        }

        public function getUpdateID():int
        {
            return (_SafeStr_4463);
        }


    }
}

