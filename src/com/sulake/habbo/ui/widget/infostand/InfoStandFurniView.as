package com.sulake.habbo.ui.widget.infostand
{
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components._SafeStr_124;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.habbo.tracking.HabboTracking;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.core.window.components.ITextWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.utils.FriendlyTime;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniActionMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetGetBadgeDetailsMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenProfileMessage;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.habbo.utils.FurniId;
    import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.ILimitedItemPreviewOverlayWidget;
    import com.sulake.habbo.room.IStuffData;
    import com.sulake.habbo.window.widgets.IRarityItemPreviewOverlayWidget;
    import com.sulake.habbo.window.widgets.IBadgeImageWidget;

    public class InfoStandFurniView 
    {

        private static const _SafeStr_4147:int = -12345678;

        private const _SafeStr_4146:int = 0;
        private const _SafeStr_4152:int = 1;
        private const _SafeStr_4153:int = 2;

        protected var _window:IItemListWindow;
        protected var _SafeStr_4148:IWindowContainer;
        protected var _SafeStr_4149:IWindow;
        protected var _SafeStr_1276:_SafeStr_124;
        protected var _buttons:IItemListWindow;
        protected var _catalog:IHabboCatalog;
        protected var _habboTracking:IHabboTracking;
        protected var _catalogButton:IWindow;
        protected var _rentButton:IWindow;
        protected var _extendButton:IWindow;
        protected var _buyoutButton:IWindow;
        private var _SafeStr_4150:int = _SafeStr_4146;
        private var _SafeStr_4151:int = 0;
        protected var _SafeStr_1324:InfoStandWidget;
        protected var _SafeStr_4145:IItemListWindow;

        public function InfoStandFurniView(_arg_1:InfoStandWidget, _arg_2:String, _arg_3:IHabboCatalog)
        {
            _SafeStr_1324 = _arg_1;
            _catalog = _arg_3;
            _habboTracking = HabboTracking.getInstance();
            createWindow(_arg_2);
        }

        public function dispose():void
        {
            _catalog = null;
            _SafeStr_1324 = null;
            _window.dispose();
            _window = null;
        }

        public function get window():IItemListWindow
        {
            return (_window);
        }

        protected function createWindow(_arg_1:String):void
        {
            var _local_2:IWindow;
            var _local_5:int;
            var _local_4:XmlAsset = (_SafeStr_1324.assets.getAssetByName("furni_view") as XmlAsset);
            _window = (_SafeStr_1324.windowManager.buildFromXML((_local_4.content as XML)) as IItemListWindow);
            if (_window == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
            _SafeStr_1276 = (_window.getListItemByName("info_border") as _SafeStr_124);
            _buttons = (_window.getListItemByName("button_list") as IItemListWindow);
            _SafeStr_4148 = (_window.getListItemByName("custom_variables") as IWindowContainer);
            if (!_SafeStr_1324.handler.container.sessionDataManager.hasSecurity(5))
            {
                _SafeStr_4148.dispose();
                _SafeStr_4148 = null;
            };
            if (_SafeStr_4148 != null)
            {
                _SafeStr_4148.procedure = customVarsWindowProcedure;
                _SafeStr_4149 = IItemListWindow(_SafeStr_4148.findChildByName("variable_list")).removeListItemAt(0);
            };
            if (_SafeStr_1276 != null)
            {
                _SafeStr_4145 = (_SafeStr_1276.findChildByName("infostand_element_list") as IItemListWindow);
            };
            _window.name = _arg_1;
            _SafeStr_1324.mainContainer.addChild(_window);
            var _local_3:IWindow = _SafeStr_1276.findChildByTag("close");
            if (_local_3 != null)
            {
                _local_3.addEventListener("WME_CLICK", onClose);
            };
            if (_buttons != null)
            {
                _local_5 = 0;
                while (_local_5 < _buttons.numListItems)
                {
                    _local_2 = _buttons.getListItemAt(_local_5);
                    _local_2.addEventListener("WME_CLICK", onButtonClicked);
                    _local_5++;
                };
            };
            _catalogButton = _SafeStr_1276.findChildByTag("catalog");
            if (_catalogButton != null)
            {
                _catalogButton.addEventListener("WME_CLICK", onCatalogButtonClicked);
            };
            _rentButton = _SafeStr_1276.findChildByName("rent_button");
            if (_rentButton != null)
            {
                _rentButton.addEventListener("WME_CLICK", onRentButtonClicked);
            };
            _extendButton = _SafeStr_1276.findChildByName("extend_button");
            if (_extendButton != null)
            {
                _extendButton.addEventListener("WME_CLICK", onExtendButtonClicked);
            };
            _buyoutButton = _SafeStr_1276.findChildByName("buyout_button");
            if (_buyoutButton != null)
            {
                _buyoutButton.addEventListener("WME_CLICK", onBuyoutButtonClicked);
            };
            var _local_6:IRegionWindow = (_SafeStr_4145.getListItemByName("owner_region") as IRegionWindow);
            if (_local_6 != null)
            {
                _local_6.addEventListener("WME_CLICK", onOwnerRegion);
                _local_6.addEventListener("WME_OVER", onOwnerRegion);
                _local_6.addEventListener("WME_OUT", onOwnerRegion);
            };
            var _local_7:IWindow = _SafeStr_1276.findChildByName("group_details_container");
            if (_local_7)
            {
                _local_7.addEventListener("WME_CLICK", onGroupInfoClicked);
            };
        }

        private function customVarsWindowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_5:Map;
            var _local_3:IItemListWindow;
            var _local_4:int;
            var _local_6:IWindowContainer;
            if (((!(_arg_1.type == "WME_CLICK")) || (!(!(_SafeStr_4148 == null)))))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "set_values":
                    _local_5 = new Map();
                    _local_3 = (_SafeStr_4148.findChildByName("variable_list") as IItemListWindow);
                    _local_4 = 0;
                    while (_local_4 < _local_3.numListItems)
                    {
                        _local_6 = (_local_3.getListItemAt(_local_4) as IWindowContainer);
                        _local_5[_local_6.name] = _local_6.findChildByName("value").caption;
                        _local_4++;
                    };
                    _SafeStr_1324.handler.setObjectData(_local_5);
                    return;
            };
        }

        protected function onBuyoutButtonClicked(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IFurnitureData;
            if ((((!(_catalog == null)) && (_SafeStr_1324)) && (_SafeStr_1324.furniData)))
            {
                _local_2 = getFurnitureData(_SafeStr_1324.furniData);
                if (_local_2)
                {
                    _catalog.openRentConfirmationWindow(_local_2, true, _SafeStr_1324.furniData.id);
                };
            };
        }

        protected function onExtendButtonClicked(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IFurnitureData;
            if ((((!(_catalog == null)) && (_SafeStr_1324)) && (_SafeStr_1324.furniData)))
            {
                _local_2 = getFurnitureData(_SafeStr_1324.furniData);
                if (_local_2)
                {
                    _catalog.openRentConfirmationWindow(_local_2, false, _SafeStr_1324.furniData.id);
                };
            };
        }

        private function getRoomObject(_arg_1:int):IRoomObject
        {
            var _local_3:int = _SafeStr_1324.handler.container.roomSession.roomId;
            var _local_2:IRoomObject = _SafeStr_1324.handler.container.roomEngine.getRoomObject(_local_3, _arg_1, 10);
            if (_local_2 == null)
            {
                _local_2 = _SafeStr_1324.handler.container.roomEngine.getRoomObject(_local_3, _arg_1, 20);
            };
            return (_local_2);
        }

        private function getFurnitureData(_arg_1:InfoStandFurniData):IFurnitureData
        {
            var _local_4:IFurnitureData;
            var _local_2:IRoomObject = getRoomObject(_arg_1.id);
            if (_local_2 == null)
            {
                return (null);
            };
            var _local_3:Boolean = (_SafeStr_1324.furniData.category == 20);
            var _local_5:int = _local_2.getModel().getNumber("furniture_type_id");
            if (_local_3)
            {
                _local_4 = _SafeStr_1324.handler.container.sessionDataManager.getWallItemData(_local_5);
            }
            else
            {
                _local_4 = _SafeStr_1324.handler.container.sessionDataManager.getFloorItemData(_local_5);
            };
            return (_local_4);
        }

        protected function onRentButtonClicked(_arg_1:WindowMouseEvent):void
        {
            if (_catalog != null)
            {
                _catalog.openCatalogPageByOfferId(_SafeStr_1324.furniData.rentOfferId, "NORMAL");
            };
        }

        protected function onClose(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1324.close();
        }

        public function set name(_arg_1:String):void
        {
            var _local_2:ITextWindow = (_SafeStr_4145.getListItemByName("name_text") as ITextWindow);
            if (_local_2 == null)
            {
                return;
            };
            _local_2.text = _arg_1;
            _local_2.visible = true;
            _local_2.height = (_local_2.textHeight + 5);
            updateWindow();
        }

        public function set furniImage(_arg_1:BitmapData):void
        {
            setImage(_arg_1, "image");
        }

        private function setImage(_arg_1:BitmapData, _arg_2:String):void
        {
            var _local_3:IBitmapWrapperWindow = (_SafeStr_1276.findChildByName(_arg_2) as IBitmapWrapperWindow);
            if (_local_3 == null)
            {
                return;
            };
            if (_arg_1 == null)
            {
                _arg_1 = new BitmapData(_local_3.width, 40, true);
            };
            _local_3.height = Math.min(_arg_1.height, 200);
            _local_3.bitmap = _arg_1.clone();
            _local_3.visible = true;
            updateWindow();
        }

        public function set description(_arg_1:String):void
        {
            var _local_2:ITextWindow = (_SafeStr_4145.getListItemByName("description_text") as ITextWindow);
            if (_local_2 == null)
            {
                return;
            };
            _local_2.text = _arg_1;
            _local_2.height = (_local_2.textHeight + 5);
            updateWindow();
        }

        public function setOwnerInfo(_arg_1:int, _arg_2:String):void
        {
            var _local_4:IRegionWindow;
            var _local_5:ITextWindow;
            var _local_3:IWindow;
            var _local_6:IWindow;
            _SafeStr_4151 = _arg_1;
            if (_SafeStr_4151 == 0)
            {
                showWindow("owner_region", false);
                showWindow("owner_spacer", false);
            }
            else
            {
                _local_4 = (_SafeStr_4145.getListItemByName("owner_region") as IRegionWindow);
                _local_5 = (_local_4.findChildByName("owner_name") as ITextWindow);
                _local_3 = _local_4.findChildByName("owner_link");
                _local_6 = _local_4.findChildByName("bcw_icon");
                if (_SafeStr_4151 != -12345678)
                {
                    _local_5.text = _arg_2;
                    _local_4.toolTipCaption = _SafeStr_1324.localizations.getLocalization("infostand.profile.link.tooltip", "");
                    _local_4.toolTipDelay = 100;
                    _local_3.visible = true;
                    if (_local_6 != null)
                    {
                        _local_6.visible = false;
                    };
                }
                else
                {
                    _local_5.text = "${builder.catalog.title}";
                    _local_4.toolTipCaption = "";
                    _local_3.visible = false;
                    if (_local_6 != null)
                    {
                        _local_6.visible = true;
                    };
                };
                showWindow("owner_region", true);
                showWindow("owner_spacer", true);
            };
            updateWindow();
        }

        private function set expiration(_arg_1:int):void
        {
            var _local_2:IWindow = _SafeStr_4145.getListItemByName("expiration_text");
            if (_local_2 == null)
            {
                return;
            };
            _SafeStr_1324.localizations.registerParameter("infostand.rent.expiration", "time", FriendlyTime.getFriendlyTime(_SafeStr_1324.handler.container.localization, _arg_1));
            _local_2.visible = ((_arg_1 >= 0) && (_SafeStr_4151 == _SafeStr_1324.handler.container.sessionDataManager.userId));
            updateWindow();
        }

        protected function onButtonClicked(_arg_1:WindowMouseEvent):void
        {
            var _local_4:RoomWidgetMessage;
            var _local_5:String;
            var _local_3:String;
            var _local_2:IWindow = (_arg_1.target as IWindow);
            switch (_local_2.name)
            {
                case "rotate":
                    _local_5 = "RWFUAM_ROTATE";
                    break;
                case "move":
                    _local_5 = "RWFAM_MOVE";
                    break;
                case "pickup":
                    if (_SafeStr_4150 == 2)
                    {
                        _local_5 = "RWFAM_PICKUP";
                    }
                    else
                    {
                        _local_5 = "RWFAM_EJECT";
                    };
                    _SafeStr_1324.close();
                    break;
                case "save_branding_configuration":
                    if (_SafeStr_1324.handler.container.sessionDataManager.hasSecurity(4))
                    {
                        _local_5 = "RWFAM_SAVE_STUFF_DATA";
                        _local_3 = getVisibleAdFurnitureExtraParams();
                        break;
                    };
                case "use":
                    _local_5 = "RWFAM_USE";
            };
            if (_local_5 != null)
            {
                _local_4 = new RoomWidgetFurniActionMessage(_local_5, _SafeStr_1324.furniData.id, _SafeStr_1324.furniData.category, _SafeStr_1324.furniData.purchaseOfferId, _local_3);
                _SafeStr_1324.messageListener.processWidgetMessage(_local_4);
            };
        }

        private function onGroupInfoClicked(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1324.messageListener.processWidgetMessage(new RoomWidgetGetBadgeDetailsMessage(false, _SafeStr_1324.furniData.groupId));
        }

        protected function onCatalogButtonClicked(_arg_1:WindowMouseEvent):void
        {
            if (_catalog != null)
            {
                _catalog.openCatalogPageByOfferId(_SafeStr_1324.furniData.purchaseOfferId, "NORMAL");
                if (((_habboTracking) && (!(_habboTracking.disposed))))
                {
                    _habboTracking.trackGoogle("infostandCatalogButton", "offer", _SafeStr_1324.furniData.purchaseOfferId);
                };
            };
        }

        protected function onOwnerRegion(_arg_1:WindowMouseEvent):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                if (_SafeStr_4151 == -12345678)
                {
                    _SafeStr_1324.handler.container.catalog.toggleBuilderCatalog();
                }
                else
                {
                    _SafeStr_1324.messageListener.processWidgetMessage(new RoomWidgetOpenProfileMessage("RWOPEM_OPEN_USER_PROFILE", _SafeStr_4151, "infoStand_furniView"));
                };
            };
            if (_arg_1.type == "WME_OUT")
            {
                IIconWindow(IRegionWindow(_arg_1.target).findChildByName("owner_link")).style = 21;
            };
            if (_arg_1.type == "WME_OVER")
            {
                IIconWindow(IRegionWindow(_arg_1.target).findChildByName("owner_link")).style = 22;
            };
        }

        protected function updateWindow():void
        {
            if ((((_SafeStr_4145 == null) || (_SafeStr_1276 == null)) || (_buttons == null)))
            {
                return;
            };
            _SafeStr_4145.arrangeListItems();
            _buttons.width = _buttons.scrollableRegion.width;
            _SafeStr_4145.height = _SafeStr_4145.scrollableRegion.height;
            _SafeStr_1276.height = (_SafeStr_4145.height + 20);
            _window.width = Math.max(_SafeStr_1276.width, _buttons.width);
            _window.height = _window.scrollableRegion.height;
            if (_SafeStr_1276.width < _buttons.width)
            {
                _SafeStr_1276.x = (_window.width - _SafeStr_1276.width);
                _buttons.x = 0;
            }
            else
            {
                _buttons.x = (_window.width - _buttons.width);
                _SafeStr_1276.x = 0;
            };
            if (_SafeStr_4148 != null)
            {
                _SafeStr_4148.x = _SafeStr_1276.x;
            };
            _SafeStr_1324.refreshContainer();
        }

        public function update(_arg_1:RoomWidgetFurniInfoUpdateEvent):void
        {
            if (_SafeStr_1276 != null)
            {
                _SafeStr_1276.color = ((FurniId.isBuilderClubId(_arg_1.id)) ? 0xD77900 : 0xFFFFFF);
            };
            name = _arg_1.name;
            description = _arg_1.description;
            furniImage = _arg_1.image;
            expiration = _arg_1.expiration;
            setOwnerInfo(((FurniId.isBuilderClubId(_arg_1.id)) ? -12345678 : _arg_1.ownerId), _arg_1.ownerName);
            var _local_3:Boolean;
            var _local_4:Boolean;
            var _local_5:Boolean;
            var _local_2:Boolean;
            if (((((_arg_1.roomControllerLevel >= 1) || (_arg_1.isOwner)) || (_arg_1.isRoomOwner)) || (_arg_1.isAnyRoomController)))
            {
                _local_3 = true;
                _local_4 = (!(_arg_1.isWallItem));
            };
            if (_arg_1.isAnyRoomController)
            {
                _local_5 = true;
            };
            var _local_6:Boolean = (_arg_1.roomControllerLevel >= 1);
            if (((((_arg_1.usagePolicy == 2) || ((_arg_1.usagePolicy == 1) && (_local_6))) || ((_arg_1.extraParam == "RWEIEP_JUKEBOX") && (_local_6))) || ((_arg_1.extraParam == "RWEIEP_USABLE_PRODUCT") && (_local_6))))
            {
                _local_2 = _SafeStr_1324.config.getBoolean("infostand.use.button.enabled");
            };
            updatePickupMode(_arg_1);
            showButton("move", _local_3);
            showButton("rotate", _local_4);
            showButton("use", _local_2);
            showAdFurnitureDetails(_local_5);
            showGroupInfo((_arg_1.groupId > 0));
            updatePurchaseButtonVisibility(_arg_1.isOwner, (_arg_1.expiration >= 0), (_arg_1.purchaseOfferId >= 0), (_arg_1.rentOfferId >= 0), _arg_1.purchaseCouldBeUsedForBuyout, _arg_1.rentCouldBeUsedForBuyout);
            showLimitedItem((_arg_1.stuffData.uniqueSerialNumber > 0), _arg_1.stuffData);
            showRarityItem((_arg_1.stuffData.rarityLevel >= 0), _arg_1.stuffData);
            _buttons.visible = ((((_local_3) || (_local_4)) || (!(_SafeStr_4150 == 0))) || (_local_2));
            updateCustomVarsWindow();
            updateWindow();
        }

        private function updateCustomVarsWindow():void
        {
            var _local_1:IWindowContainer;
            if (((_SafeStr_4148 == null) || (_SafeStr_1324.furniData == null)))
            {
                return;
            };
            var _local_6:IRoomObject = getRoomObject(_SafeStr_1324.furniData.id);
            if (_local_6 == null)
            {
                return;
            };
            var _local_3:Array = _local_6.getModel().getStringArray("furniture_custom_variables");
            _SafeStr_4148.visible = ((!(_local_3 == null)) && (_local_3.length > 0));
            if (!_SafeStr_4148.visible)
            {
                return;
            };
            var _local_5:IItemListWindow = (_SafeStr_4148.findChildByName("variable_list") as IItemListWindow);
            _local_5.destroyListItems();
            var _local_4:Map = _local_6.getModel().getStringToStringMap("furniture_data");
            for each (var _local_2:String in _local_3)
            {
                _local_1 = (_SafeStr_4149.clone() as IWindowContainer);
                _local_1.name = _local_2;
                _local_1.findChildByName("name").caption = _local_2;
                _local_1.findChildByName("value").caption = _local_4[_local_2];
                _local_5.addListItem(_local_1);
            };
        }

        private function updatePickupMode(_arg_1:RoomWidgetFurniInfoUpdateEvent):void
        {
            _SafeStr_4150 = 0;
            if (((_arg_1.isOwner) || (_arg_1.isAnyRoomController)))
            {
                _SafeStr_4150 = 2;
            }
            else
            {
                if (((_arg_1.isRoomOwner) || (_arg_1.roomControllerLevel >= 3)))
                {
                    _SafeStr_4150 = 1;
                };
            };
            if (_arg_1.isStickie)
            {
                _SafeStr_4150 = 0;
            };
            showButton("pickup", (!(_SafeStr_4150 == 0)));
            localizePickupButton(_SafeStr_4150);
        }

        private function localizePickupButton(_arg_1:int):void
        {
            if (_buttons == null)
            {
                return;
            };
            var _local_2:IWindow = _buttons.getListItemByName("pickup");
            if (_local_2 != null)
            {
                if (_arg_1 == 1)
                {
                    _local_2.caption = "${infostand.button.eject}";
                }
                else
                {
                    _local_2.caption = "${infostand.button.pickup}";
                };
            };
        }

        private function createAdElement(_arg_1:String, _arg_2:String):void
        {
            var _local_4:XmlAsset;
            var _local_5:IWindowContainer;
            var _local_6:IWindow;
            var _local_3:IWindow;
            if (_SafeStr_4145 != null)
            {
                _local_4 = (_SafeStr_1324.assets.getAssetByName("furni_view_branding_element") as XmlAsset);
                if (_local_4 != null)
                {
                    _local_5 = (_SafeStr_1324.windowManager.buildFromXML((_local_4.content as XML)) as IWindowContainer);
                    if (_local_5 != null)
                    {
                        _local_6 = _local_5.findChildByName("element_name");
                        if (_local_6 != null)
                        {
                            _local_6.caption = _arg_1;
                        };
                        _local_3 = _local_5.findChildByName("element_value");
                        if (_local_3 != null)
                        {
                            _local_3.caption = _arg_2;
                            _local_3.addEventListener("WKE_KEY_DOWN", adElementKeyEventProc);
                        };
                        if (((!(_local_6 == null)) && (!(_local_3 == null))))
                        {
                            _SafeStr_4145.addListItem(_local_5);
                        };
                    };
                };
            };
        }

        private function getAdFurnitureExtraParams():Map
        {
            var _local_5:String;
            var _local_3:Array;
            var _local_4:Array;
            var _local_7:String;
            var _local_6:String;
            var _local_1:Map = new Map();
            if (_SafeStr_1324 != null)
            {
                _local_5 = _SafeStr_1324.furniData.extraParam.substr("RWEIEP_BRANDING_OPTIONS".length);
                _local_3 = _local_5.split("\t");
                if (_local_3 != null)
                {
                    for each (var _local_2:String in _local_3)
                    {
                        _local_4 = _local_2.split("=", 2);
                        if (((!(_local_4 == null)) && (_local_4.length == 2)))
                        {
                            _local_7 = _local_4[0];
                            _local_6 = _local_4[1];
                            _local_1.add(_local_7, _local_6);
                        };
                    };
                };
            };
            return (_local_1);
        }

        private function getVisibleAdFurnitureExtraParams():String
        {
            var _local_2:Array;
            var _local_7:IWindow;
            var _local_3:IWindow;
            var _local_5:String;
            var _local_4:String;
            var _local_1:String = "";
            if (_SafeStr_1276 != null)
            {
                _local_2 = [];
                _SafeStr_1276.groupChildrenWithTag("branding_element", _local_2, -1);
                if (_local_2.length > 0)
                {
                    for each (var _local_6:IWindowContainer in _local_2)
                    {
                        _local_7 = _local_6.findChildByName("element_name");
                        _local_3 = _local_6.findChildByName("element_value");
                        if (((!(_local_7 == null)) && (!(_local_3 == null))))
                        {
                            _local_5 = trimAdFurnitureExtramParam(_local_7.caption);
                            _local_4 = trimAdFurnitureExtramParam(_local_3.caption);
                            _local_1 = (_local_1 + (((_local_5 + "=") + _local_4) + "\t"));
                        };
                    };
                };
            };
            return (_local_1);
        }

        private function trimAdFurnitureExtramParam(_arg_1:String):String
        {
            if (_arg_1 != null)
            {
                if (_arg_1.indexOf("\t") != -1)
                {
                    return (_arg_1.replace("\t", ""));
                };
            };
            return (_arg_1);
        }

        private function showAdFurnitureDetails(_arg_1:Boolean):void
        {
            var _local_5:String;
            var _local_8:Map;
            var _local_9:String;
            if (((_SafeStr_1324 == null) || (_SafeStr_1276 == null)))
            {
                return;
            };
            var _local_4:IWindow = _SafeStr_1276.findChildByName("furni_details_spacer");
            if (_local_4 != null)
            {
                _local_4.visible = _arg_1;
            };
            var _local_2:Array = [];
            _SafeStr_1276.groupChildrenWithTag("branding_element", _local_2, -1);
            if (_local_2.length > 0)
            {
                for each (var _local_6:IWindow in _local_2)
                {
                    _SafeStr_1276.removeChild(_local_6);
                    _local_6.dispose();
                };
            };
            var _local_3:Boolean;
            var _local_7:IWindow = (_SafeStr_1276.findChildByName("furni_details_text") as ITextWindow);
            if (_local_7 != null)
            {
                _local_7.visible = _arg_1;
                _local_5 = ("id: " + _SafeStr_1324.furniData.id);
                _local_8 = getAdFurnitureExtraParams();
                if (_local_8.length > 0)
                {
                    _local_3 = true;
                    for each (var _local_10:String in _local_8.getKeys())
                    {
                        _local_9 = _local_8.getValue(_local_10);
                        createAdElement(_local_10, _local_9);
                    };
                };
                _local_7.caption = _local_5;
            };
            showButton("save_branding_configuration", _local_3);
        }

        private function showGroupInfo(_arg_1:Boolean):void
        {
            showWindow("group_details_spacer", _arg_1);
            showWindow("group_details_container", _arg_1);
            showWindow("group_badge_image", false);
            showWindow("group_name", false);
        }

        private function showWindow(_arg_1:String, _arg_2:Boolean):void
        {
            var _local_3:IWindow = _SafeStr_1276.findChildByName(_arg_1);
            if (_local_3)
            {
                _local_3.visible = _arg_2;
            };
        }

        private function adElementKeyEventProc(_arg_1:WindowEvent=null, _arg_2:IWindow=null):void
        {
        }

        protected function showButton(_arg_1:String, _arg_2:Boolean):void
        {
            if (_buttons == null)
            {
                return;
            };
            var _local_3:IWindow = _buttons.getListItemByName(_arg_1);
            if (_local_3 != null)
            {
                _local_3.visible = _arg_2;
                _buttons.arrangeListItems();
            };
        }

        private function updatePurchaseButtonVisibility(_arg_1:Boolean, _arg_2:Boolean, _arg_3:Boolean, _arg_4:Boolean, _arg_5:Boolean, _arg_6:Boolean):void
        {
            var _local_11:Boolean;
            var _local_9:Boolean = ((_arg_1) && (_arg_2));
            var _local_8:Boolean = ((_local_9) && (_arg_6));
            var _local_10:Boolean = ((_local_9) && (_arg_5));
            var _local_12:Boolean = ((!(_local_9)) && (_arg_3));
            var _local_13:Boolean = ((!(_local_9)) && (_arg_4));
            if (_catalogButton != null)
            {
                _catalogButton.visible = _local_12;
                if (!_local_11)
                {
                    _local_11 = _local_12;
                };
            };
            if (_rentButton != null)
            {
                _rentButton.visible = _local_13;
                if (!_local_11)
                {
                    _local_11 = _local_13;
                };
            };
            if (_extendButton != null)
            {
                _extendButton.visible = _local_8;
                if (!_local_11)
                {
                    _local_11 = _local_8;
                };
            };
            if (_buyoutButton != null)
            {
                _buyoutButton.visible = _local_10;
                if (!_local_11)
                {
                    _local_11 = _local_10;
                };
            };
            var _local_7:IItemListWindow = (_SafeStr_4145.getListItemByName("purchase_buttons") as IItemListWindow);
            if (_local_7 != null)
            {
                _local_7.arrangeListItems();
                _local_7.visible = _local_11;
            };
            _SafeStr_4145.arrangeListItems();
        }

        public function set groupName(_arg_1:String):void
        {
            var _local_2:IWindow = _SafeStr_1276.findChildByName("group_name");
            if (_local_2)
            {
                _local_2.caption = _arg_1;
                _local_2.visible = true;
            };
        }

        private function showLimitedItem(_arg_1:Boolean, _arg_2:IStuffData):void
        {
            var _local_3:IWidgetWindow;
            var _local_4:ILimitedItemPreviewOverlayWidget;
            var _local_6:IWindowContainer = (_SafeStr_1276.findChildByName("unique_item_background_container") as IWindowContainer);
            var _local_5:IWindowContainer = (_SafeStr_1276.findChildByName("unique_item_overlay_container") as IWindowContainer);
            if (((!(_local_6)) || (!(_local_5))))
            {
                return;
            };
            if (!_arg_1)
            {
                _local_6.visible = false;
                _local_5.visible = false;
            }
            else
            {
                _local_6.visible = true;
                _local_5.visible = true;
                _local_3 = IWidgetWindow(_local_5.findChildByName("unique_item_plaque_widget"));
                _local_4 = ILimitedItemPreviewOverlayWidget(_local_3.widget);
                _local_4.serialNumber = _arg_2.uniqueSerialNumber;
                _local_4.seriesSize = _arg_2.uniqueSeriesSize;
            };
        }

        private function showRarityItem(_arg_1:Boolean, _arg_2:IStuffData):void
        {
            var _local_3:IWidgetWindow;
            var _local_4:IRarityItemPreviewOverlayWidget;
            var _local_5:IWindowContainer = (_SafeStr_1276.findChildByName("rarity_item_overlay_container") as IWindowContainer);
            if (!_local_5)
            {
                return;
            };
            if (!_arg_1)
            {
                _local_5.visible = false;
            }
            else
            {
                _local_5.visible = true;
                _local_3 = IWidgetWindow(_local_5.findChildByName("rarity_item_overlay_widget"));
                _local_4 = IRarityItemPreviewOverlayWidget(_local_3.widget);
                _local_4.rarityLevel = _arg_2.rarityLevel;
            };
        }

        public function set groupBadgeId(_arg_1:String):void
        {
            var _local_3:IWidgetWindow = (_SafeStr_1276.findChildByName("group_badge_image") as IWidgetWindow);
            var _local_2:IBadgeImageWidget = (_local_3.widget as IBadgeImageWidget);
            _local_2.badgeId = _arg_1;
            _local_2.groupId = _SafeStr_1324.furniData.groupId;
            _local_3.visible = true;
        }


    }
}

