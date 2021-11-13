package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.incoming.callforhelp.CallForHelpCategoryData;
    import com.sulake.habbo.communication.messages.incoming.callforhelp.CallForHelpTopicData;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.communication.messages.outgoing.moderator.DefaultSanctionMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModAlertMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModMuteMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModBanMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModKickMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModTradingLockMessageComposer;
    import com.sulake.habbo.utils.StringUtil;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModMessageMessageComposer;
    import com.sulake.habbo.window.utils.IAlertDialog;

    public class ModActionCtrl implements IDisposable, ITrackedWindow 
    {

        private static var _SafeStr_2865:Array;
        private static var _SafeStr_2867:Map;

        private var _main:ModerationManager;
        private var _SafeStr_2866:int;
        private var _targetUserName:String;
        private var _SafeStr_2823:IssueMessageData;
        private var _frame:IFrameWindow;
        private var _topicDropdown:IDropMenuWindow;
        private var _SafeStr_2839:Array;
        private var _actionTypeDropdown:IDropMenuWindow;
        private var _SafeStr_2868:ITextFieldWindow;
        private var _disposed:Boolean;
        private var _SafeStr_2869:UserInfoCtrl;

        public function ModActionCtrl(_arg_1:ModerationManager, _arg_2:int, _arg_3:String, _arg_4:IssueMessageData, _arg_5:UserInfoCtrl)
        {
            _main = _arg_1;
            _SafeStr_2866 = _arg_2;
            _targetUserName = _arg_3;
            _SafeStr_2823 = _arg_4;
            _SafeStr_2869 = _arg_5;
            if (_SafeStr_2865 == null)
            {
                _SafeStr_2865 = [];
                _SafeStr_2865.push(new ModActionDefinition(1, "Alert", 1, 1, 0));
                _SafeStr_2865.push(new ModActionDefinition(2, "Mute 1h", 2, 2, 0));
                _SafeStr_2865.push(new ModActionDefinition(3, "Ban 18h", 3, 3, 0));
                _SafeStr_2865.push(new ModActionDefinition(4, "Ban 7 days", 3, 4, 0));
                _SafeStr_2865.push(new ModActionDefinition(5, "Ban 30 days (step 1)", 3, 5, 0));
                _SafeStr_2865.push(new ModActionDefinition(7, "Ban 30 days (step 2)", 3, 7, 0));
                _SafeStr_2865.push(new ModActionDefinition(6, "Ban 100 years", 3, 6, 0));
                _SafeStr_2865.push(new ModActionDefinition(106, "Ban avatar-only 100 years", 3, 6, 0));
                _SafeStr_2865.push(new ModActionDefinition(101, "Kick", 4, 0, 0));
                _SafeStr_2865.push(new ModActionDefinition(102, "Lock trade 1 week", 5, 0, 168));
                _SafeStr_2865.push(new ModActionDefinition(104, "Lock trade permanent", 5, 0, 876000));
                _SafeStr_2865.push(new ModActionDefinition(105, "Message", 6, 0, 0));
            };
            _main.issueManager.addModActionView(_SafeStr_2866, this);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function show():void
        {
            _frame = IFrameWindow(_main.getXmlWindow("modact_summary"));
            _frame.caption = ("Mod action on: " + _targetUserName);
            _frame.findChildByName("custom_sanction_button").procedure = onCustomSanctionButton;
            _SafeStr_2868 = ITextFieldWindow(_frame.findChildByName("message_input"));
            _frame.findChildByName("default_sanction_button").procedure = onDefaultSanctionButton;
            _frame.findChildByName("default_sanction_button").disable();
            initializeTopicToSanctionTypeMapping();
            initializeTopicDropdown();
            initializeActionTypeDropdown();
            var _local_1:IWindow = _frame.findChildByTag("close");
            _local_1.procedure = onClose;
            _frame.visible = true;
        }

        public function getType():int
        {
            return (7);
        }

        public function getId():String
        {
            return (_targetUserName);
        }

        public function getFrame():IFrameWindow
        {
            return (_frame);
        }

        private function logEvent(_arg_1:String, _arg_2:String=""):void
        {
            if (_SafeStr_2869 != null)
            {
                _SafeStr_2869.logEvent(_arg_1, _arg_2);
            };
        }

        private function trackAction(_arg_1:String):void
        {
            if (((!(_SafeStr_2869 == null)) && (!(_SafeStr_2869.disposed))))
            {
                _SafeStr_2869.trackAction(("modAction_" + _arg_1));
            };
        }

        private function initializeTopicToSanctionTypeMapping():void
        {
            var _local_2:String;
            var _local_6:Array;
            var _local_3:int;
            var _local_4:Array;
            var _local_1:int;
            var _local_5:int;
            if (_SafeStr_2867 == null)
            {
                _SafeStr_2867 = new Map();
                _local_2 = _main.getProperty("cfh.topic_id.to.sanction_type_id");
                if (_local_2 != null)
                {
                    _local_6 = _local_2.split(",");
                    _local_3 = 0;
                    while (_local_3 < _local_6.length)
                    {
                        _local_4 = _local_6[_local_3].split("=");
                        if (_local_4.length == 2)
                        {
                            _local_1 = parseInt(_local_4[0]);
                            _local_5 = parseInt(_local_4[1]);
                            _SafeStr_2867.add(_local_1, _local_5);
                        };
                        _local_3++;
                    };
                };
            };
        }

        private function initializeTopicDropdown():void
        {
            _topicDropdown = IDropMenuWindow(_frame.findChildByName("cfh_topics"));
            _topicDropdown.addEventListener("WE_SELECTED", refreshSanctionDataForSelectedTopic);
            _SafeStr_2839 = [];
            var _local_1:Array = [];
            var _local_2:int;
            for each (var _local_4:CallForHelpCategoryData in _main.issueManager.getCfhTopics())
            {
                for each (var _local_3:CallForHelpTopicData in _local_4.topics)
                {
                    _local_1[_local_2] = (("${help.cfh.topic." + _local_3.id) + "}");
                    _SafeStr_2839[_local_2] = _local_3.id;
                    _local_2++;
                };
            };
            _topicDropdown.populate(_local_1);
        }

        private function refreshSanctionDataForSelectedTopic(_arg_1:WindowEvent):void
        {
            var _local_4:int;
            var _local_5:int = _topicDropdown.selection;
            var _local_2:int = _SafeStr_2839[_local_5];
            var _local_3:int = _SafeStr_2867.getValue(_local_2);
            if (!_local_3)
            {
                _local_3 = _SafeStr_2867.getValue(0);
            };
            if (_local_3)
            {
                _local_4 = 0;
                while (_local_4 < _SafeStr_2865.length)
                {
                    if (_SafeStr_2865[_local_4].actionId == _local_3)
                    {
                        _actionTypeDropdown.selection = _local_4;
                        break;
                    };
                    _local_4++;
                };
            }
            else
            {
                _actionTypeDropdown.selection = -1;
            };
            _main.issueManager.requestSanctionDataForAccount(_SafeStr_2866, _local_2);
        }

        public function showDefaultSanction(_arg_1:int, _arg_2:String):void
        {
            if (((_frame == null) || (!(_arg_1 == _SafeStr_2866))))
            {
                return;
            };
            var _local_3:ITextWindow = (_frame.findChildByName("default_sanction_label") as ITextWindow);
            if (_local_3 != null)
            {
                _local_3.caption = _arg_2;
            };
            _frame.findChildByName("default_sanction_button").enable();
        }

        private function initializeActionTypeDropdown():void
        {
            _actionTypeDropdown = IDropMenuWindow(_frame.findChildByName("sanction_type"));
            var _local_1:Array = [];
            for each (var _local_2:ModActionDefinition in _SafeStr_2865)
            {
                _local_1.push(_local_2.name);
            };
            _actionTypeDropdown.populate(_local_1);
        }

        private function onDefaultSanctionButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            if (_topicDropdown.selection < 0)
            {
                _main.windowManager.alert("Alert", "Please select a topic.", 0, onAlertClose);
                return;
            };
            Logger.log("Giving default sanction...");
            trackAction("defaultAction");
            logEvent("action.default");
            var _local_3:int = _SafeStr_2839[_topicDropdown.selection];
            _main.connection.send(new DefaultSanctionMessageComposer(_SafeStr_2866, _local_3, _SafeStr_2868.text, getIssueId()));
            dispose();
        }

        private function onCustomSanctionButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_6:Boolean;
            var _local_3:int;
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            if (_topicDropdown.selection < 0)
            {
                _main.windowManager.alert("Alert", "Please select a topic.", 0, onAlertClose);
                return;
            };
            if (_actionTypeDropdown.selection < 0)
            {
                _main.windowManager.alert("Alert", "Please select a sanction.", 0, onAlertClose);
                return;
            };
            var _local_4:int = _SafeStr_2839[_topicDropdown.selection];
            var _local_5:ModActionDefinition = _SafeStr_2865[_actionTypeDropdown.selection];
            switch (_local_5.actionType)
            {
                case 1:
                    if (!_main.initMsg.alertPermission)
                    {
                        _main.windowManager.alert("Alert", "You have insufficient permissions.", 0, onAlertClose);
                        return;
                    };
                    trackAction("sendCaution");
                    _main.connection.send(new ModAlertMessageComposer(_SafeStr_2866, _SafeStr_2868.text, _local_4, getIssueId()));
                    break;
                case 2:
                    trackAction("mute");
                    _main.connection.send(new ModMuteMessageComposer(_SafeStr_2866, _SafeStr_2868.text, _local_4, getIssueId()));
                    break;
                case 3:
                    if (!_main.initMsg.banPermission)
                    {
                        _main.windowManager.alert("Alert", "You have insufficient permissions.", 0, onAlertClose);
                        return;
                    };
                    trackAction("ban");
                    _local_6 = (_local_5.actionId == 106);
                    _main.connection.send(new ModBanMessageComposer(_SafeStr_2866, _SafeStr_2868.text, _local_4, _local_5.sanctionTypeId, _local_6, getIssueId()));
                    break;
                case 4:
                    if (!_main.initMsg.kickPermission)
                    {
                        _main.windowManager.alert("Alert", "You have insufficient permissions.", 0, onAlertClose);
                        return;
                    };
                    trackAction("kick");
                    _main.connection.send(new ModKickMessageComposer(_SafeStr_2866, _SafeStr_2868.text, _local_4, getIssueId()));
                    break;
                case 5:
                    trackAction("trading_lock");
                    _local_3 = (_local_5.actionLengthHours * 60);
                    _main.connection.send(new ModTradingLockMessageComposer(_SafeStr_2866, _SafeStr_2868.text, _local_3, _local_4, getIssueId()));
                    break;
                case 6:
                    if (StringUtil.isEmpty(_SafeStr_2868.text))
                    {
                        _main.windowManager.alert("Alert", "Please write a message to user.", 0, onAlertClose);
                        return;
                    };
                    trackAction("sendCaution");
                    _main.connection.send(new ModMessageMessageComposer(_SafeStr_2866, _SafeStr_2868.text, _local_4, getIssueId()));
                default:
            };
            logEvent("action.custom", "unknown");
            dispose();
        }

        private function onClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            trackAction("close");
            dispose();
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _disposed = true;
            if (_frame != null)
            {
                _frame.destroy();
                _frame = null;
            };
            _topicDropdown = null;
            _SafeStr_2868 = null;
            _main.issueManager.removeModActionView(_SafeStr_2866);
            _main = null;
        }

        private function onAlertClose(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }

        private function getIssueId():int
        {
            return ((_SafeStr_2823 != null) ? _SafeStr_2823.issueId : -1);
        }


    }
}

