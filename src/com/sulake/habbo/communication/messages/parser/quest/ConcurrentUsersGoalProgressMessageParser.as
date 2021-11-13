package com.sulake.habbo.communication.messages.parser.quest
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ConcurrentUsersGoalProgressMessageParser implements IMessageParser 
    {

        private var _state:int;
        private var _userCount:int;
        private var _userCountGoal:int;


        public function flush():Boolean
        {
            _state = -1;
            _userCount = -1;
            _userCountGoal = -1;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _state = _arg_1.readInteger();
            _userCount = _arg_1.readInteger();
            _userCountGoal = _arg_1.readInteger();
            return (true);
        }

        public function get state():int
        {
            return (_state);
        }

        public function get userCount():int
        {
            return (_userCount);
        }

        public function get userCountGoal():int
        {
            return (_userCountGoal);
        }


    }
}