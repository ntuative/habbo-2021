package com.sulake.habbo.friendbar.data
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.messenger.IHabboMessenger;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.core.utils.Map;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboFriendList;
    import com.sulake.iid.IIDHabboMessenger;
    import com.sulake.iid.IIDHabboTracking;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.friendlist.NewFriendRequestEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.NewConsoleMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendNotificationEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListFragmentMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FindFriendsProcessResultEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestsEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.RoomInviteEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerInitEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListUpdateEvent;
    import com.sulake.habbo.friendbar.events.FriendBarUpdateEvent;
    import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileByNameMessageComposer;
    import com.sulake.habbo.friendbar.events.FriendRequestUpdateEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.habbo.friendbar.events.NewMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FindNewFriendsMessageComposer;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.utils.WindowToggle;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
    import com.sulake.habbo.communication.messages.parser.friendlist.FriendListUpdateMessageParser;
    import com.sulake.habbo.friendbar.events.FindFriendsNotificationEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData;
    import com.sulake.habbo.friendlist.events.FriendRequestEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.NewConsoleMessageMessageParser;
    import com.sulake.habbo.friendbar.events.ActiveConversationsCountEvent;
    import com.sulake.habbo.messenger.events.ActiveConversationEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.RoomInviteMessageParser;
    import com.sulake.habbo.communication.messages.parser.friendlist.FriendNotificationMessageParser;
    import com.sulake.habbo.friendbar.events.NotificationEvent;

    public class HabboFriendBarData extends Component implements IHabboFriendBarData
    {

        private static const SHOW_OFFLINE_FRIENDS:Boolean = false;
        private static const SORT_ALPHABETICALLY:Boolean = false;
        private static const TRACKING_EVENT_CATEGORY:String = "Navigation";
        private static const TRACKING_EVENT_TYPE:String = "Friend Bar";
        private static const TRACKING_EVENT_ACTION_VISIT:String = "go.friendbar";
        private static const TRACKING_EVENT_ACTION_CHAT:String = "chat_btn_click";
        private static const TRACKING_EVENT_ACTION_FIND_FRIENDS:String = "find_friends_btn_click";
        public static const TRACKING_EVENT_ACTION_PLAY_SNOWSTORM_TAB:String = "play_snowstorm_tab_click";
        public static const TRACKING_EVENT_ACTION_PLAY_SNOWSTORM_BUTTON:String = "play_snowstorm_btn_click";
        private static const _SafeStr_2226:String = "Toolbar";
        private static const _SafeStr_2227:String = "open";
        private static const _SafeStr_2228:String = "close";
        private static const LEGACY_TRACKING_EVENT_TYPE_FRIENDLIST:String = "FRIENDLIST";
        private static const LEGACY_TRACKING_EVENT_TYPE_MESSENGER:String = "MESSENGER";

        private var _habboCommunicationManager:IHabboCommunicationManager;
        private var _habboFriendListComponent:IHabboFriendList;
        private var _habboMessengerComponent:IHabboMessenger;
        private var _tracking:IHabboTracking;
        private var _SafeStr_2229:Array;
        private var _SafeStr_2230:Map;
        private var _SafeStr_2231:Array;
        private var _SafeStr_2232:int;

        public function HabboFriendBarData(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            _SafeStr_2229 = [];
            _SafeStr_2230 = new Map();
            _SafeStr_2231 = [];
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboConfigurationManager(), null), new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _habboCommunicationManager = _arg_1;
            }), new ComponentDependency(new IIDHabboFriendList(), function (_arg_1:IHabboFriendList):void
            {
                _habboFriendListComponent = _arg_1;
            }), new ComponentDependency(new IIDHabboMessenger(), function (_arg_1:IHabboMessenger):void
            {
                _habboMessengerComponent = _arg_1;
            }), new ComponentDependency(new IIDHabboTracking(), function (_arg_1:IHabboTracking):void
            {
                _tracking = _arg_1;
            })]));
        }

        override protected function initComponent():void
        {
            _habboCommunicationManager.addHabboConnectionMessageEvent(new NewFriendRequestEvent(onNewFriendRequest));
            _habboCommunicationManager.addHabboConnectionMessageEvent(new NewConsoleMessageEvent(onNewConsoleMessage));
            _habboCommunicationManager.addHabboConnectionMessageEvent(new FriendNotificationEvent(onFriendNotification));
            _habboCommunicationManager.addHabboConnectionMessageEvent(new FriendListFragmentMessageEvent(onFriendsListFragment));
            _habboCommunicationManager.addHabboConnectionMessageEvent(new FindFriendsProcessResultEvent(onFindFriendProcessResult));
            _habboCommunicationManager.addHabboConnectionMessageEvent(new FriendRequestsEvent(onFriendRequestList));
            _habboCommunicationManager.addHabboConnectionMessageEvent(new RoomInviteEvent(onRoomInvite));
            _habboCommunicationManager.addHabboConnectionMessageEvent(new MessengerInitEvent(onMessengerInitialized));
            _habboCommunicationManager.addHabboConnectionMessageEvent(new FriendListUpdateEvent(onFriendListUpdate));
            _habboFriendListComponent.events.addEventListener("FRE_ACCEPTED", onFriendRequestEvent);
            _habboFriendListComponent.events.addEventListener("FRE_DECLINED", onFriendRequestEvent);
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                if (((!(_habboFriendListComponent == null)) && (!(_habboFriendListComponent.disposed))))
                {
                    _habboFriendListComponent.events.removeEventListener("FRE_ACCEPTED", onFriendRequestEvent);
                    _habboFriendListComponent.events.removeEventListener("FRE_DECLINED", onFriendRequestEvent);
                };
                _SafeStr_2229 = null;
                _SafeStr_2230.dispose();
                _SafeStr_2230 = null;
                _SafeStr_2231 = null;
                super.dispose();
            };
        }

        public function get numFriends():int
        {
            return (_SafeStr_2229.length);
        }

        public function getFriendAt(_arg_1:int):IFriendEntity
        {
            return (_SafeStr_2229[_arg_1]);
        }

        public function getFriendByID(_arg_1:int):IFriendEntity
        {
            return (_SafeStr_2230.getValue(_arg_1));
        }

        public function getFriendByName(_arg_1:String):IFriendEntity
        {
            for each (var _local_2:FriendEntity in _SafeStr_2229)
            {
                if (_local_2.name == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function setFriendAt(_arg_1:IFriendEntity, _arg_2:int):void
        {
            var _local_3:int = _SafeStr_2229.indexOf(_arg_1);
            if (((_local_3 > -1) && (!(_local_3 == _arg_2))))
            {
                _SafeStr_2229.splice(_local_3, 1);
                _SafeStr_2229.splice(_arg_2, 0, _arg_1);
                events.dispatchEvent(new FriendBarUpdateEvent());
            };
        }

        public function get numFriendRequests():int
        {
            return ((_SafeStr_2231) ? _SafeStr_2231.length : 0);
        }

        public function getFriendRequestAt(_arg_1:int):IFriendRequest
        {
            return ((_SafeStr_2231) ? _SafeStr_2231[_arg_1] : null);
        }

        public function getFriendRequestByID(_arg_1:int):IFriendRequest
        {
            if (_SafeStr_2231)
            {
                for each (var _local_2:IFriendRequest in _SafeStr_2231)
                {
                    if (_local_2.id == _arg_1)
                    {
                        return (_local_2);
                    };
                };
            };
            return (null);
        }

        public function getFriendRequestByName(_arg_1:String):IFriendRequest
        {
            if (_SafeStr_2231)
            {
                for each (var _local_2:IFriendRequest in _SafeStr_2231)
                {
                    if (_local_2.name == _arg_1)
                    {
                        return (_local_2);
                    };
                };
            };
            return (null);
        }

        public function getFriendRequestList():Array
        {
            return (_SafeStr_2231);
        }

        public function acceptFriendRequest(_arg_1:int):void
        {
            removeFriendRequest(_arg_1);
            if (_habboFriendListComponent)
            {
                if (!_habboFriendListComponent.disposed)
                {
                    _habboFriendListComponent.acceptFriendRequest(_arg_1);
                };
            };
        }

        public function showProfile(_arg_1:int):void
        {
            if (_habboCommunicationManager)
            {
                if (_arg_1 > 0)
                {
                    _habboCommunicationManager.connection.send(new GetExtendedProfileMessageComposer(_arg_1));
                }
                else
                {
                    _habboCommunicationManager.connection.send(new GetHabboGroupDetailsMessageComposer(Math.abs(_arg_1), true));
                };
            };
        }

        public function showProfileByName(_arg_1:String):void
        {
            if (_habboCommunicationManager)
            {
                _habboCommunicationManager.connection.send(new GetExtendedProfileByNameMessageComposer(_arg_1));
            };
        }

        public function acceptAllFriendRequests():void
        {
            _SafeStr_2231 = [];
            _habboFriendListComponent.acceptAllFriendRequests();
            events.dispatchEvent(new FriendRequestUpdateEvent());
        }

        public function declineFriendRequest(_arg_1:int):void
        {
            removeFriendRequest(_arg_1);
            if (_habboFriendListComponent)
            {
                if (!_habboFriendListComponent.disposed)
                {
                    _habboFriendListComponent.declineFriendRequest(_arg_1);
                };
            };
        }

        public function declineAllFriendRequests():void
        {
            _SafeStr_2231 = [];
            _habboFriendListComponent.declineAllFriendRequests();
            events.dispatchEvent(new FriendRequestUpdateEvent());
        }

        private function removeFriendRequest(_arg_1:int):void
        {
            if (_SafeStr_2231)
            {
                for each (var _local_2:FriendRequest in _SafeStr_2231)
                {
                    if (_local_2.id == _arg_1)
                    {
                        _SafeStr_2231.splice(_SafeStr_2231.indexOf(_local_2), 1);
                        events.dispatchEvent(new FriendRequestUpdateEvent());
                        return;
                    };
                };
            };
        }

        public function followToRoom(_arg_1:int):void
        {
            if (_habboCommunicationManager)
            {
                _habboCommunicationManager.connection.send(new FollowFriendMessageComposer(_arg_1));
                _habboCommunicationManager.connection.send(new EventLogMessageComposer("Navigation", "Friend Bar", "go.friendbar"));
            };
        }

        public function startConversation(_arg_1:int):void
        {
            if (_habboMessengerComponent)
            {
                _habboMessengerComponent.startConversation(_arg_1);
                events.dispatchEvent(new NewMessageEvent(false, _arg_1));
                if (_habboCommunicationManager)
                {
                    _habboCommunicationManager.connection.send(new EventLogMessageComposer("Navigation", "Friend Bar", "chat_btn_click"));
                };
            };
        }

        public function findNewFriends():void
        {
            if (_habboCommunicationManager)
            {
                _habboCommunicationManager.connection.send(new FindNewFriendsMessageComposer());
                _habboCommunicationManager.connection.send(new EventLogMessageComposer("Navigation", "Friend Bar", "find_friends_btn_click"));
            };
        }

        public function openUserTextSearch():void
        {
            if (_habboFriendListComponent.currentTabId() != 3)
            {
                _habboFriendListComponent.openFriendSearch();
            }
            else
            {
                _habboFriendListComponent.close();
            };
        }

        public function sendGameTabTracking(_arg_1:String):void
        {
            sendEventLogTracking("play_snowstorm_tab_click", _arg_1);
        }

        public function sendGameButtonTracking(_arg_1:String):void
        {
            sendEventLogTracking("play_snowstorm_btn_click", _arg_1);
        }

        private function sendEventLogTracking(_arg_1:String, _arg_2:String):void
        {
            if (_habboCommunicationManager)
            {
                _habboCommunicationManager.connection.send(new EventLogMessageComposer("Navigation", "Friend Bar", _arg_1, _arg_2, numFriends));
            };
        }

        public function toggleFriendList():void
        {
            var _local_1:IWindowContainer;
            if (_habboFriendListComponent)
            {
                if (!_habboFriendListComponent.disposed)
                {
                    if (!_habboFriendListComponent.isOpen())
                    {
                        if (_SafeStr_2231.length > 0)
                        {
                            _habboFriendListComponent.openFriendRequests();
                        }
                        else
                        {
                            _habboFriendListComponent.openFriendList();
                        };
                    }
                    else
                    {
                        _local_1 = _habboFriendListComponent.mainWindow;
                        if (((!(_local_1 == null)) && (WindowToggle.isHiddenByOtherWindows(_local_1))))
                        {
                            _local_1.activate();
                            return;
                        };
                        _habboFriendListComponent.close();
                    };
                    if (_habboCommunicationManager)
                    {
                        _habboCommunicationManager.connection.send(new EventLogMessageComposer("Toolbar", "FRIENDLIST", ((_habboFriendListComponent.isOpen()) ? "open" : "close")));
                    };
                };
            };
        }

        public function toggleMessenger():void
        {
            if (_habboMessengerComponent)
            {
                if (!_habboMessengerComponent.disposed)
                {
                    _habboMessengerComponent.toggleMessenger();
                    if (_habboCommunicationManager)
                    {
                        _habboCommunicationManager.connection.send(new EventLogMessageComposer("Toolbar", "MESSENGER", ((_habboMessengerComponent.isOpen()) ? "open" : "close")));
                    };
                };
            };
        }

        private function onMessengerInitialized(_arg_1:IMessageEvent):void
        {
            if (_habboMessengerComponent)
            {
                _habboMessengerComponent.events.addEventListener("ACCE_changed", onUpdateActiveConversationCount);
            };
        }

        private function onFriendsListFragment(_arg_1:IMessageEvent):void
        {
            buildFriendList(FriendListFragmentMessageEvent(_arg_1).getParser().friendFragment);
        }

        private function onFriendListUpdate(_arg_1:IMessageEvent):void
        {
            var _local_2:FriendEntity;
            var _local_6:FriendData;
            var _local_4:FriendListUpdateMessageParser = FriendListUpdateEvent(_arg_1).getParser();
            var _local_3:Array = _local_4.removedFriendIds;
            var _local_8:Array = _local_4.updatedFriends;
            var _local_5:Array = _local_4.addedFriends;
            for each (var _local_7:int in _local_3)
            {
                _local_2 = _SafeStr_2230.getValue(_local_7);
                if (_local_2)
                {
                    _SafeStr_2230.remove(_local_7);
                    _SafeStr_2229.splice(_SafeStr_2229.indexOf(_local_2), 1);
                    _habboMessengerComponent.closeConversation(_local_7);
                };
            };
            for each (_local_6 in _local_8)
            {
                _local_2 = _SafeStr_2230.getValue(_local_6.id);
                if (_local_2)
                {
                    if (((_local_6.online) || (false)))
                    {
                        _local_2.name = _local_6.name;
                        _local_2.realName = _local_6.realName;
                        _local_2.motto = _local_6.motto;
                        _local_2.gender = _local_6.gender;
                        _local_2.online = _local_6.online;
                        _local_2.allowFollow = _local_6.followingAllowed;
                        _local_2.figure = _local_6.figure;
                        _local_2.categoryId = _local_6.categoryId;
                        _local_2.lastAccess = _local_6.lastAccess;
                    }
                    else
                    {
                        _SafeStr_2230.remove(_local_6.id);
                        _SafeStr_2229.splice(_SafeStr_2229.indexOf(_local_2), 1);
                    };
                }
                else
                {
                    if (((_local_6.online) || (false)))
                    {
                        _local_2 = new FriendEntity(_local_6.id, _local_6.name, _local_6.realName, _local_6.motto, _local_6.gender, _local_6.online, _local_6.followingAllowed, _local_6.figure, _local_6.categoryId, _local_6.lastAccess);
                        _SafeStr_2229.splice(0, 0, _local_2);
                        _SafeStr_2230.add(_local_2.id, _local_2);
                    };
                };
            };
            for each (_local_6 in _local_5)
            {
                if (((_local_6.online) || (false)))
                {
                    if (_SafeStr_2230.getValue(_local_6.id) == null)
                    {
                        _local_2 = new FriendEntity(_local_6.id, _local_6.name, _local_6.realName, _local_6.motto, _local_6.gender, _local_6.online, _local_6.followingAllowed, _local_6.figure, _local_6.categoryId, _local_6.lastAccess);
                        _SafeStr_2229.push(_local_2);
                        _SafeStr_2230.add(_local_2.id, _local_2);
                    };
                };
                removeFriendRequest(_local_6.id);
            };
            if (((_local_5.length > 0) || (_local_8.length > 0)))
            {
                _SafeStr_2229 = sortByName(_SafeStr_2229);
            };
            events.dispatchEvent(new FriendBarUpdateEvent());
        }

        private function onFindFriendProcessResult(_arg_1:FindFriendsProcessResultEvent):void
        {
            events.dispatchEvent(new FindFriendsNotificationEvent(_arg_1.success));
        }

        private function onNewFriendRequest(_arg_1:NewFriendRequestEvent):void
        {
            var _local_2:FriendRequestData;
            if (showFriendRequests)
            {
                _local_2 = _arg_1.getParser().req;
                _SafeStr_2231.push(new FriendRequest(_local_2.requestId, _local_2.requesterName, _local_2.figureString));
                events.dispatchEvent(new FriendRequestUpdateEvent());
            };
        }

        private function onFriendRequestList(_arg_1:FriendRequestsEvent):void
        {
            var _local_3:Array;
            if (showFriendRequests)
            {
                _local_3 = _arg_1.getParser().reqs;
                for each (var _local_2:FriendRequestData in _local_3)
                {
                    _SafeStr_2231.push(new FriendRequest(_local_2.requestId, _local_2.requesterName, _local_2.figureString));
                };
                events.dispatchEvent(new FriendRequestUpdateEvent());
            };
        }

        private function onFriendRequestEvent(_arg_1:FriendRequestEvent):void
        {
            removeFriendRequest(_arg_1.requestId);
        }

        private function onNewConsoleMessage(_arg_1:NewConsoleMessageEvent):void
        {
            var _local_2:NewConsoleMessageMessageParser = _arg_1.getParser();
            _SafeStr_2232 = _local_2.senderId;
            var _local_3:Boolean = true;
            if (_habboMessengerComponent)
            {
                if (_habboMessengerComponent.isOpen())
                {
                    _local_3 = false;
                };
            };
            if (_habboFriendListComponent.hasfriendsListInitialized)
            {
                events.dispatchEvent(new NewMessageEvent(_local_3, _SafeStr_2232));
            };
            if (_local_3)
            {
                makeNotification(String(_SafeStr_2232), -1, null, false, false);
            };
        }

        private function onUpdateActiveConversationCount(_arg_1:ActiveConversationEvent):void
        {
            events.dispatchEvent(new ActiveConversationsCountEvent(_arg_1.activeConversationsCount));
        }

        private function onRoomInvite(_arg_1:RoomInviteEvent):void
        {
            var _local_2:RoomInviteMessageParser = _arg_1.getParser();
            _SafeStr_2232 = _local_2.senderId;
            if (((_habboMessengerComponent) && (!(_habboMessengerComponent.isOpen()))))
            {
                events.dispatchEvent(new NewMessageEvent(true, _SafeStr_2232));
                makeNotification(String(_SafeStr_2232), -1, null, true, false);
            };
        }

        private function onFriendNotification(_arg_1:FriendNotificationEvent):void
        {
            var _local_4:FriendNotificationMessageParser = _arg_1.getParser();
            var _local_2:Boolean = (!(_local_4.typeCode == 3));
            var _local_5:Boolean = (!(_local_4.typeCode == 4));
            var _local_3:Boolean = (!(_local_4.typeCode == 3));
            makeNotification(_local_4.avatarId, _local_4.typeCode, _local_4.message, _local_2, _local_5, _local_3);
        }

        private function makeNotification(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:Boolean, _arg_5:Boolean, _arg_6:Boolean=true):void
        {
            var _local_7:IFriendEntity;
            var _local_8:FriendNotification;
            var _local_9:Vector.<IFriendNotification> = undefined;
            if (showFriendNotifications)
            {
                _local_7 = getFriendByID(parseInt(_arg_1));
                if (_local_7)
                {
                    _local_9 = _local_7.notifications;
                    for each (_local_8 in _local_9)
                    {
                        if (_local_8.typeCode == _arg_2)
                        {
                            _local_8.message = _arg_3;
                            _local_8.viewOnce = _arg_4;
                            break;
                        };
                        _local_8 = null;
                    };
                    if (!_local_8)
                    {
                        _local_8 = new FriendNotification(_arg_2, _arg_3, _arg_4);
                        _local_9.push(_local_8);
                    }
                    else
                    {
                        if (!_arg_6)
                        {
                            return;
                        };
                    };
                    events.dispatchEvent(new NotificationEvent(_local_7.id, _local_8));
                    if (_arg_5)
                    {
                        setFriendAt(_local_7, 0);
                    };
                    if (_local_7.logEventId < 0)
                    {
                        _local_7.logEventId = _local_7.getNextLogEventId();
                    };
                    if (_tracking)
                    {
                        _tracking.trackEventLog("FriendBar", FriendNotification.typeCodeToString(_arg_2), "notified", "", ((_local_7.logEventId > 0) ? _local_7.logEventId : 0));
                    };
                };
            };
        }

        private function buildFriendList(_arg_1:Array):void
        {
            var _local_2:FriendEntity;
            for each (var _local_3:FriendData in _arg_1)
            {
                if (((_local_3.online) || (false)))
                {
                    _local_2 = new FriendEntity(_local_3.id, _local_3.name, _local_3.realName, _local_3.motto, _local_3.gender, _local_3.online, _local_3.followingAllowed, _local_3.figure, _local_3.categoryId, _local_3.lastAccess);
                    _SafeStr_2229.push(_local_2);
                    _SafeStr_2230.add(_local_2.id, _local_2);
                };
            };
            _SafeStr_2229 = sortByName(_SafeStr_2229);
            events.dispatchEvent(new FriendBarUpdateEvent());
        }

        private function sortByName(_arg_1:Array):Array
        {
            return (_arg_1);
        }

        private function sortByNameAndOnlineStatus(_arg_1:Array):Array
        {
            var _local_5:FriendEntity;
            var _local_2:Array = [];
            var _local_3:Array = [];
            var _local_4:int = _arg_1.length;
            while (_local_4-- > 0)
            {
                _local_5 = _arg_1[_local_4];
                if (_local_5.online)
                {
                    _local_2.push(_local_5);
                }
                else
                {
                    _local_3.push(_local_5);
                };
            };
            _local_4 = _local_3.length;
            while (_local_4-- > 0)
            {
                _local_2.push(_local_3.pop());
            };
            return (_local_2);
        }

        public function get showFriendNotifications():Boolean
        {
            return (getBoolean("friendbar.notifications.enabled"));
        }

        public function get showFriendRequests():Boolean
        {
            return (getBoolean("friendbar.requests.enabled"));
        }


    }
}