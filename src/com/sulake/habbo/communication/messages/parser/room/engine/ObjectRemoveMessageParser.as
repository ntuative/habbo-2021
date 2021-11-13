package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ObjectRemoveMessageParser implements IMessageParser
    {

        private var _id:int;
        private var _isExpired:Boolean;
        private var _pickerId:int;
        private var _delay:int;


        public function get id():int
        {
            return (_id);
        }

        public function get isExpired():Boolean
        {
            return (_isExpired);
        }

        public function get pickerId():int
        {
            return (_pickerId);
        }

        public function get delay():int
        {
            return (_delay);
        }

        public function flush():Boolean
        {
            _id = 0;
            _delay = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            _id = int(_arg_1.readString());
            _isExpired = _arg_1.readBoolean();
            _pickerId = _arg_1.readInteger();
            _delay = _arg_1.readInteger();
            return (true);
        }


    }
}
