package com.sulake.habbo.room.object.logic.room
{
    import com.sulake.room.object.logic.ObjectLogicBase;
    import com.sulake.habbo.room.object.RoomPlaneParser;
    import com.sulake.habbo.room.object.RoomPlaneBitmapMaskParser;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.room.utils.ColorConverter;
    import com.sulake.habbo.room.messages.RoomObjectRoomUpdateMessage;
    import com.sulake.habbo.room.object.RoomPlaneBitmapMaskData;
    import com.sulake.habbo.room.messages.RoomObjectRoomMaskUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectRoomPlaneVisibilityUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectRoomPlanePropertyUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectRoomFloorHoleUpdateMessage;
    import flash.utils.getTimer;
    import com.sulake.habbo.room.messages.RoomObjectRoomColorUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import flash.geom.Point;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.events.RoomObjectTileMouseEvent;
    import com.sulake.habbo.room.events.RoomObjectWallMouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class RoomLogic extends ObjectLogicBase
    {

        protected var _SafeStr_3207:RoomPlaneParser = null;
        private var _SafeStr_3208:RoomPlaneBitmapMaskParser = null;
        private var _color:uint = 0xFFFFFF;
        private var _SafeStr_3209:int = 0xFF;
        private var _originalColor:uint = 0xFFFFFF;
        private var _SafeStr_3210:int = 0xFF;
        private var _targetColor:uint = 0xFFFFFF;
        private var _SafeStr_3211:int = 0xFF;
        private var _colorChangedTime:int = 0;
        private var _colorTransitionLength:int = 1500;
        private var _SafeStr_3212:Boolean;

        public function RoomLogic()
        {
            _SafeStr_3207 = new RoomPlaneParser();
            _SafeStr_3208 = new RoomPlaneBitmapMaskParser();
        }

        override public function getEventTypes():Array
        {
            var _local_1:Array = ["ROE_MOUSE_MOVE", "ROE_MOUSE_CLICK"];
            return (getAllEventTypes(super.getEventTypes(), _local_1));
        }

        override public function dispose():void
        {
            super.dispose();
            if (_SafeStr_3207 != null)
            {
                _SafeStr_3207.dispose();
                _SafeStr_3207 = null;
            };
            if (_SafeStr_3208 != null)
            {
                _SafeStr_3208.dispose();
                _SafeStr_3208 = null;
            };
        }

        override public function initialize(_arg_1:XML):void
        {
            if (((_arg_1 == null) || (object == null)))
            {
                return;
            };
            if (!_SafeStr_3207.initializeFromXML(_arg_1))
            {
                return;
            };
            var _local_2:IRoomObjectModelController = (object.getModel() as IRoomObjectModelController);
            if (_local_2 != null)
            {
                _local_2.setString("room_plane_xml", _arg_1.toString());
                _local_2.setNumber("room_background_color", 0xFFFFFF);
                _local_2.setNumber("room_floor_visibility", 1);
                _local_2.setNumber("room_wall_visibility", 1);
                _local_2.setNumber("room_landscape_visibility", 1);
            };
        }

        override public function update(_arg_1:int):void
        {
            var _local_3:IRoomObjectModelController;
            var _local_2:XML;
            super.update(_arg_1);
            updateBackgroundColor(_arg_1);
            if (_SafeStr_3212)
            {
                if (object != null)
                {
                    _local_3 = (object.getModel() as IRoomObjectModelController);
                    if (_local_3 != null)
                    {
                        _local_2 = _SafeStr_3207.getXML();
                        _local_3.setString("room_plane_xml", _local_2.toString());
                        _local_3.setNumber("room_floor_hole_update_time", _arg_1);
                        _SafeStr_3207.initializeFromXML(_local_2);
                    };
                };
                _SafeStr_3212 = false;
            };
        }

        private function updateBackgroundColor(_arg_1:int):void
        {
            var _local_11:int;
            var _local_5:int;
            var _local_9:int;
            var _local_6:int;
            var _local_3:int;
            var _local_8:int;
            var _local_4:int;
            var _local_12:int;
            var _local_7:int;
            var _local_13:Number;
            var _local_2:int;
            var _local_10:IRoomObjectModelController;
            if (object == null)
            {
                return;
            };
            if (_colorChangedTime)
            {
                _local_11 = _arg_1;
                _local_5 = _color;
                _local_9 = _SafeStr_3209;
                if ((_local_11 - _colorChangedTime) >= _colorTransitionLength)
                {
                    _local_5 = _targetColor;
                    _local_9 = _SafeStr_3211;
                    _colorChangedTime = 0;
                }
                else
                {
                    _local_6 = ((_originalColor >> 16) & 0xFF);
                    _local_3 = ((_originalColor >> 8) & 0xFF);
                    _local_8 = (_originalColor & 0xFF);
                    _local_4 = ((_targetColor >> 16) & 0xFF);
                    _local_12 = ((_targetColor >> 8) & 0xFF);
                    _local_7 = (_targetColor & 0xFF);
                    _local_13 = ((_local_11 - _colorChangedTime) / _colorTransitionLength);
                    _local_6 = (_local_6 + ((_local_4 - _local_6) * _local_13));
                    _local_3 = (_local_3 + ((_local_12 - _local_3) * _local_13));
                    _local_8 = (_local_8 + ((_local_7 - _local_8) * _local_13));
                    _local_5 = (((_local_6 << 16) + (_local_3 << 8)) + _local_8);
                    _local_9 = (_SafeStr_3210 + ((_SafeStr_3211 - _SafeStr_3210) * _local_13));
                    _color = _local_5;
                    _SafeStr_3209 = _local_9;
                };
                _local_2 = ColorConverter.rgbToHSL(_local_5);
                _local_2 = ((_local_2 & 0xFFFF00) + _local_9);
                _local_5 = ColorConverter.hslToRGB(_local_2);
                _local_10 = (object.getModel() as IRoomObjectModelController);
                if (_local_10 == null)
                {
                    return;
                };
                _local_10.setNumber("room_background_color", _local_5);
            };
        }

        private function updatePlaneTypes(_arg_1:RoomObjectRoomUpdateMessage, _arg_2:IRoomObjectModelController):void
        {
            switch (_arg_1.type)
            {
                case "RORUM_ROOM_FLOOR_UPDATE":
                    _arg_2.setString("room_floor_type", _arg_1.value);
                    return;
                case "RORUM_ROOM_WALL_UPDATE":
                    _arg_2.setString("room_wall_type", _arg_1.value);
                    return;
                case "RORUM_ROOM_LANDSCAPE_UPDATE":
                    _arg_2.setString("room_landscape_type", _arg_1.value);
                    return;
            };
        }

        private function updatePlaneMasks(_arg_1:RoomObjectRoomMaskUpdateMessage, _arg_2:IRoomObjectModelController):void
        {
            var _local_7:String;
            var _local_6:XML;
            var _local_4:String;
            var _local_5:RoomPlaneBitmapMaskData;
            var _local_3:Boolean;
            switch (_arg_1.type)
            {
                case "RORMUM_ADD_MASK":
                    _local_7 = "window";
                    if (_arg_1.maskCategory == "hole")
                    {
                        _local_7 = "hole";
                    };
                    _SafeStr_3208.addMask(_arg_1.maskId, _arg_1.maskType, _arg_1.maskLocation, _local_7);
                    _local_3 = true;
                    break;
                case "RORMUM_ADD_MASK":
                    _local_3 = _SafeStr_3208.removeMask(_arg_1.maskId);
            };
            if (_local_3)
            {
                _local_6 = _SafeStr_3208.getXML();
                _local_4 = _local_6.toXMLString();
                _arg_2.setString("room_plane_mask_xml", _local_4);
            };
        }

        private function updatePlaneVisibilities(_arg_1:RoomObjectRoomPlaneVisibilityUpdateMessage, _arg_2:IRoomObjectModelController):void
        {
            var _local_3:int;
            if (_arg_1.visible)
            {
                _local_3 = 1;
            };
            switch (_arg_1.type)
            {
                case "RORPVUM_FLOOR_VISIBILITY":
                    _arg_2.setNumber("room_floor_visibility", _local_3);
                    return;
                case "RORPVUM_WALL_VISIBILITY":
                    _arg_2.setNumber("room_wall_visibility", _local_3);
                    _arg_2.setNumber("room_landscape_visibility", _local_3);
                    return;
            };
        }

        private function updatePlaneProperties(_arg_1:RoomObjectRoomPlanePropertyUpdateMessage, _arg_2:IRoomObjectModelController):void
        {
            switch (_arg_1.type)
            {
                case "RORPVUM_FLOOR_THICKNESS":
                    _arg_2.setNumber("room_floor_thickness", _arg_1.value);
                    return;
                case "RORPPUM_WALL_THICKNESS":
                    _arg_2.setNumber("room_wall_thickness", _arg_1.value);
                    return;
            };
        }

        private function updateFloorHoles(_arg_1:RoomObjectRoomFloorHoleUpdateMessage, _arg_2:IRoomObjectModelController):void
        {
            switch (_arg_1.type)
            {
                case "RORPFHUM_ADD":
                    _SafeStr_3207.addFloorHole(_arg_1.id, _arg_1.x, _arg_1.y, _arg_1.width, _arg_1.height);
                    _SafeStr_3212 = true;
                    return;
                case "RORPFHUM_REMOVE":
                    _SafeStr_3207.removeFloorHole(_arg_1.id);
                    _SafeStr_3212 = true;
                    return;
            };
        }

        private function updateColors(_arg_1:RoomObjectRoomColorUpdateMessage, _arg_2:IRoomObjectModelController):void
        {
            var _local_3:int = _arg_1.color;
            var _local_4:int = _arg_1.light;
            _arg_2.setNumber("room_colorize_bg_only", Number(_arg_1.bgOnly));
            _originalColor = _color;
            _SafeStr_3210 = _SafeStr_3209;
            _targetColor = _local_3;
            _SafeStr_3211 = _local_4;
            _colorChangedTime = getTimer();
            _colorTransitionLength = 1500;
        }

        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            if (((_arg_1 == null) || (object == null)))
            {
                return;
            };
            var _local_5:IRoomObjectModelController = (object.getModel() as IRoomObjectModelController);
            if (_local_5 == null)
            {
                return;
            };
            var _local_3:RoomObjectRoomUpdateMessage = (_arg_1 as RoomObjectRoomUpdateMessage);
            if (_local_3 != null)
            {
                updatePlaneTypes(_local_3, _local_5);
                return;
            };
            var _local_2:RoomObjectRoomMaskUpdateMessage = (_arg_1 as RoomObjectRoomMaskUpdateMessage);
            if (_local_2 != null)
            {
                updatePlaneMasks(_local_2, _local_5);
                return;
            };
            var _local_6:RoomObjectRoomPlaneVisibilityUpdateMessage = (_arg_1 as RoomObjectRoomPlaneVisibilityUpdateMessage);
            if (_local_6 != null)
            {
                updatePlaneVisibilities(_local_6, _local_5);
                return;
            };
            var _local_4:RoomObjectRoomPlanePropertyUpdateMessage = (_arg_1 as RoomObjectRoomPlanePropertyUpdateMessage);
            if (_local_4 != null)
            {
                updatePlaneProperties(_local_4, _local_5);
                return;
            };
            var _local_8:RoomObjectRoomFloorHoleUpdateMessage = (_arg_1 as RoomObjectRoomFloorHoleUpdateMessage);
            if (_local_8 != null)
            {
                updateFloorHoles(_local_8, _local_5);
            };
            var _local_7:RoomObjectRoomColorUpdateMessage = (_arg_1 as RoomObjectRoomColorUpdateMessage);
            if (_local_7 != null)
            {
                updateColors(_local_7, _local_5);
                return;
            };
        }

        override public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
            var _local_20:String;
            var _local_14:Number;
            var _local_23:Number;
            var _local_24:Number;
            if (_arg_2 == null)
            {
                return;
            };
            var _local_7:RoomSpriteMouseEvent = _arg_1;
            if (_local_7 == null)
            {
                return;
            };
            if (((object == null) || (_arg_1 == null)))
            {
                return;
            };
            var _local_9:IRoomObjectModelController = (object.getModel() as IRoomObjectModelController);
            if (_local_9 == null)
            {
                return;
            };
            var _local_10:int;
            var _local_11:String = _local_7.spriteTag;
            if (((!(_local_11 == null)) && (_local_11.indexOf("@") >= 0)))
            {
                _local_10 = parseInt(_local_11.substr((_local_11.indexOf("@") + 1)));
            };
            if (((_local_10 < 1) || (_local_10 > _SafeStr_3207.planeCount)))
            {
                if (_arg_1.type == "rollOut")
                {
                    _local_9.setNumber("room_selected_plane", 0);
                };
                return;
            };
            _local_10 = (_local_10 - 1);
            var _local_15:Point;
            var _local_4:IVector3d = _SafeStr_3207.getPlaneLocation(_local_10);
            var _local_8:IVector3d = _SafeStr_3207.getPlaneLeftSide(_local_10);
            var _local_19:IVector3d = _SafeStr_3207.getPlaneRightSide(_local_10);
            var _local_25:IVector3d = _SafeStr_3207.getPlaneNormalDirection(_local_10);
            var _local_21:int = _SafeStr_3207.getPlaneType(_local_10);
            if (((((_local_4 == null) || (_local_8 == null)) || (_local_19 == null)) || (_local_25 == null)))
            {
                return;
            };
            var _local_22:Number = _local_8.length;
            var _local_5:Number = _local_19.length;
            if (((_local_22 == 0) || (_local_5 == 0)))
            {
                return;
            };
            var _local_27:Number = _local_7.screenX;
            var _local_28:Number = _local_7.screenY;
            var _local_26:Point = new Point(_local_27, _local_28);
            _local_15 = _arg_2.getPlanePosition(_local_26, _local_4, _local_8, _local_19);
            if (_local_15 == null)
            {
                _local_9.setNumber("room_selected_plane", 0);
                return;
            };
            var _local_3:Vector3d = Vector3d.product(_local_8, (_local_15.x / _local_22));
            _local_3.add(Vector3d.product(_local_19, (_local_15.y / _local_5)));
            _local_3.add(_local_4);
            var _local_16:Number = _local_3.x;
            var _local_17:Number = _local_3.y;
            var _local_18:Number = _local_3.z;
            if (((((_local_15.x >= 0) && (_local_15.x < _local_22)) && (_local_15.y >= 0)) && (_local_15.y < _local_5)))
            {
                _local_9.setNumber("room_selected_x", _local_16);
                _local_9.setNumber("room_selected_y", _local_17);
                _local_9.setNumber("room_selected_z", _local_18);
                _local_9.setNumber("room_selected_plane", (_local_10 + 1));
            }
            else
            {
                _local_9.setNumber("room_selected_plane", 0);
                return;
            };
            var _local_6:String = "";
            var _local_12:int;
            var _local_13:RoomObjectEvent;
            switch (_arg_1.type)
            {
                case "mouseMove":
                case "rollOver":
                case "click":
                    _local_20 = "";
                    if (((_arg_1.type == "mouseMove") || (_arg_1.type == "rollOver")))
                    {
                        _local_20 = "ROE_MOUSE_MOVE";
                    }
                    else
                    {
                        if (_arg_1.type == "click")
                        {
                            _local_20 = "ROE_MOUSE_CLICK";
                        };
                    };
                    if (eventDispatcher != null)
                    {
                        if (_local_21 == 1)
                        {
                            _local_13 = new RoomObjectTileMouseEvent(_local_20, object, _arg_1.eventId, _local_16, _local_17, _local_18, _arg_1.altKey, _arg_1.ctrlKey, _arg_1.shiftKey);
                        }
                        else
                        {
                            if (((_local_21 == 2) || (_local_21 == 3)))
                            {
                                _local_14 = 90;
                                if (_local_25 != null)
                                {
                                    _local_14 = (_local_25.x + 90);
                                    if (_local_14 > 360)
                                    {
                                        _local_14 = (_local_14 - 360);
                                    };
                                };
                                _local_23 = ((_local_8.length * _local_15.x) / _local_22);
                                _local_24 = ((_local_19.length * _local_15.y) / _local_5);
                                _local_13 = new RoomObjectWallMouseEvent(_local_20, object, _arg_1.eventId, _local_4, _local_8, _local_19, _local_23, _local_24, _local_14);
                            };
                        };
                        if (_local_13 != null)
                        {
                            eventDispatcher.dispatchEvent(_local_13);
                        };
                    };
                    return;
                default:
                    return;
            };
        }


    }
}