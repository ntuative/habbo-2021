package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
    import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorUserInfoData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetModeratorUserInfoMessageComposer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetUserChatlogMessageComposer;
    import com.sulake.core.window.events.WindowEvent;

    public class UserInfoCtrl implements IDisposable, IUserInfoListener 
    {

        private static const secsInMinute:int = 60;
        private static const secsInHour:int = 3600;
        private static const secsInDay:int = 86400;
        private static const secsInYear:int = 31536000;

        private var _callerFrame:IFrameWindow;
        private var _main:ModerationManager;
        private var _SafeStr_1887:int;
        private var _SafeStr_2823:IssueMessageData;
        private var _SafeStr_690:ModeratorUserInfoData;
        private var _SafeStr_2882:IWindowContainer;
        private var _openToolsBelow:Boolean;
        private var _disposed:Boolean;
        private var _SafeStr_2883:IssueHandler;

        public function UserInfoCtrl(_arg_1:IFrameWindow, _arg_2:ModerationManager, _arg_3:IssueMessageData, _arg_4:IssueHandler=null, _arg_5:Boolean=false)
        {
            _callerFrame = _arg_1;
            _main = _arg_2;
            _SafeStr_2823 = _arg_3;
            _openToolsBelow = _arg_5;
            _SafeStr_2883 = _arg_4;
        }

        public static function formatTime(_arg_1:int):String
        {
            if (_arg_1 < (2 * 60))
            {
                return (_arg_1 + " secs ago");
            };
            if (_arg_1 < (2 * 3600))
            {
                return (Math.round((_arg_1 / 60)) + " mins ago");
            };
            if (_arg_1 < (2 * 86400))
            {
                return (Math.round((_arg_1 / 3600)) + " hours ago");
            };
            if (_arg_1 < (2 * 31536000))
            {
                return (Math.round((_arg_1 / 86400)) + " days ago");
            };
            return (Math.round((_arg_1 / 31536000)) + " years ago");
        }


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function load(_arg_1:IWindowContainer, _arg_2:int):void
        {
            _SafeStr_2882 = _arg_1;
            _SafeStr_1887 = _arg_2;
            _SafeStr_690 = null;
            refresh();
            _main.messageHandler.addUserInfoListener(this);
            _main.connection.send(new GetModeratorUserInfoMessageComposer(_arg_2));
        }

        public function onUserInfo(_arg_1:ModeratorUserInfoData):void
        {
            if (_arg_1.userId != _SafeStr_1887)
            {
                return;
            };
            _SafeStr_690 = _arg_1;
            refresh();
        }

        public function refresh():void
        {
            if (_SafeStr_2882.disposed)
            {
                return;
            };
            var _local_1:IWindowContainer = prepare();
            if (_SafeStr_690 == null)
            {
                _local_1.findChildByName("fields").visible = false;
                _local_1.findChildByName("loading_txt").visible = true;
                return;
            };
            _local_1.findChildByName("fields").visible = true;
            _local_1.findChildByName("loading_txt").visible = false;
            setTxt(_local_1, "name_txt", _SafeStr_690.userName);
            setTxt(_local_1, "registered_txt", formatTime((_SafeStr_690.registrationAgeInMinutes * 60)));
            setTxt(_local_1, "cfh_count_txt", ("" + _SafeStr_690.cfhCount));
            setAlertTxt(_local_1, "abusive_cfh_count_txt", _SafeStr_690.abusiveCfhCount);
            setAlertTxt(_local_1, "caution_count_txt", _SafeStr_690.cautionCount);
            setAlertTxt(_local_1, "ban_count_txt", _SafeStr_690.banCount);
            setAlertTxt(_local_1, "trading_lock_count_txt", _SafeStr_690.tradingLockCount);
            setTxt(_local_1, "trading_lock_expiry_txt", _SafeStr_690.tradingExpiryDate, "No active lock");
            setTxt(_local_1, "last_login_txt", formatTime((_SafeStr_690.minutesSinceLastLogin * 60)));
            setTxt(_local_1, "online_txt", ((_SafeStr_690.online) ? "Yes" : "No"));
            setTxt(_local_1, "last_purchase_txt", _SafeStr_690.lastPurchaseDate, "No purchases");
            setTxt(_local_1, "email_address_txt", _SafeStr_690.primaryEmailAddress, "No email found");
            setTxt(_local_1, "id_bans_txt", ("" + _SafeStr_690.identityRelatedBanCount));
            setTxt(_local_1, "user_class_txt", _SafeStr_690.userClassification, "-");
            setTxt(_local_1, "last_sanction_time_txt", _SafeStr_690.lastSanctionTime);
            if (_SafeStr_690.sanctionAgeHours <= 48)
            {
                (_local_1.findChildByName("last_sanction_time_txt") as ITextWindow).textColor = (((0xFF * (48 - _SafeStr_690.sanctionAgeHours)) / 48) << 16);
            };
            if (_SafeStr_690.primaryEmailAddress == "No identity")
            {
                _local_1.findChildByName("modaction_but").disable();
            };
            Logger.log(((((("USER: " + _SafeStr_690.userName) + ", ") + _SafeStr_690.banCount) + ", ") + _SafeStr_690.cautionCount));
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _disposed = true;
            _main.messageHandler.removeUserInfoListener(this);
            _callerFrame = null;
            _main = null;
            _SafeStr_690 = null;
            _SafeStr_2882 = null;
        }

        private function prepare():IWindowContainer
        {
            var _local_1:IWindowContainer = IWindowContainer(_SafeStr_2882.findChildByName("user_info"));
            if (_local_1 == null)
            {
                _local_1 = IWindowContainer(_main.getXmlWindow("user_info"));
                _SafeStr_2882.addChild(_local_1);
                ((_main.initMsg.chatlogsPermission) ? null : _local_1.findChildByName("chatlog_but").disable());
                ((_main.initMsg.alertPermission) ? null : _local_1.findChildByName("message_but").disable());
                ((((_main.initMsg.alertPermission) || (_main.initMsg.kickPermission)) || (_main.initMsg.banPermission)) ? null : _local_1.findChildByName("modaction_but").disable());
            };
            _local_1.findChildByName("chatlog_but").procedure = onChatlogButton;
            _local_1.findChildByName("roomvisits_but").procedure = onRoomVisitsButton;
            _local_1.findChildByName("habboinfotool_but").procedure = onHabboInfoToolButton;
            _local_1.findChildByName("message_but").procedure = onMessageButton;
            _local_1.findChildByName("modaction_but").procedure = onModActionButton;
            _local_1.findChildByName("view_caution_count_txt").procedure = onViewCautions;
            _local_1.findChildByName("view_ban_count_txt").procedure = onViewBans;
            _local_1.findChildByName("view_trading_lock_count_txt").procedure = onViewTradingLocks;
            _local_1.findChildByName("view_id_bans_txt").procedure = onViewIDBans;
            return (_local_1);
        }

        private function setAlertTxt(_arg_1:IWindowContainer, _arg_2:String, _arg_3:int):void
        {
            var _local_5:IWindow = _arg_1.findChildByName(_arg_2);
            var _local_4:IWindow = _arg_1.findChildByName(("view_" + _arg_2));
            if (_local_4 != null)
            {
                _local_4.visible = (_arg_3 > 0);
            };
            _local_5.caption = ("" + _arg_3);
        }

        private function setTxt(_arg_1:IWindowContainer, _arg_2:String, _arg_3:String, _arg_4:String=""):void
        {
            var _local_5:IWindow = ITextWindow(_arg_1.findChildByName(_arg_2));
            if (((!(_arg_3)) || (_arg_3.length == 0)))
            {
                _local_5.caption = _arg_4;
            }
            else
            {
                _local_5.caption = _arg_3;
            };
        }

        private function onChatlogButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            trackAction("chatLog");
            _main.windowTracker.show(new ChatlogCtrl(new GetUserChatlogMessageComposer(_SafeStr_690.userId), _main, 5, _SafeStr_690.userId), _callerFrame, _openToolsBelow, false, true);
        }

        private function onRoomVisitsButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            _main.windowTracker.show(new RoomVisitsCtrl(_main, _SafeStr_690.userId), _callerFrame, _openToolsBelow, false, true);
        }

        private function onHabboInfoToolButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            trackAction("openInfoTool");
            _main.openHkPage("habboinfotool.url", _SafeStr_690.userName);
        }

        private function onMessageButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            trackAction("openSendMessage");
            _main.windowTracker.show(new SendMsgsCtrl(_main, _SafeStr_690.userId, _SafeStr_690.userName, _SafeStr_2823), _callerFrame, _openToolsBelow, false, true);
        }

        private function onModActionButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            trackAction("openModAction");
            _main.windowTracker.show(new ModActionCtrl(_main, _SafeStr_690.userId, _SafeStr_690.userName, _SafeStr_2823, this), _callerFrame, _openToolsBelow, false, true);
        }

        private function onViewCautions(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            trackAction("viewCautions");
            showModeratorLog();
        }

        private function onViewBans(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            trackAction("viewBans");
            showModeratorLog();
        }

        private function onViewTradingLocks(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            trackAction("viewTradingLocks");
            showModeratorLog();
        }

        private function onViewIDBans(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            trackAction("viewIdentityInfo");
            showIdentityInformation();
        }

        private function showModeratorLog():void
        {
            _main.openHkPage("moderatoractionlog.url", _SafeStr_690.userName);
        }

        private function showIdentityInformation():void
        {
            _main.openHkPage("identityinformationtool.url", ("" + _SafeStr_690.identityId));
        }

        internal function logEvent(_arg_1:String, _arg_2:String):void
        {
            if (_main != null)
            {
                _main.logEvent(_arg_1, _arg_2);
            };
        }

        internal function trackAction(_arg_1:String):void
        {
            if (((_SafeStr_2883 == null) || (_SafeStr_2883.disposed)))
            {
                _main.trackGoogle(("userInfo_" + _arg_1));
            }
            else
            {
                if (this == _SafeStr_2883.callerUserInfo)
                {
                    _SafeStr_2883.trackAction(("callerUserInfo_" + _arg_1));
                }
                else
                {
                    if (this == _SafeStr_2883.reportedUserInfo)
                    {
                        _SafeStr_2883.trackAction(("reportedUserInfo_" + _arg_1));
                    }
                    else
                    {
                        _SafeStr_2883.trackAction(("userInfo_" + _arg_1));
                    };
                };
            };
        }


    }
}

