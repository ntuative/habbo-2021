package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GamePlayerValueMessageParser implements IMessageParser 
    {

        private var _userId:int = 0;
        private var _value:int = 0;


        public function get userId():int
        {
            return (_userId);
        }

        public function get value():int
        {
            return (_value);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _userId = _arg_1.readInteger();
            _value = _arg_1.readInteger();
            return (true);
        }


    }
}