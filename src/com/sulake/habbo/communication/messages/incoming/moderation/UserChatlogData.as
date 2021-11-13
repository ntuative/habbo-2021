package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class UserChatlogData 
    {

        private var _userId:int;
        private var _userName:String;
        private var _rooms:Array = [];

        public function UserChatlogData(_arg_1:IMessageDataWrapper)
        {
            var _local_3:int;
            super();
            _userId = _arg_1.readInteger();
            _userName = _arg_1.readString();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _rooms.push(new ChatRecordData(_arg_1));
                _local_3++;
            };
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get userName():String
        {
            return (_userName);
        }

        public function get rooms():Array
        {
            return (_rooms);
        }


    }
}