package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FaqClientFaqsMessageParser implements IMessageParser 
    {

        private var _urgentData:Map;
        private var _normalData:Map;


        public function get urgentData():Map
        {
            return (_urgentData);
        }

        public function get normalData():Map
        {
            return (_normalData);
        }

        public function flush():Boolean
        {
            if (_urgentData != null)
            {
                _urgentData.dispose();
            };
            _urgentData = null;
            if (_normalData != null)
            {
                _normalData.dispose();
            };
            _normalData = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            var _local_5:String;
            var _local_4:int;
            var _local_3:int;
            _urgentData = new Map();
            _normalData = new Map();
            _local_3 = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_2 = _arg_1.readInteger();
                _local_5 = _arg_1.readString();
                _urgentData.add(_local_2, _local_5);
                _local_4++;
            };
            _local_3 = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_2 = _arg_1.readInteger();
                _local_5 = _arg_1.readString();
                _normalData.add(_local_2, _local_5);
                _local_4++;
            };
            return (true);
        }


    }
}