package com.sulake.habbo.communication.messages.parser.room.action
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class DanceMessageParser implements IMessageParser 
    {

        private var _userId:int = 0;
        private var _danceStyle:int = 0;


        public function get userId():int
        {
            return (_userId);
        }

        public function get danceStyle():int
        {
            return (_danceStyle);
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
            _danceStyle = _arg_1.readInteger();
            return (true);
        }


    }
}