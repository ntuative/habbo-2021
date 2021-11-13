package com.sulake.habbo.friendbar.groupforums
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.events.ILinkEventTracker;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.help.IHabboHelp;
    import com.sulake.habbo.notifications.IHabboNotifications;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.habbo.communication.messages.parser.groupforums.ExtendedForumData;
    import flash.utils.Dictionary;
    import flash.utils.Timer;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboHelp;
    import com.sulake.iid.IIDHabboNotifications;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboSoundManager;
    import com.sulake.iid.IIDHabboTracking;
    import com.sulake.iid.IIDHabboToolbar;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.parser.groupforums.ForumDataMessageEvent;
    import com.sulake.habbo.communication.messages.parser.groupforums.ThreadMessagesMessageEvent;
    import com.sulake.habbo.communication.messages.parser.groupforums.UnreadForumsCountMessageEvent;
    import com.sulake.habbo.communication.messages.parser.groupforums.UpdateThreadMessageEvent;
    import com.sulake.habbo.communication.messages.parser.groupforums.ForumThreadsMessageEvent;
    import com.sulake.habbo.communication.messages.parser.groupforums.PostMessageMessageEvent;
    import com.sulake.habbo.communication.messages.parser.groupforums.ForumsListMessageEvent;
    import com.sulake.habbo.communication.messages.parser.groupforums.UpdateMessageMessageEvent;
    import com.sulake.habbo.communication.messages.parser.groupforums.PostThreadMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.groupforums.GetThreadMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.groupforums.GetForumsListMessageComposer;
    import com.sulake.habbo.communication.messages.parser.groupforums.GetForumsListMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.groupforums.GetForumStatsMessageComposer;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.communication.messages.outgoing.groupforums.GetThreadsMessageComposer;
    import com.sulake.habbo.communication.messages.parser.groupforums.ForumThreadsMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.groupforums.GetMessagesMessageComposer;
    import com.sulake.habbo.communication.messages.parser.groupforums.MessageData;
    import com.sulake.habbo.communication.messages.parser.groupforums.ThreadMessagesMessageParser;
    import com.sulake.habbo.communication.messages.parser.groupforums.ThreadData;
    import com.sulake.habbo.communication.messages.outgoing.groupforums.UpdateForumSettingsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.groupforums.PostMessageMessageComposer;
    import flash.utils.getTimer;
    import com.sulake.habbo.communication.messages.parser.groupforums.ForumData;
    import com.sulake.habbo.communication.messages.parser.groupforums.PostThreadMessageParser;
    import com.sulake.habbo.communication.messages.parser.groupforums.PostMessageMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.groupforums.ModerateThreadMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.groupforums.UpdateThreadMessageComposer;
    import com.sulake.habbo.communication.messages.parser.groupforums.UpdateThreadMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.groupforums.ModerateMessageMessageComposer;
    import com.sulake.habbo.communication.messages.parser.groupforums.UpdateMessageMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.groupforums.UpdateForumReadMarkerMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.groupforums.GetUnreadForumsCountMessageComposer;
    import flash.events.TimerEvent;

    public class GroupForumController extends Component implements _SafeStr_148, ILinkEventTracker
    {

        public static const FORUMS_LIST_CODE_ACTIVE:int = 0;
        public static const FORUMS_LIST_CODE_POPULAR:int = 1;
        public static const FORUMS_LIST_CODE_MY_FORUMS:int = 2;
        public static const _SafeStr_2248:int = -1;

        private var _configurationManager:ICoreConfiguration;
        private var _communicationManager:IHabboCommunicationManager;
        private var _windowManager:IHabboWindowManager;
        private var _localizationManager:IHabboLocalizationManager;
        private var _help:IHabboHelp;
        private var _notifications:IHabboNotifications;
        private var _soundManager:IHabboSoundManager;
        private var _tracking:IHabboTracking;
        private var _SafeStr_461:GroupForumView;
        private var _composeMessageView:ComposeMessageView;
        private var _forumSettingsView:ForumSettingsView;
        private var _SafeStr_2249:int = -1;
        private var _SafeStr_2250:int = -1;
        private var _SafeStr_2235:ExtendedForumData;
        private var _SafeStr_2251:int;
        private var _SafeStr_2252:int = 0;
        private var _SafeStr_2253:ForumsListData;
        private var _SafeStr_2254:ThreadsListData;
        private var _SafeStr_2255:MessagesListData;
        private var _lastReadMessageIndexByThread:Dictionary = new Dictionary();
        private var _SafeStr_2256:int = -1;
        private var _SafeStr_2257:int;
        private var _lastPostTime:int = -30000;
        private var _unreadForumsCount:int = 0;
        private var _SafeStr_2258:Timer;

        public function GroupForumController(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        public function get composeMessageView():ComposeMessageView
        {
            return (_composeMessageView);
        }

        public function set composeMessageView(_arg_1:ComposeMessageView):void
        {
            _composeMessageView = _arg_1;
        }

        public function get forumSettingsView():ForumSettingsView
        {
            return (_forumSettingsView);
        }

        public function set forumSettingsView(_arg_1:ForumSettingsView):void
        {
            _forumSettingsView = _arg_1;
        }

        public function get notifications():IHabboNotifications
        {
            return (_notifications);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function get localizationManager():IHabboLocalizationManager
        {
            return (_localizationManager);
        }

        public function get lastPostTime():int
        {
            return (_lastPostTime);
        }

        public function get unreadForumsCount():int
        {
            return (_unreadForumsCount);
        }

        public function get tracking():IHabboTracking
        {
            return (_tracking);
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboConfigurationManager(), function (_arg_1:ICoreConfiguration):void
            {
                _configurationManager = _arg_1;
            }), new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _communicationManager = _arg_1;
            }), new ComponentDependency(new IIDHabboLocalizationManager(), function (_arg_1:IHabboLocalizationManager):void
            {
                _localizationManager = _arg_1;
            }), new ComponentDependency(new IIDHabboHelp(), function (_arg_1:IHabboHelp):void
            {
                _help = _arg_1;
            }), new ComponentDependency(new IIDHabboNotifications(), function (_arg_1:IHabboNotifications):void
            {
                _notifications = _arg_1;
            }), new ComponentDependency(new IIDHabboWindowManager(), function (_arg_1:IHabboWindowManager):void
            {
                _windowManager = _arg_1;
            }), new ComponentDependency(new IIDHabboSoundManager(), function (_arg_1:IHabboSoundManager):void
            {
                _soundManager = _arg_1;
            }), new ComponentDependency(new IIDHabboTracking(), function (_arg_1:IHabboTracking):void
            {
                _tracking = _arg_1;
            }), new ComponentDependency(new IIDHabboToolbar(), null)]));
        }

        override protected function initComponent():void
        {
            _communicationManager.addHabboConnectionMessageEvent(new ForumDataMessageEvent(onForumData));
            _communicationManager.addHabboConnectionMessageEvent(new ThreadMessagesMessageEvent(onThreadMessageList));
            _communicationManager.addHabboConnectionMessageEvent(new UnreadForumsCountMessageEvent(onUnreadForumsCountMessage));
            _communicationManager.addHabboConnectionMessageEvent(new UpdateThreadMessageEvent(onUpdateThread));
            _communicationManager.addHabboConnectionMessageEvent(new ForumThreadsMessageEvent(onThreadList));
            _communicationManager.addHabboConnectionMessageEvent(new PostMessageMessageEvent(onPostMessageMessage));
            _communicationManager.addHabboConnectionMessageEvent(new ForumsListMessageEvent(onForumsList));
            _communicationManager.addHabboConnectionMessageEvent(new UpdateMessageMessageEvent(onUpdateMessage));
            _communicationManager.addHabboConnectionMessageEvent(new PostThreadMessageEvent(onPostThreadMessage));
            context.addLinkEventTracker(this);
            startPollingForUnreadForumsCount();
        }

        override public function dispose():void
        {
            if (_SafeStr_2258 != null)
            {
                _SafeStr_2258.stop();
                _SafeStr_2258 = null;
            };
            super.dispose();
        }

        private function startPollingForUnreadForumsCount():void
        {
            var _local_1:int = _configurationManager.getInteger("groupforum.poll.period", 300);
            _SafeStr_2258 = new Timer((_local_1 * 1000), 0);
            _SafeStr_2258.addEventListener("timer", onUnreadForumsCountUpdateTimerEvent);
            _SafeStr_2258.start();
            onUnreadForumsCountUpdateTimerEvent(null);
        }

        public function openGroupForum(_arg_1:int):void
        {
            if (!_communicationManager)
            {
                return;
            };
            initForum(_arg_1);
            requestThreadList(_arg_1, 0);
        }

        public function get linkPattern():String
        {
            return ("groupforum/");
        }

        public function linkReceived(_arg_1:String):void
        {
            var _local_5:int;
            var _local_6:int;
            var _local_2:int;
            var _local_4:int;
            if (!_communicationManager)
            {
                return;
            };
            var _local_3:Array = _arg_1.split("/");
            if (_local_3.length < 2)
            {
                return;
            };
            if (_local_3[1] == "list")
            {
                if (_local_3.length == 3)
                {
                    switch (_local_3[2])
                    {
                        case "active":
                            _local_5 = 0;
                            break;
                        case "popular":
                            _local_5 = 1;
                            break;
                        case "my":
                            _local_5 = 2;
                            break;
                        default:
                            return;
                    };
                    openForumsList(_local_5);
                };
            }
            else
            {
                _local_6 = _local_3[1];
                if (_local_6 == 0)
                {
                    return;
                };
                _SafeStr_2253 = null;
                if (_local_3.length == 2)
                {
                    openGroupForum(_local_6);
                }
                else
                {
                    _local_2 = _local_3[2];
                    _local_4 = 0;
                    if (_local_3.length > 3)
                    {
                        _local_4 = _local_3[3];
                    };
                    initForum(_local_6);
                    _communicationManager.connection.send(new GetThreadMessageComposer(_local_6, _local_2));
                    goToMessageIndex(_local_6, _local_2, _local_4);
                };
            };
        }

        public function openForumsList(_arg_1:int, _arg_2:int=0):void
        {
            markForumAsRead();
            _SafeStr_2249 = _arg_1;
            _SafeStr_2250 = -1;
            _communicationManager.connection.send(new GetForumsListMessageComposer(_arg_1, _arg_2, 20));
        }

        private function onForumsList(_arg_1:ForumsListMessageEvent):void
        {
            var _local_3:GetForumsListMessageParser = _arg_1.getParser();
            var _local_2:ForumsListData = new ForumsListData(_local_3);
            if (((!(_SafeStr_2235 == null)) && (_SafeStr_2252 > 0)))
            {
                _local_2.updateUnreadMessages(_SafeStr_2235, _SafeStr_2252);
            };
            if (_local_2.listCode == 2)
            {
                updateUnreadForumsCount(_local_2.unreadForumsCount);
            };
            if (_SafeStr_2249 != _local_2.listCode)
            {
                return;
            };
            _SafeStr_2253 = _local_2;
            if (!_SafeStr_461)
            {
                _SafeStr_461 = new GroupForumView(this);
            };
            _SafeStr_461.openForumsList(_SafeStr_2253);
        }

        private function initForum(_arg_1:int):void
        {
            markForumAsRead();
            _SafeStr_2249 = -1;
            _SafeStr_2250 = _arg_1;
            _SafeStr_2252 = 0;
            _communicationManager.connection.send(new GetForumStatsMessageComposer(_arg_1));
        }

        private function onForumData(_arg_1:ForumDataMessageEvent):void
        {
            var _local_2:Map;
            var _local_3:String;
            var _local_4:ExtendedForumData = _arg_1.getParser().forumData;
            if (_SafeStr_2250 != _local_4.groupId)
            {
                return;
            };
            if (!_local_4.canRead)
            {
                if (_SafeStr_461 != null)
                {
                    _SafeStr_461.dispose();
                };
                _SafeStr_2235 = null;
                _SafeStr_2250 = 0;
                _local_2 = new Map();
                _local_3 = localizationManager.getLocalization("groupforum.view.error.operation_read");
                _local_2.add("message", localizationManager.getLocalizationWithParams(("groupforum.view.error." + _local_4.readPermissionError), "", "operation", _local_3));
                notifications.showNotification("forums.error.access_denied", _local_2);
                return;
            };
            _SafeStr_2235 = _local_4;
            _SafeStr_2252 = _local_4.lastReadMessageId;
        }

        public function requestThreadList(_arg_1:int, _arg_2:int):void
        {
            if (_communicationManager)
            {
                _communicationManager.connection.send(new GetThreadsMessageComposer(_arg_1, _arg_2, 20));
            };
        }

        private function onThreadList(_arg_1:ForumThreadsMessageEvent):void
        {
            var _local_2:ForumThreadsMessageParser = _arg_1.getParser();
            if (((_SafeStr_2235 == null) || (!(_SafeStr_2235.groupId == _local_2.groupId))))
            {
                return;
            };
            _SafeStr_2254 = new ThreadsListData(_SafeStr_2235.totalThreads, _local_2.startIndex, _local_2.threads);
            if (!_SafeStr_461)
            {
                _SafeStr_461 = new GroupForumView(this);
            };
            _SafeStr_461.openThreadList(_SafeStr_2253, _SafeStr_2235, _SafeStr_2254);
        }

        public function requestThreadMessageList(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            if (_communicationManager)
            {
                _communicationManager.connection.send(new GetMessagesMessageComposer(_arg_1, _arg_2, _arg_3, 20));
            };
        }

        private function onThreadMessageList(_arg_1:ThreadMessagesMessageEvent):void
        {
            var _local_6:MessageData;
            var _local_3:ThreadMessagesMessageParser = _arg_1.getParser();
            if ((((_SafeStr_2235 == null) || (!(_SafeStr_2235.groupId == _local_3.groupId))) || (_SafeStr_2254 == null)))
            {
                return;
            };
            _SafeStr_2251 = _local_3.threadId;
            var _local_2:ThreadData = _SafeStr_2254.threadsById[_SafeStr_2251];
            if (_local_2 == null)
            {
                return;
            };
            var _local_4:int = _local_3.startIndex;
            var _local_5:int = _local_2.nMessages;
            _SafeStr_2255 = new MessagesListData(_SafeStr_2251, _local_5, _local_4, _local_3.messages);
            if (!_SafeStr_461)
            {
                _SafeStr_461 = new GroupForumView(this);
            };
            _SafeStr_461.openMessagesList(_SafeStr_2253, _SafeStr_2235, _SafeStr_2254, _SafeStr_2255);
            if (_local_3.messages.length > 0)
            {
                _local_6 = MessageData(_local_3.messages[(_local_3.messages.length - 1)]);
                if (_local_6)
                {
                    updateUnreadMessageCounts(_local_6.messageId, _local_6.threadId, _local_6.messageIndex);
                };
            };
        }

        public function updateForumSettings(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int):void
        {
            if (_communicationManager)
            {
                _communicationManager.connection.send(new UpdateForumSettingsMessageComposer(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5));
            };
        }

        public function postNewThread(_arg_1:int, _arg_2:String, _arg_3:String):void
        {
            if (_communicationManager)
            {
                _communicationManager.connection.send(new PostMessageMessageComposer(_arg_1, 0, _arg_2, _arg_3));
                _lastPostTime = getTimer();
            };
        }

        private function onPostThreadMessage(_arg_1:PostThreadMessageEvent):void
        {
            var _local_3:ForumData;
            var _local_2:PostThreadMessageParser = PostThreadMessageParser(_arg_1.getParser());
            if (_composeMessageView)
            {
                _composeMessageView.dispose();
            };
            if (((!(_SafeStr_2235 == null)) && (_SafeStr_2235.groupId == _local_2.groupId)))
            {
                updateUnreadMessageCounts(_local_2.thread.lastMessageId, _local_2.thread.threadId, (_local_2.thread.nMessages - 1));
            };
            if (_SafeStr_2253 != null)
            {
                _local_3 = _SafeStr_2253.getForumData(_local_2.groupId);
                if (_local_3 != null)
                {
                    _local_3.addNewThread(_local_2.thread);
                };
            };
            if (_SafeStr_461 == null)
            {
                return;
            };
            if (((_SafeStr_2235 == null) || (!(_local_2.groupId == _SafeStr_2235.groupId))))
            {
                return;
            };
            requestThreadList(_SafeStr_2235.groupId, 0);
        }

        public function postNewMessage(_arg_1:int, _arg_2:int, _arg_3:String):void
        {
            if (_communicationManager)
            {
                _communicationManager.connection.send(new PostMessageMessageComposer(_arg_1, _arg_2, "", _arg_3));
                _lastPostTime = getTimer();
            };
        }

        private function onPostMessageMessage(_arg_1:PostMessageMessageEvent):void
        {
            if (_composeMessageView)
            {
                _composeMessageView.dispose();
            };
            if (_SafeStr_461 == null)
            {
                return;
            };
            var _local_2:PostMessageMessageParser = PostMessageMessageParser(_arg_1.getParser());
            if ((((_SafeStr_2235 == null) || (!(_local_2.groupId == _SafeStr_2235.groupId))) || (!(_local_2.threadId == _SafeStr_2251))))
            {
                return;
            };
            var _local_3:int = (_local_2.message.messageIndex - (_local_2.message.messageIndex % 20));
            requestThreadMessageList(_SafeStr_2235.groupId, _SafeStr_2251, _local_3);
        }

        public function deleteThread(_arg_1:ExtendedForumData, _arg_2:int):void
        {
            var _local_3:int;
            if (_communicationManager)
            {
                if (_arg_1.canModerate)
                {
                    _local_3 = 10;
                };
                if (_arg_1.isStaff)
                {
                    _local_3 = 20;
                };
                _communicationManager.connection.send(new ModerateThreadMessageComposer(_arg_1.groupId, _arg_2, _local_3));
            };
        }

        public function unDeleteThread(_arg_1:ForumData, _arg_2:int):void
        {
            if (_communicationManager)
            {
                _communicationManager.connection.send(new ModerateThreadMessageComposer(_arg_1.groupId, _arg_2, 1));
            };
        }

        public function lockThread(_arg_1:ForumData, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean):void
        {
            if (_communicationManager)
            {
                _communicationManager.connection.send(new UpdateThreadMessageComposer(_arg_1.groupId, _arg_2, _arg_3, _arg_4));
            };
        }

        public function stickThread(_arg_1:ForumData, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean):void
        {
            if (_communicationManager)
            {
                _communicationManager.connection.send(new UpdateThreadMessageComposer(_arg_1.groupId, _arg_2, _arg_3, _arg_4));
            };
        }

        public function reportThread(_arg_1:ForumData, _arg_2:int):void
        {
            if (_help)
            {
                _help.reportThread(_arg_1.groupId, _arg_2);
            };
        }

        private function onUpdateThread(_arg_1:UpdateThreadMessageEvent):void
        {
            var _local_2:UpdateThreadMessageParser = _arg_1.getParser();
            if (((_SafeStr_2235 == null) || (!(_SafeStr_2235.groupId == _local_2.groupId))))
            {
                return;
            };
            var _local_3:ThreadData = _local_2.thread;
            if (((_SafeStr_2254) && (_SafeStr_461)))
            {
                if (_SafeStr_2254.updateThread(_local_3))
                {
                    _SafeStr_461.updateThread(_local_3);
                    return;
                };
            };
            _SafeStr_2254 = new ThreadsListData(1, 0, [_local_3]);
        }

        public function deleteMessage(_arg_1:ExtendedForumData, _arg_2:int, _arg_3:int):void
        {
            var _local_4:int;
            if (_communicationManager)
            {
                _local_4 = 10;
                if (_arg_1.isStaff)
                {
                    _local_4 = 20;
                };
                _communicationManager.connection.send(new ModerateMessageMessageComposer(_SafeStr_2235.groupId, _arg_2, _arg_3, _local_4));
            };
        }

        public function unDeleteMessage(_arg_1:ForumData, _arg_2:int, _arg_3:int):void
        {
            if (_communicationManager)
            {
                _communicationManager.connection.send(new ModerateMessageMessageComposer(_arg_1.groupId, _arg_2, _arg_3, 1));
            };
        }

        public function reportMessage(_arg_1:ForumData, _arg_2:int, _arg_3:int):void
        {
            if (_help)
            {
                _help.reportMessage(_arg_1.groupId, _arg_2, _arg_3);
            };
        }

        private function onUpdateMessage(_arg_1:UpdateMessageMessageEvent):void
        {
            var _local_5:int;
            var _local_6:MessageData;
            var _local_3:UpdateMessageMessageParser = _arg_1.getParser();
            if ((((_SafeStr_2235 == null) || (!(_SafeStr_2235.groupId == _local_3.groupId))) || (!(_SafeStr_2251 == _local_3.threadId))))
            {
                return;
            };
            var _local_2:MessageData = _local_3.message;
            var _local_4:Array = _SafeStr_2255["messages"];
            _local_5 = 0;
            while (_local_5 < _local_4.length)
            {
                _local_6 = _local_4[_local_5];
                if (_local_6.messageId == _local_2.messageId)
                {
                    _local_4[_local_5] = _local_2;
                    if (_SafeStr_461)
                    {
                        _SafeStr_461.updateMessage(_local_2);
                    };
                    return;
                };
                _local_5++;
            };
        }

        public function goToMessageIndex(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            _SafeStr_2256 = _arg_2;
            var _local_4:int = int(Math.floor((_arg_3 / 20)));
            _SafeStr_2257 = (_arg_3 % 20);
            requestThreadMessageList(_arg_1, _arg_2, (_local_4 * 20));
        }

        public function getUserInfo(_arg_1:int):void
        {
            if (_communicationManager)
            {
                _communicationManager.connection.send(new GetExtendedProfileMessageComposer(_arg_1));
            };
        }

        public function closeMainView():void
        {
            markForumAsRead();
            _SafeStr_461 = null;
            _SafeStr_2235 = null;
            _SafeStr_2249 = -1;
            _SafeStr_2250 = -1;
        }

        public function markForumAsRead(_arg_1:Boolean=false):void
        {
            var _local_2:UpdateForumReadMarkerMessageComposer;
            if (((_communicationManager) && (_SafeStr_2235)))
            {
                if (((_arg_1) || (_SafeStr_2252 > _SafeStr_2235.lastReadMessageId)))
                {
                    _local_2 = new UpdateForumReadMarkerMessageComposer();
                    if (_arg_1)
                    {
                        _local_2.add(_SafeStr_2235.groupId, Math.max(_SafeStr_2235.totalMessages, _SafeStr_2252), (_SafeStr_2252 == 0));
                    }
                    else
                    {
                        _local_2.add(_SafeStr_2235.groupId, _SafeStr_2252, false);
                    };
                    _communicationManager.connection.send(_local_2);
                };
            };
            _SafeStr_2252 = 0;
            _lastReadMessageIndexByThread = new Dictionary();
        }

        public function markForumsAsRead():void
        {
            var _local_1:UpdateForumReadMarkerMessageComposer;
            if (((_communicationManager) && (_SafeStr_2253)))
            {
                _local_1 = new UpdateForumReadMarkerMessageComposer();
                for each (var _local_2:ForumData in _SafeStr_2253.forums)
                {
                    if (_local_2.unreadMessages > 0)
                    {
                        _local_1.add(_local_2.groupId, _local_2.totalMessages, true);
                    };
                };
                if (_local_1.size > 0)
                {
                    _communicationManager.connection.send(_local_1);
                    updateUnreadForumsCount(0);
                };
            };
        }

        public function getThreadLastReadMessageIndex(_arg_1:int):int
        {
            var _local_3:ThreadData;
            var _local_2:* = _lastReadMessageIndexByThread[_arg_1];
            if (_local_2 != null)
            {
                return int(_local_2);
            };
            if (_SafeStr_2254)
            {
                _local_3 = _SafeStr_2254.threadsById[_arg_1];
                if (_local_3)
                {
                    return ((_local_3.nMessages - _local_3.nUnreadMessages) - 1);
                };
            };
            return (-1);
        }

        public function updateUnreadMessageCounts(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            if (_arg_1 > _SafeStr_2252)
            {
                _SafeStr_2252 = _arg_1;
                if (_SafeStr_2253)
                {
                    _SafeStr_2253.updateUnreadMessages(_SafeStr_2235, _arg_1);
                    if (_SafeStr_2253.listCode == 2)
                    {
                        updateUnreadForumsCount(_SafeStr_2253.unreadForumsCount);
                    };
                };
            };
            _lastReadMessageIndexByThread[_arg_2] = _arg_3;
        }

        public function getGoToMessageIndex():int
        {
            return (_SafeStr_2257);
        }

        public function getGoToThreadId():int
        {
            return (_SafeStr_2256);
        }

        public function resetGoTo():void
        {
            _SafeStr_2256 = -1;
            _SafeStr_2257 = -1;
        }

        public function updateUnreadForumsCount(_arg_1:int):void
        {
            if (_unreadForumsCount == _arg_1)
            {
                return;
            };
            if (_arg_1 > _unreadForumsCount)
            {
                if (_soundManager != null)
                {
                };
            };
            _unreadForumsCount = _arg_1;
            events.dispatchEvent(new UnseenForumsCountUpdatedEvent("UNSEEN_FORUMS_COUNT", _arg_1));
            if (_SafeStr_461 != null)
            {
                _SafeStr_461.updateUnreadForumsCount(_arg_1);
            };
        }

        private function onUnreadForumsCountUpdateTimerEvent(_arg_1:TimerEvent):void
        {
            if (_SafeStr_461 != null)
            {
                _communicationManager.connection.send(new GetForumsListMessageComposer(2, 0, 20));
            }
            else
            {
                _communicationManager.connection.send(new GetUnreadForumsCountMessageComposer());
            };
        }

        private function onUnreadForumsCountMessage(_arg_1:UnreadForumsCountMessageEvent):void
        {
            updateUnreadForumsCount(_arg_1.getParser().unreadForumsCount);
        }


    }
}