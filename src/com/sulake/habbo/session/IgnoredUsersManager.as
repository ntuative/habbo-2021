package com.sulake.habbo.session
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.IgnoreResultMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.IgnoredUsersMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.users.GetIgnoredUsersMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.IgnoreUserIdMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.IgnoreUserMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.UnignoreUserMessageComposer;

    public class IgnoredUsersManager implements IDisposable 
    {

        private var _sessionDataManager:SessionDataManager;
        private var _SafeStr_3707:IMessageEvent;
        private var _SafeStr_3708:IMessageEvent;
        private var _ignoredUsers:Array = [];

        public function IgnoredUsersManager(_arg_1:SessionDataManager)
        {
            _sessionDataManager = _arg_1;
            if (_sessionDataManager.communication)
            {
                _SafeStr_3707 = _sessionDataManager.communication.addHabboConnectionMessageEvent(new IgnoreResultMessageEvent(onIgnoreResult));
                _SafeStr_3708 = _sessionDataManager.communication.addHabboConnectionMessageEvent(new IgnoredUsersMessageEvent(onIgnoreList));
            };
        }

        public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            if (_sessionDataManager.communication)
            {
                _sessionDataManager.communication.removeHabboConnectionMessageEvent(_SafeStr_3707);
                _sessionDataManager.communication.removeHabboConnectionMessageEvent(_SafeStr_3708);
            };
            _SafeStr_3707 = null;
            _SafeStr_3708 = null;
            _sessionDataManager = null;
        }

        public function initIgnoreList():void
        {
            _sessionDataManager.send(new GetIgnoredUsersMessageComposer(_sessionDataManager.userName));
        }

        private function onIgnoreList(_arg_1:IgnoredUsersMessageEvent):void
        {
            _ignoredUsers = _arg_1.ignoredUsers;
        }

        private function onIgnoreResult(_arg_1:IgnoreResultMessageEvent):void
        {
            var _local_2:String = _arg_1.name;
            switch (_arg_1.result)
            {
                case 0:
                    return;
                case 1:
                    addUserToIgnoreList(_local_2);
                    return;
                case 2:
                    addUserToIgnoreList(_local_2);
                    _ignoredUsers.shift();
                    return;
                case 3:
                    removeUserFromIgnoreList(_local_2);
                default:
            };
        }

        private function addUserToIgnoreList(_arg_1:String):void
        {
            if (_ignoredUsers.indexOf(_arg_1) < 0)
            {
                _ignoredUsers.push(_arg_1);
            };
        }

        private function removeUserFromIgnoreList(_arg_1:String):void
        {
            var _local_2:int = _ignoredUsers.indexOf(_arg_1);
            if (_local_2 >= 0)
            {
                _ignoredUsers.splice(_local_2, 1);
            };
        }

        public function ignoreUserId(_arg_1:int):void
        {
            _sessionDataManager.send(new IgnoreUserIdMessageComposer(_arg_1));
        }

        public function ignoreUser(_arg_1:String):void
        {
            _sessionDataManager.send(new IgnoreUserMessageComposer(_arg_1));
        }

        public function unignoreUser(_arg_1:String):void
        {
            _sessionDataManager.send(new UnignoreUserMessageComposer(_arg_1));
        }

        public function isIgnored(_arg_1:String):Boolean
        {
            return (_ignoredUsers.indexOf(_arg_1) >= 0);
        }

        public function get disposed():Boolean
        {
            return (_sessionDataManager == null);
        }


    }
}

