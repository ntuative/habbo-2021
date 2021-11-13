package com.sulake.habbo.avatar
{
    import com.sulake.core.utils.Map;

    public class AvatarFigureContainer implements IAvatarFigureContainer 
    {

        private var _SafeStr_1332:Map;

        public function AvatarFigureContainer(_arg_1:String)
        {
            _SafeStr_1332 = new Map();
            parseFigureString(_arg_1);
        }

        public function getPartTypeIds():Array
        {
            return (getParts().getKeys());
        }

        public function hasPartType(_arg_1:String):Boolean
        {
            return (!(getParts().getValue(_arg_1) == null));
        }

        public function getPartSetId(_arg_1:String):int
        {
            var _local_2:Map = (getParts().getValue(_arg_1) as Map);
            if (_local_2 != null)
            {
                return (_local_2.getValue("setid") as int);
            };
            return (0);
        }

        public function getPartColorIds(_arg_1:String):Array
        {
            var _local_2:Map = (getParts().getValue(_arg_1) as Map);
            if (_local_2 != null)
            {
                return (_local_2.getValue("colorids") as Array);
            };
            return (null);
        }

        public function updatePart(_arg_1:String, _arg_2:int, _arg_3:Array):void
        {
            var _local_4:Map = new Map();
            _local_4.add("type", _arg_1);
            _local_4.add("setid", _arg_2);
            _local_4.add("colorids", _arg_3);
            var _local_5:Map = getParts();
            _local_5.remove(_arg_1);
            _local_5.add(_arg_1, _local_4);
        }

        public function removePart(_arg_1:String):void
        {
            getParts().remove(_arg_1);
        }

        public function getFigureString():String
        {
            var _local_3:Array;
            var _local_1:Array = [];
            for each (var _local_2:String in getParts().getKeys())
            {
                _local_3 = [];
                _local_3.push(_local_2);
                _local_3.push(getPartSetId(_local_2));
                _local_3 = _local_3.concat(getPartColorIds(_local_2));
                _local_1.push(_local_3.join("-"));
            };
            return (_local_1.join("."));
        }

        private function getParts():Map
        {
            if (_SafeStr_1332 == null)
            {
                _SafeStr_1332 = new Map();
            };
            return (_SafeStr_1332);
        }

        private function parseFigureString(_arg_1:String):void
        {
            var _local_3:Array;
            var _local_6:String;
            var _local_4:int;
            var _local_2:Array;
            var _local_5:int;
            if (_arg_1 == null)
            {
                _arg_1 = "";
            };
            for each (var _local_7:String in _arg_1.split("."))
            {
                _local_3 = _local_7.split("-");
                if (_local_3.length >= 2)
                {
                    _local_6 = String(_local_3[0]);
                    _local_4 = parseInt(_local_3[1]);
                    _local_2 = [];
                    _local_5 = 2;
                    while (_local_5 < _local_3.length)
                    {
                        _local_2.push(parseInt(_local_3[_local_5]));
                        _local_5++;
                    };
                    updatePart(_local_6, _local_4, _local_2);
                };
            };
        }


    }
}

