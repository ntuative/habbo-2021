package com.sulake.habbo.ui.widget.avatarinfo
{
    import com.sulake.habbo.ui.widget.contextmenu.IContextMenuParentWidget;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.tracking.HabboTracking;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChangePostureMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetAvatarExpressionMessage;
    import com.sulake.habbo.ui.widget.enums.AvatarExpressionEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetDanceMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenProfileMessage;

    public class OwnAvatarMenuView extends AvatarContextInfoButtonView 
    {

        private static const MODE_NORMAL:int = 0;
        private static const MODE_CLUB_DANCES:int = 1;
        private static const MODE_NAME_CHANGE:int = 2;
        private static const MODE_EXPRESSIONS:int = 3;
        private static const MODE_SIGNS:int = 4;
        private static const MODE_CHANGE_LOOKS:int = 5;

        private static var _SafeStr_3934:Boolean = false;

        private var _SafeStr_690:AvatarInfoData;
        private var _SafeStr_1493:int;

        public function OwnAvatarMenuView(_arg_1:AvatarInfoWidget)
        {
            super((_arg_1 as IContextMenuParentWidget));
            _SafeStr_3885 = false;
        }

        public static function setup(_arg_1:OwnAvatarMenuView, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:int, _arg_6:AvatarInfoData):void
        {
            _arg_1._SafeStr_690 = _arg_6;
            if ((((!(_SafeStr_3934)) && (_arg_1.widget.configuration.getInteger("new.identity", 0) > 0)) && (_arg_1.widget.configuration.getBoolean("new.user.reception.enabled"))))
            {
                _arg_1._SafeStr_1493 = 0;
                OwnAvatarMenuView._SafeStr_3934 = true;
            }
            else
            {
                if ((((_arg_1.widget.isDancing) && (_arg_1.widget.hasClub)) && (!(_arg_1.widget.hasEffectOn))))
                {
                    _arg_1._SafeStr_1493 = 1;
                }
                else
                {
                    if (((_arg_6.allowNameChange) && (_arg_1.widget.useMinimizedOwnAvatarMenu)))
                    {
                        _arg_1._SafeStr_1493 = 2;
                    }
                    else
                    {
                        _arg_1._SafeStr_1493 = 0;
                    };
                };
            };
            AvatarContextInfoButtonView.setup(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, false);
        }


        override public function dispose():void
        {
            _SafeStr_690 = null;
            super.dispose();
        }

        override protected function updateWindow():void
        {
            var _local_1:XML;
            var _local_4:IItemGridWindow;
            var _local_3:IIterator;
            var _local_5:int;
            var _local_6:int;
            var _local_8:IWindowContainer;
            var _local_2:IWindowContainer;
            var _local_7:IRegionWindow;
            if ((((!(_SafeStr_1324)) || (!(_SafeStr_1324.assets))) || (!(_SafeStr_1324.windowManager))))
            {
                return;
            };
            if (_SafeStr_2776)
            {
                activeView = getMinimizedView();
            }
            else
            {
                if (!_window)
                {
                    _local_1 = (XmlAsset(_SafeStr_1324.assets.getAssetByName("own_avatar_menu")).content as XML);
                    _window = (_SafeStr_1324.windowManager.buildFromXML(_local_1, 0) as IWindowContainer);
                    if (!_window)
                    {
                        return;
                    };
                    _window.addEventListener("WME_OVER", onMouseHoverEvent);
                    _window.addEventListener("WME_OUT", onMouseHoverEvent);
                    _window.findChildByName("minimize").addEventListener("WME_CLICK", onMinimize);
                    _window.findChildByName("minimize").addEventListener("WME_OVER", onMinimizeHover);
                    _window.findChildByName("minimize").addEventListener("WME_OUT", onMinimizeHover);
                };
                _buttons = (_window.findChildByName("buttons") as IItemListWindow);
                _buttons.procedure = buttonEventProc;
                _local_4 = (_window.findChildByName("signs_grid") as IItemGridWindow);
                _local_3 = _local_4.iterator;
                _local_5 = _local_3.length;
                _local_6 = 0;
                while (_local_6 < _local_5)
                {
                    _local_8 = (_local_3[_local_6] as IWindowContainer);
                    _local_2 = (_local_8.findChildByName("button") as IWindowContainer);
                    _local_2.procedure = gridEventProc;
                    _local_6++;
                };
                _local_7 = (_window.findChildByName("profile_link") as IRegionWindow);
                if (_local_7)
                {
                    _local_7.procedure = buttonEventProc;
                    _local_7.toolTipCaption = widget.localizations.getLocalization("infostand.profile.link.tooltip", "Click to view profile");
                    _local_7.toolTipDelay = 100;
                };
                _window.findChildByName("name").caption = _userName;
                _window.visible = false;
                activeView = _window;
                updateButtons();
            };
        }

        public function updateButtons():void
        {
            var _local_4:int;
            var _local_1:Boolean;
            var _local_2:Boolean;
            if ((((!(_window)) || (!(_SafeStr_690))) || (!(_buttons))))
            {
                return;
            };
            _buttons.autoArrangeItems = false;
            var _local_3:int = _buttons.numListItems;
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _buttons.getListItemAt(_local_4).visible = false;
                _local_4++;
            };
            var _local_5:Boolean = widget.isCurrentUserRiding;
            switch (_SafeStr_1493)
            {
                case 0:
                    showButton("change_name", _SafeStr_690.allowNameChange);
                    showButton("decorate", ((decorateModeSupported()) && ((_SafeStr_690.myRoomControllerLevel >= 1) || (_SafeStr_690.amIOwner))));
                    showButton("change_looks");
                    showButton("dance_menu", ((widget.hasClub) && (!(_local_5))), (!(widget.hasEffectOn)));
                    showButton("dance", (((!(widget.hasClub)) && (!(widget.isDancing))) && (!(_local_5))), (!(widget.hasEffectOn)));
                    showButton("dance_stop", (((!(widget.hasClub)) && (widget.isDancing)) && (!(_local_5))));
                    if (!(_SafeStr_1324.windowManager as Component).getBoolean("memenu.effects.widget.disabled"))
                    {
                        showButton("effects", (!(_local_5)));
                    };
                    showButton("handitem", (((_SafeStr_690.carryItemType > 0) && (_SafeStr_690.carryItemType < 999999)) && (widget.configuration.getBoolean("handitem.drop.enabled"))));
                    _local_1 = widget.configuration.getBoolean("avatar.expressions_menu.enabled");
                    showButton(((_local_1) ? "expressions" : "wave"));
                    _local_2 = widget.configuration.getBoolean("avatar.signs.enabled");
                    showButton("signs", _local_2);
                    break;
                case 1:
                    showButton("dance_stop", true, widget.isDancing);
                    showButton("dance_1");
                    showButton("dance_2");
                    showButton("dance_3");
                    showButton("dance_4");
                    showButton("back");
                    break;
                case 2:
                    showButton("change_name");
                    showButton("more");
                    break;
                case 5:
                    showButton("change_looks");
                    showButton("more");
                    break;
                case 3:
                    showButton("wave", true, (!(widget.isSwimming)));
                    showButton("laugh", true, (((!(widget.hasEffectOn)) && (!(widget.isSwimming))) && (widget.hasVip)), (!(widget.hasVip)));
                    showButton("blow", true, (((!(widget.hasEffectOn)) && (!(widget.isSwimming))) && (widget.hasVip)), (!(widget.hasVip)));
                    showButton("idle", true);
                    if ((((widget.configuration.getBoolean("avatar.sitting.enabled")) && (!(widget.isSwimming))) && (!(_local_5))))
                    {
                        showButton("sit", (widget.ownAvatarPosture == "std"));
                        showButton("stand", widget.canStandUp);
                    };
                    showButton("back");
                    break;
                case 4:
                    showButtonGrid("signs_grid");
                    showButton("back");
                default:
            };
            _buttons.autoArrangeItems = true;
            _buttons.visible = true;
        }

        private function gridEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_7:String;
            var _local_3:String;
            var _local_6:String;
            var _local_5:int;
            if (disposed)
            {
                return;
            };
            if (((!(_window)) || (_window.disposed)))
            {
                return;
            };
            var _local_4:Boolean;
            if (_arg_1.type == "WME_CLICK")
            {
                if (_arg_2.name == "button")
                {
                    _local_4 = true;
                    _local_7 = "_";
                    _local_3 = ((_arg_2.parent.name) ? _arg_2.parent.name : "");
                    _local_6 = _local_3.substr(0, _local_3.lastIndexOf(_local_7));
                    _local_5 = parseInt(_local_3.substr((_local_3.lastIndexOf(_local_7) + 1)));
                    switch (_local_6)
                    {
                        case "sign":
                            widget.sendSignRequest(_local_5);
                            HabboTracking.getInstance().trackEventLog("OwnAvatarMenu", "click", "sign", null, _local_5);
                    };
                };
            }
            else
            {
                super.buttonEventProc(_arg_1, _arg_2);
            };
            if (_local_4)
            {
                _SafeStr_1324.removeView(this, false);
            };
        }

        override protected function buttonEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:RoomWidgetMessage;
            var _local_5:IWindow;
            if (disposed)
            {
                return;
            };
            if (((!(_window)) || (_window.disposed)))
            {
                return;
            };
            var _local_3:Boolean;
            if (_arg_1.type == "WME_CLICK")
            {
                if (_arg_2.name == "button")
                {
                    _local_5 = (_arg_2 as IWindowContainer).getChildByName("icon_vip");
                    if ((((!(_local_5 == null)) && (_local_5.visible)) && (!(widget.hasVip))))
                    {
                        _SafeStr_1324.catalog.openClubCenter();
                        return;
                    };
                    _local_3 = true;
                    switch (_arg_2.parent.name)
                    {
                        case "change_name":
                            _local_4 = new RoomWidgetUserActionMessage("RWUAM_START_NAME_CHANGE");
                            break;
                        case "decorate":
                            if (decorateModeSupported())
                            {
                                widget.isUserDecorating = true;
                            };
                            break;
                        case "change_looks":
                            widget.openAvatarEditor();
                            HabboTracking.getInstance().trackEventLog("OwnAvatarMenu", "click", "clothes");
                            break;
                        case "expressions":
                            _local_3 = false;
                            changeMode(3);
                            break;
                        case "sit":
                            _local_4 = new RoomWidgetChangePostureMessage(1);
                            HabboTracking.getInstance().trackEventLog("OwnAvatarMenu", "click", "sit");
                            break;
                        case "stand":
                            _local_4 = new RoomWidgetChangePostureMessage(0);
                            HabboTracking.getInstance().trackEventLog("OwnAvatarMenu", "click", "stand");
                            break;
                        case "wave":
                            _local_4 = new RoomWidgetAvatarExpressionMessage(AvatarExpressionEnum.WAVE);
                            HabboTracking.getInstance().trackEventLog("OwnAvatarMenu", "click", "wave");
                            break;
                        case "blow":
                            _local_4 = new RoomWidgetAvatarExpressionMessage(AvatarExpressionEnum.BLOW);
                            HabboTracking.getInstance().trackEventLog("OwnAvatarMenu", "click", "blow");
                            break;
                        case "jump":
                            break;
                        case "laugh":
                            _local_4 = new RoomWidgetAvatarExpressionMessage(AvatarExpressionEnum.LAUGH);
                            HabboTracking.getInstance().trackEventLog("OwnAvatarMenu", "click", "laugh");
                            break;
                        case "idle":
                            _local_4 = new RoomWidgetAvatarExpressionMessage(AvatarExpressionEnum._SafeStr_592);
                            HabboTracking.getInstance().trackEventLog("OwnAvatarMenu", "click", "idle");
                            break;
                        case "dance_menu":
                            _local_3 = false;
                            changeMode(1);
                            break;
                        case "dance":
                            _local_4 = new RoomWidgetDanceMessage(1);
                            HabboTracking.getInstance().trackEventLog("OwnAvatarMenu", "click", "dance_start");
                            break;
                        case "dance_stop":
                            _local_4 = new RoomWidgetDanceMessage(0);
                            HabboTracking.getInstance().trackEventLog("OwnAvatarMenu", "click", "dance_stop");
                            break;
                        case "dance_1":
                        case "dance_2":
                        case "dance_3":
                        case "dance_4":
                            _local_4 = new RoomWidgetDanceMessage(parseInt(_arg_2.parent.name.charAt((_arg_2.parent.name.length - 1))));
                            HabboTracking.getInstance().trackEventLog("OwnAvatarMenu", "click", "dance_start");
                            break;
                        case "effects":
                            _local_4 = new RoomWidgetRequestWidgetMessage("RWRWM_EFFECTS");
                            HabboTracking.getInstance().trackEventLog("OwnAvatarMenu", "click", "effects");
                            break;
                        case "signs":
                            _local_3 = false;
                            changeMode(4);
                            break;
                        case "back":
                            _local_3 = false;
                            changeMode(0);
                            break;
                        case "more":
                            _local_3 = false;
                            widget.useMinimizedOwnAvatarMenu = false;
                            changeMode(0);
                            break;
                        case "handitem":
                            _local_4 = new RoomWidgetUserActionMessage("RWUAM_DROP_CARRY_ITEM", _SafeStr_1887);
                    };
                };
                if (_arg_2.name == "profile_link")
                {
                    _local_3 = true;
                    _local_4 = new RoomWidgetOpenProfileMessage("RWOPEM_OPEN_USER_PROFILE", userId, "ownAvatarContextMenu");
                };
                if (_local_4)
                {
                    _SafeStr_1324.messageListener.processWidgetMessage(_local_4);
                };
            }
            else
            {
                super.buttonEventProc(_arg_1, _arg_2);
            };
            if (((_local_3) && (!(_disposed))))
            {
                _SafeStr_1324.removeView(this, false);
            };
        }

        private function get widget():AvatarInfoWidget
        {
            return (_SafeStr_1324 as AvatarInfoWidget);
        }

        private function changeMode(_arg_1:int):void
        {
            _SafeStr_1493 = _arg_1;
            updateButtons();
        }

        private function decorateModeSupported():Boolean
        {
            return (widget.hasClub);
        }


    }
}

