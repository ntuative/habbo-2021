package com.sulake.core.window.utils
{
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import com.sulake.core.utils.Map;
    import flash.utils.getQualifiedClassName;

    public class PropertyStruct
    {

        public static const _SafeStr_879:String = "hex";
        public static const INT:String = "int";
        public static const _SafeStr_880:String = "uint";
        public static const NUMBER:String = "Number";
        public static const BOOLEAN:String = "Boolean";
        public static const STRING:String = "String";
        public static const _SafeStr_881:String = "Point";
        public static const RECTANGLE:String = "Rectangle";
        public static const ARRAY:String = "Array";
        public static const MAP:String = "Map";

        private var _key:String;
        private var _value:Object;
        private var _type:String;
        private var _valid:Boolean;
        private var _SafeStr_1203:Boolean;
        private var _range:Array;

        public function PropertyStruct(_arg_1:String, _arg_2:Object, _arg_3:String, _arg_4:Boolean=false, _arg_5:Array=null)
        {
            _key = _arg_1;
            _value = _arg_2;
            _type = _arg_3;
            _valid = _arg_4;
            _SafeStr_1203 = ((((_arg_3 == "Map") || (_arg_3 == "Array")) || (_arg_3 == "Point")) || (_arg_3 == "Rectangle"));
            _range = _arg_5;
        }

        public function get key():String
        {
            return (_key);
        }

        public function get value():Object
        {
            return (_value);
        }

        public function get type():String
        {
            return (_type);
        }

        public function get valid():Boolean
        {
            return (_valid);
        }

        public function get range():Array
        {
            return (_range);
        }

        public function withNameSpace(_arg_1:String):PropertyStruct
        {
            return (new PropertyStruct(((_arg_1 + ":") + _key), _value, _type, _valid, _range));
        }

        public function withoutNameSpace():PropertyStruct
        {
            return (new PropertyStruct(_key.replace(/.*:/, ""), _value, _type, _valid, _range));
        }

        public function withValue(_arg_1:Object):PropertyStruct
        {
            var _local_2:Array;
            var _local_3:Array;
            var _local_4:int;
            var _local_5:Boolean = true;
            switch (_type)
            {
                case "uint":
                case "hex":
                    _local_5 = (!(_value == uint(_arg_1)));
                    break;
                case "int":
                    _local_5 = (!(_value == int(_arg_1)));
                    break;
                case "Number":
                    _local_5 = (!(_value == Number(_arg_1)));
                    break;
                case "Boolean":
                    _local_5 = (!(_value == _arg_1));
                    break;
                case "String":
                    _local_5 = (!(_value == String(_arg_1)));
                    break;
                case "Array":
                    _local_2 = (_value as Array);
                    _local_3 = (_arg_1 as Array);
                    if ((((!(_local_2 == null)) && (!(_local_3 == null))) && (_local_2.length == _local_3.length)))
                    {
                        _local_5 = false;
                        _local_4 = 0;
                        while (_local_4 < _local_3.length)
                        {
                            if (_local_2[_local_4] != _local_3[_local_4])
                            {
                                _local_5 = true;
                                break;
                            };
                            _local_4++;
                        };
                    };
            };
            if (_local_5)
            {
                return (new PropertyStruct(_key, _arg_1, type, true, _range));
            };
            return (this);
        }

        public function toString():String
        {
            switch (_type)
            {
                case "hex":
                    return ("0x" + _value.toString(16));
                case "Boolean":
                    return ((_value == true) ? "true" : "false");
                case "Point":
                    return (((("Point(" + Point(_value).x) + ", ") + Point(_value).y) + ")");
                case "Rectangle":
                    return (((((((("Rectangle(" + Rectangle(_value).x) + ", ") + Rectangle(_value).y) + ", ") + Rectangle(_value).width) + ", ") + Rectangle(_value).height) + ")");
            };
            return String(value);
        }

        public function toXMLString():String
        {
            var _local_4:int;
            var _local_3:String;
            var _local_5:Map;
            var _local_2:Array;
            var _local_6:Point;
            var _local_1:Rectangle;
            switch (_type)
            {
                case "Map":
                    _local_5 = (_value as Map);
                    _local_3 = (((('<var key="' + _key) + '">\r<value>\r<') + _type) + ">\r");
                    _local_4 = 0;
                    while (_local_4 < _local_5.length)
                    {
                        _local_3 = (_local_3 + (((((('<var key="' + _local_5.getKey(_local_4)) + '" value="') + _local_5.getWithIndex(_local_4)) + '" type="') + getQualifiedClassName(_local_5.getWithIndex(_local_4))) + '" />\r'));
                        _local_4++;
                    };
                    _local_3 = (_local_3 + (("</" + _type) + ">\r</value>\r</var>"));
                    break;
                case "Array":
                    _local_2 = (_value as Array);
                    _local_3 = (((('<var key="' + _key) + '">\r<value>\r<') + _type) + ">\r");
                    _local_4 = 0;
                    while (_local_4 < _local_2.length)
                    {
                        _local_3 = (_local_3 + (((((('<var key="' + _local_4) + '" value="') + _local_2[_local_4]) + '" type="') + getQualifiedClassName(_local_2[_local_4])) + '" />\r'));
                        _local_4++;
                    };
                    _local_3 = (_local_3 + (("</" + _type) + ">\r</value>\r</var>"));
                    break;
                case "Point":
                    _local_6 = (_value as Point);
                    _local_3 = (((('<var key="' + _key) + '">\r<value>\r<') + _type) + ">\r");
                    _local_3 = (_local_3 + (((('<var key="x" value="' + _local_6.x) + '" type="') + "int") + '" />\r'));
                    _local_3 = (_local_3 + (((('<var key="y" value="' + _local_6.y) + '" type="') + "int") + '" />\r'));
                    _local_3 = (_local_3 + (("</" + _type) + ">\r</value>\r</var>"));
                    break;
                case "Rectangle":
                    _local_1 = (_value as Rectangle);
                    _local_3 = (((('<var key="' + _key) + '">\r<value>\r<') + _type) + ">\r");
                    _local_3 = (_local_3 + (((('<var key="x" value="' + _local_1.x) + '" type="') + "int") + '" />\r'));
                    _local_3 = (_local_3 + (((('<var key="y" value="' + _local_1.y) + '" type="') + "int") + '" />\r'));
                    _local_3 = (_local_3 + (((('<var key="width" value="' + _local_1.width) + '" type="') + "int") + '" />\r'));
                    _local_3 = (_local_3 + (((('<var key="height" value="' + _local_1.height) + '" type="') + "int") + '" />\r'));
                    _local_3 = (_local_3 + (("</" + _type) + ">\r</value>\r</var>"));
                    break;
                case "hex":
                    _local_3 = ((((((('<var key="' + _key) + '" value="') + "0x") + _value.toString(16)) + '" type="') + _type) + '" />');
                    break;
                default:
                    _local_3 = (((((('<var key="' + _key) + '" value="') + _value) + '" type="') + _type) + '" />');
            };
            return (_local_3);
        }


    }
}