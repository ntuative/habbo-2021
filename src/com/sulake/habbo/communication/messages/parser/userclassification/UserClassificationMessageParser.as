package com.sulake.habbo.communication.messages.parser.userclassification
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class UserClassificationMessageParser implements IMessageParser 
    {

        private var _classifiedUsernameMap:Map;
        private var _classifiedUserTypeMap:Map;


        public function flush():Boolean
        {
            if (_classifiedUsernameMap)
            {
                _classifiedUsernameMap.dispose();
                _classifiedUsernameMap = null;
            };
            if (_classifiedUserTypeMap)
            {
                _classifiedUserTypeMap.dispose();
                _classifiedUserTypeMap = null;
            };
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:int;
            var _local_6:String;
            var _local_5:String;
            var _local_3:int;
            var _local_2:int = _arg_1.readInteger();
            _classifiedUsernameMap = new Map();
            _classifiedUserTypeMap = new Map();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _local_4 = _arg_1.readInteger();
                _local_6 = _arg_1.readString();
                _local_5 = _arg_1.readString();
                _classifiedUsernameMap.add(_local_4, _local_6);
                _classifiedUserTypeMap.add(_local_4, _local_5);
                _local_3++;
            };
            return (true);
        }

        public function get classifiedUsernameMap():Map
        {
            return (_classifiedUsernameMap);
        }

        public function get classifiedUserTypeMap():Map
        {
            return (_classifiedUserTypeMap);
        }


    }
}