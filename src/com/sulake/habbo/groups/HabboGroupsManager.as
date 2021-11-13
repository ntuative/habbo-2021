package com.sulake.habbo.groups
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.events.ILinkEventTracker;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.navigator.IHabboNewNavigator;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.communication.messages.incoming.users.GuildEditorData;
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboNavigator;
    import com.sulake.iid.IIDHabboNewNavigator;
    import com.sulake.iid.IIDHabboFriendList;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboTracking;
    import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
    import com.sulake.habbo.communication.messages.incoming.users.ExtendedProfileChangedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDeactivatedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;
    import com.sulake.habbo.communication.messages.incoming.users.GuildCreationInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipRejectedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupJoinFailedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.GuildMembersMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.GroupDetailsChangedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.HabboUserBadgesMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCreatedEvent;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.ExtendedProfileMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.RelationshipStatusInfoEvent;
    import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipUpdatedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.GuildEditFailedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.GuildMemberMgmtFailedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.GuildCreatedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.GuildEditorDataMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.incoming.users.GroupMembershipRequestedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.GuildEditInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.GuildMemberFurniCountInHQMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsData;
    import com.sulake.habbo.communication.messages.incoming.users.ExtendedProfileData;
    import com.sulake.habbo.communication.messages.incoming.users.GuildCreationData;
    import com.sulake.habbo.communication.messages.incoming.users.GuildEditData;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.groups.events.HabboGroupsEditorData;
    import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.FlatCreatedMessageParser;
    import com.sulake.habbo.communication.messages.incoming.users.MemberData;
    import com.sulake.habbo.communication.messages.incoming.users.GuildMemberData;
    import com.sulake.habbo.communication.messages.outgoing.users.KickMemberMessageComposer;
    import com.sulake.habbo.window.utils._SafeStr_126;
    import com.sulake.habbo.communication.messages.parser.users.ScrSendUserInfoMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.GetGuestRoomResultMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.users.GetGuildEditorDataMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.GetMemberGuildItemCountMessageComposer;

    public class HabboGroupsManager extends Component implements IHabboGroupsManager, ILinkEventTracker 
    {

        public static const GROUPS_TRACKING_CATEGORY:String = "HabboGroups";

        private var _communication:IHabboCommunicationManager;
        private var _windowManager:IHabboWindowManager;
        private var _localization:IHabboLocalizationManager;
        private var _navigator:IHabboNavigator;
        private var _newNavigator:IHabboNewNavigator;
        private var _friendlist:IHabboFriendList;
        private var _catalog:IHabboCatalog;
        private var _toolbar:IHabboToolbar;
        private var _habboTracking:IHabboTracking;
        private var _sessionDataManager:ISessionDataManager;
        private var _SafeStr_563:DetailsWindowCtrl;
        private var _guildMembersWindowCtrl:GuildMembersWindowCtrl;
        private var _guildManagementWindowCtrl:GuildManagementWindowCtrl;
        private var _SafeStr_564:ExtendedProfileWindowCtrl;
        private var _SafeStr_565:HcRequiredWindowCtrl;
        private var _SafeStr_566:GroupCreatedWindowCtrl;
        private var _groupRoomInfoCtrl:GroupRoomInfoCtrl;
        private var _guildEditorData:GuildEditorData;
        private var _avatarId:int;
        private var _roomId:int;
        private var _hasVip:Boolean;
        private var _SafeStr_567:GuildKickData;
        private var _messageEvents:Vector.<IMessageEvent>;

        public function HabboGroupsManager(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            _SafeStr_563 = new DetailsWindowCtrl(this);
            _guildMembersWindowCtrl = new GuildMembersWindowCtrl(this);
            _guildManagementWindowCtrl = new GuildManagementWindowCtrl(this);
            _SafeStr_564 = new ExtendedProfileWindowCtrl(this);
            _SafeStr_565 = new HcRequiredWindowCtrl(this);
            _SafeStr_566 = new GroupCreatedWindowCtrl(this);
            _groupRoomInfoCtrl = new GroupRoomInfoCtrl(this);
            Logger.log(("HabboGroupsManager initialized: " + _arg_3));
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(), function (_arg_1:IHabboWindowManager):void
            {
                _windowManager = _arg_1;
            }), new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _communication = _arg_1;
            }), new ComponentDependency(new IIDHabboLocalizationManager(), function (_arg_1:IHabboLocalizationManager):void
            {
                _localization = _arg_1;
            }), new ComponentDependency(new IIDHabboNavigator(), function (_arg_1:IHabboNavigator):void
            {
                _navigator = _arg_1;
            }), new ComponentDependency(new IIDHabboNewNavigator(), function (_arg_1:IHabboNewNavigator):void
            {
                _newNavigator = _arg_1;
            }), new ComponentDependency(new IIDHabboFriendList(), function (_arg_1:IHabboFriendList):void
            {
                _friendlist = _arg_1;
            }), new ComponentDependency(new IIDHabboCatalog(), function (_arg_1:IHabboCatalog):void
            {
                _catalog = _arg_1;
            }), new ComponentDependency(new IIDHabboToolbar(), function (_arg_1:IHabboToolbar):void
            {
                _toolbar = _arg_1;
            }), new ComponentDependency(new IIDSessionDataManager(), function (_arg_1:ISessionDataManager):void
            {
                _sessionDataManager = _arg_1;
            }), new ComponentDependency(new IIDHabboTracking(), function (_arg_1:IHabboTracking):void
            {
                _habboTracking = _arg_1;
            })]));
        }

        override protected function initComponent():void
        {
            _messageEvents = new Vector.<IMessageEvent>(0);
            addMessageEvent(new ScrSendUserInfoEvent(onSubscriptionInfo));
            addMessageEvent(new ExtendedProfileChangedMessageEvent(onExtendedProfileChanged));
            addMessageEvent(new HabboGroupDeactivatedMessageEvent(onGroupDeactivated));
            addMessageEvent(new GetGuestRoomResultEvent(onRoomInfo));
            addMessageEvent(new GuildCreationInfoMessageEvent(onGuildCreationInfo));
            addMessageEvent(new GuildMembershipRejectedMessageEvent(_guildMembersWindowCtrl.onGuildMembershipRejected));
            addMessageEvent(new HabboGroupJoinFailedMessageEvent(onJoinFailed));
            addMessageEvent(new GuildMembersMessageEvent(_guildMembersWindowCtrl.onGuildMembers));
            addMessageEvent(new GroupDetailsChangedMessageEvent(onGroupDetailsChanged));
            addMessageEvent(new HabboUserBadgesMessageEvent(onUserBadgesMessage));
            addMessageEvent(new CloseConnectionMessageEvent(onRoomLeave));
            addMessageEvent(new FlatCreatedEvent(onFlatCreated));
            addMessageEvent(new HabboGroupDetailsMessageEvent(onGroupDetails));
            addMessageEvent(new ExtendedProfileMessageEvent(onExtendedProfile));
            addMessageEvent(new RelationshipStatusInfoEvent(onRelationshipStatusInfo));
            addMessageEvent(new GuildMembershipUpdatedMessageEvent(_guildMembersWindowCtrl.onGuildMembershipUpdated));
            addMessageEvent(new GuildEditFailedMessageEvent(onGuildEditFailed));
            addMessageEvent(new GuildMemberMgmtFailedMessageEvent(_guildMembersWindowCtrl.onGuildMemberMgmtFailed));
            addMessageEvent(new GuildCreatedMessageEvent(onGuildCreated));
            addMessageEvent(new GuildEditorDataMessageEvent(onGuildEditorData));
            addMessageEvent(new UserObjectEvent(onUserObject));
            addMessageEvent(new GroupMembershipRequestedMessageEvent(_guildMembersWindowCtrl.onMembershipRequested));
            addMessageEvent(new GuildEditInfoMessageEvent(onGuildEditInfo));
            addMessageEvent(new GuildMemberFurniCountInHQMessageEvent(onKickConfirmation));
            addMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
            context.addLinkEventTracker(this);
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
                _messageEvents = null;
            };
            if (_SafeStr_563)
            {
                _SafeStr_563.dispose();
                _SafeStr_563 = null;
            };
            if (_guildMembersWindowCtrl)
            {
                _guildMembersWindowCtrl.dispose();
                _guildMembersWindowCtrl = null;
            };
            if (_guildManagementWindowCtrl)
            {
                _guildManagementWindowCtrl.dispose();
                _guildManagementWindowCtrl = null;
            };
            if (_SafeStr_564)
            {
                _SafeStr_564.dispose();
                _SafeStr_564 = null;
            };
            if (_SafeStr_565)
            {
                _SafeStr_565.dispose();
                _SafeStr_565 = null;
            };
            if (_SafeStr_566)
            {
                _SafeStr_566.dispose();
                _SafeStr_566 = null;
            };
            if (_groupRoomInfoCtrl)
            {
                _groupRoomInfoCtrl.dispose();
                _groupRoomInfoCtrl = null;
            };
            super.dispose();
        }

        public function get linkPattern():String
        {
            return ("group/");
        }

        public function linkReceived(_arg_1:String):void
        {
            var _local_2:Array = _arg_1.split("/");
            if (_local_2.length != 2)
            {
                return;
            };
            var _local_3:int = _local_2[1];
            openGroupInfo(_local_3);
        }

        public function showGroupBadgeInfo(_arg_1:Boolean, _arg_2:int):void
        {
            openGroupInfo(_arg_2);
            send(new EventLogMessageComposer("HabboGroups", ("" + _arg_2), "badge clicked"));
        }

        public function openGroupInfo(_arg_1:int):void
        {
            send(new GetHabboGroupDetailsMessageComposer(_arg_1, true));
        }

        public function send(_arg_1:IMessageComposer):void
        {
            _communication.connection.send(_arg_1);
        }

        public function getXmlWindow(_arg_1:String):IWindow
        {
            var _local_4:IAsset;
            var _local_2:XmlAsset;
            var _local_3:IWindow;
            try
            {
                _local_4 = assets.getAssetByName(_arg_1);
                _local_2 = XmlAsset(_local_4);
                _local_3 = _windowManager.buildFromXML(XML(_local_2.content));
            }
            catch(e:Error)
            {
            };
            return (_local_3);
        }

        public function getButtonImage(_arg_1:String):BitmapData
        {
            var _local_3:String = _arg_1;
            var _local_6:IAsset = assets.getAssetByName(_local_3);
            var _local_4:BitmapDataAsset = BitmapDataAsset(_local_6);
            var _local_2:BitmapData = BitmapData(_local_4.content);
            var _local_5:BitmapData = new BitmapData(_local_2.width, _local_2.height, true, 0);
            _local_5.draw(_local_2);
            return (_local_5);
        }

        public function openGroupForum(_arg_1:int):void
        {
            context.createLinkEvent(("groupforum/" + _arg_1));
        }

        private function onGroupDeactivated(_arg_1:IMessageEvent):void
        {
            var _local_2:int = HabboGroupDeactivatedMessageEvent(_arg_1).groupId;
            _SafeStr_563.onGroupDeactivated(_local_2);
            _groupRoomInfoCtrl.onGroupDeactivated(_local_2);
        }

        private function onGroupDetails(_arg_1:IMessageEvent):void
        {
            var _local_2:HabboGroupDetailsData = HabboGroupDetailsMessageEvent(_arg_1).data;
            _SafeStr_563.onGroupDetails(_local_2);
            _SafeStr_564.onGroupDetails(_local_2);
            _groupRoomInfoCtrl.onGroupDetails(_local_2);
        }

        private function onExtendedProfile(_arg_1:IMessageEvent):void
        {
            var _local_2:ExtendedProfileData = ExtendedProfileMessageEvent(_arg_1).data;
            if (_local_2.openProfileWindow)
            {
                _SafeStr_564.badgeUpdateExpected = true;
                _SafeStr_564.relationshipUpdateExpected = true;
                _SafeStr_564.onProfile(_local_2);
            };
        }

        private function onExtendedProfileChanged(_arg_1:IMessageEvent):void
        {
            var _local_2:int = ExtendedProfileChangedMessageEvent(_arg_1).userId;
            _SafeStr_564.onProfileChanged(_local_2);
        }

        private function onGroupDetailsChanged(_arg_1:IMessageEvent):void
        {
            var _local_2:int = GroupDetailsChangedMessageEvent(_arg_1).groupId;
            if (((_SafeStr_563.isDisplayingGroup(_local_2)) || (_groupRoomInfoCtrl.isDisplayingGroup(_local_2))))
            {
                send(new GetHabboGroupDetailsMessageComposer(_local_2, false));
            };
        }

        private function onJoinFailed(_arg_1:IMessageEvent):void
        {
            var _local_3:String;
            var _local_4:String;
            var _local_2:int = HabboGroupJoinFailedMessageEvent(_arg_1).reason;
            if (_local_2 == 4)
            {
                _SafeStr_565.show(false);
            }
            else
            {
                _local_3 = ("group.joinfail." + _local_2);
                _local_4 = _localization.getLocalization(_local_3, _local_3);
                _windowManager.alert("${group.joinfail.title}", _local_4, 0, onAlertClose);
            };
        }

        private function onGuildCreationInfo(_arg_1:IMessageEvent):void
        {
            var _local_2:GuildCreationData = GuildCreationInfoMessageEvent(_arg_1).data;
            _guildManagementWindowCtrl.onGuildCreationInfo(_local_2);
            requestGuildEditorData();
        }

        private function onGuildEditInfo(_arg_1:IMessageEvent):void
        {
            var _local_2:GuildEditData = GuildEditInfoMessageEvent(_arg_1).data;
            _guildManagementWindowCtrl.onGuildEditInfo(_local_2);
            requestGuildEditorData();
        }

        private function onRoomLeave(_arg_1:IMessageEvent):void
        {
            _SafeStr_563.close();
            _groupRoomInfoCtrl.close();
        }

        private function onRoomEnter(_arg_1:IMessageEvent):void
        {
            _SafeStr_563.close();
            _groupRoomInfoCtrl.close();
            var _local_2:RoomEntryInfoMessageParser = RoomEntryInfoMessageEvent(_arg_1).getParser();
            _roomId = _local_2.guestRoomId;
        }

        private function onAlertClose(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }

        private function onGuildEditorData(_arg_1:IMessageEvent):void
        {
            _guildEditorData = GuildEditorDataMessageEvent(_arg_1).data;
            events.dispatchEvent(new HabboGroupsEditorData());
        }

        private function onGuildEditFailed(_arg_1:IMessageEvent):void
        {
            var _local_3:String;
            var _local_4:String;
            var _local_2:int = GuildEditFailedMessageEvent(_arg_1).reason;
            if (_local_2 == 2)
            {
                _SafeStr_565.show(true);
            }
            else
            {
                _local_3 = ("group.edit.fail." + _local_2);
                _local_4 = _localization.getLocalization(_local_3, _local_3);
                _windowManager.alert("${group.edit.fail.title}", _local_4, 0, onAlertClose);
            };
        }

        private function onUserObject(_arg_1:IMessageEvent):void
        {
            var _local_2:UserObjectMessageParser = UserObjectEvent(_arg_1).getParser();
            _avatarId = _local_2.id;
        }

        private function onFlatCreated(_arg_1:IMessageEvent):void
        {
            var _local_2:FlatCreatedMessageParser = FlatCreatedEvent(_arg_1).getParser();
            _guildManagementWindowCtrl.onFlatCreated(_local_2.flatId, _local_2.flatName);
        }

        private function onGuildCreated(_arg_1:IMessageEvent):void
        {
            var _local_2:GuildCreatedMessageEvent = GuildCreatedMessageEvent(_arg_1);
            _SafeStr_566.show(_local_2.groupId);
            _guildManagementWindowCtrl.close();
            _groupRoomInfoCtrl.expectedGroupId = _local_2.groupId;
            if (_roomId != _local_2.baseRoomId)
            {
                _navigator.goToPrivateRoom(_local_2.baseRoomId);
            };
        }

        private function onKickConfirmation(_arg_1:IMessageEvent):void
        {
            var _local_4:int = GuildMemberFurniCountInHQMessageEvent(_arg_1).userId();
            var _local_6:int = GuildMemberFurniCountInHQMessageEvent(_arg_1).furniCount();
            var _local_5:MemberData;
            var _local_2:GuildMemberData = _guildMembersWindowCtrl.data;
            var _local_3:String = ((_SafeStr_567.targetBlocked) ? "group.block" : "group.kick");
            if (_local_6 > 0)
            {
                if (_local_4 == _avatarId)
                {
                    localization.registerParameter("group.leaveconfirm.desc", "amount", _local_6.toString());
                    _windowManager.confirm("${group.leaveconfirm.title}", "${group.leaveconfirm.desc}", 0, onKickConfirmationClose);
                }
                else
                {
                    _local_5 = _local_2.getUser(_local_4);
                    localization.registerParameter((_local_3 + "confirm.desc"), "amount", _local_6.toString());
                    localization.registerParameter((_local_3 + "confirm.desc"), "user", _local_5.userName);
                    _windowManager.confirm((("${" + _local_3) + "confirm.title}"), (("${" + _local_3) + "confirm.desc}"), 0, onKickConfirmationClose);
                };
            }
            else
            {
                if (_local_4 == _avatarId)
                {
                    _windowManager.confirm("${group.leaveconfirm.title}", "${group.leaveconfirm_nofurni.desc}", 0, onKickConfirmationClose);
                }
                else
                {
                    if (_local_2)
                    {
                        _local_5 = _local_2.getUser(_local_4);
                        localization.registerParameter((_local_3 + "confirm_nofurni.desc"), "user", _local_5.userName);
                        _windowManager.confirm((("${" + _local_3) + "confirm.title}"), (("${" + _local_3) + "confirm_nofurni.desc}"), 0, onKickConfirmationClose);
                    };
                };
            };
        }

        private function onKickConfirmationClose(_arg_1:_SafeStr_126, _arg_2:WindowEvent):void
        {
            if ((((_arg_1 == null) || (_arg_1.disposed)) || (_SafeStr_567 == null)))
            {
                _SafeStr_567 = null;
                return;
            };
            _arg_1.dispose();
            if (_arg_2.type == "WE_OK")
            {
                send(new KickMemberMessageComposer(_SafeStr_567.kickGuildId, _SafeStr_567.kickTargetId, _SafeStr_567.targetBlocked));
            };
            _SafeStr_567 = null;
        }

        private function onSubscriptionInfo(_arg_1:IMessageEvent):void
        {
            var _local_2:ScrSendUserInfoMessageParser = ScrSendUserInfoEvent(_arg_1).getParser();
            _hasVip = ((_local_2.isVIP) && (_local_2.minutesUntilExpiration > 0));
            _guildManagementWindowCtrl.onSubscriptionChange();
        }

        private function onRoomInfo(_arg_1:IMessageEvent):void
        {
            var _local_2:GetGuestRoomResultMessageParser = GetGuestRoomResultEvent(_arg_1).getParser();
            if (_local_2.enterRoom)
            {
                _groupRoomInfoCtrl.onRoomInfo(_local_2.data);
            };
        }

        private function onRelationshipStatusInfo(_arg_1:IMessageEvent):void
        {
            var _local_2:RelationshipStatusInfoEvent = RelationshipStatusInfoEvent(_arg_1);
            _SafeStr_564.onRelationshipStatusInfo(_local_2.userId, _local_2.relationshipStatusMap);
        }

        private function onUserBadgesMessage(_arg_1:HabboUserBadgesMessageEvent):void
        {
            _SafeStr_564.onUserBadges(_arg_1.userId, _arg_1.badges);
        }

        private function requestGuildEditorData():void
        {
            if (_guildEditorData == null)
            {
                send(new GetGuildEditorDataMessageComposer());
            };
        }

        public function get localization():IHabboLocalizationManager
        {
            return (_localization);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function get guildManagementWindowCtrl():GuildManagementWindowCtrl
        {
            return (_guildManagementWindowCtrl);
        }

        public function get groupRoomInfoCtrl():GroupRoomInfoCtrl
        {
            return (_groupRoomInfoCtrl);
        }

        public function get groupRoomInfoEnabled():Boolean
        {
            return (getBoolean("groupRoomInfo.enabled"));
        }

        public function get groupDeletionEnabled():Boolean
        {
            return (getBoolean("group.deletion.enabled"));
        }

        public function get groupRoomInfoBadgeEnabled():Boolean
        {
            return ((groupRoomInfoEnabled) && (getBoolean("groupRoomInfo.badge.enabled")));
        }

        public function get toolbarAttachEnabled():Boolean
        {
            return ((groupRoomInfoEnabled) && (getBoolean("groupRoomInfo.attach.enabled")));
        }

        public function get isActivityDisplayEnabled():Boolean
        {
            return (getBoolean("activity.point.display.enabled"));
        }

        public function get guildEditorData():GuildEditorData
        {
            return (_guildEditorData);
        }

        public function get avatarId():int
        {
            return (_avatarId);
        }

        public function get navigator():IHabboNavigator
        {
            return (_newNavigator.legacyNavigator);
        }

        public function get friendlist():IHabboFriendList
        {
            return (_friendlist);
        }

        public function get guildMembersWindowCtrl():GuildMembersWindowCtrl
        {
            return (_guildMembersWindowCtrl);
        }

        public function get habboTracking():IHabboTracking
        {
            return (_habboTracking);
        }

        public function trackGoogle(_arg_1:String, _arg_2:String, _arg_3:int=-1):void
        {
            if (_habboTracking != null)
            {
                _habboTracking.trackGoogle(_arg_1, _arg_2, _arg_3);
            };
        }

        public function get roomId():int
        {
            return (_roomId);
        }

        public function get toolbar():IHabboToolbar
        {
            return (_toolbar);
        }

        public function updateVisibleExtendedProfile(_arg_1:int):void
        {
            _SafeStr_564.updateVisibleExtendedProfile(_arg_1);
        }

        public function showExtendedProfile(_arg_1:int):void
        {
            send(new GetExtendedProfileMessageComposer(_arg_1));
        }

        public function openCatalog(_arg_1:String):void
        {
            _catalog.openCatalogPage(_arg_1);
        }

        public function openVipPurchase(_arg_1:String):void
        {
            _catalog.openClubCenter();
        }

        public function get hasVip():Boolean
        {
            return (_hasVip);
        }

        public function handleUserKick(_arg_1:int, _arg_2:int):void
        {
            _SafeStr_567 = new GuildKickData(_arg_1, _arg_2);
            send(new GetMemberGuildItemCountMessageComposer(_arg_2, _arg_1));
        }

        public function handleUserBlock(_arg_1:int, _arg_2:int):void
        {
            _SafeStr_567 = new GuildKickData(_arg_1, _arg_2, true);
            send(new GetMemberGuildItemCountMessageComposer(_arg_2, _arg_1));
        }

        public function get newNavigator():IHabboNewNavigator
        {
            return (_newNavigator);
        }

        public function get sessionDataManager():ISessionDataManager
        {
            return (_sessionDataManager);
        }


    }
}

