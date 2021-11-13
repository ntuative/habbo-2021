package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class NavigatorSettingsMessageParser implements IMessageParser 
    {

        private var _homeRoomId:int;
        private var _roomIdToEnter:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _homeRoomId = _arg_1.readInteger();
            _roomIdToEnter = _arg_1.readInteger();
            return (true);
        }

        public function get homeRoomId():int
        {
            return (_homeRoomId);
        }

        public function get roomIdToEnter():int
        {
            return (_roomIdToEnter);
        }


    }
}