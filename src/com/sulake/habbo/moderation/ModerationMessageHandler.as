package com.sulake.habbo.moderation
{
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.parser.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomVisitsEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.UserChatlogEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.CfhChatlogEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.IssueInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorActionResultMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorUserInfoEvent;
    import com.sulake.habbo.communication.messages.incoming.callforhelp.CfhSanctionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorToolPreferencesEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.IssuePickFailedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.parser.userclassification.UserClassificationMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorRoomInfoEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorInitMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.IssueDeletedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.callforhelp.CfhTopicsInitMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomChatlogEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueInfoMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorInitMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorInitData;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorToolPreferencesMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.IssuePickFailedMessageParser;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueDeletedMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorUserInfoMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorRoomInfoMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.CfhChatlogMessageParser;
    import flash.utils.Dictionary;
    import com.sulake.habbo.communication.messages.parser.moderation.RoomChatlogMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.UserChatlogMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.RoomVisitsMessageParser;
    import com.sulake.habbo.communication.messages.parser.userclassification.UserClassificationMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.userclassification.UserClassificationData;
    import com.sulake.habbo.communication.messages.parser.callforhelp.CfhSanctionMessageParser;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.callforhelp.CallForHelpCategoryData;
    import com.sulake.habbo.communication.messages.parser.callforhelp.CfhTopicsInitMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorActionResultMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetModeratorUserInfoMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.moderation.*;
    import com.sulake.habbo.communication.messages.parser.moderation.*;

    public class ModerationMessageHandler
    {

        private var _moderationManager:ModerationManager;
        private var _userInfoListeners:Array = [];
        private var _roomVisitsListeners:Array = [];
        private var _SafeStr_2870:Array = [];
        private var _chatlogListeners:Array = [];
        private var _roomInfoListeners:Array = [];
        private var _roomEnterListeners:Array = [];

        public function ModerationMessageHandler(_arg_1:ModerationManager)
        {
            _moderationManager = _arg_1;
            var _local_2:IConnection = _arg_1.connection;
            _local_2.addMessageEvent(new CloseConnectionMessageEvent(onRoomExit));
            _local_2.addMessageEvent(new RoomVisitsEvent(onRoomVisits));
            _local_2.addMessageEvent(new UserChatlogEvent(onUserChatlog));
            _local_2.addMessageEvent(new CfhChatlogEvent(onCfhChatlog));
            _local_2.addMessageEvent(new IssueInfoMessageEvent(onIssueInfo));
            _local_2.addMessageEvent(new ModeratorActionResultMessageEvent(onModeratorActionResult));
            _local_2.addMessageEvent(new ModeratorUserInfoEvent(onUserInfo));
            _local_2.addMessageEvent(new CfhSanctionMessageEvent(onSanctions));
            _local_2.addMessageEvent(new ModeratorToolPreferencesEvent(onModeratorToolPreferences));
            _local_2.addMessageEvent(new IssuePickFailedMessageEvent(onIssuePickFailed));
            _local_2.addMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
            _local_2.addMessageEvent(new UserClassificationMessageEvent(onRoomUserClassification));
            _local_2.addMessageEvent(new ModeratorRoomInfoEvent(onRoomInfo));
            _local_2.addMessageEvent(new ModeratorInitMessageEvent(onModeratorInit));
            _local_2.addMessageEvent(new IssueDeletedMessageEvent(onIssueDeleted));
            _local_2.addMessageEvent(new CfhTopicsInitMessageEvent(onCfhTopics));
            _local_2.addMessageEvent(new RoomChatlogEvent(onRoomChatlog));
        }

        private function onIssueInfo(_arg_1:IssueInfoMessageEvent):void
        {
            if (((_arg_1 == null) || (_moderationManager == null)))
            {
                return;
            };
            var _local_2:IssueInfoMessageParser = _arg_1.getParser();
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:IssueMessageData = _local_2.issueData;
            _moderationManager.issueManager.playSound(_local_3);
            _moderationManager.issueManager.updateIssue(_local_3);
        }

        private function onModeratorInit(_arg_1:ModeratorInitMessageEvent):void
        {
            var _local_4:IssueMessageData;
            if (((_arg_1 == null) || (_moderationManager == null)))
            {
                return;
            };
            var _local_3:ModeratorInitMessageParser = _arg_1.getParser();
            if (((_local_3 == null) || (_local_3.data == null)))
            {
                return;
            };
            var _local_2:ModeratorInitData = _local_3.data;
            var _local_6:Array = _local_2.issues;
            var _local_5:Array = _local_2.messageTemplates;
            for each (_local_4 in _local_6)
            {
                _moderationManager.issueManager.updateIssue(_local_4);
            };
            _moderationManager.issueManager.updateIssueBrowser();
            _moderationManager.initMsg = _local_2;
            _moderationManager.startPanel.show();
        }

        private function onModeratorToolPreferences(_arg_1:ModeratorToolPreferencesEvent):void
        {
            var _local_2:ModeratorToolPreferencesMessageParser;
            if (((_moderationManager) && (_moderationManager.issueManager)))
            {
                _local_2 = _arg_1.getParser();
                _moderationManager.issueManager.setToolPreferences(_local_2.windowX, _local_2.windowY, _local_2.windowHeight, _local_2.windowWidth);
            };
        }

        private function onIssuePickFailed(_arg_1:IssuePickFailedMessageEvent):void
        {
            var event:IssuePickFailedMessageEvent = _arg_1;
            var parser:IssuePickFailedMessageParser = event.getParser();
            if (parser == null)
            {
                return;
            };
            var alert:Boolean = true;
            var issues:Array = parser.issues;
            var retryEnabled:Boolean = parser.retryEnabled;
            var retryCount:int = parser.retryCount;
            var pickedAlready:Boolean = _moderationManager.issueManager.issuePickFailed(issues);
            if (pickedAlready)
            {
                if (retryEnabled)
                {
                    if (retryCount < 10)
                    {
                        alert = false;
                        _moderationManager.issueManager.autoPick("pick failed retry", retryEnabled, retryCount);
                    };
                };
            };
            if (alert)
            {
                _moderationManager.windowManager.alert("Error", "Issue picking failed", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                {
                    _arg_1.dispose();
                });
            };
        }

        private function onIssueDeleted(_arg_1:IssueDeletedMessageEvent):void
        {
            if (((_arg_1 == null) || (_moderationManager == null)))
            {
                return;
            };
            var _local_2:IssueDeletedMessageParser = _arg_1.getParser();
            if (_local_2 == null)
            {
                return;
            };
            _moderationManager.issueManager.removeIssue(_local_2.issueId);
        }

        private function onUserInfo(_arg_1:ModeratorUserInfoEvent):void
        {
            var _local_3:ModeratorUserInfoMessageParser = _arg_1.getParser();
            Logger.log(((("GOT USER INFO: " + _local_3.data.userId) + ", ") + _local_3.data.cautionCount));
            for each (var _local_2:IUserInfoListener in _userInfoListeners)
            {
                _local_2.onUserInfo(_local_3.data);
            };
        }

        private function onRoomInfo(_arg_1:ModeratorRoomInfoEvent):void
        {
            var _local_2:RoomToolCtrl;
            var _local_3:ModeratorRoomInfoMessageParser = _arg_1.getParser();
            for each (_local_2 in _roomInfoListeners)
            {
                _local_2.onRoomInfo(_local_3.data);
            };
        }

        private function onCfhChatlog(_arg_1:CfhChatlogEvent):void
        {
            var _local_3:CfhChatlogMessageParser = _arg_1.getParser();
            var _local_2:Array = [];
            _local_2.push(_local_3.data.chatRecord);
            var _local_4:Dictionary = new Dictionary();
            _local_4[_local_3.data.callerUserId] = 0;
            _local_4[_local_3.data.reportedUserId] = 1;
            onChatlog(("Call For Help Evidence #" + _local_3.data.chatRecordId), 3, _local_3.data.callId, _local_2, _local_4);
        }

        private function onRoomChatlog(_arg_1:RoomChatlogEvent):void
        {
            var _local_3:RoomChatlogMessageParser = _arg_1.getParser();
            var _local_2:Array = [];
            _local_2.push(_local_3.data);
            var _local_4:Dictionary = new Dictionary();
            onChatlog(("Room Chatlog: " + _local_3.data.roomName), 4, _local_3.data.roomId, _local_2, _local_4);
        }

        private function onUserChatlog(_arg_1:UserChatlogEvent):void
        {
            var _local_2:UserChatlogMessageParser = _arg_1.getParser();
            var _local_3:Dictionary = new Dictionary();
            _local_3[_local_2.data.userId] = 0;
            onChatlog(("User Chatlog: " + _local_2.data.userName), 5, _local_2.data.userId, _local_2.data.rooms, _local_3);
        }

        private function onChatlog(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:Array, _arg_5:Dictionary):void
        {
            var _local_6:Array = _chatlogListeners.concat();
            for each (var _local_7:IChatLogListener in _local_6)
            {
                _local_7.onChatlog(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            };
        }

        private function onRoomVisits(_arg_1:RoomVisitsEvent):void
        {
            var _local_2:RoomVisitsCtrl;
            var _local_4:RoomVisitsMessageParser = _arg_1.getParser();
            var _local_3:Array = _roomVisitsListeners.concat();
            for each (_local_2 in _local_3)
            {
                _local_2.onRoomVisits(_local_4.data);
            };
        }

        private function onRoomUserClassification(_arg_1:UserClassificationMessageEvent):void
        {
            var _local_9:UserClassificationCtrl;
            var _local_5:UserClassificationMessageParser = (_arg_1 as UserClassificationMessageEvent).getParser();
            var _local_10:Map = _local_5.classifiedUsernameMap;
            var _local_3:Map = _local_5.classifiedUserTypeMap;
            var _local_6:int = 1;
            var _local_7:Array = [];
            for each (var _local_8:int in _local_10.getKeys())
            {
                _local_7.push(new UserClassificationData(_local_8, _local_10[_local_8], _local_3[_local_8]));
            };
            var _local_2:UserClassificationCtrl = new UserClassificationCtrl(_moderationManager, _local_6);
            _local_2.show();
            var _local_4:Array = _SafeStr_2870.concat();
            for each (_local_9 in _local_4)
            {
                _local_9.onUserClassification(_local_6, _local_7);
            };
        }

        private function onSanctions(_arg_1:CfhSanctionMessageEvent):void
        {
            var _local_2:CfhSanctionMessageParser = _arg_1.getParser();
            Logger.log(("Got sanction data..." + [_local_2.issueId, _local_2.accountId, _local_2.sanctionType]));
            _moderationManager.issueManager.updateSanctionData(_local_2.issueId, _local_2.accountId, _local_2.sanctionType);
        }

        private function onCfhTopics(_arg_1:CfhTopicsInitMessageEvent):void
        {
            var _local_2:Vector.<CallForHelpCategoryData> = undefined;
            var _local_3:CfhTopicsInitMessageParser = _arg_1.getParser();
            _local_2 = _local_3.callForHelpCategories;
            _moderationManager.cfhTopics = _local_2;
        }

        private function onRoomEnter(_arg_1:RoomEntryInfoMessageEvent):void
        {
            var _local_2:RoomToolCtrl;
            var _local_3:RoomEntryInfoMessageParser = _arg_1.getParser();
            this._moderationManager.currentFlatId = _local_3.guestRoomId;
            this._moderationManager.startPanel.guestRoomEntered(_local_3);
            for each (_local_2 in _roomEnterListeners)
            {
                _local_2.onRoomChange();
            };
        }

        private function onRoomExit(_arg_1:CloseConnectionMessageEvent):void
        {
            var _local_2:RoomToolCtrl;
            this._moderationManager.currentFlatId = 0;
            this._moderationManager.startPanel.roomExited();
            for each (_local_2 in _roomEnterListeners)
            {
                _local_2.onRoomChange();
            };
        }

        private function onModeratorActionResult(_arg_1:ModeratorActionResultMessageEvent):void
        {
            var _local_2:ModeratorActionResultMessageParser = _arg_1.getParser();
            Logger.log(((("GOT MOD ACTION RESULT: " + _local_2.userId) + ", ") + _local_2.success));
            if (_local_2.success)
            {
                _moderationManager.connection.send(new GetModeratorUserInfoMessageComposer(_local_2.userId));
            }
            else
            {
                _moderationManager.windowManager.alert("Alert", "Moderation action failed. If you tried to ban a user, please check if the user is already banned.", 0, onAlertClose);
            };
        }

        public function addUserInfoListener(_arg_1:IUserInfoListener):void
        {
            _userInfoListeners.push(_arg_1);
        }

        public function removeUserInfoListener(_arg_1:IUserInfoListener):void
        {
            var _local_3:Array = [];
            for each (var _local_2:IUserInfoListener in _userInfoListeners)
            {
                if (_local_2 != _arg_1)
                {
                    _local_3.push(_local_2);
                };
            };
            _userInfoListeners = _local_3;
        }

        public function addRoomInfoListener(_arg_1:RoomToolCtrl):void
        {
            _roomInfoListeners.push(_arg_1);
        }

        public function removeRoomInfoListener(_arg_1:RoomToolCtrl):void
        {
            var _local_2:RoomToolCtrl;
            var _local_3:Array = [];
            for each (_local_2 in _roomInfoListeners)
            {
                if (_local_2 != _arg_1)
                {
                    _local_3.push(_local_2);
                };
            };
            _roomInfoListeners = _local_3;
        }

        public function addRoomEnterListener(_arg_1:RoomToolCtrl):void
        {
            _roomEnterListeners.push(_arg_1);
        }

        public function removeRoomEnterListener(_arg_1:RoomToolCtrl):void
        {
            var _local_2:RoomToolCtrl;
            var _local_3:Array = [];
            for each (_local_2 in _roomEnterListeners)
            {
                if (_local_2 != _arg_1)
                {
                    _local_3.push(_local_2);
                };
            };
            _roomEnterListeners = _local_3;
        }

        public function addRoomVisitsListener(_arg_1:RoomVisitsCtrl):void
        {
            _roomVisitsListeners.push(_arg_1);
        }

        public function removeRoomVisitsListener(_arg_1:RoomVisitsCtrl):void
        {
            var _local_2:RoomVisitsCtrl;
            var _local_3:Array = [];
            for each (_local_2 in _roomVisitsListeners)
            {
                if (_local_2 != _arg_1)
                {
                    _local_3.push(_local_2);
                };
            };
            _roomVisitsListeners = _local_3;
        }

        public function addChatlogListener(_arg_1:IChatLogListener):void
        {
            _chatlogListeners.push(_arg_1);
        }

        public function removeChatlogListener(_arg_1:IChatLogListener):void
        {
            var _local_3:Array = [];
            for each (var _local_2:IChatLogListener in _chatlogListeners)
            {
                if (_local_2 != _arg_1)
                {
                    _local_3.push(_local_2);
                };
            };
            _chatlogListeners = _local_3;
        }

        public function addUserClassificationListener(_arg_1:UserClassificationCtrl):void
        {
            _SafeStr_2870.push(_arg_1);
        }

        public function removeUserClassificationListener(_arg_1:UserClassificationCtrl):void
        {
            var _local_2:UserClassificationCtrl;
            var _local_3:Array = [];
            for each (_local_2 in _SafeStr_2870)
            {
                if (_local_2 != _arg_1)
                {
                    _local_3.push(_local_2);
                };
            };
            _roomVisitsListeners = _local_3;
        }

        private function onAlertClose(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }


    }
}