package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class OneWayDoorStatusMessageParser implements IMessageParser 
    {

        private var _id:int;
        private var _status:int;


        public function get id():int
        {
            return (_id);
        }

        public function get status():int
        {
            return (_status);
        }

        public function flush():Boolean
        {
            _id = -1;
            _status = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            _id = _arg_1.readInteger();
            _status = _arg_1.readInteger();
            return (true);
        }


    }
}