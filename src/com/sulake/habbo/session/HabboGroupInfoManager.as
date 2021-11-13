package com.sulake.habbo.session
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomReadyMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupBadgesMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupBadgesMessageComposer;

    public class HabboGroupInfoManager implements IDisposable 
    {

        private var _sessionDataManager:SessionDataManager;
        private var _SafeStr_2111:Map;
        private var _SafeStr_3705:IMessageEvent;
        private var _SafeStr_3706:IMessageEvent;

        public function HabboGroupInfoManager(_arg_1:SessionDataManager)
        {
            _sessionDataManager = _arg_1;
            _SafeStr_2111 = new Map();
            if (_sessionDataManager.communication)
            {
                _SafeStr_3705 = _sessionDataManager.communication.addHabboConnectionMessageEvent(new RoomReadyMessageEvent(onRoomReady));
                _SafeStr_3706 = _sessionDataManager.communication.addHabboConnectionMessageEvent(new HabboGroupBadgesMessageEvent(onHabboGroupBadges));
            };
        }

        public function get disposed():Boolean
        {
            return (_sessionDataManager == null);
        }

        public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            if (_sessionDataManager.communication)
            {
                _sessionDataManager.communication.removeHabboConnectionMessageEvent(_SafeStr_3705);
                _sessionDataManager.communication.removeHabboConnectionMessageEvent(_SafeStr_3706);
            };
            _SafeStr_2111 = null;
            _sessionDataManager = null;
        }

        private function onRoomReady(_arg_1:IMessageEvent):void
        {
            _sessionDataManager.send(new GetHabboGroupBadgesMessageComposer());
        }

        private function onHabboGroupBadges(_arg_1:HabboGroupBadgesMessageEvent):void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_2:Map = _arg_1.badges;
            _local_4 = 0;
            while (_local_4 < _local_2.length)
            {
                _local_3 = _local_2.getKey(_local_4);
                _SafeStr_2111.remove(_local_3);
                _SafeStr_2111.add(_local_3, _local_2.getWithIndex(_local_4));
                _local_4++;
            };
        }

        public function getBadgeId(_arg_1:int):String
        {
            return (_SafeStr_2111.getValue(_arg_1));
        }


    }
}

