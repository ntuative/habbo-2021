package com.sulake.habbo.freeflowchat.data
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
    import com.sulake.habbo.session.events.RoomSessionEvent;

    public class RoomSessionEventHandler implements IDisposable 
    {

        private var _SafeStr_659:HabboFreeFlowChat;

        public function RoomSessionEventHandler(_arg_1:HabboFreeFlowChat)
        {
            _SafeStr_659 = _arg_1;
            _SafeStr_659.roomSessionManager.events.addEventListener("RSE_CREATED", onRoomSessionCreated);
            _SafeStr_659.roomSessionManager.events.addEventListener("RSE_ENDED", onRoomSessionEnded);
        }

        public function dispose():void
        {
            if (!disposed)
            {
                if (_SafeStr_659)
                {
                    _SafeStr_659.roomSessionManager.events.removeEventListener("RSE_CREATED", onRoomSessionCreated);
                    _SafeStr_659.roomSessionManager.events.removeEventListener("RSE_ENDED", onRoomSessionEnded);
                    _SafeStr_659 = null;
                };
            };
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_659 == null);
        }

        private function onRoomSessionCreated(_arg_1:RoomSessionEvent):void
        {
            _SafeStr_659.roomEntered();
        }

        private function onRoomSessionEnded(_arg_1:RoomSessionEvent):void
        {
            _SafeStr_659.roomLeft();
        }


    }
}

