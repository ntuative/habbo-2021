package com.sulake.habbo.moderation
{
    import com.sulake.core.utils.Map;
    import flash.utils.Timer;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.callforhelp.CallForHelpCategoryData;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ReleaseIssuesMessageComposer;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModToolSanctionComposer;
    import com.sulake.habbo.utils.StringUtil;
    import com.sulake.habbo.communication.messages.incoming.callforhelp.CfhSanctionTypeData;
    import com.sulake.habbo.communication.messages.outgoing.moderator.CloseIssuesMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.PickIssuesMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.CloseIssueDefaultActionMessageComposer;

    public class IssueManager 
    {

        public static const _SafeStr_2852:String = "issue_bundle_open";
        public static const BUNDLE_MY:String = "issue_bundle_my";
        public static const _SafeStr_2853:String = "issue_bundle_picked";
        public static const PRIORITY_UPDATE_INTERVAL_MS:int = 15000;
        public static const RESOLUTION_USELESS:int = 1;
        public static const RESOLUTION_RESOLVED:int = 3;

        private var _moderationManager:ModerationManager;
        private var _SafeStr_2849:IssueBrowser;
        private var _SafeStr_2831:Map;
        private var _SafeStr_2854:Map;
        private var _SafeStr_2855:Map;
        private var _SafeStr_2856:Array;
        private var _SafeStr_2857:Array;
        private var _issueHandlers:Map;
        private var _SafeStr_2858:Map;
        private var _SafeStr_2859:int = 1;
        private var _SafeStr_2860:int;
        private var _SafeStr_2851:Timer;
        private var _issueListLimit:int;
        private var _SafeStr_2861:int;
        private var _SafeStr_2862:int;
        private var _windowWidth:int;
        private var _SafeStr_2863:int;
        private var _SafeStr_2864:Vector.<CallForHelpCategoryData>;

        public function IssueManager(_arg_1:ModerationManager)
        {
            _moderationManager = _arg_1;
            _SafeStr_2831 = new Map();
            _SafeStr_2854 = new Map();
            _SafeStr_2855 = new Map();
            _SafeStr_2849 = new IssueBrowser(this, _moderationManager.windowManager, _moderationManager.assets);
            _SafeStr_2856 = [];
            _SafeStr_2857 = [];
            _issueHandlers = new Map();
            _SafeStr_2858 = new Map();
            _SafeStr_2860 = _moderationManager.getInteger("chf.score.updatefactor", 60);
            _issueListLimit = _moderationManager.getInteger("max.call_for_help.results", 200);
            _SafeStr_2851 = new Timer(15000, 0);
            _SafeStr_2851.addEventListener("timer", updateIssueBrowser);
            _SafeStr_2851.start();
        }

        public function get issueListLimit():int
        {
            return (_issueListLimit);
        }

        public function init():void
        {
            _SafeStr_2849.show();
        }

        public function pickBundle(_arg_1:int, _arg_2:String, _arg_3:Boolean=false, _arg_4:int=0):void
        {
            var _local_5:IssueBundle = (_SafeStr_2854.getValue(_arg_1) as IssueBundle);
            if (_local_5 == null)
            {
                return;
            };
            sendPick(_local_5.getIssueIds(), _arg_3, _arg_4, _arg_2);
            _SafeStr_2856 = _SafeStr_2856.concat(_local_5.getIssueIds());
        }

        public function autoPick(_arg_1:String, _arg_2:Boolean=false, _arg_3:int=0):void
        {
            var _local_4:IssueBundle = null;
            var _local_6:IssueBundle;
            var _local_5:Array = _SafeStr_2854.getValues();
            for each (_local_6 in _local_5)
            {
                if (((_local_6.state == 1) && ((_local_4 == null) || (isBundleHigherPriorityOrOlder(_local_6, _local_4)))))
                {
                    _local_4 = _local_6;
                };
            };
            if (_local_4 == null)
            {
                return;
            };
            pickBundle(_local_4.id, _arg_1, _arg_2, _arg_3);
        }

        private function isBundleHigherPriorityOrOlder(_arg_1:IssueBundle, _arg_2:IssueBundle):Boolean
        {
            if (_arg_1.highestPriority < _arg_2.highestPriority)
            {
                return (true);
            };
            return ((_arg_1.highestPriority == _arg_2.highestPriority) && (_arg_1.issueAgeInMilliseconds < _arg_2.issueAgeInMilliseconds));
        }

        public function releaseAll():void
        {
            var _local_3:IssueBundle;
            if (_SafeStr_2854 == null)
            {
                return;
            };
            var _local_1:int = _moderationManager.sessionDataManager.userId;
            var _local_2:Array = [];
            for each (_local_3 in _SafeStr_2854)
            {
                if (((_local_3.state == 2) && (_local_3.pickerUserId == _local_1)))
                {
                    _local_2 = _local_2.concat(_local_3.getIssueIds());
                };
            };
            sendRelease(_local_2);
        }

        public function releaseBundle(_arg_1:int):void
        {
            if (_SafeStr_2854 == null)
            {
                return;
            };
            var _local_2:IssueBundle = (_SafeStr_2854.getValue(_arg_1) as IssueBundle);
            if (_local_2 == null)
            {
                return;
            };
            sendRelease(_local_2.getIssueIds());
        }

        private function sendRelease(_arg_1:Array):void
        {
            if (((((_arg_1 == null) || (_arg_1.length == 0)) || (_moderationManager == null)) || (_moderationManager.connection == null)))
            {
                return;
            };
            _moderationManager.connection.send(new ReleaseIssuesMessageComposer(_arg_1));
            _SafeStr_2857 = _SafeStr_2857.concat(_arg_1);
        }

        public function playSound(_arg_1:IssueMessageData):void
        {
            if (_SafeStr_2831[_arg_1.issueId] != null)
            {
                return;
            };
            if (((_SafeStr_2849 == null) || (!(_SafeStr_2849.isOpen()))))
            {
                _moderationManager.soundManager.playSound("HBST_call_for_help");
            };
        }

        public function updateIssue(_arg_1:IssueMessageData):void
        {
            var _local_9:IssueBundle;
            var _local_3:IssueBundle;
            var _local_2:int;
            var _local_4:Array;
            var _local_5:Boolean;
            var _local_7:IssueBundle;
            var _local_8:int;
            if (_arg_1 == null)
            {
                return;
            };
            _SafeStr_2831.remove(_arg_1.issueId);
            _SafeStr_2831.add(_arg_1.issueId, _arg_1);
            var _local_6:int = _SafeStr_2855.getValue(_arg_1.issueId);
            if (_local_6 != 0)
            {
                _local_9 = (_SafeStr_2854.getValue(_local_6) as IssueBundle);
                if (_local_9 != null)
                {
                    if (_local_9.matches(_arg_1))
                    {
                        _local_9.updateIssue(_arg_1);
                    }
                    else
                    {
                        _local_9.removeIssue(_arg_1.issueId);
                        if (_local_9.getIssueCount() == 0)
                        {
                            _SafeStr_2854.remove(_local_9.id);
                            removeHandler(_local_9.id);
                        };
                        _SafeStr_2855.remove(_arg_1.issueId);
                        _local_9 = null;
                    };
                };
            };
            if (_arg_1.state == 3)
            {
                _SafeStr_2831.remove(_arg_1.issueId);
                return;
            };
            if (_local_9 == null)
            {
                for each (_local_3 in _SafeStr_2854)
                {
                    if (_local_3.matches(_arg_1))
                    {
                        _local_9 = _local_3;
                        _local_9.updateIssue(_arg_1);
                        _SafeStr_2855.add(_arg_1.issueId, _local_9.id);
                        break;
                    };
                };
            };
            if (_local_9 == null)
            {
                _local_6 = _SafeStr_2859++;
                _local_9 = new IssueBundle(_local_6, _arg_1);
                _SafeStr_2855.add(_arg_1.issueId, _local_6);
                _SafeStr_2854.add(_local_6, _local_9);
            };
            if (_local_9 == null)
            {
                return;
            };
            if (_SafeStr_2856.indexOf(_arg_1.issueId) != -1)
            {
                handleBundle(_local_9.id);
                _local_2 = _moderationManager.sessionDataManager.userId;
                if (_local_2 != _arg_1.pickerUserId)
                {
                    if (_arg_1.state == 2)
                    {
                        unhandleBundle(_local_9.id);
                    };
                };
            };
            if (_arg_1.state == 1)
            {
                _local_4 = getBundles("issue_bundle_my");
                _local_5 = false;
                for each (_local_7 in _local_4)
                {
                    if (_local_7.matches(_arg_1, true))
                    {
                        _local_5 = true;
                        break;
                    };
                };
                _local_8 = _SafeStr_2857.indexOf(_arg_1.issueId);
                if (((_local_8 == -1) && (_local_5)))
                {
                    sendPick([_arg_1.issueId], false, 0, ("matches bundle with issue: " + _local_7.getHighestPriorityIssue().issueId));
                }
                else
                {
                    _SafeStr_2857.splice(_local_8, 1);
                };
            };
            updateHandler(_local_9.id);
            _SafeStr_2849.update();
        }

        public function updateIssueBrowser(_arg_1:Event=null):void
        {
            if (_moderationManager == null)
            {
                return;
            };
            if (_SafeStr_2849 != null)
            {
                _SafeStr_2849.update();
            };
        }

        private function updateHandler(_arg_1:int):void
        {
            var _local_2:IIssueHandler = _issueHandlers.getValue(_arg_1);
            if (_local_2 != null)
            {
                _local_2.updateIssuesAndMessages();
            };
        }

        public function removeHandler(_arg_1:int):void
        {
            var _local_2:IIssueHandler = _issueHandlers.remove(_arg_1);
            if (_local_2 != null)
            {
                _local_2.dispose();
                _local_2 = null;
            };
        }

        public function addModActionView(_arg_1:int, _arg_2:ModActionCtrl):void
        {
            _SafeStr_2858.add(_arg_1, _arg_2);
        }

        public function removeModActionView(_arg_1:int):void
        {
            _SafeStr_2858.remove(_arg_1);
        }

        public function removeIssue(_arg_1:int):void
        {
            var _local_3:IssueBundle;
            if (_SafeStr_2831 == null)
            {
                return;
            };
            var _local_2:int = _SafeStr_2855.getValue(_arg_1);
            if (_local_2 != 0)
            {
                _local_3 = (_SafeStr_2854.getValue(_local_2) as IssueBundle);
                if (_local_3 != null)
                {
                    _local_3.removeIssue(_arg_1);
                    if (_local_3.getIssueCount() == 0)
                    {
                        _SafeStr_2854.remove(_local_3.id);
                    };
                };
            };
            _SafeStr_2831.remove(_arg_1);
            _SafeStr_2849.update();
        }

        public function getBundles(_arg_1:String):Array
        {
            var _local_4:IssueBundle;
            if (_SafeStr_2854 == null)
            {
                return ([]);
            };
            var _local_3:Array = [];
            var _local_2:int = _moderationManager.sessionDataManager.userId;
            for each (_local_4 in _SafeStr_2854)
            {
                switch (_arg_1)
                {
                    case "issue_bundle_open":
                        if (_local_4.state == 1)
                        {
                            _local_3.push(_local_4);
                        };
                        break;
                    case "issue_bundle_my":
                        if (((_local_4.state == 2) && (_local_4.pickerUserId == _local_2)))
                        {
                            _local_3.push(_local_4);
                        };
                        break;
                    case "issue_bundle_picked":
                        if (((_local_4.state == 2) && (!(_local_4.pickerUserId == _local_2))))
                        {
                            _local_3.push(_local_4);
                        };
                };
            };
            return (_local_3);
        }

        public function handleBundle(_arg_1:int):void
        {
            var _local_5:IssueBundle = (_SafeStr_2854.getValue(_arg_1) as IssueBundle);
            if (_local_5 == null)
            {
                return;
            };
            var _local_4:IIssueHandler = new IssueHandler(_moderationManager, _local_5, _SafeStr_2864, _SafeStr_2861, _SafeStr_2862, _windowWidth, _SafeStr_2863);
            _moderationManager.windowTracker.show((_local_4 as ITrackedWindow), null, false, false, false, true, _SafeStr_2861, _SafeStr_2862, _windowWidth, _SafeStr_2863);
            removeHandler(_arg_1);
            _issueHandlers.add(_arg_1, _local_4);
            var _local_2:Array = [];
            for each (var _local_3:int in _SafeStr_2856)
            {
                if (!_local_5.contains(_local_3))
                {
                    _local_2 = _local_2.concat(_local_3);
                };
            };
            _SafeStr_2856 = _local_2;
        }

        public function unhandleBundle(_arg_1:int):void
        {
            var _local_3:IssueBundle = (_SafeStr_2854.getValue(_arg_1) as IssueBundle);
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:ITrackedWindow = _issueHandlers.remove(_arg_1);
            if (_local_2 != null)
            {
                _local_2.dispose();
            };
        }

        public function closeBundle(_arg_1:int, _arg_2:int):void
        {
            var _local_3:IssueBundle = (_SafeStr_2854.getValue(_arg_1) as IssueBundle);
            if (_local_3 == null)
            {
                return;
            };
            sendClose(_local_3.getIssueIds(), _arg_2);
        }

        public function closeDefaultAction(_arg_1:int, _arg_2:int):void
        {
            var _local_6:IssueBundle = (_SafeStr_2854.getValue(_arg_1) as IssueBundle);
            if (_local_6 == null)
            {
                return;
            };
            var _local_5:int = _local_6.getHighestPriorityIssue().issueId;
            var _local_4:Array = [];
            for each (var _local_3:int in _local_6.getIssueIds())
            {
                if (_local_3 != _local_5)
                {
                    _local_4.push(_local_3);
                };
            };
            sendCloseDefaultAction(_local_5, _local_4, _arg_2);
        }

        public function requestSanctionData(_arg_1:int, _arg_2:int):void
        {
            var _local_3:IssueBundle = (_SafeStr_2854.getValue(_arg_1) as IssueBundle);
            if (_local_3 == null)
            {
                return;
            };
            if (_local_3.getHighestPriorityIssue() != null)
            {
                _moderationManager.connection.send(new ModToolSanctionComposer(_local_3.getHighestPriorityIssue().issueId, -1, _arg_2));
            };
        }

        public function requestSanctionDataForAccount(_arg_1:int, _arg_2:int):void
        {
            _moderationManager.connection.send(new ModToolSanctionComposer(-1, _arg_1, _arg_2));
        }

        public function updateSanctionData(_arg_1:int, _arg_2:int, _arg_3:CfhSanctionTypeData):void
        {
            var _local_4:IIssueHandler;
            var _local_5:ModActionCtrl;
            var _local_6:String = (_arg_3.name + ((_arg_3.avatarOnly) ? " (avatar) " : " "));
            if (_arg_3.sanctionLengthInHours > 24)
            {
                _local_6 = (_local_6 + ((_arg_3.sanctionLengthInHours / 24) + " days"));
            }
            else
            {
                _local_6 = (_local_6 + (_arg_3.sanctionLengthInHours + "h"));
            };
            if (!StringUtil.isEmpty(_arg_3.tradeLockInfo))
            {
                _local_6 = (_local_6 + (" & " + _arg_3.tradeLockInfo));
            };
            if (!StringUtil.isEmpty(_arg_3.machineBanInfo))
            {
                _local_6 = (_local_6 + (" & " + _arg_3.machineBanInfo));
            };
            if (_arg_1 > 0)
            {
                for each (var _local_7:IssueBundle in _SafeStr_2854)
                {
                    if (_local_7.contains(_arg_1))
                    {
                        _local_4 = _issueHandlers.getValue(_local_7.id);
                        if (_local_4 != null)
                        {
                            _local_4.showDefaultSanction(_arg_2, _local_6);
                        };
                    };
                };
            }
            else
            {
                _local_5 = _SafeStr_2858.getValue(_arg_2);
                if (_local_5 != null)
                {
                    _local_5.showDefaultSanction(_arg_2, _local_6);
                };
            };
        }

        private function sendClose(_arg_1:Array, _arg_2:int):void
        {
            if ((((_arg_1 == null) || (_moderationManager == null)) || (_moderationManager.connection == null)))
            {
                return;
            };
            _moderationManager.connection.send(new CloseIssuesMessageComposer(_arg_1, _arg_2));
        }

        private function sendPick(_arg_1:Array, _arg_2:Boolean, _arg_3:int, _arg_4:String):void
        {
            if ((((_arg_1 == null) || (_moderationManager == null)) || (_moderationManager.connection == null)))
            {
                return;
            };
            _moderationManager.connection.send(new PickIssuesMessageComposer(_arg_1, _arg_2, _arg_3, _arg_4));
        }

        private function sendCloseDefaultAction(_arg_1:int, _arg_2:Array, _arg_3:int):void
        {
            _moderationManager.connection.send(new CloseIssueDefaultActionMessageComposer(_arg_1, _arg_2, _arg_3));
        }

        public function autoHandle(_arg_1:int):void
        {
            var _local_3:IssueBundle = null;
            var _local_5:IssueBundle;
            var _local_4:Array = _SafeStr_2854.getValues();
            var _local_2:int = _moderationManager.sessionDataManager.userId;
            for each (_local_5 in _local_4)
            {
                if (((((_local_5.state == 2) && (_local_5.pickerUserId == _local_2)) && (!(_local_5.id == _arg_1))) && ((_local_3 == null) || (_local_5.highestPriority < _local_3.highestPriority))))
                {
                    _local_3 = _local_5;
                };
            };
            if (_local_3 == null)
            {
                autoPick("issue manager pick next");
                return;
            };
            handleBundle(_local_3.id);
        }

        public function issuePickFailed(_arg_1:Array):Boolean
        {
            var _local_6:IssueMessageData;
            var _local_4:int;
            var _local_10:String;
            var _local_2:int;
            var _local_13:IssueBundle;
            var _local_5:IssueBundle;
            var _local_11:Array;
            var _local_12:int;
            var _local_8:int;
            var _local_3:IIssueHandler;
            if (!_arg_1)
            {
                return (false);
            };
            var _local_7:Boolean;
            var _local_9:int = _moderationManager.sessionDataManager.userId;
            for each (_local_6 in _arg_1)
            {
                _local_4 = _local_6.issueId;
                _local_10 = _local_6.pickerUserName;
                _local_2 = _local_6.pickerUserId;
                if (((!(_local_2 == -1)) && (!(_local_2 == _local_9))))
                {
                    _local_7 = true;
                };
                _local_13 = null;
                for each (_local_5 in _SafeStr_2854)
                {
                    _local_11 = _local_5.getIssueIds();
                    if (_local_11 != null)
                    {
                        for each (_local_12 in _local_11)
                        {
                            if (_local_4 == _local_12)
                            {
                                _local_13 = _local_5;
                                break;
                            };
                        };
                    };
                };
                if (_local_13 != null)
                {
                    _local_8 = _local_13.id;
                    _local_3 = _issueHandlers.getValue(_local_8);
                    if (_local_3 != null)
                    {
                        _local_3.dispose();
                    };
                    releaseBundle(_local_8);
                };
            };
            return (_local_7);
        }

        public function setToolPreferences(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            _SafeStr_2861 = _arg_1;
            _SafeStr_2862 = _arg_2;
            _SafeStr_2863 = _arg_3;
            _windowWidth = _arg_4;
        }

        public function setCfhTopics(_arg_1:Vector.<CallForHelpCategoryData>):void
        {
            this._SafeStr_2864 = _arg_1;
        }

        public function getCfhTopics():Vector.<CallForHelpCategoryData>
        {
            return (_SafeStr_2864);
        }


    }
}

