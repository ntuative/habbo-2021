package com.sulake.habbo.ui.widget.furniture.present
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPresentDataUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetEcotronBoxDataUpdateEvent;
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.ui.handler.FurniturePresentWidgetHandler;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.inventory.items.IFurnitureItem;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.habbo.tracking.HabboTracking;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileByNameMessageComposer;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPresentOpenMessage;
    import com.sulake.habbo.session.IUserData;

    public class PresentFurniWidget extends RoomWidgetBase implements IAvatarImageListener 
    {

        private static const _SafeStr_1457:String = "floor";
        private static const TYPE_WALLPAPER:String = "wallpaper";
        private static const TYPE_LANDSCAPE:String = "landscape";

        private var _habboConfiguration:ICoreConfiguration;
        private var _catalog:IHabboCatalog;
        private var _inventory:IHabboInventory;
        private var _roomEngine:IRoomEngine;
        private var _window:IFrameWindow;
        private var _SafeStr_1922:int = -1;
        private var _SafeStr_4123:int = 0;
        private var _SafeStr_4124:String;
        private var _text:String;
        private var _SafeStr_1284:Boolean;
        private var _SafeStr_4088:Boolean = false;
        private var _SafeStr_4125:String;
        private var _senderName:String;
        private var _SafeStr_4126:int = -1;
        private var _SafeStr_4127:String = "";
        private var _placedInRoom:Boolean = false;

        public function PresentFurniWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager, _arg_5:ICoreConfiguration, _arg_6:IHabboCatalog, _arg_7:IHabboInventory, _arg_8:IRoomEngine)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            _habboConfiguration = _arg_5;
            _catalog = _arg_6;
            _inventory = _arg_7;
            _roomEngine = _arg_8;
        }

        override public function dispose():void
        {
            hideInterface();
            _habboConfiguration = null;
            _catalog = null;
            _inventory = null;
            _roomEngine = null;
            super.dispose();
        }

        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addEventListener("RWPDUE_PACKAGEINFO", onObjectUpdate);
            _arg_1.addEventListener("RWPDUE_CONTENTS", onObjectUpdate);
            _arg_1.addEventListener("RWPDUE_CONTENTS_IMAGE", onObjectUpdate);
            _arg_1.addEventListener("RWPDUE_CONTENTS_CLUB", onObjectUpdate);
            _arg_1.addEventListener("RWPDUE_CONTENTS_FLOOR", onObjectUpdate);
            _arg_1.addEventListener("RWPDUE_CONTENTS_LANDSCAPE", onObjectUpdate);
            _arg_1.addEventListener("RWPDUE_CONTENTS_WALLPAPER", onObjectUpdate);
            _arg_1.addEventListener("RWROUE_FURNI_REMOVED", onRoomObjectRemoved);
            _arg_1.addEventListener("RWEBDUE_PACKAGEINFO", onEcotronUpdate);
            super.registerUpdateEvents(_arg_1);
        }

        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.removeEventListener("RWPDUE_PACKAGEINFO", onObjectUpdate);
            _arg_1.removeEventListener("RWPDUE_CONTENTS", onObjectUpdate);
            _arg_1.removeEventListener("RWPDUE_CONTENTS_IMAGE", onObjectUpdate);
            _arg_1.removeEventListener("RWPDUE_CONTENTS_CLUB", onObjectUpdate);
            _arg_1.removeEventListener("RWPDUE_CONTENTS_FLOOR", onObjectUpdate);
            _arg_1.removeEventListener("RWPDUE_CONTENTS_LANDSCAPE", onObjectUpdate);
            _arg_1.removeEventListener("RWPDUE_CONTENTS_WALLPAPER", onObjectUpdate);
            _arg_1.removeEventListener("RWEBDUE_PACKAGEINFO", onEcotronUpdate);
            _arg_1.removeEventListener("RWROUE_FURNI_REMOVED", onRoomObjectRemoved);
        }

        private function onObjectUpdate(_arg_1:RoomWidgetPresentDataUpdateEvent):void
        {
            switch (_arg_1.type)
            {
                case "RWPDUE_PACKAGEINFO":
                    hideInterface();
                    _SafeStr_4088 = false;
                    _SafeStr_1922 = _arg_1.objectId;
                    _text = _arg_1.text;
                    _SafeStr_1284 = _arg_1.controller;
                    _senderName = _arg_1.purchaserName;
                    _SafeStr_4125 = _arg_1.purchaserFigure;
                    showInterface();
                    showIcon(_arg_1.iconBitmapData);
                    return;
                case "RWPDUE_CONTENTS_FLOOR":
                    if (!_SafeStr_4088)
                    {
                        return;
                    };
                    _SafeStr_1922 = _arg_1.objectId;
                    _SafeStr_4123 = _arg_1.classId;
                    _SafeStr_4124 = _arg_1.itemType;
                    _text = _arg_1.text;
                    _SafeStr_1284 = _arg_1.controller;
                    _SafeStr_4126 = _arg_1.placedItemId;
                    _SafeStr_4127 = _arg_1.placedItemType;
                    _placedInRoom = _arg_1.placedInRoom;
                    showGiftOpenedInterface();
                    showCustomIcon("packagecard_icon_floor");
                    return;
                case "RWPDUE_CONTENTS_LANDSCAPE":
                    if (!_SafeStr_4088)
                    {
                        return;
                    };
                    _SafeStr_1922 = _arg_1.objectId;
                    _SafeStr_4123 = _arg_1.classId;
                    _SafeStr_4124 = _arg_1.itemType;
                    _text = _arg_1.text;
                    _SafeStr_1284 = _arg_1.controller;
                    _SafeStr_4126 = _arg_1.placedItemId;
                    _SafeStr_4127 = _arg_1.placedItemType;
                    _placedInRoom = _arg_1.placedInRoom;
                    showGiftOpenedInterface();
                    showCustomIcon("packagecard_icon_landscape");
                    return;
                case "RWPDUE_CONTENTS_WALLPAPER":
                    if (!_SafeStr_4088)
                    {
                        return;
                    };
                    _SafeStr_1922 = _arg_1.objectId;
                    _SafeStr_4123 = _arg_1.classId;
                    _SafeStr_4124 = _arg_1.itemType;
                    _text = _arg_1.text;
                    _SafeStr_1284 = _arg_1.controller;
                    _SafeStr_4126 = _arg_1.placedItemId;
                    _SafeStr_4127 = _arg_1.placedItemType;
                    _placedInRoom = _arg_1.placedInRoom;
                    showGiftOpenedInterface();
                    showCustomIcon("packagecard_icon_wallpaper");
                    return;
                case "RWPDUE_CONTENTS_CLUB":
                    if (!_SafeStr_4088)
                    {
                        return;
                    };
                    _SafeStr_1922 = _arg_1.objectId;
                    _SafeStr_4123 = _arg_1.classId;
                    _SafeStr_4124 = _arg_1.itemType;
                    _text = _arg_1.text;
                    _SafeStr_1284 = _arg_1.controller;
                    showGiftOpenedInterface();
                    showCustomIcon("packagecard_icon_hc");
                    return;
                case "RWPDUE_CONTENTS":
                    if (!_SafeStr_4088)
                    {
                        return;
                    };
                    _SafeStr_1922 = _arg_1.objectId;
                    _SafeStr_4123 = _arg_1.classId;
                    _SafeStr_4124 = _arg_1.itemType;
                    _text = _arg_1.text;
                    _SafeStr_1284 = _arg_1.controller;
                    _SafeStr_4126 = _arg_1.placedItemId;
                    _SafeStr_4127 = _arg_1.placedItemType;
                    _placedInRoom = _arg_1.placedInRoom;
                    showGiftOpenedInterface();
                    showIcon(_arg_1.iconBitmapData);
                    return;
                case "RWPDUE_CONTENTS_IMAGE":
                    if (!_SafeStr_4088)
                    {
                        return;
                    };
                    showIcon(_arg_1.iconBitmapData);
                    return;
            };
        }

        private function onRoomObjectRemoved(_arg_1:RoomWidgetRoomObjectUpdateEvent):void
        {
            if (_arg_1.id == _SafeStr_1922)
            {
                hideInterface();
            };
            if (_arg_1.id == _SafeStr_4126)
            {
                if (_placedInRoom)
                {
                    _placedInRoom = false;
                    updateRoomAndInventoryButtons();
                };
            };
        }

        private function onEcotronUpdate(_arg_1:RoomWidgetEcotronBoxDataUpdateEvent):void
        {
            switch (_arg_1.type)
            {
                case "RWEBDUE_PACKAGEINFO":
                    hideInterface();
                    return;
            };
        }

        private function showCustomIcon(_arg_1:String):void
        {
            var _local_2:BitmapData;
            var _local_3:BitmapDataAsset = (assets.getAssetByName(_arg_1) as BitmapDataAsset);
            if (_local_3 != null)
            {
                _local_2 = (_local_3.content as BitmapData);
            };
            showIcon(_local_2);
        }

        private function showIcon(_arg_1:BitmapData):void
        {
            if (_arg_1 == null)
            {
                _arg_1 = new BitmapData(1, 1);
            };
            if (((_window == null) || (_window.disposed)))
            {
                return;
            };
            var _local_2:IBitmapWrapperWindow = (_window.findChildByName("gift_image") as IBitmapWrapperWindow);
            if (_local_2 == null)
            {
                return;
            };
            if (_local_2.bitmap != null)
            {
                _local_2.bitmap.dispose();
            };
            _local_2.bitmap = new BitmapData(_local_2.width, _local_2.height, true, 0);
            var _local_3:Point = new Point(((_local_2.width - _arg_1.width) / 2), ((_local_2.height - _arg_1.height) / 2));
            _local_2.bitmap.copyPixels(_arg_1, _arg_1.rect, _local_3);
        }

        private function showGiftOpenedInterface():void
        {
            var _local_11:String;
            var _local_3:BitmapDataAsset;
            var _local_1:BitmapData;
            var _local_2:String;
            var _local_10:Boolean;
            var _local_4:String;
            if (_SafeStr_1922 < 0)
            {
                return;
            };
            if (_window != null)
            {
                _window.dispose();
            };
            var _local_9:XmlAsset = (assets.getAssetByName("packagecard_new_opened") as XmlAsset);
            _window = (windowManager.buildFromXML((_local_9.content as XML)) as IFrameWindow);
            _window.center();
            if (!isUnknownSender())
            {
                _local_11 = "widget.furni.present.window.title_from";
                _SafeStr_819.registerParameter(_local_11, "name", _senderName);
                _window.caption = _SafeStr_819.getLocalization(_local_11, _senderName);
            };
            var _local_6:IWindow = _window.findChildByName("header_button_close");
            if (_local_6 != null)
            {
                _local_6.addEventListener("WME_CLICK", onClose);
            };
            var _local_7:IBitmapWrapperWindow = (_window.findChildByName("image_bg") as IBitmapWrapperWindow);
            if (_local_7 != null)
            {
                _local_3 = (assets.getAssetByName("gift_icon_background") as BitmapDataAsset);
                if (_local_3 != null)
                {
                    _local_1 = (_local_3.content as BitmapData);
                    if (_local_7.bitmap)
                    {
                        _local_7.bitmap.dispose();
                    };
                    _local_7.bitmap = _local_1.clone();
                };
            };
            var _local_5:ITextWindow = (_window.findChildByName("gift_message") as ITextWindow);
            if (_local_5 != null)
            {
                _local_5.text = "";
                if (_text != null)
                {
                    _local_2 = "widget.furni.present.message_opened";
                    _local_10 = isSpacesItem();
                    if (_local_10)
                    {
                        _local_2 = "widget.furni.present.spaces.message_opened";
                    };
                    _SafeStr_819.registerParameter(_local_2, "product", _text);
                    if (_SafeStr_4124 == "h")
                    {
                        _local_5.text = _text;
                    }
                    else
                    {
                        _local_5.text = _SafeStr_819.getLocalization(_local_2, _text);
                    };
                }
                else
                {
                    _local_5.visible = false;
                };
            };
            var _local_8:IWindow = _window.findChildByName("give_gift_button");
            if (_local_8 != null)
            {
                if (!isUnknownSender())
                {
                    _local_4 = "widget.furni.present.give_gift";
                    _SafeStr_819.registerParameter(_local_4, "name", _senderName);
                    _local_8.caption = _SafeStr_819.getLocalization(_local_4, _senderName);
                    _local_8.addEventListener("WME_CLICK", onGiveGiftOpened);
                }
                else
                {
                    _local_8.visible = false;
                };
            };
            prepareAvatarImageContainer();
            updateGiftDialogAvatarImage(_SafeStr_4125);
            updateRoomAndInventoryButtons();
            selectGiftedObject();
        }

        private function isSpacesItem():Boolean
        {
            var _local_2:IFurnitureData;
            var _local_3:String;
            var _local_1:Boolean;
            if (_SafeStr_4124 == "i")
            {
                _local_2 = (_SafeStr_3915 as FurniturePresentWidgetHandler).container.sessionDataManager.getWallItemData(_SafeStr_4123);
                if (_local_2 != null)
                {
                    _local_3 = _local_2.className;
                    _local_1 = (((_local_3 == "floor") || (_local_2.className == "landscape")) || (_local_2.className == "wallpaper"));
                };
            };
            return (_local_1);
        }

        private function isClubItem():Boolean
        {
            return (_SafeStr_4124 == "h");
        }

        private function updateRoomAndInventoryButtons():void
        {
            if (((_window == null) || (_window.disposed)))
            {
                return;
            };
            var _local_4:Boolean = isSpacesItem();
            var _local_7:Boolean = isClubItem();
            var _local_10:IWindow = _window.findChildByName("keep_in_room_button");
            if (_local_10 != null)
            {
                _local_10.addEventListener("WME_CLICK", onKeepInRoom);
                _local_10.visible = _placedInRoom;
                if (((_local_4) || (_local_7)))
                {
                    _local_10.visible = false;
                };
            };
            var _local_1:IWindow = _window.findChildByName("place_in_room_button");
            if (_local_1 != null)
            {
                _local_1.addEventListener("WME_CLICK", onPlaceInRoom);
                _local_1.visible = (!(_placedInRoom));
                if (_local_4)
                {
                    _local_1.disable();
                };
                if (((_local_4) || (_local_7)))
                {
                    _local_1.visible = false;
                };
            };
            var _local_2:IWindow = _window.findChildByName("put_in_inventory_button");
            if (_local_2 != null)
            {
                _local_2.addEventListener("WME_CLICK", onPutInInventory);
                _local_2.enable();
                if (((_local_4) || (_local_7)))
                {
                    _local_2.visible = false;
                };
            };
            var _local_8:IWindow = _window.findChildByName("separator");
            if (_local_8 != null)
            {
                _local_8.visible = isUnknownSender();
            };
            var _local_5:IWindow = (_window.findChildByName("give_container") as IWindow);
            if (_local_5 != null)
            {
                _local_5.visible = (!(isUnknownSender()));
            };
            var _local_6:IItemListWindow = (_window.findChildByName("button_list") as IItemListWindow);
            if (_local_6 != null)
            {
                _local_6.arrangeListItems();
            };
            var _local_3:IItemListWindow = (_window.findChildByName("give_element_list") as IItemListWindow);
            if (_local_3 != null)
            {
                _local_3.arrangeListItems();
            };
            var _local_9:IItemListWindow = (_window.findChildByName("element_list") as IItemListWindow);
            if (_local_9 != null)
            {
                _local_9.arrangeListItems();
            };
            _window.resizeToFitContent();
        }

        private function resetAndHideInterface():void
        {
            _SafeStr_4088 = false;
            _SafeStr_4126 = -1;
            _placedInRoom = false;
            hideInterface();
        }

        private function onKeepInRoom(_arg_1:WindowEvent):void
        {
            resetAndHideInterface();
        }

        private function onPlaceInRoom(_arg_1:WindowEvent):void
        {
            var _local_3:IFurnitureItem;
            var _local_2:IWindow = _arg_1.target;
            _local_2.disable();
            if (((_SafeStr_4126 > 0) && (!(_placedInRoom))))
            {
                _local_3 = null;
                switch (_SafeStr_4127)
                {
                    case "s":
                        _local_3 = _inventory.getFloorItemById(-(_SafeStr_4126));
                        if (requestSelectedFurniPlacement(_local_3))
                        {
                            _inventory.removeUnseenFurniCounter(_SafeStr_4126);
                        };
                        break;
                    case "i":
                        _local_3 = _inventory.getWallItemById(_SafeStr_4126);
                        if (requestSelectedFurniPlacement(_local_3))
                        {
                            _inventory.removeUnseenFurniCounter(_SafeStr_4126);
                        };
                        break;
                    case "p":
                        if (_inventory.placePetToRoom(_SafeStr_4126, false))
                        {
                            _inventory.removeUnseenPetCounter(_SafeStr_4126);
                        };
                        break;
                    default:
                };
            };
            resetAndHideInterface();
        }

        public function requestSelectedFurniPlacement(_arg_1:IFurnitureItem):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            var _local_2:Boolean;
            if ((((_arg_1.category == 3) || (_arg_1.category == 2)) || (_arg_1.category == 4)))
            {
                _local_2 = false;
            }
            else
            {
                _local_2 = _inventory.requestSelectedFurniToMover(_arg_1);
            };
            return (_local_2);
        }

        private function onPutInInventory(_arg_1:WindowEvent):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_3:IRoomObject;
            var _local_2:IWindow = _arg_1.target;
            _local_2.disable();
            if (((_SafeStr_4126 > 0) && (_placedInRoom)))
            {
                if (_SafeStr_4127 == "p")
                {
                    (_SafeStr_3915 as FurniturePresentWidgetHandler).container.roomSession.pickUpPet(_SafeStr_4126);
                }
                else
                {
                    _local_4 = (_SafeStr_3915 as FurniturePresentWidgetHandler).container.roomSession.roomId;
                    _local_5 = 10;
                    _local_3 = _roomEngine.getRoomObject(_local_4, _SafeStr_4126, _local_5);
                    if (_local_3 != null)
                    {
                        _roomEngine.modifyRoomObject(_local_3.getId(), _local_5, "OBJECT_PICKUP");
                    };
                };
            };
            resetAndHideInterface();
        }

        private function showInterface():void
        {
            var _local_10:String;
            var _local_8:String;
            var _local_2:String;
            var _local_5:IWindow;
            var _local_3:String;
            var _local_12:IWindow;
            if (_SafeStr_1922 < 0)
            {
                return;
            };
            if (_window != null)
            {
                _window.dispose();
            };
            var _local_6:XmlAsset = (assets.getAssetByName("packagecard_new") as XmlAsset);
            _window = (windowManager.buildFromXML((_local_6.content as XML)) as IFrameWindow);
            _window.center();
            if (!isUnknownSender())
            {
                _local_10 = "widget.furni.present.window.title_from";
                _SafeStr_819.registerParameter(_local_10, "name", _senderName);
                _window.caption = _SafeStr_819.getLocalization(_local_10, _senderName);
            };
            var _local_4:IWindow = _window.findChildByName("header_button_close");
            if (_local_4 != null)
            {
                _local_4.addEventListener("WME_CLICK", onClose);
            };
            var _local_9:IStaticBitmapWrapperWindow = (_window.findChildByName("gift_card") as IStaticBitmapWrapperWindow);
            if (_local_9)
            {
                _local_8 = _habboConfiguration.getProperty("catalog.gift_wrapping_new.gift_card");
                if (_local_8 != "")
                {
                    _local_9.assetUri = (("${image.library.url}Giftcards/" + _local_8) + ".png");
                };
            };
            prepareAvatarImageContainer();
            if (isUnknownSender())
            {
                updateUnknownSenderAvatarImage();
            }
            else
            {
                updateGiftDialogAvatarImage(_SafeStr_4125);
            };
            var _local_1:ITextWindow = (_window.findChildByName("message_text") as ITextWindow);
            if (_local_1 != null)
            {
                _local_1.text = _text;
            };
            var _local_11:ITextWindow = (_window.findChildByName("message_from") as ITextWindow);
            if (_local_11 != null)
            {
                _local_11.text = "";
                if (!isUnknownSender())
                {
                    _local_2 = "widget.furni.present.message_from";
                    _SafeStr_819.registerParameter(_local_2, "name", _senderName);
                    _local_11.text = _SafeStr_819.getLocalization(_local_2, _senderName);
                    _local_11.addEventListener("WME_CLICK", onSenderNameClick);
                }
                else
                {
                    _local_11.visible = false;
                };
            };
            var _local_7:IItemListWindow = (_window.findChildByName("button_list") as IItemListWindow);
            if (_local_7 != null)
            {
                _local_5 = _local_7.getListItemByName("give_gift_button");
                if (_local_5 != null)
                {
                    if (!isUnknownSender())
                    {
                        _local_3 = "widget.furni.present.give_gift";
                        _SafeStr_819.registerParameter(_local_3, "name", _senderName);
                        _local_5.caption = _SafeStr_819.getLocalization(_local_3, _senderName);
                    };
                    if (_SafeStr_1284)
                    {
                        _local_5.addEventListener("WME_CLICK", onGiveGift);
                    };
                    if (((!(_SafeStr_1284)) || (isUnknownSender())))
                    {
                        _local_5.visible = false;
                    };
                };
                _local_12 = _window.findChildByName("open_gift_button");
                if (_local_12 != null)
                {
                    if (_SafeStr_1284)
                    {
                        _local_12.addEventListener("WME_CLICK", onOpenGift);
                    }
                    else
                    {
                        _local_12.visible = false;
                    };
                };
                _local_7.arrangeListItems();
            };
            _window.resizeToFitContent();
        }

        private function isUnknownSender():Boolean
        {
            return ((_senderName == null) || (_senderName.length == 0));
        }

        private function onClose(_arg_1:WindowEvent):void
        {
            _SafeStr_4088 = false;
            hideInterface();
        }

        private function onGiveGift(_arg_1:WindowEvent):void
        {
            openGiftShop();
            HabboTracking.getInstance().trackEventLog("Catalog", "click", "client.return_gift_from_open_giftcard.clicked");
        }

        private function onGiveGiftOpened(_arg_1:WindowEvent):void
        {
            openGiftShop();
            HabboTracking.getInstance().trackEventLog("Catalog", "click", "client.return_gift_from_opened_present.clicked");
        }

        private function openGiftShop():void
        {
            if (!isUnknownSender())
            {
                _catalog.giftReceiver = _senderName;
            };
            _catalog.openCatalogPage("gift_shop");
        }

        private function send(_arg_1:IMessageComposer):void
        {
            var _local_2:IConnection;
            if (_catalog != null)
            {
                _local_2 = _catalog.connection;
                if (_local_2 != null)
                {
                    _local_2.send(_arg_1);
                };
            };
        }

        private function getExtendedProfile():void
        {
            if (!isUnknownSender())
            {
                send(new GetExtendedProfileByNameMessageComposer(_senderName));
            };
        }

        private function onSenderImageClick(_arg_1:WindowEvent):void
        {
            getExtendedProfile();
        }

        private function onSenderNameClick(_arg_1:WindowEvent):void
        {
            getExtendedProfile();
        }

        private function onOpenGift(_arg_1:WindowEvent):void
        {
            sendOpen();
        }

        public function getAvatarFaceBitmap(_arg_1:String):BitmapData
        {
            var _local_3:IAvatarRenderManager = (_SafeStr_3915 as FurniturePresentWidgetHandler).container.avatarRenderManager;
            if ((((_local_3 == null) || (_arg_1 == null)) || (_arg_1.length == 0)))
            {
                return (null);
            };
            var _local_2:BitmapData;
            var _local_4:IAvatarImage = _local_3.createAvatarImage(_arg_1, "h", null, this);
            if (_local_4 != null)
            {
                _local_2 = _local_4.getCroppedImage("head");
                _local_4.dispose();
            };
            return (_local_2);
        }

        public function avatarImageReady(_arg_1:String):void
        {
            if (((_window == null) || (_window.disposed)))
            {
                return;
            };
            if (_arg_1 == _SafeStr_4125)
            {
                updateGiftDialogAvatarImage(_arg_1);
            };
        }

        private function prepareAvatarImageContainer():void
        {
            var _local_1:IRegionWindow = (_window.findChildByName("avatar_image_region") as IRegionWindow);
            if (_local_1 != null)
            {
                if (!isUnknownSender())
                {
                    _local_1.addEventListener("WME_CLICK", onSenderImageClick);
                }
                else
                {
                    _local_1.disable();
                };
            };
        }

        private function updateGiftDialogAvatarImage(_arg_1:String):void
        {
            var _local_2:BitmapData = getAvatarFaceBitmap(_arg_1);
            if (_local_2 != null)
            {
                updateAvatarImage(_local_2);
            };
        }

        private function updateUnknownSenderAvatarImage():void
        {
            var _local_1:BitmapData;
            var _local_2:BitmapDataAsset = (_assets.getAssetByName("gift_incognito") as BitmapDataAsset);
            if (_local_2 != null)
            {
                _local_1 = (_local_2.content as BitmapData);
                if (_local_1 != null)
                {
                    updateAvatarImage(_local_1.clone());
                };
            };
        }

        private function updateAvatarImage(_arg_1:BitmapData):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            var _local_3:IBitmapWrapperWindow = (_window.findChildByName("avatar_image") as IBitmapWrapperWindow);
            if (_local_3 == null)
            {
                return;
            };
            _local_3.bitmap = _arg_1;
            _local_3.width = _arg_1.width;
            _local_3.height = _arg_1.height;
            var _local_2:IWindowContainer = (_window.findChildByName("avatar_image_region") as IWindowContainer);
            if (_local_2 != null)
            {
                _local_2.width = _arg_1.width;
                _local_2.height = _arg_1.height;
            };
        }

        private function hideInterface():void
        {
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
            if (!_SafeStr_4088)
            {
                _SafeStr_1922 = -1;
            };
            _text = "";
            _SafeStr_1284 = false;
        }

        private function sendOpen():void
        {
            var _local_1:RoomWidgetPresentOpenMessage;
            if ((((_SafeStr_4088) || (_SafeStr_1922 == -1)) || (!(_SafeStr_1284))))
            {
                return;
            };
            _SafeStr_4088 = true;
            hideInterface();
            if (messageListener != null)
            {
                _local_1 = new RoomWidgetPresentOpenMessage("RWPOM_OPEN_PRESENT", _SafeStr_1922);
                messageListener.processWidgetMessage(_local_1);
            };
        }

        private function selectGiftedObject():void
        {
            var _local_5:int;
            var _local_3:int;
            var _local_4:int;
            var _local_2:IRoomObject;
            var _local_1:IUserData;
            if (((_SafeStr_4126 > 0) && (_placedInRoom)))
            {
                _local_5 = _roomEngine.activeRoomId;
                if (_SafeStr_4127 == "p")
                {
                    _local_3 = _roomEngine.getRoomObjectCount(_local_5, 100);
                    _local_4 = 0;
                    while (_local_4 < _local_3)
                    {
                        _local_2 = _roomEngine.getRoomObjectWithIndex(_local_5, _local_4, 100);
                        _local_1 = (_SafeStr_3915 as FurniturePresentWidgetHandler).container.roomSession.userDataManager.getUserDataByIndex(_local_2.getId());
                        if (((!(_local_1 == null)) && (_local_1.webID == _SafeStr_4126)))
                        {
                            _roomEngine.selectRoomObject(_local_5, _local_1.roomObjectId, 100);
                            break;
                        };
                        _local_4++;
                    };
                }
                else
                {
                    _roomEngine.selectRoomObject(_local_5, _SafeStr_4126, 10);
                };
            };
        }


    }
}

