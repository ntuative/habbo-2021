package com.sulake.habbo.ui.widget.infostand
{
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components._SafeStr_124;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetGetBadgeDetailsMessage;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.IAvatarImageWidget;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.widgets.IBadgeImageWidget;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomTagSearchMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.habbo.communication.messages.incoming.users.RelationshipStatusInfo;
    import com.sulake.habbo.friendlist.RelationshipStatusEnum;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChangeMottoMessage;
    import com.sulake.core.window.components.ITextFieldWindow;
    import flash.utils.getTimer;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
    import com.sulake.habbo.tracking.HabboTracking;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenProfileMessage;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.ITextLinkWindow;
    import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;

    public class InfoStandUserView
    {

        protected static const LINK_COLOR_ACTIONS_DEFAULT:uint = 0xFFFFFF;
        protected static const LINK_COLOR_ACTIONS_HOVER:uint = 9552639;

        private const ITEM_SPACER:int = 5;
        private const MOTTO_TEXT_OFFSET:int = 3;
        private const MOTTO_EDITED_COLOR:int = 0xAAAAAA;
        private const MOTTO_UNCHANGED_COLOR:int = 0xFFFFFF;
        private const _SafeStr_4159:int = 2000;
        private const MAX_MOTTO_HEIGHT:int = 50;
        private const MIN_MOTTO_HEIGHT:int = 23;
        private const TOOLTIP_DELAY:int = 100;

        protected var _SafeStr_1324:InfoStandWidget;
        protected var _window:IItemListWindow;
        protected var _SafeStr_4145:IItemListWindow;
        protected var _SafeStr_4157:IItemListWindow;
        private var _SafeStr_1276:_SafeStr_124;
        private var _SafeStr_2910:TagListRenderer;
        private var _badgeDetails:_SafeStr_124;
        private var _SafeStr_4158:int;
        protected var _profileLinkRegion:IRegionWindow;

        public function InfoStandUserView(_arg_1:InfoStandWidget, _arg_2:String)
        {
            _SafeStr_1324 = _arg_1;
            createWindow(_arg_2);
            _SafeStr_2910 = new TagListRenderer(_arg_1, onTagSelected);
        }

        public function dispose():void
        {
            if (_profileLinkRegion)
            {
                _profileLinkRegion.dispose();
                _profileLinkRegion = null;
            };
            _SafeStr_1324 = null;
            _window.dispose();
            _window = null;
            _SafeStr_2910.dispose();
            _SafeStr_2910 = null;
            disposeBadgeDetails();
        }

        public function get window():IItemListWindow
        {
            return (_window);
        }

        protected function updateWindow():void
        {
            if (((_SafeStr_4145 == null) || (_SafeStr_1276 == null)))
            {
                return;
            };
            _SafeStr_4145.height = _SafeStr_4145.scrollableRegion.height;
            _SafeStr_1276.height = (_SafeStr_4145.height + 20);
            _window.width = _SafeStr_1276.width;
            _window.height = _window.scrollableRegion.height;
            _SafeStr_1324.refreshContainer();
        }

        protected function createWindow(_arg_1:String):void
        {
            var _local_8:BitmapDataAsset;
            var _local_7:BitmapData;
            var _local_3:IWindow;
            var _local_6:int;
            _window = (_SafeStr_1324.getXmlWindow("user_view") as IItemListWindow);
            if (_window == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
            _SafeStr_1276 = (_window.getListItemByName("info_border") as _SafeStr_124);
            if (_SafeStr_1276 != null)
            {
                _SafeStr_4145 = (_SafeStr_1276.findChildByName("infostand_element_list") as IItemListWindow);
                _SafeStr_4157 = (_SafeStr_1276.findChildByName("relationship_status_container") as IItemListWindow);
                _SafeStr_4157.visible = _SafeStr_1324.config.getBoolean("relationship.status.enabled");
                _SafeStr_1276.findChildByName("heart_randomusername").procedure = onRelationshipUserNameLinkClicked;
                _SafeStr_1276.findChildByName("smile_randomusername").procedure = onRelationshipUserNameLinkClicked;
                _SafeStr_1276.findChildByName("bobba_randomusername").procedure = onRelationshipUserNameLinkClicked;
            };
            _window.name = _arg_1;
            var _local_5:IBitmapWrapperWindow = (_SafeStr_1276.findChildByName("home_icon") as IBitmapWrapperWindow);
            if (_local_5 != null)
            {
                _local_5.bitmap = new BitmapData(_local_5.width, _local_5.height, true, 0);
                _local_8 = (_SafeStr_1324.assets.getAssetByName("icon_home") as BitmapDataAsset);
                _local_7 = (_local_8.content as BitmapData);
                _local_5.bitmap = new BitmapData(_local_5.width, _local_5.height, true, 0);
                _local_5.bitmap.copyPixels(_local_7, _local_7.rect, new Point(0, 0));
                _local_5.addEventListener("WME_CLICK", onButtonClicked);
            };
            _SafeStr_1324.mainContainer.addChild(_window);
            var _local_4:IWindow = _SafeStr_1276.findChildByTag("close");
            if (_local_4 != null)
            {
                _local_4.addEventListener("WME_CLICK", onClose);
            };
            _local_6 = 0;
            while (_local_6 < 5)
            {
                _local_3 = _SafeStr_1276.findChildByName(("badge_" + _local_6));
                if (_local_3 != null)
                {
                    _local_3.addEventListener("WME_OVER", showBadgeInfo);
                    _local_3.addEventListener("WME_OUT", hideBadgeInfo);
                };
                _local_6++;
            };
            _local_3 = _SafeStr_1276.findChildByName("badge_group");
            if (_local_3 != null)
            {
                _local_3.addEventListener("WME_CLICK", selectGroupBadge);
                _local_3.addEventListener("WME_OVER", showGroupBadgeInfo);
                _local_3.addEventListener("WME_OUT", hideGroupBadgeInfo);
            };
            var _local_2:IWindow = _SafeStr_1276.findChildByName("avatar_image_profile_link");
            if (_local_2 != null)
            {
                _local_2.procedure = onProfileLink;
            };
            if (_SafeStr_1324.handler.isActivityDisplayEnabled)
            {
                _SafeStr_1276.findChildByName("score_spacer").visible = true;
                _SafeStr_1276.findChildByName("score_value").visible = true;
                _SafeStr_1276.findChildByName("score_text").visible = true;
            };
        }

        private function selectGroupBadge(_arg_1:WindowMouseEvent):void
        {
            if (_SafeStr_1324.userData.groupId < 0)
            {
                return;
            };
            var _local_2:Boolean = (_SafeStr_1324.userData.type == "RWUIUE_OWN_USER");
            var _local_3:RoomWidgetGetBadgeDetailsMessage = new RoomWidgetGetBadgeDetailsMessage(_local_2, _SafeStr_1324.userData.groupId);
            _SafeStr_1324.messageListener.processWidgetMessage(_local_3);
        }

        private function showGroupBadgeInfo(_arg_1:WindowMouseEvent):void
        {
            if (_SafeStr_1324.userData.groupId < 0)
            {
                return;
            };
            createBadgeDetails();
            if (_arg_1.window == null)
            {
                return;
            };
            _badgeDetails.findChildByName("name").caption = _SafeStr_1324.userData.groupName;
            var _local_2:Rectangle = new Rectangle();
            _arg_1.window.getGlobalRectangle(_local_2);
            _badgeDetails.x = (_local_2.left - _badgeDetails.width);
            _badgeDetails.y = (_local_2.top + ((_local_2.height - _badgeDetails.height) / 2));
        }

        private function hideGroupBadgeInfo(_arg_1:WindowMouseEvent):void
        {
            disposeBadgeDetails();
        }

        private function showBadgeInfo(_arg_1:WindowMouseEvent):void
        {
            var _local_5:ITextWindow;
            if (_arg_1.window == null)
            {
                return;
            };
            var _local_6:int = int(_arg_1.window.name.replace("badge_", ""));
            if (_local_6 < 0)
            {
                return;
            };
            var _local_2:Array = _SafeStr_1324.userData.badges;
            if (_local_2 == null)
            {
                return;
            };
            if (_local_6 >= _local_2.length)
            {
                return;
            };
            var _local_3:String = _SafeStr_1324.userData.badges[_local_6];
            if (_local_3 == null)
            {
                return;
            };
            createBadgeDetails();
            _local_5 = (_badgeDetails.getChildByName("name") as ITextWindow);
            if (_local_5 != null)
            {
                _local_5.text = _SafeStr_1324.localizations.getBadgeName(_local_3);
            };
            _local_5 = (_badgeDetails.getChildByName("description") as ITextWindow);
            if (_local_5 != null)
            {
                _local_5.text = _SafeStr_1324.localizations.getBadgeDesc(_local_3);
                _badgeDetails.height = ((_local_5.text == "") ? 40 : 99);
            };
            var _local_4:Rectangle = new Rectangle();
            _arg_1.window.getGlobalRectangle(_local_4);
            _badgeDetails.x = (_local_4.left - _badgeDetails.width);
            _badgeDetails.y = (_local_4.top + ((_local_4.height - _badgeDetails.height) / 2));
        }

        private function hideBadgeInfo(_arg_1:WindowMouseEvent):void
        {
            disposeBadgeDetails();
        }

        private function createBadgeDetails():void
        {
            if (_badgeDetails != null)
            {
                return;
            };
            var _local_1:XmlAsset = (_SafeStr_1324.assets.getAssetByName("badge_details") as XmlAsset);
            if (_local_1 == null)
            {
                return;
            };
            _badgeDetails = (_SafeStr_1324.windowManager.buildFromXML((_local_1.content as XML)) as _SafeStr_124);
            if (_badgeDetails == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
        }

        private function disposeBadgeDetails():void
        {
            if (_badgeDetails != null)
            {
                _badgeDetails.dispose();
                _badgeDetails = null;
            };
        }

        private function onClose(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1324.close();
        }

        public function set name(_arg_1:String):void
        {
            if (_profileLinkRegion == null)
            {
                _profileLinkRegion = (_SafeStr_4145.getListItemByName("profile_link") as IRegionWindow);
                if (_profileLinkRegion == null)
                {
                    return;
                };
                _profileLinkRegion.procedure = onProfileLink;
                _profileLinkRegion.visible = true;
            };
            var _local_2:ITextWindow = (_profileLinkRegion.findChildByName("name_text") as ITextWindow);
            if (_local_2 == null)
            {
                return;
            };
            _local_2.text = _arg_1;
            _local_2.visible = true;
        }

        public function set realName(_arg_1:String):void
        {
            var _local_2:ITextWindow = (_SafeStr_4145.getListItemByName("realname_text") as ITextWindow);
            if (_local_2 == null)
            {
                return;
            };
            if (_arg_1.length == 0)
            {
                _local_2.text = "";
            }
            else
            {
                _SafeStr_1324.localizations.registerParameter("infostand.text.realname", "realname", _arg_1);
                _local_2.text = _SafeStr_1324.localizations.getLocalization("infostand.text.realname");
            };
            _local_2.height = (_local_2.textHeight + 5);
            _local_2.visible = (_arg_1.length > 0);
        }

        public function setFigure(_arg_1:String):void
        {
            var _local_2:IAvatarImageWidget = (IWidgetWindow(_SafeStr_1276.findChildByName("avatar_image")).widget as IAvatarImageWidget);
            _local_2.figure = _arg_1;
        }

        public function setMotto(_arg_1:String, _arg_2:Boolean):void
        {
            var _local_7:IWindowContainer = (_SafeStr_4145.getListItemByName("motto_container") as IWindowContainer);
            if (!_local_7)
            {
                return;
            };
            var _local_3:IWindow = _local_7.findChildByName("changemotto.image");
            var _local_6:ITextWindow = (_local_7.findChildByName("motto_text") as ITextWindow);
            var _local_5:IWindowContainer = (_SafeStr_4145.getListItemByName("motto_spacer") as IWindowContainer);
            if (((_local_6 == null) || (_local_5 == null)))
            {
                return;
            };
            if (_arg_1 == null)
            {
                _arg_1 = "";
            };
            if (_arg_2)
            {
                _local_3.visible = true;
                if (_arg_1 == "")
                {
                    _arg_1 = _SafeStr_1324.localizations.getLocalization("infostand.motto.change");
                    _local_6.textColor = 0xAAAAAA;
                }
                else
                {
                    _local_6.textColor = 0xFFFFFF;
                };
                _local_6.enable();
            }
            else
            {
                _local_3.visible = false;
                _local_6.textColor = 0xFFFFFF;
                _local_6.disable();
            };
            if (!_SafeStr_1324.config.getBoolean("infostand.motto.change.enabled"))
            {
                _local_6.disable();
            };
            _local_6.text = _arg_1;
            _local_6.height = Math.min((_local_6.textHeight + 5), 50);
            _local_6.height = Math.max(_local_6.height, 23);
            _local_7.height = (_local_6.height + 3);
            if (_arg_2)
            {
                _local_6.addEventListener("WKE_KEY_UP", onMottoKeyboard);
                _local_6.addEventListener("WME_CLICK", onMottoClicked);
            }
            else
            {
                _local_6.removeEventListener("WKE_KEY_UP", onMottoClicked);
            };
            var _local_4:Boolean = ((_local_6.text) && (_local_6.text.toLowerCase().indexOf("crikey") >= 0));
            if (_SafeStr_1276)
            {
                _SafeStr_1276.findChildByName("sticker_croco").visible = _local_4;
                _SafeStr_1276.findChildByName("avatar_image").visible = (!(_local_4));
            };
            updateWindow();
        }

        public function set achievementScore(_arg_1:int):void
        {
            if (!_SafeStr_1324.handler.isActivityDisplayEnabled)
            {
                return;
            };
            var _local_2:ITextWindow = (_SafeStr_4145.getListItemByName("score_value") as ITextWindow);
            if (_local_2 == null)
            {
                return;
            };
            _local_2.text = String(_arg_1);
        }

        public function set carryItem(_arg_1:int):void
        {
            var _local_2:String;
            var _local_6:ITextWindow = (_SafeStr_4145.getListItemByName("handitem_txt") as ITextWindow);
            var _local_3:IWindowContainer = (_SafeStr_4145.getListItemByName("handitem_spacer") as IWindowContainer);
            if (((_local_6 == null) || (_local_3 == null)))
            {
                return;
            };
            if (((_arg_1 > 0) && (_arg_1 < 999999)))
            {
                _local_2 = _SafeStr_1324.localizations.getLocalization(("handitem" + _arg_1), ("handitem" + _arg_1));
                _SafeStr_1324.localizations.registerParameter("infostand.text.handitem", "item", _local_2);
            };
            _local_6.height = (_local_6.textHeight + 5);
            var _local_4:Boolean = _local_6.visible;
            var _local_5:Boolean = ((_arg_1 > 0) && (_arg_1 < 999999));
            _local_6.visible = _local_5;
            _local_3.visible = _local_5;
            if (_local_5 != _local_4)
            {
                _SafeStr_4145.arrangeListItems();
            };
            updateWindow();
        }

        public function set xp(_arg_1:int):void
        {
            var _local_5:ITextWindow = (_SafeStr_4145.getListItemByName("xp_text") as ITextWindow);
            var _local_2:IWindowContainer = (_SafeStr_4145.getListItemByName("xp_spacer") as IWindowContainer);
            if (((_local_5 == null) || (_local_2 == null)))
            {
                return;
            };
            _SafeStr_1324.localizations.registerParameter("infostand.text.xp", "xp", _arg_1.toString());
            _local_5.height = (_local_5.textHeight + 5);
            var _local_3:Boolean = _local_5.visible;
            var _local_4:Boolean = (_arg_1 > 0);
            _local_5.visible = _local_4;
            _local_2.visible = _local_4;
            if (_local_4 != _local_3)
            {
                _SafeStr_4145.arrangeListItems();
            };
            updateWindow();
        }

        public function setBadge(_arg_1:int, _arg_2:String):void
        {
            var _local_3:IBadgeImageWidget = (IWidgetWindow(_SafeStr_1276.findChildByName(("badge_" + _arg_1))).widget as IBadgeImageWidget);
            _local_3.badgeId = _arg_2;
        }

        public function clearBadges():void
        {
            var _local_2:int;
            var _local_1:IBadgeImageWidget;
            _local_2 = 0;
            while (_local_2 < 5)
            {
                _local_1 = (IWidgetWindow(_SafeStr_1276.findChildByName(("badge_" + _local_2))).widget as IBadgeImageWidget);
                _local_1.badgeId = "";
                _local_2++;
            };
        }

        public function clearGroupBadge():void
        {
            var _local_1:IBadgeImageWidget = (IWidgetWindow(_SafeStr_1276.findChildByName("badge_group")).widget as IBadgeImageWidget);
            _local_1.badgeId = "";
        }

        public function setGroupBadge(_arg_1:String):void
        {
            var _local_2:IBadgeImageWidget = (IWidgetWindow(_SafeStr_1276.findChildByName("badge_group")).widget as IBadgeImageWidget);
            _local_2.badgeId = _arg_1;
        }

        private function onTagSelected(_arg_1:WindowMouseEvent):void
        {
            var _local_2:ITextWindow = (_arg_1.target as ITextWindow);
            if (_local_2 == null)
            {
                return;
            };
            _SafeStr_1324.messageListener.processWidgetMessage(new RoomWidgetRoomTagSearchMessage(_local_2.text));
        }

        public function update(_arg_1:RoomWidgetUserInfoUpdateEvent):void
        {
            clearBadges();
            clearGroupBadge();
            setGroupBadge(_arg_1.groupBadgeId);
            updateInfo(_arg_1);
        }

        public function setRelationshipStatuses(_arg_1:Map):void
        {
            var _local_5:String;
            var _local_2:IWindow;
            var _local_3:RelationshipStatusInfo;
            var _local_7:String;
            var _local_6:IWindow;
            if (((!(_SafeStr_1276)) || (!(_SafeStr_1324))))
            {
                return;
            };
            for each (var _local_4:int in RelationshipStatusEnum.displayableStatuses)
            {
                _local_5 = RelationshipStatusEnum.statusAsString(_local_4);
                _local_2 = _SafeStr_1276.findChildByName(("relationship_" + _local_5));
                _local_3 = _arg_1.getValue(_local_4);
                if (_local_3)
                {
                    _local_2.visible = (_local_3.friendCount > 0);
                    _local_7 = (_local_5 + "_randomusername");
                    _local_6 = _SafeStr_1276.findChildByName(_local_7);
                    if (_local_6)
                    {
                        _local_6.caption = _local_3.randomFriendName;
                        _local_6.id = _local_3.randomFriendId;
                    };
                    _SafeStr_1276.findChildByName((_local_5 + "_others")).visible = (_local_3.friendCount > 1);
                    _SafeStr_1324.localizations.registerParameter((("infostand.relstatus." + _local_5) + ".others"), "amount", (_local_3.friendCount - 1).toString());
                }
                else
                {
                    _local_2.visible = false;
                };
            };
        }

        protected function updateInfo(_arg_1:RoomWidgetUserInfoUpdateEvent):void
        {
            name = _arg_1.name;
            setMotto(_arg_1.motto, (_arg_1.type == "RWUIUE_OWN_USER"));
            achievementScore = _arg_1.achievementScore;
            carryItem = _arg_1.carryItem;
            xp = _arg_1.xp;
            setFigure(_arg_1.figure);
        }

        protected function onMottoKeyboard(_arg_1:WindowKeyboardEvent):void
        {
            var _local_5:RoomWidgetChangeMottoMessage;
            var _local_2:int;
            var _local_6:int;
            var _local_7:IWindowContainer = (_SafeStr_4145.getListItemByName("motto_container") as IWindowContainer);
            if (!_local_7)
            {
                return;
            };
            var _local_4:ITextFieldWindow = (_local_7.findChildByName("motto_text") as ITextFieldWindow);
            var _local_3:String = _local_4.text;
            if (_arg_1.keyCode == 13)
            {
                _local_2 = getTimer();
                if ((((_local_2 - _SafeStr_4158) > 2000) && (!(_local_3 == _SafeStr_1324.localizations.getLocalization("infostand.motto.change")))))
                {
                    _local_6 = _SafeStr_1324.userData.userId;
                    _local_5 = new RoomWidgetChangeMottoMessage(_local_3);
                    _SafeStr_1324.messageListener.processWidgetMessage(_local_5);
                    _SafeStr_4158 = _local_2;
                    _local_4.textColor = 0xFFFFFF;
                    _local_4.unfocus();
                };
            }
            else
            {
                _local_4.textColor = 0xAAAAAA;
            };
            _local_4.height = Math.min((_local_4.textHeight + 5), 50);
            _local_4.height = Math.max(_local_4.height, 23);
            _local_7.height = (_local_4.height + 3);
        }

        protected function onMottoClicked(_arg_1:WindowMouseEvent):void
        {
            var _local_3:IWindowContainer = (_SafeStr_4145.getListItemByName("motto_container") as IWindowContainer);
            if (!_local_3)
            {
                return;
            };
            var _local_2:ITextWindow = (_local_3.findChildByName("motto_text") as ITextWindow);
            if (_local_2.text == _SafeStr_1324.localizations.getLocalization("infostand.motto.change"))
            {
                _local_2.text = "";
            };
            _local_2.textColor = 0xAAAAAA;
        }

        protected function onButtonClicked(_arg_1:WindowMouseEvent):void
        {
            var _local_3:RoomWidgetMessage;
            var _local_4:String;
            var _local_2:IWindow = (_arg_1.target as IWindow);
            switch (_local_2.name)
            {
                case "home_icon":
                    _local_4 = "RWUAM_OPEN_HOME_PAGE";
            };
            if (_local_4 != null)
            {
                _local_3 = new RoomWidgetUserActionMessage(_local_4, _SafeStr_1324.userData.userId);
                HabboTracking.getInstance().trackEventLog("InfoStand", "click", _local_4);
            };
            if (_local_3 != null)
            {
                _SafeStr_1324.messageListener.processWidgetMessage(_local_3);
            };
            updateWindow();
        }

        protected function onProfileLink(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:ITextWindow;
            if (_arg_1.type == "WME_CLICK")
            {
                _SafeStr_1324.messageListener.processWidgetMessage(new RoomWidgetOpenProfileMessage("RWOPEM_OPEN_USER_PROFILE", _SafeStr_1324.userData.userId, "infoStand_userView"));
            };
            if (_arg_2.name == "profile_link")
            {
                if (_arg_1.type == "WME_OVER")
                {
                    _local_3 = (_profileLinkRegion.findChildByName("name_text") as ITextWindow);
                    _local_3.textColor = 9552639;
                };
                if (_arg_1.type == "WME_OUT")
                {
                    _local_3 = (_profileLinkRegion.findChildByName("name_text") as ITextWindow);
                    _local_3.textColor = 0xFFFFFF;
                };
            };
        }

        private function onRelationshipUserNameLinkClicked(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((_arg_1.type == "WME_CLICK") && (_arg_2 is ITextLinkWindow)))
            {
                _SafeStr_1324.handler.container.connection.send(new GetExtendedProfileMessageComposer(_arg_2.id));
            };
        }


    }
}