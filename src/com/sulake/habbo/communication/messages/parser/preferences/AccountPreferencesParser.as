package com.sulake.habbo.communication.messages.parser.preferences
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class AccountPreferencesParser implements IMessageParser 
    {

        private var _traxVolume:int;
        private var _furniVolume:int;
        private var _uiVolume:int;
        private var _freeFlowChatDisabled:Boolean;
        private var _roomInvitesIgnored:Boolean;
        private var _roomCameraFollowDisabled:Boolean;
        private var _uiFlags:int;
        private var _preferedChatStyle:int;


        public function get traxVolume():int
        {
            return (_traxVolume);
        }

        public function get furniVolume():int
        {
            return (_furniVolume);
        }

        public function get uiVolume():int
        {
            return (_uiVolume);
        }

        public function get freeFlowChatDisabled():Boolean
        {
            return (_freeFlowChatDisabled);
        }

        public function get roomInvitesIgnored():Boolean
        {
            return (_roomInvitesIgnored);
        }

        public function get roomCameraFollowDisabled():Boolean
        {
            return (_roomCameraFollowDisabled);
        }

        public function get uiFlags():int
        {
            return (_uiFlags);
        }

        public function get preferedChatStyle():int
        {
            return (_preferedChatStyle);
        }

        public function flush():Boolean
        {
            _freeFlowChatDisabled = false;
            _roomCameraFollowDisabled = false;
            _uiFlags = 0;
            _preferedChatStyle = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _uiVolume = _arg_1.readInteger();
            _furniVolume = _arg_1.readInteger();
            _traxVolume = _arg_1.readInteger();
            _freeFlowChatDisabled = _arg_1.readBoolean();
            _roomInvitesIgnored = _arg_1.readBoolean();
            _roomCameraFollowDisabled = _arg_1.readBoolean();
            _uiFlags = _arg_1.readInteger();
            _preferedChatStyle = _arg_1.readInteger();
            return (true);
        }


    }
}