package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.ui.widget.memenu.MeMenuWidget;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetDanceMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChangePostureMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetSelectEffectMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenCatalogMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenInventoryMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMeMenuMessage;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetStoreSettingsMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetAvatarExpressionMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEffectsUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetHabboClubUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPurseUpdateEvent;
    import com.sulake.habbo.help.enum.HabboHelpTutorialEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetSettingsUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;
    import com.sulake.habbo.catalog.purse.PurseEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetTutorialEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetMiniMailUpdateEvent;
    import com.sulake.habbo.messenger.events.MiniMailMessageEvent;

    public class MeMenuWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var _inventory:IHabboInventory;
        private var _toolbar:IHabboToolbar;
        private var _catalog:IHabboCatalog;
        private var _SafeStr_1324:MeMenuWidget;

        public function MeMenuWidgetHandler()
        {
            Logger.log("[MeMenuWidgetHandler]");
        }

        public function set widget(_arg_1:MeMenuWidget):void
        {
            _SafeStr_1324 = _arg_1;
        }

        public function dispose():void
        {
            if (((_container) && (_container.avatarEditor)))
            {
                _container.avatarEditor.close(0);
            };
            _disposed = true;
            this.container = null;
            _inventory = null;
            _toolbar = null;
            _catalog = null;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get type():String
        {
            return ("RWE_ME_MENU");
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            if (_container != null)
            {
                if ((((_inventory) && (!(_inventory.disposed))) && (_inventory.events)))
                {
                    _inventory.events.removeEventListener("HIEE_EFFECTS_CHANGED", onAvatarEffectsChanged);
                    _inventory.events.removeEventListener("HIHCE_HABBO_CLUB_CHANGED", onHabboClubSubscriptionChanged);
                };
                if ((((_toolbar) && (!(_toolbar.disposed))) && (_toolbar.events)))
                {
                    _toolbar.events.removeEventListener("HTE_TOOLBAR_CLICK", onHabboToolbarEvent);
                };
                if ((((_container.habboHelp) && (!(_container.habboHelp.disposed))) && (_container.habboHelp.events)))
                {
                    _container.habboHelp.events.removeEventListener("HHTPNUFWE_LIGHT_CLOTHES_ICON", onHelpTutorialEvent);
                    _container.habboHelp.events.removeEventListener("HHTPNUFWE_AVATAR_TUTORIAL_START", onHelpTutorialEvent);
                };
                if ((((_container.catalog) && (!(_container.catalog.disposed))) && (_container.catalog.events)))
                {
                    _container.catalog.events.removeEventListener("catalog_purse_credit_balance", onCreditBalance);
                };
                if ((((_container.messenger) && (!(_container.messenger.disposed))) && (_container.messenger.events)))
                {
                    _container.messenger.events.removeEventListener("MMME_new", onMiniMailNewMessage);
                    _container.messenger.events.removeEventListener("MMME_unread", onMiniMailUnreadCount);
                };
            };
            _container = _arg_1;
            if (_container == null)
            {
                return;
            };
            _inventory = _container.inventory;
            if (_inventory != null)
            {
                _inventory.events.addEventListener("HIEE_EFFECTS_CHANGED", onAvatarEffectsChanged);
                _inventory.events.addEventListener("HIHCE_HABBO_CLUB_CHANGED", onHabboClubSubscriptionChanged);
            };
            _toolbar = _container.toolbar;
            if (((_toolbar) && (_toolbar.events)))
            {
                _toolbar.events.addEventListener("HTE_TOOLBAR_CLICK", onHabboToolbarEvent);
            };
            if (_container.habboHelp != null)
            {
                _container.habboHelp.events.addEventListener("HHTPNUFWE_LIGHT_CLOTHES_ICON", onHelpTutorialEvent);
                _container.habboHelp.events.addEventListener("HHTPNUFWE_AVATAR_TUTORIAL_START", onHelpTutorialEvent);
            };
            _catalog = _container.catalog;
            if (_container.catalog != null)
            {
                _container.catalog.events.addEventListener("catalog_purse_credit_balance", onCreditBalance);
            };
            if ((((_container.messenger) && (!(_container.messenger.disposed))) && (_container.messenger.events)))
            {
                _container.messenger.events.addEventListener("MMME_new", onMiniMailNewMessage);
                _container.messenger.events.addEventListener("MMME_unread", onMiniMailUnreadCount);
            };
        }

        public function get container():IRoomWidgetHandlerContainer
        {
            return (_container);
        }

        private function onHabboToolbarEvent(_arg_1:HabboToolbarEvent):void
        {
            if ((((disposed) || (!(_container))) || (!(_container.events))))
            {
                return;
            };
            if (_arg_1.type == "HTE_TOOLBAR_CLICK")
            {
                switch (_arg_1.iconId)
                {
                    case "HTIE_ICON_MEMENU":
                        return;
                };
            };
        }

        public function getWidgetMessages():Array
        {
            var _local_1:Array = [];
            _local_1.push("RWCM_MESSAGE_AVATAR_EXPRESSION");
            _local_1.push("RWCM_MESSAGE_DANCE");
            _local_1.push("RWCPM_MESSAGE_CHANGE_POSTURE");
            _local_1.push("RWCM_MESSAGE_GET_EFFECTS");
            _local_1.push("RWCM_MESSAGE_SELECT_EFFECT");
            _local_1.push("RWCM_MESSAGE_UNSELECT_EFFECT");
            _local_1.push("RWCM_MESSAGE_UNSELECT_ALL_EFFECTS");
            _local_1.push("RWGOI_MESSAGE_OPEN_INVENTORY");
            _local_1.push("RWGOI_MESSAGE_OPEN_CATALOG");
            _local_1.push("RWGOI_MESSAGE_STOP_EFFECT");
            _local_1.push("RWGOI_MESSAGE_NAVIGATE_TO_ROOM");
            _local_1.push("RWGOI_MESSAGE_NAVIGATE_HOME");
            _local_1.push("RWCM_OPEN_AVATAR_EDITOR");
            _local_1.push("RWCM_GET_WARDROBE");
            _local_1.push("select_outfit");
            _local_1.push("RWSORM_SHOW_OWN_ROOMS");
            _local_1.push("RWRWM_ME_MENU");
            _local_1.push("RWMMM_MESSAGE_ME_MENU_OPENED");
            _local_1.push("RWGSM_GET_SETTINGS");
            _local_1.push("RWSSM_STORE_SETTINGS");
            _local_1.push("RWSSM_STORE_SOUND");
            _local_1.push("RWSSM_PREVIEW_SOUND");
            _local_1.push("RWSSM_STORE_CHAT");
            _local_1.push("RWAEM_AVATAR_EDITOR_VIEW_DISPOSED");
            _local_1.push("RWRWM_EFFECTS");
            return (_local_1);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_4:HabboToolbarEvent;
            var _local_13:RoomWidgetDanceMessage;
            var _local_11:RoomWidgetChangePostureMessage;
            var _local_10:Array;
            var _local_2:RoomWidgetSelectEffectMessage;
            var _local_9:RoomWidgetSelectEffectMessage;
            var _local_14:RoomWidgetOpenCatalogMessage;
            var _local_5:RoomWidgetOpenInventoryMessage;
            var _local_15:RoomWidgetMeMenuMessage;
            var _local_12:Boolean;
            var _local_6:int;
            var _local_3:IUserData;
            var _local_8:int;
            var _local_7:RoomWidgetStoreSettingsMessage;
            if (!_arg_1)
            {
                return (null);
            };
            switch (_arg_1.type)
            {
                case "RWRWM_ME_MENU":
                    if ((((!(_container == null)) && (!(_container.toolbar == null))) && (!(_container.toolbar.events == null))))
                    {
                        _local_4 = new HabboToolbarEvent("HTE_TOOLBAR_CLICK");
                        _local_4.iconId = "HTIE_ICON_MEMENU";
                        if (((((!(disposed)) && (_container)) && (_container.toolbar)) && (_container.toolbar.events)))
                        {
                            _container.toolbar.events.dispatchEvent(_local_4);
                        };
                    };
                    break;
                case "RWCM_MESSAGE_AVATAR_EXPRESSION":
                    if (((!(_container == null)) && (!(_container.roomSession == null))))
                    {
                        _container.roomSession.sendAvatarExpressionMessage(RoomWidgetAvatarExpressionMessage(_arg_1).animation.ordinal);
                    };
                    break;
                case "RWCM_MESSAGE_DANCE":
                    if (((!(_container == null)) && (!(_container.roomSession == null))))
                    {
                        _local_13 = (_arg_1 as RoomWidgetDanceMessage);
                        if (_local_13 != null)
                        {
                            _container.roomSession.sendDanceMessage(_local_13.style);
                        };
                    };
                    break;
                case "RWCPM_MESSAGE_CHANGE_POSTURE":
                    if (((!(_container == null)) && (!(_container.roomSession == null))))
                    {
                        _local_11 = (_arg_1 as RoomWidgetChangePostureMessage);
                        if (_local_11 != null)
                        {
                            _container.roomSession.sendChangePostureMessage(_local_11.posture);
                        };
                    };
                    break;
                case "RWCM_MESSAGE_GET_EFFECTS":
                    if (_inventory != null)
                    {
                        _local_10 = _inventory.getAvatarEffects();
                        _container.events.dispatchEvent(new RoomWidgetUpdateEffectsUpdateEvent(_local_10));
                    };
                    break;
                case "RWCM_MESSAGE_SELECT_EFFECT":
                    if (_inventory != null)
                    {
                        _local_2 = (_arg_1 as RoomWidgetSelectEffectMessage);
                        _inventory.setEffectSelected(_local_2.effectType);
                    };
                    break;
                case "RWCM_MESSAGE_UNSELECT_EFFECT":
                    if (_inventory != null)
                    {
                        _local_9 = (_arg_1 as RoomWidgetSelectEffectMessage);
                        _inventory.setEffectDeselected(_local_9.effectType);
                    };
                    break;
                case "RWGOI_MESSAGE_OPEN_CATALOG":
                    _local_14 = (_arg_1 as RoomWidgetOpenCatalogMessage);
                    if (((!(_catalog == null)) && (_local_14.pageKey == "RWOCM_CLUB_MAIN")))
                    {
                        _catalog.openClubCenter();
                    };
                    break;
                case "RWGOI_MESSAGE_OPEN_INVENTORY":
                    _local_5 = (_arg_1 as RoomWidgetOpenInventoryMessage);
                    if (_inventory != null)
                    {
                        Logger.log(("MeMenuWidgetHandler open inventory: " + _local_5.inventoryType));
                        switch (_local_5.inventoryType)
                        {
                            case "inventory_effects":
                                _catalog.openCatalogPage("avatar_effects");
                                break;
                            case "inventory_badges":
                                _inventory.toggleInventoryPage("badges");
                                break;
                            case "inventory_furniture":
                                _inventory.toggleInventoryPage("furni");
                                break;
                            case "inventory_clothes":
                                break;
                            default:
                                Logger.log(("MeMenuWidgetHandler: unknown inventory type: " + _local_5.inventoryType));
                        };
                    };
                    break;
                case "RWCM_MESSAGE_UNSELECT_ALL_EFFECTS":
                case "RWGOI_MESSAGE_STOP_EFFECT":
                    Logger.log("STOP ALL EFFECTS");
                    if (_inventory != null)
                    {
                        _inventory.deselectAllEffects(true);
                    };
                    break;
                case "RWGOI_MESSAGE_NAVIGATE_HOME":
                    Logger.log("MeMenuWidgetHandler: GO HOME");
                    if (_container != null)
                    {
                        _container.navigator.goToHomeRoom();
                    };
                    break;
                case "RWSORM_SHOW_OWN_ROOMS":
                    if (_container != null)
                    {
                        _container.navigator.showOwnRooms();
                    };
                    break;
                case "RWMMM_MESSAGE_ME_MENU_OPENED":
                    _local_15 = (_arg_1 as RoomWidgetMeMenuMessage);
                    if ((((!(_local_15)) || (!(_container))) || (!(_container.events))))
                    {
                        return (null);
                    };
                    if (_inventory != null)
                    {
                        _local_12 = false;
                        if (((!(_container == null)) && (!(_container.sessionDataManager == null))))
                        {
                            _local_12 = _container.sessionDataManager.hasClub;
                        };
                        _container.events.dispatchEvent(new RoomWidgetHabboClubUpdateEvent(_inventory.clubDays, _inventory.clubPeriods, _inventory.clubPastPeriods, _local_12, _inventory.clubLevel));
                    };
                    if (((!(_catalog == null)) && (!(_catalog.getPurse() == null))))
                    {
                        _container.events.dispatchEvent(new RoomWidgetPurseUpdateEvent("RWPUE_CREDIT_BALANCE", _catalog.getPurse().credits));
                    };
                    if ((((_container.roomSession) && (_container.roomSession.userDataManager)) && (_container.roomEngine)))
                    {
                        _local_6 = ((_container.sessionDataManager != null) ? _container.sessionDataManager.userId : -1);
                        _local_3 = _container.roomSession.userDataManager.getUserData(_local_6);
                        if (!_local_3)
                        {
                            return (null);
                        };
                        _local_8 = 0;
                        _container.roomEngine.selectAvatar(_local_8, _local_3.roomObjectId);
                    };
                    break;
                case "RWCM_OPEN_AVATAR_EDITOR":
                    Logger.log("MeMenuWidgetHandler: Open avatar editor...");
                    if (_container)
                    {
                        _container.avatarEditor.openEditor(0, null, null, true);
                        _container.avatarEditor.loadOwnAvatarInEditor(0);
                        if (((_container.habboHelp) && (_container.habboHelp.events)))
                        {
                            _container.habboHelp.events.dispatchEvent(new HabboHelpTutorialEvent("HHTE_DONE_AVATAR_EDITOR_OPENING"));
                        };
                    };
                    break;
                case "RWGSM_GET_SETTINGS":
                    _container.events.dispatchEvent(new RoomWidgetSettingsUpdateEvent("RWSUE_SETTINGS", _container.soundManager.traxVolume, _container.soundManager.furniVolume, _container.soundManager.genericVolume));
                    break;
                case "RWSSM_STORE_SOUND":
                    _container.soundManager.traxVolume = (_arg_1 as RoomWidgetStoreSettingsMessage).traxVolume;
                    _container.soundManager.furniVolume = (_arg_1 as RoomWidgetStoreSettingsMessage).furniVolume;
                    _container.soundManager.genericVolume = (_arg_1 as RoomWidgetStoreSettingsMessage).genericVolume;
                    _container.events.dispatchEvent(new RoomWidgetSettingsUpdateEvent("RWSUE_SETTINGS", _container.soundManager.traxVolume, _container.soundManager.furniVolume, _container.soundManager.genericVolume));
                    break;
                case "RWSSM_PREVIEW_SOUND":
                    _local_7 = (_arg_1 as RoomWidgetStoreSettingsMessage);
                    _container.soundManager.previewVolume(_local_7.genericVolume, _local_7.furniVolume, _local_7.traxVolume);
                    _container.events.dispatchEvent(new RoomWidgetSettingsUpdateEvent("RWSUE_SETTINGS", _container.soundManager.traxVolume, _container.soundManager.furniVolume, _container.soundManager.genericVolume));
                    break;
                case "RWAEM_AVATAR_EDITOR_VIEW_DISPOSED":
                    if (((_container.habboHelp) && (_container.habboHelp.events)))
                    {
                        _container.habboHelp.events.dispatchEvent(new HabboHelpTutorialEvent("HHTE_DONE_AVATAR_EDITOR_CLOSING"));
                    };
                    break;
                case "RWSSM_STORE_CHAT":
                    if (_container.freeFlowChat)
                    {
                        _container.freeFlowChat.isDisabledInPreferences = RoomWidgetStoreSettingsMessage(_arg_1).forceOldChat;
                        if (!RoomWidgetStoreSettingsMessage(_arg_1).forceOldChat)
                        {
                            if (((_container.layoutManager) && (_container.layoutManager.getChatContainer())))
                            {
                                _container.layoutManager.getChatContainer().setDisplayObject(_container.freeFlowChat.displayObject);
                            };
                        }
                        else
                        {
                            _container.freeFlowChat.clear();
                        };
                    };
                    break;
                default:
                    Logger.log(("Unhandled message in MeMenuWidgetHandler: " + _arg_1.type));
            };
            return (null);
        }

        public function getProcessedEvents():Array
        {
            return ([]);
        }

        public function processEvent(_arg_1:Event):void
        {
        }

        public function update():void
        {
        }

        private function onAvatarEffectsChanged(_arg_1:Event=null):void
        {
            var _local_2:Array;
            if (_container == null)
            {
                return;
            };
            Logger.log("[MeMenuWidgetHandler] Received Avatar Effects Have Changed Event...\t");
            if (_inventory != null)
            {
                _local_2 = _inventory.getAvatarEffects();
                _container.events.dispatchEvent(new RoomWidgetUpdateEffectsUpdateEvent(_local_2));
            };
        }

        private function onHabboClubSubscriptionChanged(_arg_1:Event=null):void
        {
            var _local_2:Boolean;
            if (_inventory != null)
            {
                _local_2 = false;
                if (((!(_container == null)) && (!(_container.sessionDataManager == null))))
                {
                    _local_2 = _container.sessionDataManager.hasClub;
                };
                _container.events.dispatchEvent(new RoomWidgetHabboClubUpdateEvent(_inventory.clubDays, _inventory.clubPeriods, _inventory.clubPastPeriods, _local_2, _inventory.clubLevel));
            };
        }

        private function onCreditBalance(_arg_1:PurseEvent):void
        {
            if ((((_arg_1 == null) || (_container == null)) || (_container.events == null)))
            {
                return;
            };
            _container.events.dispatchEvent(new RoomWidgetPurseUpdateEvent("RWPUE_CREDIT_BALANCE", _arg_1.balance));
        }

        private function onHelpTutorialEvent(_arg_1:HabboHelpTutorialEvent):void
        {
            if (_container == null)
            {
                return;
            };
            switch (_arg_1.type)
            {
                case "HHTPNUFWE_AVATAR_TUTORIAL_START":
                    _container.events.dispatchEvent(new RoomWidgetTutorialEvent("HHTPNUFWE_AE_STARTED"));
                    return;
                case "HHTPNUFWE_LIGHT_CLOTHES_ICON":
                    _container.events.dispatchEvent(new RoomWidgetTutorialEvent("HHTPNUFWE_AE_HIGHLIGHT"));
                    return;
            };
        }

        private function onMiniMailNewMessage(_arg_1:MiniMailMessageEvent):void
        {
            _container.events.dispatchEvent(new RoomWidgetMiniMailUpdateEvent("RWMMUE_new_mini_mail"));
        }

        private function onMiniMailUnreadCount(_arg_1:MiniMailMessageEvent):void
        {
            _container.events.dispatchEvent(new RoomWidgetMiniMailUpdateEvent("RWMMUE_unread_mini_mail"));
        }


    }
}

