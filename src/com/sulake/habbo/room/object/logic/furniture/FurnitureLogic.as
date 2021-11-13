package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.object.logic.MovingObjectLogic;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.object.IRoomObjectController;
    import com.sulake.room.utils._SafeStr_93;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.room.events.RoomObjectMouseEvent;
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.habbo.room.events.RoomObjectStateChangeEvent;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectHeightUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectItemDataUpdateMessage;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.room.messages.RoomObjectMoveUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectSelectedMessage;

    public class FurnitureLogic extends MovingObjectLogic
    {

        private static const BOUNCE_STEPS:int = 8;
        private static const BOUNCE_STEP_HEIGHT:Number = 0.0625;

        private var _mouseOver:Boolean = false;
        private var _SafeStr_3191:Number = 0;
        private var _SafeStr_3192:Number = 0;
        private var _SafeStr_3193:Number = 0;
        private var _SafeStr_2291:Number = 0;
        private var _SafeStr_2292:Number = 0;
        private var _SafeStr_3194:Number = 0;
        private var _SafeStr_3195:Boolean = false;
        private var _SafeStr_3196:int = 0;
        private var _storedRotateMessage:RoomObjectUpdateMessage;
        private var _locationOffset:Vector3d = new Vector3d();
        private var _directions:Array = [];


        override public function getEventTypes():Array
        {
            var _local_1:Array = ["RORAE_ROOM_AD_TOOLTIP_SHOW", "RORAE_ROOM_AD_TOOLTIP_HIDE", "RORAE_ROOM_AD_FURNI_DOUBLE_CLICK", "ROSCE_STATE_CHANGE", "ROE_MOUSE_CLICK", "RORAE_ROOM_AD_FURNI_CLICK", "ROE_MOUSE_DOWN"];
            if (widget != null)
            {
                _local_1.push("ROWRE_OPEN_WIDGET");
                _local_1.push("ROWRE_CLOSE_WIDGET");
            };
            if (contextMenu != null)
            {
                _local_1.push("ROWRE_OPEN_FURNI_CONTEXT_MENU");
                _local_1.push("ROWRE_CLOSE_FURNI_CONTEXT_MENU");
            };
            return (getAllEventTypes(super.getEventTypes(), _local_1));
        }

        override public function dispose():void
        {
            super.dispose();
            _storedRotateMessage = null;
            _directions = null;
        }

        override public function set object(_arg_1:IRoomObjectController):void
        {
            super.object = _arg_1;
            if (((!(_arg_1 == null)) && (_arg_1.getLocation().length > 0)))
            {
                _SafeStr_3195 = true;
            };
        }

        override public function initialize(_arg_1:XML):void
        {
            var _local_6:int;
            var _local_11:XML;
            var _local_7:int;
            if (_arg_1 == null)
            {
                return;
            };
            _SafeStr_3191 = 0;
            _SafeStr_3192 = 0;
            _SafeStr_3193 = 0;
            _directions = [];
            var _local_10:XMLList = _arg_1.model.dimensions;
            if (_local_10.length() == 0)
            {
                return;
            };
            var _local_2:XMLList = _local_10.@x;
            if (_local_2.length() == 1)
            {
                _SafeStr_3191 = Number(_local_2);
            };
            _local_2 = _local_10.@y;
            if (_local_2.length() == 1)
            {
                _SafeStr_3192 = Number(_local_2);
            };
            _local_2 = _local_10.@z;
            if (_local_2.length() == 1)
            {
                _SafeStr_3193 = Number(_local_2);
            };
            _SafeStr_2291 = (_SafeStr_3191 / 2);
            _SafeStr_2292 = (_SafeStr_3192 / 2);
            _local_2 = _local_10.@centerZ;
            if (_local_2.length() == 1)
            {
                _SafeStr_3194 = Number(_local_2);
            }
            else
            {
                _SafeStr_3194 = (_SafeStr_3193 / 2);
            };
            var _local_4:XMLList = _arg_1.model.directions.direction;
            var _local_5:Array = ["id"];
            _local_6 = 0;
            while (_local_6 < _local_4.length())
            {
                _local_11 = _local_4[_local_6];
                if (_SafeStr_93.checkRequiredAttributes(_local_11, _local_5))
                {
                    _local_7 = parseInt(_local_11.@id);
                    _directions.push(_local_7);
                };
                _local_6++;
            };
            _directions.sort(16);
            if (((object == null) || (object.getModelController() == null)))
            {
                return;
            };
            var _local_9:XMLList = _arg_1.customvars.variable;
            var _local_8:Array = [];
            for each (var _local_3:XML in _local_9)
            {
                _local_8.push(_local_3.@name.toString());
            };
            object.getModelController().setStringArray("furniture_custom_variables", _local_8, true);
            object.getModelController().setNumber("furniture_size_x", _SafeStr_3191, true);
            object.getModelController().setNumber("furniture_size_y", _SafeStr_3192, true);
            if (!object.getModelController().hasNumber("furniture_size_z"))
            {
                object.getModelController().setNumber("furniture_size_z", _SafeStr_3193);
            };
            object.getModelController().setNumber("furniture_center_x", _SafeStr_2291, true);
            object.getModelController().setNumber("furniture_center_y", _SafeStr_2292, true);
            object.getModelController().setNumber("furniture_center_z", _SafeStr_3194, true);
            object.getModelController().setNumberArray("furniture_allowed_directions", _directions, true);
            object.getModelController().setNumber("furniture_alpha_multiplier", 1);
        }

        protected function getAdClickUrl(_arg_1:IRoomObjectModelController):String
        {
            return (_arg_1.getString("furniture_ad_url"));
        }

        protected function handleAdClick(_arg_1:int, _arg_2:String, _arg_3:String):void
        {
            if (eventDispatcher != null)
            {
                eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent("RORAE_ROOM_AD_FURNI_CLICK", object));
            };
        }

        override public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
            var _local_5:RoomObjectEvent;
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return;
            };
            if (object == null)
            {
                return;
            };
            var _local_4:IRoomObjectModelController = (object.getModel() as IRoomObjectModelController);
            if (_local_4 == null)
            {
                return;
            };
            var _local_3:String = getAdClickUrl(_local_4);
            switch (_arg_1.type)
            {
                case "mouseMove":
                    if (eventDispatcher != null)
                    {
                        _local_5 = new RoomObjectMouseEvent("ROE_MOUSE_MOVE", object, _arg_1.eventId, _arg_1.altKey, _arg_1.ctrlKey, _arg_1.shiftKey, _arg_1.buttonDown);
                        (_local_5 as RoomObjectMouseEvent).localX = _arg_1.localX;
                        (_local_5 as RoomObjectMouseEvent).localY = _arg_1.localY;
                        (_local_5 as RoomObjectMouseEvent).spriteOffsetX = _arg_1.spriteOffsetX;
                        (_local_5 as RoomObjectMouseEvent).spriteOffsetY = _arg_1.spriteOffsetY;
                        eventDispatcher.dispatchEvent(_local_5);
                    };
                    return;
                case "rollOver":
                    if (!_mouseOver)
                    {
                        if ((((!(eventDispatcher == null)) && (!(_local_3 == null))) && (_local_3.indexOf("http") == 0)))
                        {
                            eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent("RORAE_ROOM_AD_TOOLTIP_SHOW", object));
                        };
                        if (eventDispatcher != null)
                        {
                            _local_5 = new RoomObjectMouseEvent("ROE_MOUSE_ENTER", object, _arg_1.eventId, _arg_1.altKey, _arg_1.ctrlKey, _arg_1.shiftKey, _arg_1.buttonDown);
                            (_local_5 as RoomObjectMouseEvent).localX = _arg_1.localX;
                            (_local_5 as RoomObjectMouseEvent).localY = _arg_1.localY;
                            (_local_5 as RoomObjectMouseEvent).spriteOffsetX = _arg_1.spriteOffsetX;
                            (_local_5 as RoomObjectMouseEvent).spriteOffsetY = _arg_1.spriteOffsetY;
                            eventDispatcher.dispatchEvent(_local_5);
                        };
                        _mouseOver = true;
                    };
                    return;
                case "rollOut":
                    if (_mouseOver)
                    {
                        if ((((!(eventDispatcher == null)) && (!(_local_3 == null))) && (_local_3.indexOf("http") == 0)))
                        {
                            eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent("RORAE_ROOM_AD_TOOLTIP_HIDE", object));
                        };
                        if (eventDispatcher != null)
                        {
                            _local_5 = new RoomObjectMouseEvent("ROE_MOUSE_LEAVE", object, _arg_1.eventId, _arg_1.altKey, _arg_1.ctrlKey, _arg_1.shiftKey, _arg_1.buttonDown);
                            (_local_5 as RoomObjectMouseEvent).localX = _arg_1.localX;
                            (_local_5 as RoomObjectMouseEvent).localY = _arg_1.localY;
                            (_local_5 as RoomObjectMouseEvent).spriteOffsetX = _arg_1.spriteOffsetX;
                            (_local_5 as RoomObjectMouseEvent).spriteOffsetY = _arg_1.spriteOffsetY;
                            eventDispatcher.dispatchEvent(_local_5);
                        };
                        _mouseOver = false;
                    };
                    return;
                case "doubleClick":
                    useObject();
                    return;
                case "click":
                    if (eventDispatcher != null)
                    {
                        _local_5 = new RoomObjectMouseEvent("ROE_MOUSE_CLICK", object, _arg_1.eventId, _arg_1.altKey, _arg_1.ctrlKey, _arg_1.shiftKey, _arg_1.buttonDown);
                        (_local_5 as RoomObjectMouseEvent).localX = _arg_1.localX;
                        (_local_5 as RoomObjectMouseEvent).localY = _arg_1.localY;
                        (_local_5 as RoomObjectMouseEvent).spriteOffsetX = _arg_1.spriteOffsetX;
                        (_local_5 as RoomObjectMouseEvent).spriteOffsetY = _arg_1.spriteOffsetY;
                        eventDispatcher.dispatchEvent(_local_5);
                    };
                    if ((((!(eventDispatcher == null)) && (!(_local_3 == null))) && (_local_3.indexOf("http") == 0)))
                    {
                        eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent("RORAE_ROOM_AD_TOOLTIP_HIDE", object));
                    };
                    if (((!(eventDispatcher == null)) && (!(_local_3 == null))))
                    {
                        handleAdClick(object.getId(), object.getType(), _local_3);
                    };
                    if ((((!(eventDispatcher == null)) && (!(object == null))) && (!(contextMenu == null))))
                    {
                        eventDispatcher.dispatchEvent(new RoomObjectWidgetRequestEvent("ROWRE_OPEN_FURNI_CONTEXT_MENU", object));
                    };
                    return;
                case "mouseDown":
                    if (eventDispatcher != null)
                    {
                        _local_5 = new RoomObjectMouseEvent("ROE_MOUSE_DOWN", object, _arg_1.eventId, _arg_1.altKey, _arg_1.ctrlKey, _arg_1.shiftKey, _arg_1.buttonDown);
                        eventDispatcher.dispatchEvent(_local_5);
                    };
                    return;
                default:
                    return;
            };
        }

        override public function useObject():void
        {
            var _local_2:IRoomObjectModelController;
            var _local_1:String;
            if (object != null)
            {
                _local_2 = (object.getModel() as IRoomObjectModelController);
                if (_local_2 != null)
                {
                    _local_1 = getAdClickUrl(_local_2);
                    if ((((!(eventDispatcher == null)) && (!(_local_1 == null))) && (_local_1.length > 0)))
                    {
                        eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent("RORAE_ROOM_AD_FURNI_DOUBLE_CLICK", object, null, _local_1));
                    };
                };
                if (eventDispatcher != null)
                {
                    if (widget != null)
                    {
                        eventDispatcher.dispatchEvent(new RoomObjectWidgetRequestEvent("ROWRE_OPEN_WIDGET", object));
                    };
                    eventDispatcher.dispatchEvent(new RoomObjectStateChangeEvent("ROSCE_STATE_CHANGE", object));
                };
            };
        }

        private function handleDataUpdateMessage(_arg_1:RoomObjectDataUpdateMessage):void
        {
            var _local_2:IRoomObjectModelController = object.getModelController();
            object.setState(_arg_1.state, 0);
            if (_local_2 != null)
            {
                if (_arg_1.data != null)
                {
                    _arg_1.data.writeRoomObjectModel(_local_2);
                };
                if (!isNaN(_arg_1.extra))
                {
                    _local_2.setString("furniture_extras", String(_arg_1.extra));
                };
                _local_2.setNumber("furniture_state_update_time", lastUpdateTime);
            };
        }

        private function handleHeightUpdateMessage(_arg_1:RoomObjectHeightUpdateMessage):void
        {
            var _local_2:IRoomObjectModelController = object.getModelController();
            if (_local_2 != null)
            {
                _local_2.setNumber("furniture_size_z", _arg_1.height);
            };
        }

        private function handleItemDataUpdateMessage(_arg_1:RoomObjectItemDataUpdateMessage):void
        {
            var _local_2:IRoomObjectModelController = object.getModelController();
            if (_local_2 != null)
            {
                _local_2.setString("furniture_itemdata", _arg_1.itemData);
            };
        }

        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_5:IVector3d;
            var _local_2:IVector3d;
            var _local_7:String;
            var _local_8:RoomObjectDataUpdateMessage = (_arg_1 as RoomObjectDataUpdateMessage);
            if (_local_8 != null)
            {
                handleDataUpdateMessage(_local_8);
                return;
            };
            var _local_4:RoomObjectHeightUpdateMessage = (_arg_1 as RoomObjectHeightUpdateMessage);
            if (_local_4 != null)
            {
                handleHeightUpdateMessage(_local_4);
                return;
            };
            var _local_6:RoomObjectItemDataUpdateMessage = (_arg_1 as RoomObjectItemDataUpdateMessage);
            if (_local_6 != null)
            {
                handleItemDataUpdateMessage(_local_6);
                return;
            };
            _mouseOver = false;
            if (((!(_arg_1.dir == null)) && (!(_arg_1.loc == null))))
            {
                if (!(_arg_1 is RoomObjectMoveUpdateMessage))
                {
                    _local_5 = object.getDirection();
                    _local_2 = object.getLocation();
                    if ((((((((!(_local_5 == null)) && (!(_local_5.x == _arg_1.dir.x))) && (_SafeStr_3195)) && (!(_local_2 == null))) && (_local_2.x == _arg_1.loc.x)) && (_local_2.y == _arg_1.loc.y)) && (_local_2.z == _arg_1.loc.z)))
                    {
                        _SafeStr_3196 = 1;
                        _storedRotateMessage = new RoomObjectUpdateMessage(_arg_1.loc, _arg_1.dir);
                        _arg_1 = null;
                    };
                };
                _SafeStr_3195 = true;
            };
            var _local_3:RoomObjectSelectedMessage = (_arg_1 as RoomObjectSelectedMessage);
            if (((((!(contextMenu == null)) && (!(_local_3 == null))) && (!(eventDispatcher == null))) && (!(object == null))))
            {
                _local_7 = ((_local_3.selected) ? "ROWRE_OPEN_FURNI_CONTEXT_MENU" : "ROWRE_CLOSE_FURNI_CONTEXT_MENU");
                eventDispatcher.dispatchEvent(new RoomObjectWidgetRequestEvent(_local_7, object));
            };
            super.processUpdateMessage(_arg_1);
        }

        override protected function getLocationOffset():IVector3d
        {
            if (_SafeStr_3196 > 0)
            {
                _locationOffset.x = 0;
                _locationOffset.y = 0;
                if (_SafeStr_3196 <= (8 / 2))
                {
                    _locationOffset.z = (0.0625 * _SafeStr_3196);
                }
                else
                {
                    if (_SafeStr_3196 <= 8)
                    {
                        if (_storedRotateMessage)
                        {
                            super.processUpdateMessage(_storedRotateMessage);
                            _storedRotateMessage = null;
                        };
                        _locationOffset.z = (0.0625 * (8 - _SafeStr_3196));
                    };
                };
                return (_locationOffset);
            };
            return (null);
        }

        override public function update(_arg_1:int):void
        {
            super.update(_arg_1);
            if (_SafeStr_3196 > 0)
            {
                _SafeStr_3196++;
                if (_SafeStr_3196 > 8)
                {
                    _SafeStr_3196 = 0;
                };
            };
        }

        override public function tearDown():void
        {
            if (((!(widget == null)) && (object.getModelController().getNumber("furniture_real_room_object") == 1)))
            {
                eventDispatcher.dispatchEvent(new RoomObjectWidgetRequestEvent("ROWRE_CLOSE_WIDGET", object));
            };
            super.tearDown();
        }


    }
}