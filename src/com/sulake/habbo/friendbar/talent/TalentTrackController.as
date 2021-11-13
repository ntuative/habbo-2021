package com.sulake.habbo.friendbar.talent
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.window.utils.IModalDialog;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.communication.messages.parser.talent.TalentTrack;
    import com.sulake.core.window.components._SafeStr_124;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.parser.talent.TalentTrackMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.ChangeEmailResultEvent;
    import com.sulake.habbo.communication.messages.incoming.users.EmailStatusResultEvent;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsMessageEvent;
    import com.sulake.habbo.communication.messages.parser.talent.TalentTrackMessageParser;
    import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsData;
    import com.sulake.habbo.session.talent.TalentEnum;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.IAvatarImageWidget;
    import com.sulake.core.window.components.ITextWindow;
    import __AS3__.vec.Vector;
    import flash.geom.Point;
    import com.sulake.habbo.communication.messages.parser.talent.TalentTrackRewardPerk;
    import com.sulake.habbo.communication.messages.parser.talent.TalentTrackRewardProduct;
    import com.sulake.habbo.communication.messages.parser.talent.TalentTrackTask;
    import com.sulake.habbo.communication.messages.parser.talent.TalentTrackLevel;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.habbo.window.widgets.IBadgeImageWidget;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.utils._SafeStr_25;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.GetEmailStatusComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.talent._SafeStr_36;
    import com.sulake.habbo.communication.messages.outgoing.users.ChangeEmailComposer;
    import com.sulake.core.window.components.ITextFieldWindow;

    public class TalentTrackController implements IDisposable 
    {

        private static const MODAL_DIALOG_LAYER:int = 3;
        private static const HORIZONTAL_MARGIN:int = 100;
        private static const BEGIN_PANE_PREFIX:String = "begin_";
        private static const LEVEL_PANE_PREFIX:String = "level_pane_";
        private static const NO_CITIZENSHIP_SUFFIX:String = "_no_citizenship";
        private static const PROGRESS_BAR_MARGIN:int = 40;
        private static const DEFAULT_PADDING:int = 10;
        private static const REWARD_WIDTH:int = 200;
        private static const BADGE_RECT_SIZE:int = 60;

        private var _habboTalent:HabboTalent;
        private var _disposed:Boolean = false;
        private var _SafeStr_1665:IModalDialog;
        private var _window:IWindowContainer;
        private var _taskProgressPopup:IModalDialog;
        private var _SafeStr_2393:IItemListWindow;
        private var _talentTrack:TalentTrack;
        private var _talentProgressMeter:TalentProgressMeter;
        private var _SafeStr_2394:IWindowContainer;
        private var _SafeStr_2395:_SafeStr_124;
        private var _SafeStr_2396:_SafeStr_124;
        private var _SafeStr_2384:_SafeStr_124;
        private var _SafeStr_2385:_SafeStr_124;
        private var _SafeStr_2397:IWindowContainer;
        private var _SafeStr_2398:IWindowContainer;
        private var _SafeStr_2399:IWindowContainer;
        private var _overlayTemplate:IWindow;
        private var _SafeStr_2400:int = -1;

        public function TalentTrackController(_arg_1:HabboTalent)
        {
            _habboTalent = _arg_1;
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_talentProgressMeter)
                {
                    _talentProgressMeter.dispose();
                    _talentProgressMeter = null;
                };
                destroyWindow();
                _habboTalent = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get window():IWindowContainer
        {
            return (_window);
        }

        public function get talentTrack():TalentTrack
        {
            return (_talentTrack);
        }

        public function initialize():void
        {
            _habboTalent.communicationManager.addHabboConnectionMessageEvent(new TalentTrackMessageEvent(onTalentTrack));
            _habboTalent.communicationManager.addHabboConnectionMessageEvent(new ChangeEmailResultEvent(onChangeEmailResult));
            _habboTalent.communicationManager.addHabboConnectionMessageEvent(new EmailStatusResultEvent(onEmailStatus));
            _habboTalent.communicationManager.addHabboConnectionMessageEvent(new HabboGroupDetailsMessageEvent(onGroupDetails));
        }

        private function onEmailStatus(_arg_1:EmailStatusResultEvent):void
        {
            var _local_2:IWindowContainer = getEmailContainer();
            if (_local_2 != null)
            {
                getEmailText().text = _arg_1.getParser().email;
                _local_2.findChildByName("unverified_container").visible = (!(_arg_1.getParser().isVerified));
                _local_2.findChildByName("verified_txt").visible = _arg_1.getParser().isVerified;
            };
        }

        private function onChangeEmailResult(_arg_1:ChangeEmailResultEvent):void
        {
            setEmailErrorStatus(true, _arg_1.getParser().result);
        }

        private function onTalentTrack(_arg_1:TalentTrackMessageEvent):void
        {
            var _local_2:TalentTrackMessageParser = _arg_1.getParser();
            _talentTrack = _local_2.getTalentTrack();
            createWindow();
        }

        private function onGroupDetails(_arg_1:HabboGroupDetailsMessageEvent):void
        {
            var _local_2:HabboGroupDetailsData = _arg_1.data;
            if (_local_2.groupId == _SafeStr_2400)
            {
                _SafeStr_2400 = -1;
                _habboTalent.navigator.goToPrivateRoom(_local_2.roomId);
            };
        }

        private function createWindow():void
        {
            var _local_1:IWindowContainer;
            var _local_5:int;
            destroyWindow();
            _SafeStr_1665 = _habboTalent.getModalXmlWindow("talent_track");
            _window = IWindowContainer(_SafeStr_1665.rootWindow);
            _window.procedure = onWindowEvent;
            _SafeStr_1665.background.procedure = onModalWindowBackgroundEvent;
            _habboTalent.windowManager.getWindowContext(3).getDesktopWindow().addEventListener("WE_RESIZED", onDesktopResized);
            _SafeStr_2393 = IItemListWindow(_window.findChildByName("panorama"));
            _SafeStr_2394 = IWindowContainer(_SafeStr_2393.removeListItem(_SafeStr_2393.getListItemByName("level_pane")));
            var _local_2:IItemListWindow = IItemListWindow(_SafeStr_2394.findChildByName("reward_list"));
            _SafeStr_2395 = _SafeStr_124(_local_2.removeListItem(_local_2.getListItemByName("reward_achieved")));
            _SafeStr_2396 = _SafeStr_124(_local_2.removeListItem(_local_2.getListItemByName("reward_locked")));
            _SafeStr_2384 = _SafeStr_124(_local_2.removeListItem(_local_2.getListItemByName("reward_product")));
            _SafeStr_2385 = _SafeStr_124(_local_2.removeListItem(_local_2.getListItemByName("reward_vip")));
            var _local_4:IItemListWindow = IItemListWindow(_SafeStr_2394.findChildByName("task_list_top"));
            _SafeStr_2397 = IWindowContainer(_local_4.removeListItem(_local_4.getListItemByName("task_achieved")));
            _SafeStr_2398 = IWindowContainer(_local_4.removeListItem(_local_4.getListItemByName("task_ongoing")));
            _SafeStr_2399 = IWindowContainer(_local_4.removeListItem(_local_4.getListItemByName("task_locked")));
            _overlayTemplate = _SafeStr_2394.removeChild(_SafeStr_2394.findChildByName("action_overlay"));
            var _local_3:Boolean = _habboTalent.citizenshipEnabled;
            for each (var _local_7:String in TalentEnum.asArray)
            {
                _local_1 = (_SafeStr_2393.getListItemByName(("begin_" + _local_7)) as IWindowContainer);
                if (_local_1 != null)
                {
                    _local_1.visible = ((_local_7 == _talentTrack.name) && (_local_3));
                    if (_local_1.visible)
                    {
                        showAvatarInContainer(_local_1);
                    };
                };
                if (_local_7 != "citizenship")
                {
                    _local_1 = (_SafeStr_2393.getListItemByName((("begin_" + _local_7) + "_no_citizenship")) as IWindowContainer);
                    if (_local_1 != null)
                    {
                        _local_1.visible = ((_local_7 == _talentTrack.name) && (!(_local_3)));
                        if (_local_1.visible)
                        {
                            showAvatarInContainer(_local_1);
                        };
                    };
                };
            };
            _window.findChildByName("frame_title").caption = (("${talent.track." + _talentTrack.name) + ".frame.title}");
            _window.findChildByName("frame_subtitle").caption = (("${talent.track." + _talentTrack.name) + ".frame.subtitle}");
            _window.findChildByName("progress_text").caption = (("${talent.track." + _talentTrack.name) + ".progress.title}");
            if (((_local_3) && (!(_talentTrack.name == "citizenship"))))
            {
                _talentTrack.removeFirstLevel();
            };
            var _local_6:int;
            _local_5 = 0;
            while (_local_5 < _talentTrack.levels.length)
            {
                createLevelPane(_talentTrack.levels[_local_5], _local_5);
                if (_talentTrack.levels[_local_5].state == 1)
                {
                    _local_6 = _local_5;
                };
                _local_5++;
            };
            _talentProgressMeter = new TalentProgressMeter(_habboTalent, this);
            _SafeStr_2393.setListItemIndex(_SafeStr_2393.getListItemByName("end_padding"), (_SafeStr_2393.numListItems - 1));
            resizeWindow();
            scrollToLevel(_local_6);
        }

        private function showAvatarInContainer(_arg_1:IWindowContainer):void
        {
            var _local_2:IWidgetWindow = (_arg_1.findChildByName("avatar_image") as IWidgetWindow);
            if (_local_2 != null)
            {
                IAvatarImageWidget(_local_2.widget).figure = _habboTalent.sessionManager.figure;
            };
        }

        private function createLevelPane(_arg_1:TalentTrackLevel, _arg_2:int):void
        {
            var _local_16:_SafeStr_124;
            var _local_3:ITextWindow;
            var _local_4:ITextWindow;
            var _local_21:ITextWindow;
            var _local_6:ITextWindow;
            var _local_7:IItemListWindow;
            var _local_18:int;
            var _local_22:IWindow;
            var _local_17:Vector.<IWindow> = undefined;
            var _local_15:IWindow;
            var _local_5:Point;
            var _local_9:IWindowContainer = IWindowContainer(_SafeStr_2394.clone());
            var _local_14:IItemListWindow = IItemListWindow(_local_9.findChildByName("status_list"));
            var _local_19:IWindowContainer = IWindowContainer(_local_9.findChildByName("level_reward"));
            var _local_10:IWindowContainer = IWindowContainer(_local_9.findChildByName("level_task"));
            var _local_12:IItemListWindow = IItemListWindow(_local_9.findChildByName("task_list_top"));
            var _local_20:IItemListWindow = IItemListWindow(_local_9.findChildByName("task_list_bottom"));
            _local_9.name = ("level_pane_" + _arg_2);
            _local_9.findChildByName("level_title").caption = (((("${talent.track." + _talentTrack.name) + ".level.") + _arg_1.level) + ".title}");
            _local_9.findChildByName("level_description").caption = (((("${talent.track." + _talentTrack.name) + ".level.") + _arg_1.level) + ".description}");
            if (_arg_2 == 0)
            {
                _local_19.width = 0;
                _local_19.visible = false;
                _local_14.x = (4 * 10);
            }
            else
            {
                _local_16 = _SafeStr_124(_local_19.findChildByName("border"));
                _local_3 = ITextWindow(_local_19.findChildByName("title_locked"));
                _local_4 = ITextWindow(_local_19.findChildByName("title_achieved"));
                _local_21 = ITextWindow(_local_19.findChildByName("description_locked"));
                _local_6 = ITextWindow(_local_19.findChildByName("description_achieved"));
                _local_7 = IItemListWindow(_local_19.findChildByName("reward_list"));
                switch (_arg_1.state)
                {
                    case 1:
                    case 2:
                        _local_16.color = 4537147;
                        _local_3.visible = false;
                        _local_4.caption = ((_habboTalent.localizationManager.getLocalization("talent.track.common.unlocked.level.prefix") + " ") + _habboTalent.localizationManager.getLocalization((((("talent.track." + _talentTrack.name) + ".level.") + _arg_1.level) + ".title")));
                        _local_21.visible = false;
                        _local_6.caption = (((("${talent.track." + _talentTrack.name) + ".level.") + _arg_1.level) + ".unlock}");
                        _local_19.findChildByName("locked").visible = false;
                        break;
                    case 0:
                        _local_16.color = 0xBDBDBD;
                        _local_16.findChildByName("unlocked").visible = false;
                        _local_3.caption = (((("${talent.track." + _talentTrack.name) + ".level.") + _arg_1.level) + ".title}");
                        _local_4.visible = false;
                        _local_21.caption = (((("${talent.track." + _talentTrack.name) + ".level.") + _arg_1.level) + ".unlock}");
                        _local_6.visible = false;
                        _local_19.findChildByName("achieved").visible = false;
                    default:
                };
                if (_arg_1.rewardCount == 0)
                {
                    _local_18 = Math.max(200, Math.max(_local_4.width, _local_3.width));
                    _local_21.width = _local_18;
                    _local_6.width = _local_18;
                    _local_16.width = (_local_18 + (2 * 10));
                    _local_19.width = (_local_18 + (2 * 10));
                    _local_16.height = ((_local_6.y + Math.max(_local_6.height, _local_21.height)) + 10);
                    _local_19.height = (_local_16.height + _local_16.y);
                    _local_7.visible = false;
                }
                else
                {
                    if (((_arg_1.rewardCount == 1) && (_arg_1.rewardProducts.length > 0)))
                    {
                        _local_18 = Math.max((200 + (10 * 2)), Math.max(_local_4.width, _local_3.width));
                        _local_21.width = _local_18;
                        _local_6.width = _local_18;
                        _local_7.addListItem(createRewardProduct(_arg_1, _arg_1.rewardProducts[0]));
                        _local_16.width = (_local_18 + (2 * 10));
                        _local_19.width = (_local_18 + (2 * 10));
                    }
                    else
                    {
                        if (_arg_1.rewardCount == 1)
                        {
                            _local_16.width = 420;
                            _local_21.width = (200 * 2);
                            _local_6.width = (200 * 2);
                            _local_7.addListItem(((_arg_1.rewardPerks.length > 0) ? createRewardPerk(_arg_1, _arg_1.rewardPerks[0]) : createRewardProduct(_arg_1, _arg_1.rewardProducts[0])));
                            _local_7.arrangeListItems();
                            _local_19.width = (_local_7.width + (2 * 10));
                            _local_16.width = (_local_7.width + (2 * 10));
                        }
                        else
                        {
                            for each (var _local_11:TalentTrackRewardPerk in _arg_1.rewardPerks)
                            {
                                _local_7.addListItem(createRewardPerk(_arg_1, _local_11));
                            };
                            for each (var _local_8:TalentTrackRewardProduct in _arg_1.rewardProducts)
                            {
                                _local_7.addListItem(createRewardProduct(_arg_1, _local_8));
                            };
                            _local_7.arrangeListItems();
                            _local_19.width = (_local_7.width + (2 * 10));
                            _local_16.width = (_local_7.width + (2 * 10));
                            _local_6.width = (_local_16.width - (2 * 10));
                        };
                    };
                };
            };
            if (_arg_1.tasks.length == 0)
            {
                _local_10.width = 0;
                _local_10.visible = false;
            }
            else
            {
                _local_17 = new Vector.<IWindow>();
                for each (var _local_13:TalentTrackTask in _arg_1.tasks)
                {
                    _local_22 = createTask(_arg_1, _local_13);
                    if (_local_12.numListItems == _local_20.numListItems)
                    {
                        _local_12.addListItem(_local_22);
                    }
                    else
                    {
                        _local_20.addListItem(_local_22);
                    };
                    if (((_local_13.badgeCode == "ACH_SafetyQuizGraduate1") && (_local_13.state == 1)))
                    {
                        _local_17.push(_local_22);
                    };
                };
                _local_12.arrangeListItems();
                _local_20.arrangeListItems();
                _local_10.width = Math.max(_local_12.width, _local_20.width);
                for each (_local_22 in _local_17)
                {
                    _local_15 = _overlayTemplate.clone();
                    _local_5 = new Point();
                    _local_9.addChild(_local_15);
                    _local_22.convertPointFromLocalToGlobalSpace(_local_5);
                    _local_9.convertPointFromGlobalToLocalSpace(_local_5);
                    _local_15.x = (_local_15.x + _local_5.x);
                    _local_15.y = (_local_15.y + _local_5.y);
                    _local_15.visible = true;
                };
            };
            _local_14.arrangeListItems();
            _local_14.width = ((_local_19.width + 10) + _local_10.width);
            _local_9.width = ((_local_14.x + _local_14.width) + 10);
            repositionLevelIllustration(_arg_1, _local_9);
            _SafeStr_2393.addListItem(_local_9);
        }

        private function repositionLevelIllustration(_arg_1:TalentTrackLevel, _arg_2:IWindowContainer):void
        {
            var _local_3:IWindow = _arg_2.findChildByName("level_description");
            var _local_4:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_arg_2.findChildByName("level_illustration"));
            _local_4.assetUri = (((("${image.library.url}talent/" + _talentTrack.name) + "_") + _arg_1.level) + ".png");
            if (((_arg_1.level == 8) && (_talentTrack.name == "helper")))
            {
                _local_4.width = 220;
                _local_4.height = 270;
                _local_4.x = Math.max(_local_3.right, _arg_2.width);
            }
            else
            {
                if (((_arg_1.level == 0) && (_talentTrack.name == "citizenship")))
                {
                    _local_4.width = 0;
                    _local_4.x = Math.max(_local_3.right, _arg_2.width);
                }
                else
                {
                    if (((_arg_1.level == 4) && (_talentTrack.name == "citizenship")))
                    {
                        _local_4.width = 220;
                        _local_4.height = 280;
                        _local_4.x = Math.max(_local_3.right, _arg_2.width);
                    }
                    else
                    {
                        _local_4.x = Math.max(_local_3.right, (_arg_2.width - _local_4.width));
                    };
                };
            };
            _arg_2.width = Math.max(_arg_2.width, _local_4.right);
        }

        private function createRewardPerk(_arg_1:TalentTrackLevel, _arg_2:TalentTrackRewardPerk):IWindowContainer
        {
            var _local_3:IWindowContainer;
            switch (_arg_1.state)
            {
                case 1:
                case 2:
                    _local_3 = IWindowContainer(_SafeStr_2395.clone());
                    IBadgeImageWidget(IWidgetWindow(_local_3.findChildByName("achieved")).widget).badgeId = _arg_2.perkId;
                    break;
                case 0:
                    _local_3 = IWindowContainer(_SafeStr_2396.clone());
                default:
            };
            var _local_5:IWindow = IWindow(_local_3.findChildByName("title"));
            var _local_4:IWindow = ITextWindow(_local_3.findChildByName("description"));
            _local_5.caption = (("${perk." + _arg_2.perkId) + ".name}");
            _local_4.caption = (("${perk." + _arg_2.perkId) + ".description}");
            if (_arg_1.rewardCount == 1)
            {
                _local_3.width = (200 * 2);
                _local_3.findChildByName("title").width = ((200 * 2) - 60);
                _local_3.findChildByName("description").width = ((200 * 2) - 60);
            }
            else
            {
                if (_local_4.height > 30)
                {
                    _local_4.width = (_local_4.width + (4 * 10));
                };
                _local_4.width = Math.max(_local_4.width, _local_5.width);
                _local_3.width = ((Math.max(_local_4.width, _local_5.width) + 60) + 10);
            };
            return (_local_3);
        }

        private function createRewardProduct(_arg_1:TalentTrackLevel, _arg_2:TalentTrackRewardProduct):IWindowContainer
        {
            var _local_3:IWindowContainer;
            if (_arg_2.vipDays == 0)
            {
                _local_3 = IWindowContainer(_SafeStr_2384.clone());
                IStaticBitmapWrapperWindow(_local_3.findChildByName("product_icon")).assetUri = (("${image.library.url}talent/reward_product_" + _arg_2.productCode.toLowerCase().replace(" ", "_")) + ".png");
            }
            else
            {
                _local_3 = IWindowContainer(_SafeStr_2385.clone());
                _local_3.findChildByName("vip_length").caption = _habboTalent.localizationManager.getLocalizationWithParams("catalog.vip.item.header.days", "", "num_days", _arg_2.vipDays);
            };
            if (_arg_1.state == 0)
            {
                _local_3.color = 0x979797;
                _local_3.blend = 0.6;
            };
            return (_local_3);
        }

        private function createTask(_arg_1:TalentTrackLevel, _arg_2:TalentTrackTask):IWindowContainer
        {
            var _local_6:IWindowContainer;
            var _local_3:IRegionWindow;
            if (((_arg_2.badgeCode == null) || (_arg_2.badgeCode == "")))
            {
                return (null);
            };
            switch (_arg_2.state)
            {
                case 2:
                    _local_6 = IWindowContainer(_SafeStr_2397.clone());
                    IBadgeImageWidget(IWidgetWindow(_local_6.findChildByName("badge")).widget).badgeId = _arg_2.badgeCode;
                    break;
                case 1:
                    _local_6 = IWindowContainer(_SafeStr_2398.clone());
                    IBadgeImageWidget(IWidgetWindow(_local_6.findChildByName("badge")).widget).badgeId = _arg_2.badgeCode;
                    _local_6.findChildByName("task_progress_fg").width = _SafeStr_25.map(_arg_2.currentScore, 0, _arg_2.totalScore, 0, 48);
                    _local_3 = (_local_6.findChildByName("task_ongoing_region") as IRegionWindow);
                    _local_3.id = _arg_2.achievementId;
                    if (_arg_2.badgeCode == "ACH_SafetyQuizGraduate1")
                    {
                        _local_3.toolTipCaption = "";
                        _local_3.name = _arg_2.badgeCode;
                    };
                    break;
                case 0:
                    _local_6 = IWindowContainer(_SafeStr_2399.clone());
                default:
            };
            var _local_5:IWindow = _local_6.findChildByName("title");
            var _local_4:IWindow = _local_6.findChildByName("description");
            _local_5.caption = _habboTalent.localizationManager.getAchievementName(_arg_2.badgeCode).toUpperCase();
            _local_4.caption = _habboTalent.localizationManager.getAchievementInstruction(_arg_2.badgeCode);
            if (_local_5.height > 20)
            {
                _local_5.y = (_local_5.y - 5);
                _local_4.y = (_local_4.y + 5);
            }
            else
            {
                if (_local_4.height > 30)
                {
                    _local_5.y = (_local_5.y - 5);
                    _local_4.y = (_local_4.y - 5);
                };
            };
            return (_local_6);
        }

        private function destroyWindow():void
        {
            destroyTaskProgressDialog();
            if (_overlayTemplate != null)
            {
                _overlayTemplate.dispose();
                _overlayTemplate = null;
            };
            if (_SafeStr_2394)
            {
                _SafeStr_2394.dispose();
                _SafeStr_2394 = null;
            };
            if (_SafeStr_2395)
            {
                _SafeStr_2395.dispose();
                _SafeStr_2395 = null;
            };
            if (_SafeStr_2396)
            {
                _SafeStr_2396.dispose();
                _SafeStr_2396 = null;
            };
            if (_SafeStr_2384)
            {
                _SafeStr_2384.dispose();
                _SafeStr_2384 = null;
            };
            if (_SafeStr_2385)
            {
                _SafeStr_2385.dispose();
                _SafeStr_2385 = null;
            };
            if (_SafeStr_2397)
            {
                _SafeStr_2397.dispose();
                _SafeStr_2397 = null;
            };
            if (_SafeStr_2398)
            {
                _SafeStr_2398.dispose();
                _SafeStr_2398 = null;
            };
            if (_SafeStr_2399)
            {
                _SafeStr_2399.dispose();
                _SafeStr_2399 = null;
            };
            if (_SafeStr_1665)
            {
                _SafeStr_1665.dispose();
                _SafeStr_1665 = null;
                _window = null;
                _habboTalent.windowManager.getWindowContext(3).getDesktopWindow().removeEventListener("WE_RESIZED", onDesktopResized);
            };
        }

        private function resizeWindow():void
        {
            if (((_SafeStr_1665 == null) || (_SafeStr_1665.disposed)))
            {
                return;
            };
            _window.x = 100;
            _window.width = (_window.desktop.width - (2 * 100));
            _window.findChildByName("frame").width = _window.width;
            _window.findChildByName("panorama").width = _window.width;
            _window.findChildByName("panorama_scrollbar").width = _window.width;
            _talentProgressMeter.resize();
            _SafeStr_2393.arrangeListItems();
            _window.invalidate();
        }

        private function onDesktopResized(_arg_1:WindowEvent):void
        {
            resizeWindow();
        }

        private function onWindowEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:int;
            if ((((_window == null) || (_window.disposed)) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "header_button_close":
                    destroyWindow();
                    return;
                case "progress_container":
                    _local_3 = WindowMouseEvent(_arg_1).localX;
                    if (_local_3 < 40)
                    {
                        _SafeStr_2393.scrollH = 0;
                    }
                    else
                    {
                        if (_local_3 > (_talentProgressMeter.width - 40))
                        {
                            _SafeStr_2393.scrollH = 1;
                        }
                        else
                        {
                            scrollToLevel(int(Math.floor((_local_3 / _talentProgressMeter.progressPerLevelWidth))));
                        };
                    };
                    return;
                case "task_ongoing_region":
                    createTaskProgressDialog(_arg_2.id);
                    return;
                case "citizenship_button":
                    _habboTalent.tracking.trackTalentTrackOpen("citizenship", "talentrack");
                    _habboTalent.send(new GetTalentTrackMessageComposer("citizenship"));
                    return;
                case "button_track_citizenship":
                    return;
                case "button_track_helper":
                    return;
                case "ACH_SafetyQuizGraduate1":
                    closeAndLog(_arg_2.name);
                    _habboTalent.habboHelp.showSafetyBooklet();
                    return;
                default:
                    return;
            };
        }

        private function onModalWindowBackgroundEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if ((((_window == null) || (_window.disposed)) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            destroyWindow();
        }

        private function scrollToLevel(_arg_1:int):void
        {
            var _local_2:IWindow;
            if (_arg_1 == 0)
            {
                _SafeStr_2393.scrollH = 0;
            }
            else
            {
                _local_2 = _SafeStr_2393.getListItemByName(("level_pane_" + _arg_1));
                if (_local_2 != null)
                {
                    Logger.log(_SafeStr_2393.scrollH);
                    _SafeStr_2393.scrollH = _SafeStr_25.map((_local_2.x - 20), 0, (_SafeStr_2393.scrollableRegion.width - _SafeStr_2393.visibleRegion.width), 0, 1);
                    Logger.log(((((((_local_2.x + " ") + _SafeStr_2393.scrollableRegion.width) + " ") + _SafeStr_25.map(_local_2.x, 0, _SafeStr_2393.scrollableRegion.width, 0, 1)) + " ") + _SafeStr_2393.scrollH));
                };
            };
        }

        private function createTaskProgressDialog(_arg_1:int):void
        {
            var _local_7:String;
            var _local_5:String;
            var _local_4:Boolean;
            destroyTaskProgressDialog();
            var _local_3:TalentTrackTask = _talentTrack.findTaskByAchievementId(_arg_1);
            if ((((_local_3 == null) || (_local_3.badgeCode == null)) || (_local_3.badgeCode == "")))
            {
                return;
            };
            _habboTalent.tracking.trackEventLog("Talent", talentTrack.name, "talent.progress.show", _local_3.badgeCode);
            if (_local_3.badgeCode == "ACH_GuideAdvertisementReader1")
            {
                setupTourAdvertisement();
                return;
            };
            _taskProgressPopup = _habboTalent.getModalXmlWindow("task_progress_dialog");
            _taskProgressPopup.rootWindow.procedure = onTaskProgressWindowEvent;
            _taskProgressPopup.background.procedure = onTaskProgressBackgroundWindowEvent;
            var _local_2:IWindowContainer = IWindowContainer(_taskProgressPopup.rootWindow);
            _local_2.findChildByName("instruction").caption = _habboTalent.localizationManager.getAchievementInstruction(_local_3.badgeCode);
            _local_2.findChildByName("title").caption = _habboTalent.localizationManager.getAchievementName(_local_3.badgeCode);
            _local_2.findChildByName("progress_text").caption = ((((_habboTalent.localizationManager.getLocalization("talent.track.task.progress.dialog.progress") + " ") + _local_3.currentScore) + "/") + _local_3.totalScore);
            IBadgeImageWidget(IWidgetWindow(_local_2.findChildByName("badge")).widget).badgeId = _local_3.badgeCode;
            getEmailContainer().visible = false;
            if (_habboTalent.citizenshipEnabled)
            {
                _local_7 = _habboTalent.localizationManager.getLocalization((((("talent.track.task.action." + _talentTrack.name) + ".") + mapBadgeCode(_local_3.badgeCode)) + ".description"), "");
                _local_5 = _habboTalent.localizationManager.getLocalization((((("talent.track.task.action." + _talentTrack.name) + ".") + mapBadgeCode(_local_3.badgeCode)) + ".link"), "");
                _local_4 = ((!(_local_7 == "")) || (!(_local_5 == "")));
                _local_2.findChildByName("action_separator").visible = _local_4;
                _local_2.findChildByName("action_title").visible = _local_4;
                setText(_local_2, "action_description", _local_7);
                setText(_local_2, "action_link", _local_5);
                _local_2.findChildByName("action_link").name = _local_3.badgeCode;
                _local_2.findChildByName("progress_separator").visible = (!(_local_5 == ""));
                if (((_local_3.badgeCode == "ACH_EmailVerification1") && (emailChangeEnabled)))
                {
                    getEmailContainer().visible = true;
                    getEmailContainer().findChildByName("change_email_region").procedure = onChangeEmail;
                    getEmailText().procedure = onEmailTxt;
                    _habboTalent.send(new GetEmailStatusComposer());
                    setEmailErrorStatus(false);
                };
            }
            else
            {
                _local_2.findChildByName("action_separator").visible = false;
                _local_2.findChildByName("action_title").visible = false;
                _local_2.findChildByName("action_description").visible = false;
                _local_2.findChildByName("action_link").visible = false;
            };
            IItemListWindow(_local_2.findChildByName("top_list")).arrangeListItems();
            if (_local_3.currentScore <= 0)
            {
                _local_2.findChildByName("achieved_left").visible = false;
                _local_2.findChildByName("achieved_right").visible = false;
                _local_2.findChildByName("achieved_mid").visible = false;
            }
            else
            {
                if (_local_3.currentScore < _local_3.totalScore)
                {
                    _local_2.findChildByName("achieved_right").visible = false;
                    _local_2.findChildByName("achieved_mid").width = _SafeStr_25.map(_local_3.currentScore, 0, _local_3.totalScore, 0, _local_2.findChildByName("unachieved_mid").width);
                };
            };
            var _local_6:IItemListWindow = IItemListWindow(_local_2.findChildByName("list"));
            if (!_local_3.hasProgressDisplay())
            {
                _local_6.removeListItem(_local_6.getListItemByName("progress_main_container"));
            };
            _local_6.arrangeListItems();
        }

        private function getEmailContainer():IWindowContainer
        {
            if (((_taskProgressPopup == null) || (_taskProgressPopup.rootWindow == null)))
            {
                return (null);
            };
            var _local_1:IWindowContainer = IWindowContainer(_taskProgressPopup.rootWindow);
            return ((_local_1 == null) ? null : IWindowContainer(_local_1.findChildByName("email_container")));
        }

        private function mapBadgeCode(_arg_1:String):String
        {
            if (((_arg_1 == "ACH_RoomEntry1") || (_arg_1 == "ACH_RoomEntry2")))
            {
                return ("ACH_RoomEntry");
            };
            return (_arg_1);
        }

        private function setText(_arg_1:IWindowContainer, _arg_2:String, _arg_3:String):void
        {
            var _local_4:IWindow = _arg_1.findChildByName(_arg_2);
            _local_4.caption = _arg_3;
            _local_4.visible = (!(_arg_3 == ""));
        }

        private function destroyTaskProgressDialog():void
        {
            if (_taskProgressPopup != null)
            {
                _taskProgressPopup.dispose();
                _taskProgressPopup = null;
            };
        }

        private function onTaskProgressWindowEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:int;
            if ((((_taskProgressPopup == null) || (_taskProgressPopup.disposed)) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "header_button_close":
                case "thanks_button":
                    destroyTaskProgressDialog();
                    return;
                case "ACH_HabboWayGraduate1":
                    closeAndLog(_arg_2.name);
                    _habboTalent.habboHelp.showHabboWay();
                    return;
                case "ACH_GuideGroupMember1":
                    closeAndLog(_arg_2.name);
                    _local_3 = _habboTalent.getInteger("guide.help.alpha.groupid", 0);
                    if (_local_3 > 0)
                    {
                        _SafeStr_2400 = _local_3;
                        _habboTalent.send(new GetHabboGroupDetailsMessageComposer(_local_3, false));
                    };
                    return;
                case "ACH_SafetyQuizGraduate1":
                    closeAndLog(_arg_2.name);
                    _habboTalent.habboHelp.showSafetyBooklet();
                    return;
                case "ACH_RoomEntry1":
                case "ACH_RoomEntry2":
                    closeAndLog(_arg_2.name);
                    _habboTalent.navigator.openNavigator(null);
                    return;
                case "ACH_AvatarLooks1":
                    closeAndLog(_arg_2.name);
                    _habboTalent.avatarEditor.openEditor(0, null, null, true);
                    _habboTalent.avatarEditor.loadOwnAvatarInEditor(0);
                    return;
            };
        }

        private function closeAndLog(_arg_1:String):void
        {
            destroyWindow();
            _habboTalent.tracking.trackEventLog("Talent", _talentTrack.name, "talent.progress.click_activity", _arg_1);
        }

        private function setupTourAdvertisement():void
        {
            _taskProgressPopup = _habboTalent.getModalXmlWindow("tour_task_progress_dialog");
            var _local_1:IWindowContainer = IWindowContainer(_taskProgressPopup.rootWindow);
            _local_1.findChildByName("take_tour_button").procedure = onTakeTour;
            _local_1.findChildByName("decline_tour_region").procedure = onDeclineTour;
            _local_1.findChildByName("header_button_close").procedure = onCloseTourAd;
        }

        private function onTakeTour(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                destroyWindow();
                destroyTaskProgressDialog();
                _habboTalent.send(new _SafeStr_36());
                _habboTalent.habboHelp.requestGuide();
                _habboTalent.tracking.trackEventLog("Help", "", "tour.new_user.accept");
                _habboTalent.tracking.trackGoogle("newbieTourWindow", "click_acceptTour");
            };
        }

        private function onCloseTourAd(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                destroyTaskProgressDialog();
            };
        }

        private function onDeclineTour(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                destroyWindow();
                destroyTaskProgressDialog();
                _habboTalent.send(new _SafeStr_36());
                _habboTalent.tracking.trackEventLog("Help", "", "tour.new_user.cancel");
                _habboTalent.tracking.trackGoogle("newbieTourWindow", "click_refuseTour");
            };
        }

        private function onChangeEmail(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:String;
            if (_arg_1.type == "WME_CLICK")
            {
                _local_3 = getEmailText().text;
                _habboTalent.send(new ChangeEmailComposer(_local_3));
            };
        }

        private function onEmailTxt(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WE_FOCUSED")
            {
                setEmailErrorStatus(false);
            };
        }

        private function setEmailErrorStatus(_arg_1:Boolean, _arg_2:int=0):void
        {
            if (getEmailContainer() == null)
            {
                return;
            };
            var _local_3:Boolean = ((_arg_1) && (!(_arg_2 == 0)));
            var _local_4:IWindowContainer = getEmailContainer();
            var _local_5:IWindow = _local_4.findChildByName("error_txt");
            _local_5.visible = _local_3;
            _local_5.caption = (("${welcome.gift.email.error." + _arg_2) + "}");
            _local_4.findChildByName("error_border").visible = _local_3;
            _local_4.findChildByName("change_email_region").visible = (!(_arg_1));
            _local_4.findChildByName("changed_container").visible = ((_arg_1) && (_arg_2 == 0));
        }

        private function getEmailText():ITextFieldWindow
        {
            return (ITextFieldWindow(getEmailContainer().findChildByName("email_txt")));
        }

        private function onTaskProgressBackgroundWindowEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if ((((_taskProgressPopup == null) || (_taskProgressPopup.disposed)) || (!(_arg_1.type == "WME_CLICK"))))
            {
                return;
            };
            destroyTaskProgressDialog();
        }

        private function get emailChangeEnabled():Boolean
        {
            return (_habboTalent.getBoolean("talent.progress.emailchange.enabled"));
        }


    }
}

