package com.sulake.habbo.communication.messages.parser.roomsettings
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class MuteAllInRoomParser implements IMessageParser 
    {

        private var _allMuted:Boolean;


        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _allMuted = _arg_1.readBoolean();
            return (true);
        }

        public function get allMuted():Boolean
        {
            return (_allMuted);
        }

        public function flush():Boolean
        {
            return (true);
        }


    }
}