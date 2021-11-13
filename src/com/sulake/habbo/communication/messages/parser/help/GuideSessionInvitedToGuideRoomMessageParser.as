package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuideSessionInvitedToGuideRoomMessageParser implements IMessageParser 
    {

        private var _SafeStr_1907:int = 0;
        private var _roomName:String = "";


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _SafeStr_1907 = _arg_1.readInteger();
            _roomName = _arg_1.readString();
            return (true);
        }

        public function getRoomId():int
        {
            return (_SafeStr_1907);
        }

        public function getRoomName():String
        {
            return (_roomName);
        }


    }
}

