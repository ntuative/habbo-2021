package com.sulake.habbo.friendlist
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.core.runtime.events.ILinkEventTracker;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.messenger.IHabboMessenger;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.habbo.friendlist.domain.FriendListTabs;
    import com.sulake.habbo.friendlist.domain.FriendCategories;
    import com.sulake.habbo.friendlist.domain.FriendRequests;
    import com.sulake.habbo.friendlist.domain.AvatarSearchResults;
    import com.sulake.habbo.notifications.IHabboNotifications;
    import flash.utils.Timer;
    import com.sulake.habbo.friendlist.domain.FriendCategoriesDeps;
    import com.sulake.habbo.friendlist.domain.AvatarSearchDeps;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboTracking;
    import com.sulake.iid.IIDHabboMessenger;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboNotifications;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDSessionDataManager;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerInitEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListFragmentMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist._SafeStr_39;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.utils.HabboWebTools;
    import flash.utils.Dictionary;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.RequestFriendMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.quest.FriendRequestQuestCompleteMessageComposer;
    import flash.geom.Point;
    import com.sulake.habbo.friendlist.domain.FriendListTab;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.FriendsListFragmentMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
    import com.sulake.habbo.friendlist.domain.Friend;
    import flash.events.TimerEvent;
    import com.sulake.habbo.friendlist.domain.FriendCategory;
    import com.sulake.habbo.communication.messages.parser.friendlist.MessengerInitMessageParser;
    import com.sulake.habbo.friendlist.domain.FriendRequestsDeps;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendCategoryData;
    import com.sulake.habbo.friendlist.domain.FriendListTabsDeps;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.AcceptFriendResultEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FollowFriendFailedEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListUpdateEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestsEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.NewFriendRequestEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.RoomInviteErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.HabboSearchResultEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist._SafeStr_24;
    import com.sulake.habbo.communication.messages.outgoing.friendlist._SafeStr_22;
    import com.sulake.habbo.communication.messages.parser.friendlist.FriendRequestsMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData;
    import com.sulake.habbo.friendlist.domain.FriendRequest;
    import com.sulake.habbo.communication.messages.parser.friendlist.NewFriendRequestMessageParser;
    import com.sulake.habbo.communication.messages.parser.friendlist.AcceptFriendResultMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.AcceptFriendFailureData;
    import com.sulake.habbo.communication.messages.parser.friendlist.HabboSearchResultMessageParser;
    import com.sulake.habbo.communication.messages.parser.friendlist.MessengerErrorMessageParser;
    import com.sulake.habbo.communication.messages.parser.friendlist.RoomInviteErrorMessageParser;
    import com.sulake.habbo.communication.messages.parser.friendlist.FollowFriendFailedMessageParser;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.utils.getTimer;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.SetRelationshipStatusMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.friendlist.*;
    import com.sulake.habbo.friendlist.domain.*;
    import com.sulake.habbo.communication.messages.parser.friendlist.*;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.*;

    public class HabboFriendList extends Component implements IHabboFriendList, IAvatarImageListener, ILinkEventTracker 
    {

        public static const AVATAR_FACE_NAME:String = "face";

        private var _windowManager:IHabboWindowManager;
        private var _communication:IHabboCommunicationManager;
        private var _messenger:IHabboMessenger;
        private var _localization:IHabboLocalizationManager;
        private var _avatarManager:IAvatarRenderManager;
        private var _sessionData:ISessionDataManager;
        private var _tracking:IHabboTracking;
        private var _laf:_SafeStr_99;
        private var _tabs:FriendListTabs;
        private var _view:FriendListView;
        private var _openedToWebPopup:OpenedToWebPopup;
        private var _avatarId:int;
        internal var _SafeStr_575:FriendCategories;
        private var _friendRequests:FriendRequests;
        private var _searchResults:AvatarSearchResults;
        private var _notifications:IHabboNotifications;
        private var _SafeStr_576:Timer;
        private var _SafeStr_578:int;
        private var _SafeStr_579:Array;
        private var _SafeStr_577:Timer;
        private var _hasfriendsListInitialized:Boolean = false;
        private var _lastRoomInvitationTime:int = -60000;

        public function HabboFriendList(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            _SafeStr_575 = new FriendCategories(new FriendCategoriesDeps(this));
            _searchResults = new AvatarSearchResults(new AvatarSearchDeps(this));
            _laf = new _SafeStr_99();
            _SafeStr_579 = [];
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _communication = _arg_1;
            }), new ComponentDependency(new IIDHabboTracking(), function (_arg_1:IHabboTracking):void
            {
                _tracking = _arg_1;
            }), new ComponentDependency(new IIDHabboMessenger(), function (_arg_1:IHabboMessenger):void
            {
                _messenger = _arg_1;
            }, false), new ComponentDependency(new IIDAvatarRenderManager(), function (_arg_1:IAvatarRenderManager):void
            {
                _avatarManager = _arg_1;
            }), new ComponentDependency(new IIDHabboLocalizationManager(), function (_arg_1:IHabboLocalizationManager):void
            {
                _localization = _arg_1;
            }), new ComponentDependency(new IIDHabboNotifications(), function (_arg_1:IHabboNotifications):void
            {
                _notifications = _arg_1;
            }), new ComponentDependency(new IIDHabboWindowManager(), function (_arg_1:IHabboWindowManager):void
            {
                _windowManager = _arg_1;
            }), new ComponentDependency(new IIDSessionDataManager(), function (_arg_1:ISessionDataManager):void
            {
                _sessionData = _arg_1;
            })]));
        }

        override protected function initComponent():void
        {
            _communication.addHabboConnectionMessageEvent(new UserObjectEvent(onUserObject));
            _communication.addHabboConnectionMessageEvent(new MessengerInitEvent(onMessengerInit));
            _communication.addHabboConnectionMessageEvent(new FriendListFragmentMessageEvent(onFriendsListFragment));
            context.addLinkEventTracker(this);
            send(new _SafeStr_39());
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            context.removeLinkEventTracker(this);
            if (_SafeStr_576)
            {
                _SafeStr_576.stop();
                _SafeStr_576.removeEventListener("timer", sendFriendListUpdate);
                _SafeStr_576 = null;
            };
            if (_SafeStr_577)
            {
                if (_SafeStr_577.running)
                {
                    _SafeStr_577.stop();
                };
                _SafeStr_577.removeEventListener("timer", batchFriendsUpdate);
                _SafeStr_577 = null;
            };
            super.dispose();
        }

        public function send(_arg_1:IMessageComposer):void
        {
            _communication.connection.send(_arg_1);
        }

        public function trackGoogle(_arg_1:String, _arg_2:String, _arg_3:int=-1):void
        {
            if (_tracking != null)
            {
                _tracking.trackGoogle(_arg_1, _arg_2, _arg_3);
            };
        }

        public function openHabboWebPage(_arg_1:String, _arg_2:Dictionary, _arg_3:int, _arg_4:int):void
        {
            var _local_6:String = getProperty(_arg_1, _arg_2);
            var _local_5:String = "habboMain";
            try
            {
                HabboWebTools.navigateToURL(_local_6, _local_5);
            }
            catch(e:Error)
            {
                Logger.log(("GOT ERROR: " + e));
            };
            if (_openedToWebPopup == null)
            {
                _openedToWebPopup = new OpenedToWebPopup(this);
            };
            _openedToWebPopup.show(_arg_3, _arg_4);
        }

        public function getText(_arg_1:String):String
        {
            return (_localization.getLocalization(_arg_1));
        }

        public function registerParameter(_arg_1:String, _arg_2:String, _arg_3:String):void
        {
            _localization.registerParameter(_arg_1, _arg_2, _arg_3);
        }

        public function showLimitReachedAlert():void
        {
            registerParameter("friendlist.listfull.text", "mylimit", ("" + friendRequests.limit));
            registerParameter("friendlist.listfull.text", "clublimit", ("" + friendRequests.clubLimit));
            simpleAlert("${friendlist.listfull.title}", "${friendlist.listfull.text}");
        }

        public function showFriendRequestSentAlert(_arg_1:String):void
        {
            registerParameter("friendlist.friendrequestsent.text", "user_name", _arg_1);
            simpleAlert("${friendlist.friendrequestsent.title}", "${friendlist.friendrequestsent.text}");
        }

        public function getFriend(_arg_1:int):IFriend
        {
            if (_view == null)
            {
                Logger.log("Cannot process getFriend. Friendlist not initialized.");
                return (null);
            };
            return (_SafeStr_575.findFriend(_arg_1));
        }

        public function canBeAskedForAFriend(_arg_1:int):Boolean
        {
            if (_view == null)
            {
                Logger.log("Cannot process canBeAskedForAFriend. Friendlist not initialized.");
                return (false);
            };
            return (((this.getFriend(_arg_1) == null) && (!(searchResults.isFriendRequestSent(_arg_1)))) && (categories.getFriendCount(false) < friendRequests.limit));
        }

        public function askForAFriend(_arg_1:int, _arg_2:String):Boolean
        {
            if (_view == null)
            {
                Logger.log("Cannot ask for friend. Friendlist not initialized.");
                return (false);
            };
            if (searchResults.isFriendRequestSent(_arg_1))
            {
                return (true);
            };
            if (!canBeAskedForAFriend(_arg_1))
            {
                return (false);
            };
            send(new RequestFriendMessageComposer(_arg_2));
            searchResults.setFriendRequestSent(_arg_1);
            send(new FriendRequestQuestCompleteMessageComposer());
            return (true);
        }

        public function openFriendList():void
        {
            openFriendListWithTab(1);
        }

        public function openFriendRequests():void
        {
            openFriendListWithTab(2);
        }

        public function openFriendSearch():void
        {
            openFriendListWithTab(3);
            SearchView(_tabs.findTab(3).tabView).focus();
        }

        public function close():void
        {
            if (_view)
            {
                _view.close();
            };
        }

        public function alignBottomLeftTo(_arg_1:Point):void
        {
            if (_view)
            {
                _view.alignBottomLeftTo(_arg_1);
            };
        }

        public function isOpen():Boolean
        {
            if (_view)
            {
                return (_view.isOpen());
            };
            return (false);
        }

        public function currentTabId():int
        {
            if (((_view == null) || (!(_view.isOpen()))))
            {
                return (0);
            };
            return (_SafeStr_578);
        }

        private function openFriendListWithTab(_arg_1:int):void
        {
            if (_view == null)
            {
                Logger.log("Cannot open friendlist. Friendlist not initialized.");
                return;
            };
            _view.openFriendList();
            var _local_2:FriendListTab = tabs.findTab(_arg_1);
            if (_local_2 != tabs.findSelectedTab())
            {
                tabs.toggleSelected(_local_2);
                view.refresh("openFriendList");
            };
            _view.mainWindow.activate();
            _SafeStr_578 = _arg_1;
        }

        public function getFriendCount(_arg_1:Boolean, _arg_2:Boolean):int
        {
            if (_view == null)
            {
                Logger.log("Cannot get friend count. Friendlist not initialized.");
                return (0);
            };
            return (this._SafeStr_575.getFriendCount(_arg_1, _arg_2));
        }

        public function getButton(_arg_1:String, _arg_2:String, _arg_3:Function, _arg_4:int=0, _arg_5:int=0, _arg_6:int=0):IBitmapWrapperWindow
        {
            var _local_8:BitmapData = getButtonImage(_arg_2);
            var _local_7:IBitmapWrapperWindow = (_windowManager.createWindow(_arg_1, "", 21, 0, (0x01 | 0x10), new Rectangle(_arg_4, _arg_5, _local_8.width, _local_8.height), _arg_3, _arg_6) as IBitmapWrapperWindow);
            _local_7.bitmap = _local_8;
            return (_local_7);
        }

        public function getXmlWindow(_arg_1:String):IWindow
        {
            var _local_3:IAsset = assets.getAssetByName((_arg_1 + "_xml"));
            var _local_2:XmlAsset = XmlAsset(_local_3);
            return (_windowManager.buildFromXML(XML(_local_2.content)));
        }

        public function isMessagesPersisted():Boolean
        {
            return (getBoolean("friend_list.persistent_message_status.enabled"));
        }

        public function getSmallGroupBadgeBitmap(_arg_1:String):BitmapData
        {
            if (_sessionData)
            {
                return (_sessionData.getGroupBadgeSmallImage(_arg_1));
            };
            return (null);
        }

        public function getAvatarFaceBitmap(_arg_1:String):BitmapData
        {
            var _local_3:Boolean = getBoolean("zoom.enabled");
            var _local_4:IAvatarImage = _avatarManager.createAvatarImage(_arg_1, ((_local_3) ? "h" : "sh"), null, this);
            if (!_local_4)
            {
                return (null);
            };
            var _local_2:BitmapData = _local_4.getCroppedImage("head", ((_local_3) ? 0.5 : 1));
            _local_4.dispose();
            return (_local_2);
        }

        public function isEmbeddedMinimailEnabled():Boolean
        {
            var _local_1:String = getProperty("client.minimail.embed.enabled");
            return (_local_1 == "true");
        }

        private function onUserObject(_arg_1:IMessageEvent):void
        {
            var _local_2:UserObjectMessageParser = (_arg_1 as UserObjectEvent).getParser();
            _avatarId = _local_2.id;
        }

        private function onFriendsListFragment(_arg_1:IMessageEvent):void
        {
            var _local_2:FriendsListFragmentMessageParser = (_arg_1 as FriendListFragmentMessageEvent).getParser();
            for each (var _local_3:FriendData in _local_2.friendFragment)
            {
                _SafeStr_579.push(_local_3);
            };
            if ((_local_2.fragmentNo + 1) >= _local_2.totalFragments)
            {
                _SafeStr_577 = new Timer(5000, Math.ceil((_SafeStr_579.length / 300)));
                _SafeStr_577.addEventListener("timer", batchFriendsUpdate);
                _SafeStr_577.start();
            };
        }

        private function batchFriendsUpdate(_arg_1:TimerEvent):void
        {
            var _local_2:int;
            var _local_4:FriendData;
            var _local_3:int;
            if (_SafeStr_579.length > 300)
            {
                _local_3 = (_SafeStr_579.length - 300);
            };
            _local_2 = (_SafeStr_579.length - 1);
            while (_local_2 >= _local_3)
            {
                _local_4 = _SafeStr_579[_local_2];
                _SafeStr_575.addFriend(new Friend(_local_4));
                _SafeStr_579.splice(_local_2, 1);
                _local_2--;
            };
            if (_SafeStr_579.length == 0)
            {
                _hasfriendsListInitialized = true;
            };
        }

        private function onMessengerInit(_arg_1:IMessageEvent):void
        {
            var _local_4:FriendCategory;
            _view = new FriendListView(this);
            var _local_2:MessengerInitMessageParser = (_arg_1 as MessengerInitEvent).getParser();
            _friendRequests = new FriendRequests(new FriendRequestsDeps(this), _local_2.userFriendLimit, _local_2.extendedFriendLimit);
            for each (var _local_3:FriendCategoryData in _local_2.categories)
            {
                _SafeStr_575.addCategory(new FriendCategory(_local_3.id, _local_3.name));
            };
            _SafeStr_575.addCategory(new FriendCategory(0, getText("friendlist.friends")));
            _SafeStr_575.addCategory(new FriendCategory(-1, getText("friendlist.friends.offlinecaption")));
            _tabs = new FriendListTabs(new FriendListTabsDeps(this));
            if (!_SafeStr_576)
            {
                _SafeStr_576 = new Timer(120000);
                _SafeStr_576.addEventListener("timer", sendFriendListUpdate);
                _SafeStr_576.start();
            };
            getFriendRequests();
            registerListeners();
            if (_SafeStr_575.getFriendCount(true, false) == 0)
            {
                _local_4 = _SafeStr_575.findCategory(-1);
                if (_local_4)
                {
                    _local_4.setOpen(true);
                };
            };
            Logger.log("FRIENDLIST INITIALIZED SUCCESSFULLY");
        }

        public function trackFriendListEvent(_arg_1:String):void
        {
            events.dispatchEvent(new Event(_arg_1));
        }

        private function getSortedFriends(_arg_1:Array):Array
        {
            var _local_3:Array = [];
            var _local_6:Dictionary = new Dictionary();
            for each (var _local_5:FriendData in _arg_1)
            {
                _local_3.push(_local_5.name.toLowerCase());
                _local_6[_local_5.name.toLowerCase()] = _local_5;
            };
            _local_3.sort();
            var _local_2:Array = [];
            for each (var _local_4:String in _local_3)
            {
                _local_2.push(_local_6[_local_4]);
            };
            return (_local_2);
        }

        private function registerListeners():void
        {
            _communication.addHabboConnectionMessageEvent(new MessengerErrorEvent(onMessengerError));
            _communication.addHabboConnectionMessageEvent(new UserRightsMessageEvent(onUserRights));
            _communication.addHabboConnectionMessageEvent(new AcceptFriendResultEvent(onAcceptFriendResult));
            _communication.addHabboConnectionMessageEvent(new FollowFriendFailedEvent(onFollowFriendFailed));
            _communication.addHabboConnectionMessageEvent(new FriendListUpdateEvent(onFriendListUpdate));
            _communication.addHabboConnectionMessageEvent(new FriendRequestsEvent(onFriendRequests));
            _communication.addHabboConnectionMessageEvent(new NewFriendRequestEvent(onNewFriendRequest));
            _communication.addHabboConnectionMessageEvent(new RoomInviteErrorEvent(onRoomInviteError));
            _communication.addHabboConnectionMessageEvent(new HabboSearchResultEvent(onHabboSearchResult));
        }

        private function getFriendRequests():void
        {
            Logger.log("Sending friend requests request");
            send(new _SafeStr_24());
        }

        protected function sendFriendListUpdate(_arg_1:Event):void
        {
            Logger.log("Sending update request");
            send(new _SafeStr_22());
        }

        private function onFriendRequests(_arg_1:IMessageEvent):void
        {
            var _local_2:FriendRequestsMessageParser = (_arg_1 as FriendRequestsEvent).getParser();
            _friendRequests.clearAndUpdateView(false);
            for each (var _local_3:FriendRequestData in _local_2.reqs)
            {
                _friendRequests.addRequest(new FriendRequest(_local_3));
            };
            if (_local_2.reqs.length > 0)
            {
                _tabs.findTab(2).setNewMessageArrived(true);
            };
            _view.refresh("friendRequests");
        }

        private function onNewFriendRequest(_arg_1:IMessageEvent):void
        {
            Logger.log("Received new friend request");
            var _local_2:NewFriendRequestMessageParser = (_arg_1 as NewFriendRequestEvent).getParser();
            var _local_4:FriendRequest = new FriendRequest(_local_2.req);
            _friendRequests.addRequestAndUpdateView(_local_4);
            var _local_3:FriendListTab = _tabs.findTab(2);
            _local_3.setNewMessageArrived(true);
            _view.refresh("newFriendRequest");
        }

        private function onAcceptFriendResult(_arg_1:IMessageEvent):void
        {
            var _local_2:AcceptFriendResultMessageParser = (_arg_1 as AcceptFriendResultEvent).getParser();
            for each (var _local_3:AcceptFriendFailureData in _local_2.failures)
            {
                friendRequests.acceptFailed(_local_3.senderId);
                showAlertView(_local_3.errorCode);
            };
        }

        private function onHabboSearchResult(_arg_1:IMessageEvent):void
        {
            var _local_2:HabboSearchResultMessageParser = (_arg_1 as HabboSearchResultEvent).getParser();
            _searchResults.searchReceived(_local_2.friends, _local_2.others);
            _view.refresh("search");
        }

        private function onMessengerError(_arg_1:IMessageEvent):void
        {
            var _local_2:MessengerErrorMessageParser = (_arg_1 as MessengerErrorEvent).getParser();
            showAlertView(_local_2.errorCode, _local_2.clientMessageId);
        }

        private function showAlertView(_arg_1:int, _arg_2:int=0):void
        {
            var _local_3:String = "";
            switch (_arg_1)
            {
                case 1:
                    _local_3 = "${friendlist.error.friendlistownlimit}";
                    break;
                case 2:
                    _local_3 = "${friendlist.error.friendlistlimitofrequester}";
                    break;
                case 3:
                    _local_3 = "${friendlist.error.friend_requests_disabled}";
                    break;
                case 4:
                    _local_3 = "${friendlist.error.requestnotfound}";
                    break;
                default:
                    _local_3 = ((("Received messenger error: msg: " + _arg_2) + ", errorCode: ") + _arg_1);
            };
            simpleAlert("${friendlist.alert.title}", _local_3);
        }

        private function onRoomInviteError(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomInviteErrorMessageParser = (_arg_1 as RoomInviteErrorEvent).getParser();
            var _local_3:String = ((("Received room invite error: errorCode: " + _local_2.errorCode) + ", recipients: ") + Util.arrayToString(_local_2.failedRecipients));
            simpleAlert("${friendlist.alert.title}", _local_3);
        }

        private function onFriendListUpdate(_arg_1:IMessageEvent):void
        {
            _SafeStr_575.onFriendListUpdate(_arg_1);
            _view.refresh("friendListUpdate");
        }

        private function onFollowFriendFailed(_arg_1:IMessageEvent):void
        {
            var _local_2:FollowFriendFailedMessageParser = (_arg_1 as FollowFriendFailedEvent).getParser();
            var _local_3:String = getFollowFriendErrorText(_local_2.errorCode);
            Logger.log(((("Received follow friend failed: " + _local_2.errorCode) + ", ") + _local_3));
            simpleAlert("${friendlist.alert.title}", _local_3);
        }

        public function simpleAlert(_arg_1:String, _arg_2:String):void
        {
            windowManager.simpleAlert(_arg_1, null, _arg_2);
        }

        private function getFollowFriendErrorText(_arg_1:int):String
        {
            if (_arg_1 == 0)
            {
                return ("${friendlist.followerror.notfriend}");
            };
            if (_arg_1 == 1)
            {
                return ("${friendlist.followerror.offline}");
            };
            if (_arg_1 == 2)
            {
                return ("${friendlist.followerror.hotelview}");
            };
            if (_arg_1 == 3)
            {
                return ("${friendlist.followerror.prevented}");
            };
            return ("Unknown follow friend error " + _arg_1);
        }

        public function refreshText(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Boolean, _arg_4:String):void
        {
            var _local_5:IWindow = _arg_1.getChildByName(_arg_2);
            if (!_arg_3)
            {
                _local_5.visible = false;
            }
            else
            {
                _local_5.visible = true;
                _local_5.caption = _arg_4;
            };
        }

        public function refreshButton(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Boolean, _arg_4:Function, _arg_5:int):void
        {
            var _local_6:IWindow = (_arg_1.findChildByName(_arg_2) as IWindow);
            if (!_arg_3)
            {
                _local_6.visible = false;
            }
            else
            {
                prepareButton(_local_6, _arg_2, _arg_4, _arg_5);
                _local_6.visible = true;
            };
        }

        public function refreshRelationshipRegion(_arg_1:IWindowContainer, _arg_2:String, _arg_3:int, _arg_4:Function, _arg_5:int):void
        {
            var _local_6:IRegionWindow = IRegionWindow(_arg_1.findChildByName(_arg_2));
            var _local_7:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_local_6.findChildByTag("bitmap"));
            var _local_8:String = "relationship_status_none";
            switch (_arg_3)
            {
                case 1:
                    _local_8 = "relationship_status_heart";
                    break;
                case 2:
                    _local_8 = "relationship_status_smile";
                    break;
                case 3:
                    _local_8 = "relationship_status_bobba";
                default:
            };
            _local_7.assetUri = _local_8;
            _local_7.visible = true;
            _local_6.id = _arg_5;
            _local_6.procedure = _arg_4;
            _local_6.visible = ((_arg_5 > 0) && (getBoolean("relationship.status.enabled")));
        }

        public function refreshIcon(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Boolean, _arg_4:Function, _arg_5:int):void
        {
            var _local_6:IWindow = _arg_1.findChildByName(_arg_2);
            if (!_arg_3)
            {
                _local_6.visible = false;
            }
            else
            {
                _local_6.id = _arg_5;
                _local_6.procedure = _arg_4;
                _local_6.visible = true;
            };
        }

        private function prepareButton(_arg_1:IWindow, _arg_2:String, _arg_3:Function, _arg_4:int):void
        {
            var _local_5:IBitmapWrapperWindow;
            _arg_1.id = _arg_4;
            if ((_arg_1 is IBitmapWrapperWindow))
            {
                _local_5 = (_arg_1 as IBitmapWrapperWindow);
            }
            else
            {
                _local_5 = (IWindowContainer(_arg_1).findChildByTag("bitmap") as IBitmapWrapperWindow);
            };
            if (_local_5.bitmap != null)
            {
                return;
            };
            _local_5.bitmap = getButtonImage(_arg_2);
            _local_5.width = _local_5.bitmap.width;
            _local_5.height = _local_5.bitmap.height;
            _arg_1.procedure = _arg_3;
        }

        public function getButtonImage(_arg_1:String):BitmapData
        {
            var _local_4:BitmapData;
            var _local_5:IAsset = assets.getAssetByName((_arg_1 + "_png"));
            var _local_3:BitmapDataAsset = (_local_5 as BitmapDataAsset);
            Logger.log(("GETTING ASSET: " + _arg_1));
            var _local_2:BitmapData = (_local_3.content as BitmapData);
            Logger.log(((("GOT ASSET: " + _local_5) + ", ") + _local_2));
            _local_4 = new BitmapData(_local_2.width, _local_2.height, true, 0);
            _local_4.draw(_local_2);
            return (_local_4);
        }

        public function get lastRoomInvitationTime():int
        {
            return (_lastRoomInvitationTime);
        }

        public function resetLastRoomInvitationTime():void
        {
            _lastRoomInvitationTime = getTimer();
        }

        public function get hasfriendsListInitialized():Boolean
        {
            return (_hasfriendsListInitialized);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function get categories():FriendCategories
        {
            return (_SafeStr_575);
        }

        public function get friendRequests():FriendRequests
        {
            return (_friendRequests);
        }

        public function get searchResults():AvatarSearchResults
        {
            return (_searchResults);
        }

        public function get view():FriendListView
        {
            return (_view);
        }

        public function get tabs():FriendListTabs
        {
            return (_tabs);
        }

        public function get laf():_SafeStr_99
        {
            return (_laf);
        }

        public function get messenger():IHabboMessenger
        {
            return (_messenger);
        }

        public function get avatarId():int
        {
            return (_avatarId);
        }

        public function get notifications():IHabboNotifications
        {
            return (_notifications);
        }

        public function get tracking():IHabboTracking
        {
            return (_tracking);
        }

        public function get mainWindow():IWindowContainer
        {
            if (_view == null)
            {
                return (null);
            };
            return (_view.mainWindow);
        }

        public function getFriendNames():Array
        {
            if (_SafeStr_575 == null)
            {
                return ([]);
            };
            return (_SafeStr_575.getFriendNames());
        }

        public function acceptFriendRequest(_arg_1:int):void
        {
            if (!_tabs)
            {
                return;
            };
            var _local_3:FriendListTab = _tabs.findTab(2);
            if (!_local_3)
            {
                return;
            };
            var _local_2:IFriendRequestsView = (_local_3.tabView as IFriendRequestsView);
            if (!_local_2)
            {
                return;
            };
            _local_2.acceptRequest(_arg_1);
        }

        public function acceptAllFriendRequests():void
        {
            var _local_2:FriendListTab = _tabs.findTab(2);
            if (!_local_2)
            {
                return;
            };
            var _local_1:IFriendRequestsView = (_local_2.tabView as IFriendRequestsView);
            if (!_local_1)
            {
                return;
            };
            _local_1.acceptAllRequests();
        }

        public function declineFriendRequest(_arg_1:int):void
        {
            var _local_3:FriendListTab = _tabs.findTab(2);
            if (!_local_3)
            {
                return;
            };
            var _local_2:IFriendRequestsView = (_local_3.tabView as IFriendRequestsView);
            if (!_local_2)
            {
                return;
            };
            _local_2.declineRequest(_arg_1);
        }

        public function declineAllFriendRequests():void
        {
            var _local_2:FriendListTab = _tabs.findTab(2);
            if (!_local_2)
            {
                return;
            };
            var _local_1:IFriendRequestsView = (_local_2.tabView as IFriendRequestsView);
            if (!_local_1)
            {
                return;
            };
            _local_1.declineAllRequests();
        }

        public function setRelationshipStatus(_arg_1:int, _arg_2:int):void
        {
            send(new SetRelationshipStatusMessageComposer(_arg_1, _arg_2));
        }

        public function getRelationshipStatus(_arg_1:int):int
        {
            var _local_2:Friend = _SafeStr_575.findFriend(_arg_1);
            if (_local_2)
            {
                return (_local_2.relationshipStatus);
            };
            return (0);
        }

        private function onUserRights(_arg_1:IMessageEvent):void
        {
            if (((!(_sessionData)) || (!(_friendRequests))))
            {
                return;
            };
            var _local_2:int;
            if (_sessionData.hasVip)
            {
                _local_2 = _friendRequests.clubLimit;
            }
            else
            {
                if (_sessionData.hasClub)
                {
                    _local_2 = _friendRequests.clubLimit;
                };
            };
            if (_local_2 > _friendRequests.limit)
            {
                _friendRequests.limit = _local_2;
            };
        }

        public function avatarImageReady(_arg_1:String):void
        {
            var _local_6:IWindowContainer;
            var _local_5:IBitmapWrapperWindow;
            var _local_3:BitmapData;
            if (((disposed) || (_SafeStr_575 == null)))
            {
                return;
            };
            var _local_2:Dictionary = _SafeStr_575.getAllFriends();
            if (_local_2 == null)
            {
                return;
            };
            for each (var _local_4:Friend in _local_2)
            {
                if ((((!(_local_4 == null)) && (!(_local_4.disposed))) && (_local_4.figure == _arg_1)))
                {
                    if (_local_4.isGroupFriend())
                    {
                        _local_4.face = getSmallGroupBadgeBitmap(_local_4.figure);
                    }
                    else
                    {
                        _local_4.face = getAvatarFaceBitmap(_local_4.figure);
                    };
                    if (_local_4.face != null)
                    {
                        _local_6 = _local_4.view;
                        if (_local_6 != null)
                        {
                            _local_5 = (_local_6.getChildByName("face") as IBitmapWrapperWindow);
                            if (((!(_local_5 == null)) && (!(_local_5.disposed))))
                            {
                                _local_3 = _local_5.bitmap;
                                if (_local_3 != null)
                                {
                                    _local_3.fillRect(_local_3.rect, 0);
                                    _local_3.copyPixels(_local_4.face, _local_4.face.rect, new Point(0, 0), null, null, true);
                                };
                                _local_5.invalidate();
                            };
                        };
                    };
                };
            };
        }

        public function get linkPattern():String
        {
            return ("friendlist/");
        }

        public function linkReceived(_arg_1:String):void
        {
            var _local_3:Array;
            var _local_4:int;
            var _local_2:Array = _arg_1.split("/");
            if (_local_2.length < 2)
            {
                return;
            };
            switch (_local_2[1])
            {
                case "open":
                    openFriendList();
                    return;
                case "openchat":
                    if (((_local_2.length < 3) || (_messenger == null)))
                    {
                        return;
                    };
                    _local_3 = _local_2[2].split(":");
                    if (_local_3.length < 2)
                    {
                        return;
                    };
                    if (_local_3[0] == _avatarId)
                    {
                        _local_4 = _local_3[1];
                    }
                    else
                    {
                        _local_4 = _local_3[0];
                    };
                    if (((_local_4) && (_local_4 > 0)))
                    {
                        openFriendList();
                        _messenger.startConversation(_local_4);
                    };
                    return;
                default:
                    Logger.log(("FriendList unknown link-type received: " + _local_2[1]));
                    return;
            };
        }


    }
}

