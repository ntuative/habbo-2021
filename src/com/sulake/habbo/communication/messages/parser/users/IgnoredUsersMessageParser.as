package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class IgnoredUsersMessageParser implements IMessageParser 
    {

        protected var _ignoredUsers:Array = null;

        public function IgnoredUsersMessageParser()
        {
            _ignoredUsers = [];
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _ignoredUsers = [];
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _ignoredUsers.push(_arg_1.readString());
                _local_3++;
            };
            return (true);
        }

        public function get ignoredUsers():Array
        {
            return (_ignoredUsers.slice());
        }


    }
}