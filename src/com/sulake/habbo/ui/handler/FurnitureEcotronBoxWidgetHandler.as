package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.ui.widget.events.RoomWidgetEcotronBoxDataUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetEcotronBoxOpenMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.display.BitmapData;
    import com.sulake.habbo.session.events.RoomSessionPresentEvent;
    import com.sulake.habbo.room._SafeStr_147;
    import flash.events.Event;

    public class FurnitureEcotronBoxWidgetHandler implements IRoomWidgetHandler, IGetImageListener 
    {

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
            return ("RWE_FURNI_ECOTRONBOX_WIDGET");
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
            return (["RWFWM_MESSAGE_REQUEST_ECOTRONBOX", "RWEBOM_OPEN_ECOTRONBOX", "RWEBOM_ECOTRONBOX_OPENED"]);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_7:RoomWidgetFurniToWidgetMessage;
            var _local_5:IRoomObject;
            var _local_11:IRoomObjectModel;
            var _local_10:String;
            var _local_6:int;
            var _local_9:IFurnitureData;
            var _local_8:String;
            var _local_2:Boolean;
            var _local_3:RoomWidgetEcotronBoxDataUpdateEvent;
            var _local_4:RoomWidgetEcotronBoxOpenMessage;
            switch (_arg_1.type)
            {
                case "RWFWM_MESSAGE_REQUEST_ECOTRONBOX":
                    _local_7 = (_arg_1 as RoomWidgetFurniToWidgetMessage);
                    _local_5 = _container.roomEngine.getRoomObject(_local_7.roomId, _local_7.id, _local_7.category);
                    if (_local_5 != null)
                    {
                        _local_11 = _local_5.getModel();
                        if (_local_11 != null)
                        {
                            _SafeStr_1922 = _local_7.id;
                            _local_10 = _local_11.getString("furniture_data");
                            if (_local_10 == null)
                            {
                                return (null);
                            };
                            _local_6 = _local_11.getNumber("furniture_type_id");
                            _local_9 = _container.sessionDataManager.getFloorItemData(_local_6);
                            _local_8 = ((_local_9 != null) ? _local_9.className : "");
                            _local_2 = ((_container.roomSession.isRoomOwner) || (_container.sessionDataManager.isAnyRoomController));
                            _local_3 = new RoomWidgetEcotronBoxDataUpdateEvent("RWEBDUE_PACKAGEINFO", _local_7.id, _local_10, _local_8, _local_2);
                            _container.events.dispatchEvent(_local_3);
                        };
                    };
                    break;
                case "RWEBOM_OPEN_ECOTRONBOX":
                    _local_4 = (_arg_1 as RoomWidgetEcotronBoxOpenMessage);
                    if (_local_4.objectId != _SafeStr_1922)
                    {
                        return (null);
                    };
                    if (((!(_container == null)) && (!(_container.roomSession == null))))
                    {
                        _container.roomSession.sendPresentOpenMessage(_local_4.objectId);
                    };
            };
            return (null);
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            if (disposed)
            {
                return;
            };
            var _local_3:RoomWidgetEcotronBoxDataUpdateEvent = new RoomWidgetEcotronBoxDataUpdateEvent("RWEBDUE_CONTENTS", 0, _name, "", false, _arg_2);
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
            var _local_5:RoomSessionPresentEvent;
            var _local_4:_SafeStr_147;
            var _local_2:IFurnitureData;
            var _local_3:RoomWidgetEcotronBoxDataUpdateEvent;
            if (_arg_1 == null)
            {
                return;
            };
            if ((((!(_container == null)) && (!(_container.events == null))) && (!(_arg_1 == null))))
            {
                switch (_arg_1.type)
                {
                    case "RSPE_PRESENT_OPENED":
                        _local_5 = (_arg_1 as RoomSessionPresentEvent);
                        if (_local_5 != null)
                        {
                            _local_4 = null;
                            _name = "";
                            if (_local_5.itemType == "s")
                            {
                                _local_4 = _container.roomEngine.getFurnitureIcon(_local_5.classId, this);
                                _local_2 = _container.sessionDataManager.getFloorItemData(_local_5.classId);
                            }
                            else
                            {
                                if (_local_5.itemType == "i")
                                {
                                    _local_4 = _container.roomEngine.getWallItemIcon(_local_5.classId, this);
                                    _local_2 = _container.sessionDataManager.getWallItemData(_local_5.classId);
                                };
                            };
                            if (_local_2 != null)
                            {
                                _name = _local_2.localizedName;
                            };
                            if (_local_4 != null)
                            {
                                _local_3 = new RoomWidgetEcotronBoxDataUpdateEvent("RWEBDUE_CONTENTS", 0, _name, "", false, _local_4.data);
                                _container.events.dispatchEvent(_local_3);
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

