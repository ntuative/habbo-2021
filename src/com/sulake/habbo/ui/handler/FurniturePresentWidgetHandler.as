package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.room._SafeStr_147;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPresentDataUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPresentOpenMessage;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.display.BitmapData;
    import com.sulake.habbo.session.events.RoomSessionPresentEvent;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.avatar.pets.PetFigureData;
    import flash.events.Event;

    public class FurniturePresentWidgetHandler implements IRoomWidgetHandler, IGetImageListener
    {

        private static const _SafeStr_1457:String = "floor";
        private static const TYPE_WALLPAPER:String = "wallpaper";
        private static const TYPE_LANDSCAPE:String = "landscape";
        private static const TYPE_POSTER:String = "poster";

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var _SafeStr_1922:int = -1;
        private var _name:String = "";


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get type():String
        {
            return ("RWE_FURNI_PRESENT_WIDGET");
        }

        public function get container():IRoomWidgetHandlerContainer
        {
            return (_container);
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            _container = _arg_1;
        }

        public function dispose():void
        {
            _disposed = true;
            _container = null;
        }

        public function getWidgetMessages():Array
        {
            return (["RWFWM_MESSAGE_REQUEST_PRESENT", "RWPOM_OPEN_PRESENT"]);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_4:RoomWidgetFurniToWidgetMessage;
            var _local_3:IRoomObject;
            var _local_12:IRoomObjectModel;
            var _local_11:String;
            var _local_7:String;
            var _local_13:String;
            var _local_10:int;
            var _local_5:String;
            var _local_6:int;
            var _local_9:_SafeStr_147;
            var _local_2:RoomWidgetPresentDataUpdateEvent;
            var _local_8:RoomWidgetPresentOpenMessage;
            switch (_arg_1.type)
            {
                case "RWFWM_MESSAGE_REQUEST_PRESENT":
                    _local_4 = (_arg_1 as RoomWidgetFurniToWidgetMessage);
                    _local_3 = _container.roomEngine.getRoomObject(_local_4.roomId, _local_4.id, _local_4.category);
                    if (_local_3 != null)
                    {
                        _local_12 = _local_3.getModel();
                        if (_local_12 != null)
                        {
                            _SafeStr_1922 = _local_4.id;
                            _local_11 = _local_12.getString("furniture_data");
                            if (_local_11 == null)
                            {
                                _local_11 = "";
                            };
                            _local_7 = _local_12.getString("furniture_purchaser_name");
                            _local_13 = _local_12.getString("furniture_purchaser_figure");
                            _local_10 = _local_12.getNumber("furniture_type_id");
                            _local_5 = _local_12.getString("furniture_extras");
                            _local_6 = 32;
                            _local_9 = _container.roomEngine.getFurnitureImage(_local_10, new Vector3d(180), _local_6, null, 0, _local_5);
                            _local_2 = new RoomWidgetPresentDataUpdateEvent("RWPDUE_PACKAGEINFO", _local_4.id, _local_11, _container.isOwnerOfFurniture(_local_3), _local_9.data, _local_7, _local_13);
                            _container.events.dispatchEvent(_local_2);
                        };
                    };
                    break;
                case "RWPOM_OPEN_PRESENT":
                    _local_8 = (_arg_1 as RoomWidgetPresentOpenMessage);
                    if (_local_8.objectId != _SafeStr_1922)
                    {
                        return (null);
                    };
                    if (_container != null)
                    {
                        if (_container.roomSession != null)
                        {
                            _container.roomSession.sendPresentOpenMessage(_local_8.objectId);
                        };
                        if (_container.roomEngine != null)
                        {
                            _container.roomEngine.changeObjectModelData(_container.roomEngine.activeRoomId, _local_8.objectId, 10, "furniture_disable_picking_animation", 1);
                        };
                    };
            };
            return (null);
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            if (((disposed) || (_container == null)))
            {
                return;
            };
            var _local_3:RoomWidgetPresentDataUpdateEvent = new RoomWidgetPresentDataUpdateEvent("RWPDUE_CONTENTS_IMAGE", 0, _name, false, _arg_2);
            _container.events.dispatchEvent(_local_3);
        }

        public function imageFailed(_arg_1:int):void
        {
        }

        public function getProcessedEvents():Array
        {
            return (["RSPE_PRESENT_OPENED"]);
        }

        public function processEvent(_arg_1:Event):void
        {
            var _local_13:RoomSessionPresentEvent;
            var _local_3:IFurnitureData;
            var _local_5:_SafeStr_147;
            var _local_10:RoomWidgetPresentDataUpdateEvent;
            var _local_2:Boolean;
            var _local_11:IRoomObject;
            var _local_6:IProductData;
            var _local_14:String;
            var _local_4:String;
            var _local_8:int;
            var _local_9:String;
            var _local_12:PetFigureData;
            var _local_16:int;
            var _local_7:int;
            var _local_15:_SafeStr_147;
            if (_arg_1 == null)
            {
                return;
            };
            if ((((!(_container == null)) && (!(_container.events == null))) && (!(_arg_1 == null))))
            {
                switch (_arg_1.type)
                {
                    case "RSPE_PRESENT_OPENED":
                        _local_13 = (_arg_1 as RoomSessionPresentEvent);
                        if (_local_13 != null)
                        {
                            _name = "";
                            _local_5 = null;
                            if (_local_13.itemType == "s")
                            {
                                _local_3 = _container.sessionDataManager.getFloorItemData(_local_13.classId);
                            }
                            else
                            {
                                if (_local_13.itemType == "i")
                                {
                                    _local_3 = _container.sessionDataManager.getWallItemData(_local_13.classId);
                                };
                            };
                            _local_2 = false;
                            if (_local_13.placedInRoom)
                            {
                                _local_11 = _container.roomEngine.getRoomObject(_container.roomSession.roomId, _local_13.placedItemId, 10);
                                if (_local_11 != null)
                                {
                                    _local_2 = _container.isOwnerOfFurniture(_local_11);
                                };
                            };
                            switch (_local_13.itemType)
                            {
                                case "i":
                                    if (_local_3 != null)
                                    {
                                        switch (_local_3.className)
                                        {
                                            case "floor":
                                                _local_10 = new RoomWidgetPresentDataUpdateEvent("RWPDUE_CONTENTS_FLOOR", 0, _container.localization.getLocalization("inventory.furni.item.floor.name"), _local_2, null);
                                                break;
                                            case "landscape":
                                                _local_10 = new RoomWidgetPresentDataUpdateEvent("RWPDUE_CONTENTS_LANDSCAPE", 0, _container.localization.getLocalization("inventory.furni.item.landscape.name"), _local_2, null);
                                                break;
                                            case "wallpaper":
                                                _local_10 = new RoomWidgetPresentDataUpdateEvent("RWPDUE_CONTENTS_WALLPAPER", 0, _container.localization.getLocalization("inventory.furni.item.wallpaper.name"), _local_2, null);
                                                break;
                                            case "poster":
                                                _local_14 = _local_13.productCode;
                                                _local_4 = null;
                                                if (_local_14.indexOf("poster") == 0)
                                                {
                                                    _local_8 = int(_local_14.replace("poster", ""));
                                                    _local_4 = String(_local_8);
                                                };
                                                _local_5 = _container.roomEngine.getWallItemIcon(_local_13.classId, this, _local_4);
                                                _local_6 = _container.sessionDataManager.getProductData(_local_14);
                                                if (_local_6 != null)
                                                {
                                                    _name = _local_6.name;
                                                }
                                                else
                                                {
                                                    if (_local_3 != null)
                                                    {
                                                        _name = _local_3.localizedName;
                                                    };
                                                };
                                                if (_local_5 != null)
                                                {
                                                    _local_10 = new RoomWidgetPresentDataUpdateEvent("RWPDUE_CONTENTS", 0, _name, _local_2, _local_5.data);
                                                };
                                                break;
                                            default:
                                                _local_5 = _container.roomEngine.getWallItemIcon(_local_13.classId, this);
                                                if (_local_3 != null)
                                                {
                                                    _name = _local_3.localizedName;
                                                };
                                                if (_local_5 != null)
                                                {
                                                    _local_10 = new RoomWidgetPresentDataUpdateEvent("RWPDUE_CONTENTS", 0, _name, _local_2, _local_5.data);
                                                };
                                        };
                                    };
                                    break;
                                case "h":
                                    _local_10 = new RoomWidgetPresentDataUpdateEvent("RWPDUE_CONTENTS_CLUB", 0, _container.localization.getLocalization("widget.furni.present.hc"), false, null);
                                    break;
                                default:
                                    if (_local_13.placedItemType == "p")
                                    {
                                        _local_9 = _local_13.petFigureString;
                                        if (((!(_local_9 == null)) && (_local_9.length > 0)))
                                        {
                                            _local_12 = new PetFigureData(_local_9);
                                            _local_16 = 2;
                                            _local_7 = 64;
                                            if (_local_12.typeId == 15)
                                            {
                                                _local_7 = 32;
                                            };
                                            _local_15 = _container.roomEngine.getPetImage(_local_12.typeId, _local_12.paletteId, _local_12.color, new Vector3d((_local_16 * 45)), _local_7, this, true, 0, _local_12.customParts);
                                            if (_local_15 != null)
                                            {
                                                _local_5 = _local_15;
                                            };
                                        };
                                    };
                                    if (_local_5 == null)
                                    {
                                        _local_5 = _container.roomEngine.getFurnitureImage(_local_13.classId, new Vector3d(90), 64, this);
                                    };
                                    _local_6 = _container.sessionDataManager.getProductData(_local_13.productCode);
                                    if (_local_6 != null)
                                    {
                                        _name = _local_6.name;
                                    }
                                    else
                                    {
                                        if (_local_3 != null)
                                        {
                                            _name = _local_3.localizedName;
                                        };
                                    };
                                    if (_local_5 != null)
                                    {
                                        _local_10 = new RoomWidgetPresentDataUpdateEvent("RWPDUE_CONTENTS", 0, _name, _local_2, _local_5.data);
                                    };
                            };
                            if (_local_10 != null)
                            {
                                _local_10.classId = _local_13.classId;
                                _local_10.itemType = _local_13.itemType;
                                _local_10.placedItemId = _local_13.placedItemId;
                                _local_10.placedInRoom = _local_13.placedInRoom;
                                _local_10.placedItemType = _local_13.placedItemType;
                                _container.events.dispatchEvent(_local_10);
                            };
                        };
                        return;
                };
            };
        }

        public function update():void
        {
        }


    }
}