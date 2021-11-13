package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class UserRemoveMessageParser implements IMessageParser
    {

        private var _id:int = 0;


        public function get id():int
        {
            return (_id);
        }

        public function flush():Boolean
        {
            _id = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            _id = int(_arg_1.readString());
            return (true);
        }


    }
}
