package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class NotificationDialogMessageParser implements IMessageParser 
    {

        private var _type:String;
        private var _parameters:Map;


        public function flush():Boolean
        {
            _type = null;
            _parameters = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_5:String;
            var _local_4:String;
            _type = _arg_1.readString();
            _parameters = new Map();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _local_5 = _arg_1.readString();
                _local_4 = _arg_1.readString();
                _parameters.add(_local_5, _local_4);
                _local_3++;
            };
            return (true);
        }

        public function get type():String
        {
            return (_type);
        }

        public function get parameters():Map
        {
            return (_parameters);
        }


    }
}