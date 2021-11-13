package com.sulake.habbo.communication.messages.parser.room.chat
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ChatMessageParser implements IMessageParser 
    {

        private var _userId:int = 0;
        private var _text:String = "";
        private var _links:Array;
        private var _gesture:int = 0;
        private var _trackingId:int = -1;
        private var _styleId:int = 0;


        public function get userId():int
        {
            return (_userId);
        }

        public function get text():String
        {
            return (_text);
        }

        public function get links():Array
        {
            return (_links);
        }

        public function get gesture():int
        {
            return (_gesture);
        }

        public function get trackingId():int
        {
            return (_trackingId);
        }

        public function get styleId():int
        {
            return (_styleId);
        }

        public function flush():Boolean
        {
            _userId = 0;
            _text = "";
            _gesture = 0;
            _links = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            if (_arg_1 == null)
            {
                return (false);
            };
            _userId = _arg_1.readInteger();
            _text = _arg_1.readString();
            _gesture = _arg_1.readInteger();
            _styleId = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            if (_local_2 > 0)
            {
                _links = [];
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    _links.push([_arg_1.readString(), _arg_1.readString(), _arg_1.readBoolean()]);
                    _local_3++;
                };
            };
            _trackingId = _arg_1.readInteger();
            return (true);
        }


    }
}