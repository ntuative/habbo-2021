package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.ui.widget.events.ChooserItem;
    import com.sulake.habbo.ui.widget.events.RoomWidgetChooserContentEvent;
    import flash.events.Event;

    public class FurniChooserWidgetHandler implements IRoomWidgetHandler
    {

        private var _container:IRoomWidgetHandlerContainer = null;
        private var _disposed:Boolean = false;


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get type():String
        {
            return ("RWE_FURNI_CHOOSER");
        }

        public function dispose():void
        {
            _disposed = true;
            _container = null;
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            _container = _arg_1;
        }

        public function getWidgetMessages():Array
        {
            var _local_1:Array = [];
            _local_1.push("RWRWM_FURNI_CHOOSER");
            _local_1.push("RWROM_SELECT_OBJECT");
            return (_local_1);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetRoomObjectMessage;
            if (_arg_1 == null)
            {
                return (null);
            };
            switch (_arg_1.type)
            {
                case "RWRWM_FURNI_CHOOSER":
                    handleFurniChooserRequest();
                    break;
                case "RWROM_SELECT_OBJECT":
                    _local_2 = (_arg_1 as RoomWidgetRoomObjectMessage);
                    if (_local_2 == null)
                    {
                        return (null);
                    };
                    if (((_local_2.category == 10) || (_local_2.category == 20)))
                    {
                        _container.roomEngine.selectRoomObject(_container.roomSession.roomId, _local_2.id, _local_2.category);
                    };
            };
            return (null);
        }

        private function handleFurniChooserRequest():void
        {
            var _local_4:int;
            var _local_6:int;
            var _local_5:IFurnitureData;
            var _local_7:String;
            var _local_1:IRoomObject;
            var _local_2:String;
            var _local_10:int;
            if ((((_container == null) || (_container.roomSession == null)) || (_container.roomEngine == null)))
            {
                return;
            };
            if (_container.roomSession.userDataManager == null)
            {
                return;
            };
            var _local_9:int = _container.roomSession.roomId;
            var _local_8:Array = [];
            var _local_3:int = _container.roomEngine.getRoomObjectCount(_local_9, 10);
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_1 = _container.roomEngine.getRoomObjectWithIndex(_local_9, _local_4, 10);
                if (_local_1 != null)
                {
                    _local_6 = _local_1.getModel().getNumber("furniture_type_id");
                    _local_5 = _container.sessionDataManager.getFloorItemData(_local_6);
                    if (_local_5 != null)
                    {
                        _local_7 = _local_5.localizedName;
                    }
                    else
                    {
                        _local_7 = _local_1.getType();
                    };
                    _local_8.push(new ChooserItem(_local_1.getId(), 10, _local_7));
                };
                _local_4++;
            };
            _local_3 = _container.roomEngine.getRoomObjectCount(_local_9, 20);
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_1 = _container.roomEngine.getRoomObjectWithIndex(_local_9, _local_4, 20);
                if (_local_1 != null)
                {
                    _local_2 = _local_1.getType();
                    if (_local_2.indexOf("poster") == 0)
                    {
                        _local_10 = int(_local_2.replace("poster", ""));
                        _local_7 = _container.localization.getLocalization((("poster_" + _local_10) + "_name"), (("poster_" + _local_10) + "_name"));
                    }
                    else
                    {
                        _local_6 = _local_1.getModel().getNumber("furniture_type_id");
                        _local_5 = _container.sessionDataManager.getWallItemData(_local_6);
                        if (((!(_local_5 == null)) && (_local_5.localizedName.length > 0)))
                        {
                            _local_7 = _local_5.localizedName;
                        }
                        else
                        {
                            _local_7 = _local_2;
                        };
                    };
                    _local_8.push(new ChooserItem(_local_1.getId(), 20, _local_7));
                };
                _local_4++;
            };
            _local_8.sort(compareItems);
            _container.events.dispatchEvent(new RoomWidgetChooserContentEvent("RWCCE_FURNI_CHOOSER_CONTENT", _local_8, _container.sessionDataManager.isAnyRoomController));
        }

        private function compareItems(_arg_1:ChooserItem, _arg_2:ChooserItem):int
        {
            if ((((((_arg_1 == null) || (_arg_2 == null)) || (_arg_1.name == _arg_2.name)) || (_arg_1.name.length == 0)) || (_arg_2.name.length == 0)))
            {
                return (1);
            };
            var _local_3:Array = new Array(_arg_1.name.toUpperCase(), _arg_2.name.toUpperCase()).sort();
            if (_local_3.indexOf(_arg_1.name.toUpperCase()) == 0)
            {
                return (-1);
            };
            return (1);
        }

        public function getProcessedEvents():Array
        {
            return (null);
        }

        public function processEvent(_arg_1:Event):void
        {
        }

        public function update():void
        {
        }


    }
}
