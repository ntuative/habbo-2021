package com.sulake.core.window.utils
{
    import com.sulake.core.utils.XMLVariableParser;
    import com.sulake.core.utils.Map;

    public class XMLPropertyArrayParser extends XMLVariableParser 
    {


        public static function parse(_arg_1:XMLList):Array
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:Map = new Map();
            var _local_3:Array = [];
            var _local_2:Array = [];
            _local_4 = XMLVariableParser.parseVariableList(_arg_1, _local_6, _local_3);
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_2.push(new PropertyStruct(_local_6.getKey(_local_5), _local_6.getWithIndex(_local_5), _local_3[_local_5], true));
                _local_5++;
            };
            return (_local_2);
        }


    }
}