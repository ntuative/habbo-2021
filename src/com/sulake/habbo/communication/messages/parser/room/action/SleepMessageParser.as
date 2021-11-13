package com.sulake.habbo.communication.messages.parser.room.action
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class SleepMessageParser implements IMessageParser 
    {

        private var _userId:int = 0;
        private var _sleeping:Boolean = false;


        public function get userId():int
        {
            return (_userId);
        }

        public function get sleeping():Boolean
        {
            return (_sleeping);
        }

        public function flush():Boolean
        {
            _userId = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            _userId = _arg_1.readInteger();
            _sleeping = _arg_1.readBoolean();
            return (true);
        }


    }
}