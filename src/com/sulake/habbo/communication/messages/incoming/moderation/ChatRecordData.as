package com.sulake.habbo.communication.messages.incoming.moderation
{
    import flash.utils.Dictionary;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ChatRecordData 
    {

        public static const _SafeStr_1793:int = 0;
        public static const _SafeStr_1794:int = 1;
        public static const _SafeStr_1795:int = 2;
        public static const _SafeStr_1796:int = 3;
        public static const _SafeStr_1797:int = 4;
        public static const TYPE_SELFIE:int = 5;
        public static const _SafeStr_1798:int = 6;

        private var _recordType:int;
        private var _context:Dictionary = new Dictionary();
        private var _chatlog:Array = [];

        public function ChatRecordData(_arg_1:IMessageDataWrapper)
        {
            var _local_4:int;
            var _local_3:String = null;
            var _local_6:int;
            var _local_5:int;
            super();
            _recordType = _arg_1.readByte();
            var _local_2:int = _arg_1.readShort();
            _local_4 = 0;
            while (_local_4 < _local_2)
            {
                _local_3 = _arg_1.readString();
                _local_6 = _arg_1.readByte();
                switch (_local_6)
                {
                    case 0:
                        _context[_local_3] = _arg_1.readBoolean();
                        break;
                    case 1:
                        _context[_local_3] = _arg_1.readInteger();
                        break;
                    case 2:
                        _context[_local_3] = _arg_1.readString();
                        break;
                    default:
                        throw (new Error(("Unknown data type " + _local_6)));
                };
                _local_4++;
            };
            var _local_7:int = _arg_1.readShort();
            _local_5 = 0;
            while (_local_5 < _local_7)
            {
                _chatlog.push(new ChatlineData(_arg_1));
                _local_5++;
            };
        }

        public function get recordType():int
        {
            return (_recordType);
        }

        public function get context():Dictionary
        {
            return (_context);
        }

        public function get chatlog():Array
        {
            return (_chatlog);
        }

        public function get roomId():int
        {
            return (getInt("roomId"));
        }

        public function get roomName():String
        {
            return (_context["roomName"] as String);
        }

        public function get groupId():int
        {
            return (getInt("groupId"));
        }

        public function get threadId():int
        {
            return (getInt("threadId"));
        }

        public function get messageId():int
        {
            return (getInt("messageId"));
        }

        private function getInt(_arg_1:String):int
        {
            var _local_2:* = _context[_arg_1];
            if (_local_2 == null)
            {
                return (0);
            };
            return (_local_2 as int);
        }


    }
}

