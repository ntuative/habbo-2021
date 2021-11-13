package com.sulake.habbo.messenger
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.help.IHabboHelp;
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboSoundManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboFriendList;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboTracking;
    import com.sulake.iid.IIDHabboHelp;
    import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerInitEvent;
    import com.sulake.habbo.communication.messages.parser.preferences.AccountPreferencesEvent;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.MiniMailNewMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.MiniMailUnreadCountEvent;
    import com.sulake.habbo.messenger.events.MiniMailMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.MiniMailUnreadCountMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.room.session.OpenFlatConnectionMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.friendlist.NewConsoleMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.InstantMessageErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.RoomInviteEvent;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.communication.messages.parser.friendlist.NewConsoleMessageMessageParser;
    import com.sulake.habbo.communication.messages.parser.friendlist.RoomInviteMessageParser;
    import com.sulake.habbo.communication.messages.parser.friendlist.InstantMessageErrorMessageParser;
    import com.sulake.habbo.messenger.events.ActiveConversationEvent;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.friendlist.IFriend;

    public class HabboMessenger extends Component implements IHabboMessenger 
    {

        private var _windowManager:IHabboWindowManager;
        private var _communication:IHabboCommunicationManager;
        private var _localization:IHabboLocalizationManager;
        private var _friendList:IHabboFriendList;
        private var _soundManager:IHabboSoundManager;
        private var _tracking:IHabboTracking;
        private var _SafeStr_459:int = 0;
        private var _sessionDataManager:ISessionDataManager;
        private var _help:IHabboHelp;
        private var _SafeStr_461:MainView;
        private var _messageEvents:Vector.<IMessageEvent>;
        private var _SafeStr_460:Boolean = false;
        private var _followingToGroupRoom:Boolean = false;

        public function HabboMessenger(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(), function (_arg_1:IHabboWindowManager):void
            {
                _windowManager = _arg_1;
            }), new ComponentDependency(new IIDHabboSoundManager(), function (_arg_1:IHabboSoundManager):void
            {
                _soundManager = _arg_1;
            }), new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _communication = _arg_1;
            }), new ComponentDependency(new IIDHabboLocalizationManager(), function (_arg_1:IHabboLocalizationManager):void
            {
                _localization = _arg_1;
            }), new ComponentDependency(new IIDHabboFriendList(), function (_arg_1:IHabboFriendList):void
            {
                _friendList = _arg_1;
            }), new ComponentDependency(new IIDSessionDataManager(), function (_arg_1:ISessionDataManager):void
            {
                _sessionDataManager = _arg_1;
            }), new ComponentDependency(new IIDHabboTracking(), function (_arg_1:IHabboTracking):void
            {
                _tracking = _arg_1;
            }), new ComponentDependency(new IIDHabboHelp(), function (_arg_1:IHabboHelp):void
            {
                _help = _arg_1;
            })]));
        }

        override protected function initComponent():void
        {
            _messageEvents = new Vector.<IMessageEvent>(0);
            addMessageEvent(new MessengerInitEvent(onMessengerInit));
            addMessageEvent(new AccountPreferencesEvent(onAccountPreferences));
            addMessageEvent(new HabboGroupDetailsMessageEvent(onHabboGroupDetails));
            if (getBoolean("client.minimail.embed.enabled"))
            {
                addMessageEvent(new MiniMailNewMessageEvent(onMiniMailMessage));
                addMessageEvent(new MiniMailUnreadCountEvent(onMiniMailUnreadCount));
            };
        }

        private function addMessageEvent(_arg_1:IMessageEvent):void
        {
            _messageEvents.push(_communication.addHabboConnectionMessageEvent(_arg_1));
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            if (((!(_messageEvents == null)) && (!(_communication == null))))
            {
                for each (var _local_1:IMessageEvent in _messageEvents)
                {
                    _communication.removeHabboConnectionMessageEvent(_local_1);
                };
            };
            super.dispose();
        }

        private function onMiniMailMessage(_arg_1:IMessageEvent):void
        {
            _SafeStr_459++;
            playMessageReceivedSound();
            events.dispatchEvent(new MiniMailMessageEvent("MMME_new", _SafeStr_459));
        }

        private function onMiniMailUnreadCount(_arg_1:IMessageEvent):void
        {
            _SafeStr_459 = (_arg_1.parser as MiniMailUnreadCountMessageParser).unreadMessageCount;
            events.dispatchEvent(new MiniMailMessageEvent("MMME_unread", _SafeStr_459));
        }

        private function onAccountPreferences(_arg_1:AccountPreferencesEvent):void
        {
            _SafeStr_460 = _arg_1.getParser().roomInvitesIgnored;
        }

        private function onHabboGroupDetails(_arg_1:HabboGroupDetailsMessageEvent):void
        {
            if (_followingToGroupRoom)
            {
                _followingToGroupRoom = false;
                send(new OpenFlatConnectionMessageComposer(_arg_1.data.roomId));
            };
        }

        public function getRoomInvitesIgnored():Boolean
        {
            return (_SafeStr_460);
        }

        public function setRoomInvitesIgnored(_arg_1:Boolean):void
        {
            _SafeStr_460 = _arg_1;
        }

        private function onMessengerInit(_arg_1:IMessageEvent):void
        {
            _SafeStr_461 = new MainView(this);
            addMessageEvent(new NewConsoleMessageEvent(onNewConsoleMessage));
            addMessageEvent(new InstantMessageErrorEvent(onInstantMessageError));
            addMessageEvent(new RoomInviteEvent(onRoomInvite));
        }

        public function startConversation(_arg_1:int):void
        {
            if (_SafeStr_461 != null)
            {
                _SafeStr_461.startConversation(_arg_1);
                _SafeStr_461.show();
            };
        }

        public function getUnseenMiniMailMessageCount():int
        {
            return (_SafeStr_459);
        }

        public function setFollowingAllowed(_arg_1:int, _arg_2:Boolean):void
        {
            if (_SafeStr_461 != null)
            {
                _SafeStr_461.setFollowingAllowed(_arg_1, _arg_2);
            };
        }

        public function setOnlineStatus(_arg_1:int, _arg_2:Boolean):void
        {
            if (_SafeStr_461 != null)
            {
                _SafeStr_461.setOnlineStatus(_arg_1, _arg_2);
            };
        }

        public function send(_arg_1:IMessageComposer):void
        {
            _communication.connection.send(_arg_1);
        }

        public function playSendSound():void
        {
            if (_soundManager != null)
            {
                _soundManager.playSound("HBST_message_sent");
            };
        }

        public function isOpen():Boolean
        {
            return ((!(_SafeStr_461 == null)) && (_SafeStr_461.isOpen));
        }

        public function toggleMessenger():void
        {
            if (_SafeStr_461 != null)
            {
                _SafeStr_461.toggle();
            };
        }

        public function getText(_arg_1:String):String
        {
            return (_localization.getLocalization(_arg_1, _arg_1));
        }

        private function onNewConsoleMessage(_arg_1:NewConsoleMessageEvent):void
        {
            var _local_2:NewConsoleMessageMessageParser = _arg_1.getParser();
            Logger.log(((("Received console msg: " + _local_2.messageText) + ", ") + _local_2.senderId));
            if (_SafeStr_461 != null)
            {
                _SafeStr_461.addConsoleMessage(_local_2.senderId, _local_2.messageText, _local_2.secondsSinceSent, _local_2.extraData);
                if (!_SafeStr_461.isOpen)
                {
                    playMessageReceivedSound();
                };
            };
        }

        private function onRoomInvite(_arg_1:RoomInviteEvent):void
        {
            var _local_2:RoomInviteMessageParser = _arg_1.getParser();
            if (_SafeStr_461 != null)
            {
                _SafeStr_461.addRoomInvite(_local_2.senderId, _local_2.messageText);
                if (!_SafeStr_461.isOpen)
                {
                    playMessageReceivedSound();
                };
            };
        }

        private function playMessageReceivedSound():void
        {
            if (_soundManager != null)
            {
                _soundManager.playSound("HBST_message_received");
            };
        }

        private function onInstantMessageError(_arg_1:IMessageEvent):void
        {
            var _local_2:InstantMessageErrorMessageParser = (_arg_1 as InstantMessageErrorEvent).getParser();
            if (_SafeStr_461 != null)
            {
                _SafeStr_461.onInstantMessageError(_local_2.userId, _local_2.errorCode, _local_2.message);
            };
        }

        public function conversationCountUpdated(_arg_1:int):void
        {
            events.dispatchEvent(new ActiveConversationEvent("ACCE_changed", _arg_1));
        }

        public function getXmlWindow(_arg_1:String):IWindow
        {
            var _local_3:IAsset = assets.getAssetByName((_arg_1 + "_xml"));
            var _local_2:XmlAsset = XmlAsset(_local_3);
            return (_windowManager.buildFromXML(XML(_local_2.content)));
        }

        public function trackGoogle(_arg_1:String, _arg_2:String, _arg_3:int=-1):void
        {
            if (_tracking)
            {
                _tracking.trackGoogle(_arg_1, _arg_2, _arg_3);
            };
        }

        internal function getFriend(_arg_1:int):IFriend
        {
            return (_friendList.getFriend(_arg_1));
        }

        public function get sessionDataManager():ISessionDataManager
        {
            return (_sessionDataManager);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (_localization);
        }

        internal function reportUser(_arg_1:int):void
        {
            _help.reportUserFromIM(_arg_1);
        }

        public function set followingToGroupRoom(_arg_1:Boolean):void
        {
            _followingToGroupRoom = _arg_1;
        }

        public function closeConversation(_arg_1:int):void
        {
            _SafeStr_461.hideConversation(_arg_1);
        }

        public function get hasfriendsListInitialized():Boolean
        {
            return (_friendList.hasfriendsListInitialized);
        }


    }
}

