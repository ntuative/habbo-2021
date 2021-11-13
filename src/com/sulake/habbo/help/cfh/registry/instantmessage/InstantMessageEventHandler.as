package com.sulake.habbo.help.cfh.registry.instantmessage
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.help.HabboHelp;
    import com.sulake.habbo.communication.messages.incoming.friendlist.NewConsoleMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.RoomInviteEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.NewConsoleMessageMessageParser;
    import com.sulake.habbo.communication.messages.parser.friendlist.RoomInviteMessageParser;

    public class InstantMessageEventHandler implements IDisposable 
    {

        private var _SafeStr_659:HabboHelp;

        public function InstantMessageEventHandler(_arg_1:HabboHelp)
        {
            _SafeStr_659 = _arg_1;
            _SafeStr_659.addMessageEvent(new NewConsoleMessageEvent(onInstantMessage));
            _SafeStr_659.addMessageEvent(new RoomInviteEvent(onRoomInvite));
        }

        public function onInstantMessage(_arg_1:NewConsoleMessageEvent):void
        {
            var _local_4:String;
            var _local_3:String;
            var _local_2:NewConsoleMessageMessageParser = _arg_1.getParser();
            if (((_local_2.senderId < 0) && (!(_local_2.extraData == null))))
            {
                _local_4 = _local_2.extraData.split("/")[2];
                _local_3 = _local_2.extraData.split("/")[0];
                _SafeStr_659.instantMessageRegistry.addItem(_local_2.senderId, ((_local_4 + ":") + _local_3), _local_2.messageText);
            }
            else
            {
                _SafeStr_659.instantMessageRegistry.addItem(_local_2.senderId, "", _local_2.messageText);
            };
        }

        public function onRoomInvite(_arg_1:RoomInviteEvent):void
        {
            var _local_2:RoomInviteMessageParser = _arg_1.getParser();
            _SafeStr_659.instantMessageRegistry.addItem(_local_2.senderId, "", _local_2.messageText);
        }

        public function dispose():void
        {
            if (!disposed)
            {
                if (_SafeStr_659)
                {
                    _SafeStr_659 = null;
                };
            };
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_659 == null);
        }


    }
}

