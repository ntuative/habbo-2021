package com.adobe.serialization.json
{
    import __AS3__.vec.Vector;
    import flash.utils.describeType;

    public class JSONEncoder
    {

        private var jsonString:String;

        public function JSONEncoder(_arg_1:*)
        {
            jsonString = convertToString(_arg_1);
        }

        public function getString():String
        {
            return (jsonString);
        }

        private function convertToString(_arg_1:*):String
        {
            if ((_arg_1 is String))
            {
                return (escapeString((_arg_1 as String)));
            };
            if ((_arg_1 is Number))
            {
                return ((isFinite((_arg_1 as Number))) ? _arg_1.toString() : "null");
            };
            if ((_arg_1 is Boolean))
            {
                return ((_arg_1) ? "true" : "false");
            };
            if ((_arg_1 is Array))
            {
                return (arrayToString((_arg_1 as Array)));
            };
            if ((_arg_1 is Vector.<*>))
            {
                return (vectorToString(_arg_1));
            };
            if (((_arg_1 is Object) && (!(_arg_1 == null))))
            {
                return (objectToString(_arg_1));
            };
            return ("null");
        }

        private function escapeString(_arg_1:String):String
        {
            var _local_6:String;
            var _local_7:int;
            var _local_5:String;
            var _local_2:String;
            var _local_3:String = "";
            var _local_4:Number = _arg_1.length;
            _local_7 = 0;
            while (_local_7 < _local_4)
            {
                _local_6 = _arg_1.charAt(_local_7);
                switch (_local_6)
                {
                    case '"':
                        _local_3 = (_local_3 + '\\"');
                        break;
                    case "\\":
                        _local_3 = (_local_3 + "\\\\");
                        break;
                    case "\b":
                        _local_3 = (_local_3 + "\\b");
                        break;
                    case "\f":
                        _local_3 = (_local_3 + "\\f");
                        break;
                    case "\n":
                        _local_3 = (_local_3 + "\\n");
                        break;
                    case "\r":
                        _local_3 = (_local_3 + "\\r");
                        break;
                    case "\t":
                        _local_3 = (_local_3 + "\\t");
                        break;
                    default:
                        if (_local_6 < " ")
                        {
                            _local_5 = _local_6.charCodeAt(0).toString(16);
                            _local_2 = ((_local_5.length == 2) ? "00" : "000");
                            _local_3 = (_local_3 + (("\\u" + _local_2) + _local_5));
                        }
                        else
                        {
                            _local_3 = (_local_3 + _local_6);
                        };
                };
                _local_7++;
            };
            return (('"' + _local_3) + '"');
        }

        private function arrayToString(_arg_1:Array):String
        {
            var _local_4:int;
            var _local_2:String = "";
            var _local_3:int = _arg_1.length;
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                if (_local_2.length > 0)
                {
                    _local_2 = (_local_2 + ",");
                };
                _local_2 = (_local_2 + convertToString(_arg_1[_local_4]));
                _local_4++;
            };
            return (("[" + _local_2) + "]");
        }

        private function vectorToString(_arg_1:Vector.<*>):String
        {
            var _local_4:int;
            var _local_2:String = "";
            var _local_3:int = _arg_1.length;
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                if (_local_2.length > 0)
                {
                    _local_2 = (_local_2 + ",");
                };
                _local_2 = (_local_2 + convertToString(_arg_1[_local_4]));
                _local_4++;
            };
            return (("[" + _local_2) + "]");
        }

        private function objectToString(_arg_1:Object):String
        {
            var _local_5:Object;
            var _local_3:String = "";
            var _local_2:XML = describeType(_arg_1);
            if (_local_2.@name.toString() == "Object")
            {
                for (var _local_6:String in _arg_1)
                {
                    _local_5 = _arg_1[_local_6];
                    if (!(_local_5 is Function))
                    {
                        if (_local_3.length > 0)
                        {
                            _local_3 = (_local_3 + ",");
                        };
                        _local_3 = (_local_3 + ((escapeString(_local_6) + ":") + convertToString(_local_5)));
                    };
                };
            }
            else
            {
                for each (var _local_4:XML in _local_2..*.((name() == "variable") || ((name() == "accessor") && (attribute("access").charAt(0) == "r"))))
                {
                    if (!((_local_4.metadata) && (_local_4.metadata.(@name == "Transient").length() > 0)))
                    {
                        if (_local_3.length > 0)
                        {
                            _local_3 = (_local_3 + ",");
                        };
                        _local_3 = (_local_3 + ((escapeString(_local_4.@name.toString()) + ":") + convertToString(_arg_1[_local_4.@name])));
                    };
                };
            };
            return (("{" + _local_3) + "}");
        }


    }
}
