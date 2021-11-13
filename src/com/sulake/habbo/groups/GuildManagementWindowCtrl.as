package com.sulake.habbo.groups
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.groups.badge.BadgeEditorCtrl;
    import com.sulake.habbo.communication.messages.incoming.users.IGuildData;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.incoming.users.RoomEntryData;
    import com.sulake.core.window.IWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.communication.messages.incoming.users.GuildColorData;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.communication.messages.incoming.users.GuildCreationData;
    import com.sulake.core.window.components.ITabContextWindow;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.habbo.communication.messages.incoming.users.GuildEditData;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.habbo.communication.messages.outgoing.users.UpdateGuildIdentityMessageComposer;
    import com.sulake.habbo.groups.events.GuildSettingsChangedInManageEvent;
    import com.sulake.habbo.communication.messages.outgoing.users.UpdateGuildBadgeMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.UpdateGuildColorsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.UpdateGuildSettingsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.CreateGuildMessageComposer;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.IBadgeImageWidget;

    public class GuildManagementWindowCtrl implements IDisposable 
    {

        private static const VIEW_IDENTITY:int = 1;
        private static const VIEW_BADGE:int = 2;
        private static const VIEW_COLORS:int = 3;
        private static const VIEW_CONFIRM:int = 4;
        private static const VIEW_SETTINGS:int = 5;
        private static const _SafeStr_2638:int = 43;
        private static const _SafeStr_2639:int = 69;
        private static const EDIT_HEADER_TEXTS_OFFSET:int = -20;
        private static const CREATE_HEADER_BITMAP_OFFSET:int = 36;
        private static const STEP_TITLE_Y_OFFSET_ACTIVE:int = 5;
        private static const STEP_TITLE_Y_OFFSET_INACTIVE:int = 9;
        private static const STEP_TITLE_CREDIT_Y_OFFSET_ACTIVE:int = 6;
        private static const STEP_TITLE_CREDIT_Y_OFFSET_INACTIVE:int = 10;
        private static const MAX_DESCRIPTION_LENGTH:int = 0xFF;
        private static const MAX_NAME_LENGTH:int = 30;

        private var _SafeStr_825:HabboGroupsManager;
        private var _window:IWindowContainer;
        private var _SafeStr_2640:BadgeEditorCtrl;
        private var _SafeStr_2641:ColorGridCtrl;
        private var _SafeStr_2642:ColorGridCtrl;
        private var _SafeStr_2643:GuildSettingsCtrl;
        private var _SafeStr_2644:Boolean = false;
        private var _SafeStr_2645:int = 0;
        private var _data:IGuildData;
        private var _SafeStr_2646:int = 1;

        public function GuildManagementWindowCtrl(_arg_1:HabboGroupsManager)
        {
            _SafeStr_825 = _arg_1;
            _SafeStr_2640 = new BadgeEditorCtrl(_SafeStr_825);
            _SafeStr_2641 = new ColorGridCtrl(_SafeStr_825, onPrimaryColorSelected);
            _SafeStr_2642 = new ColorGridCtrl(_SafeStr_825, onSecondaryColorSelected);
            _SafeStr_2643 = new GuildSettingsCtrl();
        }

        public function dispose():void
        {
            _SafeStr_825 = null;
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            if (_SafeStr_2640)
            {
                _SafeStr_2640.dispose();
                _SafeStr_2640 = null;
            };
            if (_SafeStr_2641)
            {
                _SafeStr_2641.dispose();
                _SafeStr_2641 = null;
            };
            if (_SafeStr_2642)
            {
                _SafeStr_2642.dispose();
                _SafeStr_2642 = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_825 == null);
        }

        private function prepare():void
        {
            if (_window != null)
            {
                return;
            };
            _window = IFrameWindow(_SafeStr_825.getXmlWindow("group_management_window"));
            _window.findChildByTag("close").procedure = onCloseWindow;
            _window.center();
            _window.findChildByName("create_room_link_region").procedure = onCreateRoomLink;
            _window.findChildByName("cancel_link_region").procedure = onCancelLink;
            _window.findChildByName("next_step_button").procedure = onNextStep;
            _window.findChildByName("previous_step_link_region").procedure = onPreviousStep;
            _window.findChildByName("buy_button").procedure = onBuy;
            _window.findChildByName("vip_required_region").procedure = onGetVip;
            _window.addEventListener("WE_DEACTIVATED", onWindowUnActivated);
            _window.findChildByName("edit_tab_1").procedure = onTab;
            _window.findChildByName("edit_tab_2").procedure = onTab;
            _window.findChildByName("edit_tab_3").procedure = onTab;
            _window.findChildByName("edit_tab_5").procedure = onTab;
            _window.findChildByName("reset_badge").procedure = onBadgeReset;
            _window.findChildByName("reset_colors").procedure = onColorReset;
            _window.findChildByName("step_1_members_region").procedure = onMembersClick;
            _SafeStr_2643.prepare(_window);
        }

        public function onFlatCreated(_arg_1:int, _arg_2:String):void
        {
            if (((((!(_window == null)) && (_window.visible)) && (!(_data == null))) && (!(_data.exists))))
            {
                _data.ownedRooms.splice(0, 0, new RoomEntryData(_arg_1, _arg_2, false));
                prepareRoomSelection();
                this.getBaseDropMenu().selection = 0;
            };
        }

        public function onSubscriptionChange():void
        {
            if ((((((!(_window == null)) && (_window.visible)) && (!(_data == null))) && (!(_data.exists))) && (_SafeStr_2646 == 4)))
            {
                refresh();
            };
        }

        public function refresh():void
        {
            var _local_2:int;
            var _local_1:IWindow;
            prepare();
            var _local_3:Boolean = ((!(_data.exists)) || (_data.isOwner));
            _window.findChildByName("edit_tab_1").visible = _local_3;
            _window.findChildByName("edit_tab_2").visible = _local_3;
            _window.findChildByName("edit_tab_3").visible = _local_3;
            _window.findChildByName("edit_tab_5").visible = _local_3;
            _local_2 = 1;
            while (_local_2 <= 5)
            {
                getStepContainer(_local_2).visible = (_SafeStr_2646 == _local_2);
                _local_1 = _window.findChildByName(("header_pic_bitmap_step_" + _local_2));
                _local_1.y = ((_data.exists) ? 0 : 36);
                _local_1.visible = (_SafeStr_2646 == _local_2);
                _local_2++;
            };
            _window.findChildByName("header_caption_txt").caption = getStepCaption();
            _window.findChildByName("header_desc_txt").caption = getStepDesc();
            _window.findChildByName("header_pic_bitmap");
            _window.findChildByName("header_caption_txt").y = (43 + getHeaderTextOffset());
            _window.findChildByName("header_desc_txt").y = (69 + getHeaderTextOffset());
            _window.findChildByName("edit_guild_tab_context").visible = _data.exists;
            _window.findChildByName("footer_cont").visible = (!(_data.exists));
            _window.findChildByName("reset_badge").visible = false;
            _window.findChildByName("reset_colors").visible = false;
            if (_SafeStr_2646 == 2)
            {
                if (!_data.exists)
                {
                    _SafeStr_825.trackGoogle("groupPurchase", "step2_badge");
                };
                if (!_SafeStr_2640.isIntialized)
                {
                    _SafeStr_2640.createWindow(getStepContainer(2), _data.badgeSettings);
                    _SafeStr_2640.resetLayerOptions(_data.badgeSettings);
                };
                _window.findChildByName("reset_badge").visible = _data.exists;
            };
            if (_SafeStr_2646 == 3)
            {
                if (!_data.exists)
                {
                    _SafeStr_825.trackGoogle("groupPurchase", "step3_colors");
                };
                if (!_SafeStr_2641.isInitialized)
                {
                    _SafeStr_2641.createAndAttach(getStepContainer(3), "guild_primary_color_selector", _SafeStr_825.guildEditorData.guildPrimaryColors);
                    if (_data.exists)
                    {
                        _SafeStr_2641.setSelectedColorById(_data.primaryColorId);
                    }
                    else
                    {
                        _SafeStr_2641.setSelectedColorById(_SafeStr_825.guildEditorData.findMatchingPrimaryColorId(_SafeStr_2640.primaryColorIndex));
                    };
                };
                if (!_SafeStr_2642.isInitialized)
                {
                    _SafeStr_2642.createAndAttach(getStepContainer(3), "guild_secondary_color_selector", _SafeStr_825.guildEditorData.guildSecondaryColors);
                    if (_data.exists)
                    {
                        _SafeStr_2642.setSelectedColorById(_data.secondaryColorId);
                    }
                    else
                    {
                        _SafeStr_2642.setSelectedColorById(_SafeStr_825.guildEditorData.findMatchingSecondaryColorId(_SafeStr_2640.secondaryColorIndex));
                    };
                };
                _window.findChildByName("reset_colors").visible = _data.exists;
            };
            if (_SafeStr_2646 == 5)
            {
                if (!_SafeStr_2643.isInitialized)
                {
                    _SafeStr_2643.refresh(_data);
                };
            };
            if (_SafeStr_2646 == 4)
            {
                if (!_data.exists)
                {
                    _SafeStr_825.trackGoogle("groupPurchase", "step4_confirm");
                };
                updateConfirmPreview();
            };
            if (_SafeStr_2646 == 1)
            {
                if (!_data.exists)
                {
                    _SafeStr_825.trackGoogle("groupPurchase", "step1_identity");
                }
                else
                {
                    _SafeStr_825.windowManager.registerLocalizationParameter("group.membercount", "totalMembers", ("" + _data.membershipCount));
                    _window.findChildByName("step_1_members_txt").caption = _SafeStr_825.localization.getLocalization("group.membercount");
                };
                _window.findChildByName("base_label").visible = (!(_data.exists));
                _window.findChildByName("base_dropmenu").visible = (!(_data.exists));
                _window.findChildByName("base_warning").visible = (!(_data.exists));
                _window.findChildByName("create_room_link_region").visible = (!(_data.exists));
                _window.findChildByName("step_1_members_region").visible = data.exists;
            };
            refreshCreateHeader();
        }

        private function updateConfirmPreview():void
        {
            var _local_1:BitmapData;
            var _local_5:IBitmapWrapperWindow;
            var _local_2:GuildColorData;
            var _local_4:IWindow;
            var _local_6:GuildColorData;
            var _local_3:IWindow;
            if (((_SafeStr_825.guildEditorData == null) || (_window == null)))
            {
                return;
            };
            if (_SafeStr_2640.isIntialized)
            {
                _local_1 = _SafeStr_2640.getBadgeBitmap();
                _local_5 = (_window.findChildByName("badge_preview_image") as IBitmapWrapperWindow);
                if (((!(_local_1 == null)) && (!(_local_5 == null))))
                {
                    _local_5.bitmap = _local_1;
                };
            };
            if (_SafeStr_2641.isInitialized)
            {
                _local_2 = _SafeStr_2641.getSelectedColorData();
                _local_4 = _window.findChildByName("badge_preview_primary_color_top");
                if (((!(_local_2 == null)) && (!(_local_4 == null))))
                {
                    _local_4.color = _local_2.color;
                };
            };
            if (_SafeStr_2642.isInitialized)
            {
                _local_6 = _SafeStr_2642.getSelectedColorData();
                _local_3 = _window.findChildByName("badge_preview_secondary_color_top");
                if (((!(_local_6 == null)) && (!(_local_3 == null))))
                {
                    _local_3.color = _local_6.color;
                };
            };
            if (_SafeStr_825.hasVip)
            {
                _window.findChildByName("buy_button").enable();
                _window.findChildByName("buy_border").color = 0xFFC300;
            }
            else
            {
                _window.findChildByName("buy_border").color = 0xAAAAAA;
                _window.findChildByName("buy_button").disable();
            };
            _window.findChildByName("vip_required_border").visible = (!(_SafeStr_825.hasVip));
            _window.findChildByName("confirmation_caption").caption = ITextWindow(_window.findChildByName("name_txt")).text;
        }

        private function getHeaderTextOffset():int
        {
            return ((_data.exists) ? -20 : 0);
        }

        private function refreshCreateHeader():void
        {
            var _local_1:int;
            _window.findChildByName("steps_header_cont").visible = (!(_data.exists));
            if (_data.exists)
            {
                return;
            };
            _window.findChildByName("next_step_button").visible = hasNextStep();
            _window.findChildByName("previous_step_link_region").visible = hasPreviousStep();
            _window.findChildByName("cancel_link_region").visible = (!(hasPreviousStep()));
            _window.findChildByName("buy_border").visible = (!(hasNextStep()));
            _local_1 = 1;
            while (_local_1 <= 4)
            {
                getStepHeader(_local_1, false).visible = (!(_local_1 == _SafeStr_2646));
                getStepHeader(_local_1, true).visible = (_local_1 == _SafeStr_2646);
                _window.findChildByName(("step_title_" + _local_1)).y = ((_local_1 == _SafeStr_2646) ? 5 : 9);
                _local_1++;
            };
            _window.findChildByName("gcreate_icon_credit").y = ((_SafeStr_2646 == 4) ? 6 : 10);
        }

        private function getStepHeader(_arg_1:int, _arg_2:Boolean):IWindow
        {
            return (_window.findChildByName(((("gcreate_" + _arg_1) + "_") + ((_arg_2) ? "1" : "0"))));
        }

        private function getStepContainer(_arg_1:int):IWindowContainer
        {
            return (IWindowContainer(_window.findChildByName(("step_cont_" + _arg_1))));
        }

        private function getStepCaption():String
        {
            var _local_1:String = (((_data.exists) ? "group.edit.tabcaption." : "group.create.stepcaption.") + _SafeStr_2646);
            return (_SafeStr_825.localization.getLocalization(_local_1, _local_1));
        }

        private function getStepDesc():String
        {
            var _local_1:String = (((_data.exists) ? "group.edit.tabdesc." : "group.create.stepdesc.") + _SafeStr_2646);
            return (_SafeStr_825.localization.getLocalization(_local_1, _local_1));
        }

        public function onGuildCreationInfo(_arg_1:GuildCreationData):void
        {
            _data = _arg_1;
            _SafeStr_2646 = 1;
            _SafeStr_2645 = 0;
            refresh();
            refreshBadgeImage();
            setupInputs();
            _SafeStr_825.localization.registerParameter("group.create.confirm.buyinfo", "amount", ("" + _arg_1.costInCredits));
            _window.visible = true;
            _window.activate();
        }

        public function onGuildEditInfo(_arg_1:GuildEditData):void
        {
            _data = _arg_1;
            _SafeStr_2646 = 1;
            _SafeStr_2645 = 0;
            refresh();
            refreshBadgeImage();
            setupInputs();
            var _local_2:ITabContextWindow = ITabContextWindow(_window.findChildByName("edit_guild_tab_context"));
            var _local_3:ISelectableWindow = ISelectableWindow(_window.findChildByName(("edit_tab_" + _SafeStr_2646)));
            _local_2.selector.setSelected(_local_3);
            _window.visible = true;
            _window.activate();
        }

        private function setupInputs():void
        {
            ITextWindow(_window.findChildByName("name_txt")).text = _data.groupName;
            ITextWindow(_window.findChildByName("desc_txt")).text = _data.groupDesc;
            prepareRoomSelection();
            _SafeStr_2640.resetLayerOptions(_data.badgeSettings);
            _SafeStr_2641.setSelectedColorById(_data.primaryColorId);
            _SafeStr_2642.setSelectedColorById(_data.secondaryColorId);
            _SafeStr_2643.refresh(_data);
        }

        private function onTab(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((!(_arg_1.type == "WE_SELECT")) || (_arg_2.id == _SafeStr_2646)))
            {
                return;
            };
            if (!validateView())
            {
                _arg_1.preventDefault();
                return;
            };
            saveView();
            _SafeStr_2646 = _arg_2.id;
            refresh();
        }

        private function onColorReset(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                if (_SafeStr_2641.isInitialized)
                {
                    _SafeStr_2641.setSelectedColorById(_data.primaryColorId);
                };
                if (_SafeStr_2642.isInitialized)
                {
                    _SafeStr_2642.setSelectedColorById(_data.secondaryColorId);
                };
            };
        }

        private function onBadgeReset(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((_arg_1.type == "WME_CLICK") && (_SafeStr_2640.isIntialized)))
            {
                _SafeStr_2640.resetLayerOptions(_data.badgeSettings);
            };
        }

        private function onMembersClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if ((((_arg_1.type == "WME_CLICK") && (_data.exists)) && (!(_SafeStr_825.guildMembersWindowCtrl == null))))
            {
                _SafeStr_825.trackGoogle("groupManagement", "groupMembers");
                _SafeStr_825.guildMembersWindowCtrl.onMembersClick(_data.groupId, 0);
            };
        }

        private function onCancelLink(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            close();
        }

        private function onCreateRoomLink(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            _SafeStr_825.navigator.startRoomCreation();
        }

        private function onNextStep(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            if (!validateView())
            {
                return;
            };
            _SafeStr_2646 = limitStep((_SafeStr_2646 + 1));
            refresh();
        }

        private function onPreviousStep(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            if (!validateView())
            {
                return;
            };
            _SafeStr_2646 = limitStep((_SafeStr_2646 - 1));
            refresh();
        }

        private function onBuy(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            if (!_data.exists)
            {
                _SafeStr_825.trackGoogle("groupPurchase", "buyGroup");
            };
            sendCreateGuildMessage();
        }

        private function onGetVip(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            if (!_data.exists)
            {
                _SafeStr_825.trackGoogle("groupPurchase", "buyVip");
            };
            _SafeStr_825.openVipPurchase("GuildManagementWindowCtrl");
        }

        private function showAlert(_arg_1:String, _arg_2:String):void
        {
            if (!_SafeStr_2644)
            {
                _SafeStr_2644 = true;
                _SafeStr_825.windowManager.alert(_arg_1, _arg_2, 0, onAlertClose);
            };
        }

        private function onAlertClose(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
            _SafeStr_2644 = false;
        }

        private function validateView():Boolean
        {
            var _local_2:String;
            var _local_3:RoomEntryData;
            var _local_4:String;
            var _local_1:Array;
            switch (_SafeStr_2646)
            {
                case 1:
                    _local_2 = ITextFieldWindow(_window.findChildByName("name_txt")).text;
                    if (!_data.exists)
                    {
                        _local_3 = resolveBaseRoom();
                        if (((((_local_2 == null) || (_local_2.length == 0)) || (_local_3 == null)) || (_local_3.roomId == 0)))
                        {
                            showAlert("${group.edit.error.title}", "${group.edit.error.no.name.or.room.selected}");
                            return (false);
                        };
                        if (((_local_3.hasControllers) && (!(_SafeStr_2645 == _local_3.roomId))))
                        {
                            _SafeStr_2645 = _local_3.roomId;
                            showAlert("${group.edit.error.warning}", "${group.edit.error.controllers}");
                            return (false);
                        };
                    };
                    if (_local_2.length >= 30)
                    {
                        showAlert("${group.edit.error.title}", "${group.edit.error.name.length}");
                        return (false);
                    };
                    _local_4 = ITextFieldWindow(_window.findChildByName("desc_txt")).text;
                    if (((!(_local_4 == null)) && (_local_4.length >= 0xFF)))
                    {
                        showAlert("${group.edit.error.title}", "${group.edit.error.desc.length}");
                        return (false);
                    };
                    return (true);
                case 2:
                    _local_1 = ((_SafeStr_2640.isIntialized) ? _SafeStr_2640.getBadgeSettings() : _data.badgeSettings);
                    _SafeStr_2640.onViewChange();
                    return (true);
                case 3:
                    if (((_SafeStr_2641.getSelectedColorData() == null) || (_SafeStr_2642.getSelectedColorData() == null)))
                    {
                        showAlert("${group.edit.error.title}", "${group.edit.error.no.color.selected}");
                        return (false);
                    };
                    return (true);
                default:
                    return (true);
            };
        }

        private function saveView():void
        {
            var _local_3:String;
            var _local_5:String;
            var _local_1:Array;
            var _local_2:int;
            var _local_4:int;
            switch (_SafeStr_2646)
            {
                case 1:
                    _local_3 = ITextFieldWindow(_window.findChildByName("name_txt")).text;
                    _local_5 = ITextFieldWindow(_window.findChildByName("desc_txt")).text;
                    _SafeStr_825.send(new UpdateGuildIdentityMessageComposer(_data.groupId, _local_3, _local_5));
                    _SafeStr_825.events.dispatchEvent(new GuildSettingsChangedInManageEvent("GSCIME_GUILD_VISUAL_SETTINGS_CHANGED", _data.groupId));
                    return;
                case 2:
                    _local_1 = ((_SafeStr_2640.isIntialized) ? _SafeStr_2640.getBadgeSettings() : _data.badgeSettings);
                    _SafeStr_825.send(new UpdateGuildBadgeMessageComposer(_data.groupId, _local_1));
                    _SafeStr_825.events.dispatchEvent(new GuildSettingsChangedInManageEvent("GSCIME_GUILD_VISUAL_SETTINGS_CHANGED", _data.groupId));
                    return;
                case 3:
                    _local_2 = ((_SafeStr_2641.isInitialized) ? _SafeStr_2641.getSelectedColorId() : _data.primaryColorId);
                    _local_4 = ((_SafeStr_2642.isInitialized) ? _SafeStr_2642.getSelectedColorId() : _data.secondaryColorId);
                    _SafeStr_825.send(new UpdateGuildColorsMessageComposer(_data.groupId, _local_2, _local_4));
                    _SafeStr_825.events.dispatchEvent(new GuildSettingsChangedInManageEvent("GSCIME_GUILD_VISUAL_SETTINGS_CHANGED", _data.groupId));
                    return;
                case 5:
                    _SafeStr_825.send(new UpdateGuildSettingsMessageComposer(_data.groupId, _SafeStr_2643.guildType, _SafeStr_2643.rightsLevel));
                    _SafeStr_2643.resetModified();
                default:
            };
        }

        private function sendCreateGuildMessage():void
        {
            var _local_3:String = ITextFieldWindow(_window.findChildByName("name_txt")).text;
            var _local_5:String = ITextFieldWindow(_window.findChildByName("desc_txt")).text;
            var _local_6:RoomEntryData = resolveBaseRoom();
            var _local_1:Array = ((_SafeStr_2640.isIntialized) ? _SafeStr_2640.getBadgeSettings() : _data.badgeSettings);
            var _local_2:int = ((_SafeStr_2641.isInitialized) ? _SafeStr_2641.getSelectedColorId() : _data.primaryColorId);
            var _local_4:int = ((_SafeStr_2642.isInitialized) ? _SafeStr_2642.getSelectedColorId() : _data.secondaryColorId);
            _SafeStr_2645 = 0;
            _SafeStr_825.send(new CreateGuildMessageComposer(_local_3, _local_5, _local_6.roomId, _local_2, _local_4, _local_1));
        }

        private function hasPreviousStep():Boolean
        {
            return (!(_SafeStr_2646 == limitStep((_SafeStr_2646 - 1))));
        }

        private function hasNextStep():Boolean
        {
            return (!(_SafeStr_2646 == limitStep((_SafeStr_2646 + 1))));
        }

        private function limitStep(_arg_1:int):int
        {
            return (Math.max(1, Math.min(_arg_1, 4)));
        }

        private function getBaseDropMenu():IDropMenuWindow
        {
            return (IDropMenuWindow(_window.findChildByName("base_dropmenu")));
        }

        private function prepareRoomSelection():void
        {
            var _local_2:int;
            var _local_4:RoomEntryData;
            var _local_1:IDropMenuWindow = getBaseDropMenu();
            var _local_3:Array = [];
            var _local_5:int;
            _local_3.push(_SafeStr_825.localization.getLocalization("group.edit.base.select.room", "group.edit.base.select.room"));
            _local_2 = 0;
            while (_local_2 < _data.ownedRooms.length)
            {
                _local_4 = _data.ownedRooms[_local_2];
                _local_3.push(_local_4.roomName);
                if (_local_4.roomId == _data.baseRoomId)
                {
                    _local_5 = (_local_2 + 1);
                };
                _local_2++;
            };
            _local_1.populate(_local_3);
            if (_local_3.length > 0)
            {
                _local_1.selection = _local_5;
            };
        }

        private function resolveBaseRoom():RoomEntryData
        {
            var _local_1:IDropMenuWindow = IDropMenuWindow(_window.findChildByName("base_dropmenu"));
            var _local_2:int = (_local_1.selection - 1);
            if ((((_local_2 >= 0) && (_local_2 < _data.ownedRooms.length)) && (!(_data.ownedRooms[_local_2] == null))))
            {
                return (RoomEntryData(_data.ownedRooms[_local_2]));
            };
            return (null);
        }

        private function onCloseWindow(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            if (_data.exists)
            {
                if (!validateView())
                {
                    return;
                };
                saveView();
            };
            close();
        }

        public function close():void
        {
            if (_window != null)
            {
                _window.visible = false;
            };
        }

        public function onPrimaryColorSelected(_arg_1:ColorGridCtrl):void
        {
            var _local_3:GuildColorData;
            var _local_2:IWindow = _window.findChildByName("guild_color_primary_color_top");
            if (((((!(_local_2 == null)) && (!(_SafeStr_825.guildEditorData == null))) && (_arg_1.selectedColorIndex >= 0)) && (_arg_1.selectedColorIndex <= _SafeStr_825.guildEditorData.guildPrimaryColors.length)))
            {
                _local_3 = _SafeStr_825.guildEditorData.guildPrimaryColors[_arg_1.selectedColorIndex];
                _local_2.color = _local_3.color;
            };
        }

        public function onSecondaryColorSelected(_arg_1:ColorGridCtrl):void
        {
            var _local_3:GuildColorData;
            var _local_2:IWindow = _window.findChildByName("guild_color_secondary_color_top");
            if ((((!(_SafeStr_825.guildEditorData == null)) && (_arg_1.selectedColorIndex >= 0)) && (_arg_1.selectedColorIndex <= _SafeStr_825.guildEditorData.guildSecondaryColors.length)))
            {
                _local_3 = _SafeStr_825.guildEditorData.guildSecondaryColors[_arg_1.selectedColorIndex];
                _local_2.color = _local_3.color;
            };
        }

        public function get data():IGuildData
        {
            return (_data);
        }

        private function refreshBadgeImage():void
        {
            var _local_2:IWindow = _window.findChildByName("step_1_badge");
            var _local_1:IBadgeImageWidget = (IWidgetWindow(_window.findChildByName("group_logo")).widget as IBadgeImageWidget);
            if (((_local_1 == null) || (_local_2 == null)))
            {
                return;
            };
            if (!_data.exists)
            {
                _local_2.visible = false;
                _local_2.invalidate();
            }
            else
            {
                _local_1.badgeId = _data.badgeCode;
                _local_1.groupId = _data.groupId;
                _local_2.visible = true;
                _local_2.invalidate();
            };
        }

        private function onWindowUnActivated(_arg_1:WindowEvent):void
        {
            if (((((!(_data == null)) && (_data.exists)) && (!(_window == null))) && (_window.visible)))
            {
                saveView();
            };
        }


    }
}

