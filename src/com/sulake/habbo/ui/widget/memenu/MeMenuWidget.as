package com.sulake.habbo.ui.widget.memenu
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import flash.geom.Point;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.runtime.ICoreConfiguration;
    import flash.external.ExternalInterface;
    import com.sulake.habbo.ui.handler.MeMenuWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.habbo.ui.widget.memenu.soundsettings.MeMenuSoundSettingsView;
    import com.sulake.habbo.ui.widget.memenu.chatsettings.MeMenuChatSettingsView;
    import flash.geom.Rectangle;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetSettingsUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetTutorialEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMeMenuMessage;
    import com.sulake.habbo.utils.WindowToggle;
    import com.sulake.habbo.ui.widget.events.RoomWidgetToolbarClickedUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEffectsUpdateEvent;
    import flash.events.Event;
    import com.sulake.habbo.ui.widget.events.RoomWidgetAvatarEditorUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetWaveUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetMiniMailUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetDanceUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetHabboClubUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPurseUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomEngineUpdateEvent;

    public class MeMenuWidget extends RoomWidgetBase 
    {

        public static const MAIN_VIEW:String = "me_menu_top_view";
        public static const MY_CLOTHES_VIEW:String = "me_menu_my_clothes_view";
        public static const _SafeStr_4176:String = "me_menu_dance_moves_view";
        public static const _SafeStr_4177:String = "me_menu_settings_view";
        public static const SOUND_SETTINGS_VIEW:String = "me_menu_sound_settings";
        public static const CHAT_SETTINGS_VIEW:String = "me_menu_chat_settings";
        private static const DEFAULT_VIEW_LOCATION_BOTTOM:Point = new Point(95, 440);

        private var _SafeStr_2682:IMeMenuView;
        private var _mainWindow:IWindowContainer;
        private var _habboClubDays:int = 0;
        private var _habboClubPeriods:int = 0;
        private var _SafeStr_4178:int = 0;
        private var _allowHabboClubDances:Boolean = false;
        private var _habboClubLevel:int = 0;
        private var _hasEffectOn:Boolean = false;
        private var _isDancing:Boolean = false;
        private var _SafeStr_4179:Boolean = false;
        private var _isMinimailEnabled:Boolean = false;
        private var _SafeStr_4180:int = 0;
        private var _SafeStr_3029:Boolean = false;
        private var _config:ICoreConfiguration;
        private var _userId:int;

        public function MeMenuWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager, _arg_5:ICoreConfiguration)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            _config = _arg_5;
            if (ExternalInterface.available)
            {
                _isMinimailEnabled = _arg_5.getBoolean("client.minimail.embed.enabled");
            };
            (_arg_1 as MeMenuWidgetHandler).widget = this;
            changeView("me_menu_top_view");
            hide();
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            hide();
            if (_SafeStr_2682 != null)
            {
                _SafeStr_2682.dispose();
                _SafeStr_2682 = null;
            };
            _mainWindow = null;
            _config = null;
            super.dispose();
        }

        public function get handler():MeMenuWidgetHandler
        {
            return (_SafeStr_3915 as MeMenuWidgetHandler);
        }

        override public function get mainWindow():IWindow
        {
            return (_mainWindow);
        }

        private function get mainContainer():IWindowContainer
        {
            var _local_1:IAsset;
            if (_mainWindow == null)
            {
                _local_1 = _assets.getAssetByName("memenu");
                if (_local_1)
                {
                    _mainWindow = (windowManager.buildFromXML((_local_1.content as XML)) as IWindowContainer);
                };
            };
            if (_mainWindow)
            {
                return (_mainWindow.findChildByTag("MAIN_CONTENT") as IWindowContainer);
            };
            return (null);
        }

        public function changeView(_arg_1:String):void
        {
            var _local_2:IMeMenuView;
            switch (_arg_1)
            {
                case "me_menu_top_view":
                    _local_2 = new MeMenuMainView(config);
                    break;
                case "me_menu_dance_moves_view":
                    _local_2 = new MeMenuDanceView();
                    break;
                case "me_menu_settings_view":
                    _local_2 = new MeMenuSettingsMenuView();
                    break;
                case "me_menu_sound_settings":
                    _local_2 = new MeMenuSoundSettingsView();
                    break;
                case "me_menu_chat_settings":
                    _local_2 = new MeMenuChatSettingsView();
                    break;
                default:
                    Logger.log(("Me Menu Change view: unknown view: " + _arg_1));
            };
            if (_local_2 != null)
            {
                if (_SafeStr_2682)
                {
                    _SafeStr_2682.dispose();
                    _SafeStr_2682 = null;
                };
                _SafeStr_2682 = _local_2;
                _SafeStr_2682.init(this, _arg_1);
                mainContainer.removeChildAt(0);
                mainContainer.addChildAt(_SafeStr_2682.window, 0);
                _mainWindow.visible = true;
                _mainWindow.activate();
            };
            updateSize();
        }

        public function updateSize():void
        {
            var _local_1:int;
            var _local_2:Rectangle;
            if ((((_SafeStr_2682) && (_SafeStr_2682.window)) && (_mainWindow)))
            {
                _local_1 = 5;
                _SafeStr_2682.window.position = new Point(_local_1, _local_1);
                mainContainer.width = (_SafeStr_2682.window.width + (_local_1 * 2));
                mainContainer.height = (_SafeStr_2682.window.height + (_local_1 * 2));
                if (((((_config.getBoolean("simple.memenu.enabled")) && (handler)) && (handler.container)) && (handler.container.toolbar)))
                {
                    _local_2 = handler.container.toolbar.getRect();
                    _mainWindow.x = (_local_2.right + _local_1);
                    _mainWindow.y = (_local_2.bottom - _mainWindow.height);
                }
                else
                {
                    _mainWindow.x = DEFAULT_VIEW_LOCATION_BOTTOM.x;
                    _mainWindow.y = (DEFAULT_VIEW_LOCATION_BOTTOM.y - mainContainer.height);
                };
            };
        }

        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addEventListener("RWMMUE_new_mini_mail", onMiniMailUpdate);
            _arg_1.addEventListener("RWMMUE_unread_mini_mail", onMiniMailUpdate);
            _arg_1.addEventListener("RWUE_WAVE", onWaveEvent);
            _arg_1.addEventListener("RWUE_DANCE", onDanceEvent);
            _arg_1.addEventListener("RWUEUE_UPDATE_EFFECTS", onUpdateEffects);
            _arg_1.addEventListener("RWUE_REQUEST_ME_MENU_TOOLBAR_CLICKED", onToolbarClicked);
            _arg_1.addEventListener("RWUE_AVATAR_EDITOR_CLOSED", onAvatarEditorClosed);
            _arg_1.addEventListener("RWUE_HIDE_AVATAR_EDITOR", onHideAvatarEditor);
            _arg_1.addEventListener("RWROUE_OBJECT_DESELECTED", onAvatarDeselected);
            _arg_1.addEventListener("RWBIUE_HABBO_CLUB", onHabboClubEvent);
            _arg_1.addEventListener("RWUIUE_OWN_USER", onUserInfo);
            _arg_1.addEventListener("RWSUE_SETTINGS", onSettingsUpdate);
            _arg_1.addEventListener("HHTPNUFWE_AE_STARTED", onTutorialEvent);
            _arg_1.addEventListener("HHTPNUFWE_AE_HIGHLIGHT", onTutorialEvent);
            _arg_1.addEventListener("RWPUE_CREDIT_BALANCE", onCreditBalance);
            _arg_1.addEventListener("RWREUE_NORMAL_MODE", onNormalMode);
            _arg_1.addEventListener("RWREUE_GAME_MODE", onGameMode);
            super.registerUpdateEvents(_arg_1);
        }

        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.removeEventListener("RWUE_WAVE", onWaveEvent);
            _arg_1.removeEventListener("RWUE_DANCE", onDanceEvent);
            _arg_1.removeEventListener("RWUEUE_UPDATE_EFFECTS", onUpdateEffects);
            _arg_1.removeEventListener("RWUE_REQUEST_ME_MENU_TOOLBAR_CLICKED", onToolbarClicked);
            _arg_1.removeEventListener("RWROUE_OBJECT_DESELECTED", onAvatarDeselected);
            _arg_1.removeEventListener("RWBIUE_HABBO_CLUB", onHabboClubEvent);
            _arg_1.removeEventListener("RWUE_AVATAR_EDITOR_CLOSED", onHideAvatarEditor);
            _arg_1.removeEventListener("RWUE_HIDE_AVATAR_EDITOR", onAvatarEditorClosed);
            _arg_1.removeEventListener("RWUIUE_OWN_USER", onUserInfo);
            _arg_1.removeEventListener("RWSUE_SETTINGS", onSettingsUpdate);
            _arg_1.removeEventListener("HHTPNUFWE_AE_HIGHLIGHT", onTutorialEvent);
            _arg_1.removeEventListener("HHTPNUFWE_AE_STARTED", onTutorialEvent);
            _arg_1.removeEventListener("RWPUE_CREDIT_BALANCE", onCreditBalance);
            _arg_1.removeEventListener("RWREUE_NORMAL_MODE", onNormalMode);
            _arg_1.removeEventListener("RWREUE_NORMAL_MODE", onGameMode);
        }

        public function hide(_arg_1:RoomWidgetRoomObjectUpdateEvent=null):void
        {
            if (_SafeStr_2682 != null)
            {
                _mainWindow.removeChild(_SafeStr_2682.window);
                _SafeStr_2682.dispose();
                _SafeStr_2682 = null;
            };
            _mainWindow.visible = false;
            _SafeStr_4179 = false;
        }

        private function onUserInfo(_arg_1:RoomWidgetUserInfoUpdateEvent):void
        {
            _userId = _arg_1.webID;
        }

        private function onSettingsUpdate(_arg_1:RoomWidgetSettingsUpdateEvent):void
        {
            if (!_SafeStr_4179)
            {
                return;
            };
            if (_SafeStr_2682.window.name == "me_menu_sound_settings")
            {
                (_SafeStr_2682 as MeMenuSoundSettingsView).updateSettings(_arg_1);
            };
        }

        private function onTutorialEvent(_arg_1:RoomWidgetTutorialEvent):void
        {
            switch (_arg_1.type)
            {
                case "HHTPNUFWE_AE_HIGHLIGHT":
                    Logger.log(((("* MeMenuWidget: onHighlightClothesIcon " + _SafeStr_4179) + " view: ") + _SafeStr_2682.window.name));
                    if (((!(_SafeStr_4179 == true)) || (!(_SafeStr_2682.window.name == "me_menu_top_view"))))
                    {
                        return;
                    };
                    (_SafeStr_2682 as MeMenuMainView).setIconAssets("clothes_icon", "me_menu_top_view", "clothes_highlighter_blue");
                    return;
                case "HHTPNUFWE_AE_STARTED":
                    hide();
                    return;
            };
        }

        private function onToolbarClicked(_arg_1:RoomWidgetToolbarClickedUpdateEvent):void
        {
            var _local_2:RoomWidgetMeMenuMessage;
            if (_SafeStr_4179)
            {
                if (((!(_mainWindow == null)) && (WindowToggle.isHiddenByOtherWindows(_mainWindow))))
                {
                    _mainWindow.activate();
                    return;
                };
                _SafeStr_4179 = false;
            }
            else
            {
                _SafeStr_4179 = true;
            };
            if (_SafeStr_4179)
            {
                _local_2 = new RoomWidgetMeMenuMessage("RWMMM_MESSAGE_ME_MENU_OPENED");
                if (messageListener != null)
                {
                    messageListener.processWidgetMessage(_local_2);
                };
                changeView("me_menu_top_view");
            }
            else
            {
                hide();
            };
        }

        private function onUpdateEffects(_arg_1:RoomWidgetUpdateEffectsUpdateEvent):void
        {
            _hasEffectOn = false;
            for each (var _local_2:IWidgetAvatarEffect in _arg_1.effects)
            {
                if (_local_2.isInUse)
                {
                    _hasEffectOn = true;
                };
            };
        }

        private function onAvatarDeselected(_arg_1:Event):void
        {
            if (((!(_SafeStr_2682 == null)) && (!(_SafeStr_2682.window.name == "me_menu_my_clothes_view"))))
            {
                hide();
            };
        }

        private function onAvatarEditorClosed(_arg_1:RoomWidgetAvatarEditorUpdateEvent):void
        {
            if (((!(_SafeStr_2682 == null)) && (_SafeStr_2682.window.name == "me_menu_my_clothes_view")))
            {
                changeView("me_menu_top_view");
            };
        }

        private function onHideAvatarEditor(_arg_1:RoomWidgetAvatarEditorUpdateEvent):void
        {
            if (((!(_SafeStr_2682 == null)) && (_SafeStr_2682.window.name == "me_menu_my_clothes_view")))
            {
                changeView("me_menu_top_view");
            };
        }

        private function onWaveEvent(_arg_1:RoomWidgetWaveUpdateEvent):void
        {
            Logger.log("[MeMenuWidget] Wave Event received");
        }

        private function onMiniMailUpdate(_arg_1:RoomWidgetMiniMailUpdateEvent):void
        {
            if (_SafeStr_2682)
            {
                _SafeStr_2682.updateUnseenItemCount("minimail", handler.container.messenger.getUnseenMiniMailMessageCount());
            };
        }

        private function onDanceEvent(_arg_1:RoomWidgetDanceUpdateEvent):void
        {
            Logger.log(("[MeMenuWidget] Dance Event received, style: " + _arg_1.style));
        }

        private function onHabboClubEvent(_arg_1:RoomWidgetHabboClubUpdateEvent):void
        {
            var _local_2:Boolean = (!(_arg_1.daysLeft == _habboClubDays));
            _habboClubDays = _arg_1.daysLeft;
            _habboClubPeriods = _arg_1.periodsLeft;
            _SafeStr_4178 = _arg_1.pastPeriods;
            _allowHabboClubDances = _arg_1.allowClubDances;
            _local_2 = ((_local_2) || (!(_arg_1.clubLevel == _habboClubLevel)));
            _habboClubLevel = _arg_1.clubLevel;
            if (_local_2)
            {
                if (_SafeStr_2682 != null)
                {
                    changeView(_SafeStr_2682.window.name);
                };
            };
        }

        private function onCreditBalance(_arg_1:RoomWidgetPurseUpdateEvent):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _SafeStr_4180 = _arg_1.balance;
            localizations.registerParameter("widget.memenu.credits", "credits", _SafeStr_4180.toString());
        }

        private function onNormalMode(_arg_1:RoomWidgetRoomEngineUpdateEvent):void
        {
            _SafeStr_3029 = false;
        }

        private function onGameMode(_arg_1:RoomWidgetRoomEngineUpdateEvent):void
        {
            _SafeStr_3029 = true;
        }

        public function get allowHabboClubDances():Boolean
        {
            return (_allowHabboClubDances);
        }

        public function get isHabboClubActive():Boolean
        {
            return (_habboClubDays > 0);
        }

        public function get habboClubDays():int
        {
            return (_habboClubDays);
        }

        public function get habboClubPeriods():int
        {
            return (_habboClubPeriods);
        }

        public function get habboClubLevel():int
        {
            return (_habboClubLevel);
        }

        public function get isMinimailEnabled():Boolean
        {
            return (_isMinimailEnabled);
        }

        public function get config():ICoreConfiguration
        {
            return (_config);
        }

        public function get hasEffectOn():Boolean
        {
            return (_hasEffectOn);
        }

        public function get isDancing():Boolean
        {
            return (_isDancing);
        }

        public function set isDancing(_arg_1:Boolean):void
        {
            _isDancing = _arg_1;
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get unreadMiniMailMessageCount():int
        {
            return (handler.container.messenger.getUnseenMiniMailMessageCount());
        }


    }
}

