package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FaqCategoryMessageParser implements IMessageParser 
    {

        private var _categoryId:int;
        private var _description:String;
        private var _data:Map;


        public function get categoryId():int
        {
            return (_categoryId);
        }

        public function get description():String
        {
            return (_description);
        }

        public function get data():Map
        {
            return (_data);
        }

        public function flush():Boolean
        {
            if (_data != null)
            {
                _data.dispose();
            };
            _data = null;
            _categoryId = -1;
            _description = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            var _local_5:String;
            var _local_4:int;
            _data = new Map();
            _categoryId = _arg_1.readInteger();
            _description = _arg_1.readString();
            var _local_3:int = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_2 = _arg_1.readInteger();
                _local_5 = _arg_1.readString();
                _data.add(_local_2, _local_5);
                _local_4++;
            };
            return (true);
        }


    }
}