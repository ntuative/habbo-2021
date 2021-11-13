package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class HabboUserBadgesMessageParser implements IMessageParser 
    {

        private var _userId:int;
        private var _badges:Array;


        public function flush():Boolean
        {
            _userId = -1;
            _badges = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_5:int;
            var _local_2:int;
            var _local_3:String;
            _userId = _arg_1.readInteger();
            var _local_4:int = _arg_1.readInteger();
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_2 = _arg_1.readInteger();
                _local_3 = _arg_1.readString();
                _badges.push(_local_3);
                _local_5++;
            };
            return (true);
        }

        public function get badges():Array
        {
            return (_badges);
        }

        public function get userId():int
        {
            return (_userId);
        }


    }
}