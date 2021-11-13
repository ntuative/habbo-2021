package com.sulake.habbo.room.object.logic
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.events.RoomObjectMoveEvent;
    import com.sulake.room.utils._SafeStr_93;
    import com.sulake.habbo.room.messages.RoomObjectAvatarPostureUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarChatUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarPetGestureUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarSleepUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarSelectedMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarExperienceUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectAvatarFigureUpdateMessage;
    import com.sulake.habbo.avatar.pets.PetFigureData;
    import com.sulake.room.object.IRoomObjectModelController;
    import flash.utils.getTimer;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.events.RoomObjectMouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class PetLogic extends MovingObjectLogic
    {

        private var _SafeStr_3220:int = 0;
        private var _SafeStr_3224:int = 0;
        private var _SafeStr_3232:int = 0;
        private var _selected:Boolean = false;
        private var _SafeStr_3217:Vector3d = null;
        private var _SafeStr_3233:Boolean = false;
        private var _SafeStr_3234:int = 0;
        private var _SafeStr_3235:int = 0;
        private var _headDirectionDelta:int = 0;
        private var _SafeStr_3236:int = 0;
        private var _directions:Array = [];


        override public function getEventTypes():Array
        {
            var _local_1:Array = ["ROE_MOUSE_CLICK", "ROME_POSITION_CHANGED"];
            return (getAllEventTypes(super.getEventTypes(), _local_1));
        }

        override public function dispose():void
        {
            var _local_1:RoomObjectEvent;
            if (((_selected) && (!(object == null))))
            {
                if (eventDispatcher != null)
                {
                    _local_1 = new RoomObjectMoveEvent("ROME_OBJECT_REMOVED", object);
                    eventDispatcher.dispatchEvent(_local_1);
                };
            };
            _directions = null;
            super.dispose();
            _SafeStr_3217 = null;
        }

        override public function initialize(_arg_1:XML):void
        {
            var _local_4:int;
            var _local_6:XML;
            var _local_5:int;
            super.initialize(_arg_1);
            _directions = [];
            var _local_2:XMLList = _arg_1.model.directions.direction;
            var _local_3:Array = ["id"];
            _local_4 = 0;
            while (_local_4 < _local_2.length())
            {
                _local_6 = _local_2[_local_4];
                if (_SafeStr_93.checkRequiredAttributes(_local_6, _local_3))
                {
                    _local_5 = parseInt(_local_6.@id);
                    _directions.push(_local_5);
                };
                _local_4++;
            };
            _directions.sort(16);
            object.getModelController().setNumberArray("pet_allowed_directions", _directions, true);
        }

        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_5:RoomObjectAvatarPostureUpdateMessage;
            var _local_2:RoomObjectAvatarUpdateMessage;
            var _local_10:RoomObjectAvatarChatUpdateMessage;
            var _local_11:RoomObjectAvatarPetGestureUpdateMessage;
            var _local_6:RoomObjectAvatarSleepUpdateMessage;
            var _local_4:RoomObjectAvatarSelectedMessage;
            var _local_12:RoomObjectAvatarExperienceUpdateMessage;
            var _local_8:RoomObjectAvatarFigureUpdateMessage;
            var _local_9:String;
            var _local_3:PetFigureData;
            if (((_arg_1 == null) || (object == null)))
            {
                return;
            };
            var _local_7:IRoomObjectModelController = object.getModelController();
            if (!_SafeStr_3233)
            {
                super.processUpdateMessage(_arg_1);
                if ((_arg_1 is RoomObjectAvatarPostureUpdateMessage))
                {
                    _local_5 = (_arg_1 as RoomObjectAvatarPostureUpdateMessage);
                    _local_7.setString("figure_posture", _local_5.postureType);
                    return;
                };
                if ((_arg_1 is RoomObjectAvatarUpdateMessage))
                {
                    _local_2 = (_arg_1 as RoomObjectAvatarUpdateMessage);
                    _local_7.setNumber("head_direction", _local_2.dirHead);
                    return;
                };
                if ((_arg_1 is RoomObjectAvatarChatUpdateMessage))
                {
                    _local_10 = (_arg_1 as RoomObjectAvatarChatUpdateMessage);
                    _local_7.setNumber("figure_talk", 1);
                    _SafeStr_3220 = (getTimer() + (_local_10.numberOfWords * 1000));
                    return;
                };
                if ((_arg_1 is RoomObjectAvatarPetGestureUpdateMessage))
                {
                    _local_11 = (_arg_1 as RoomObjectAvatarPetGestureUpdateMessage);
                    _local_7.setString("figure_gesture", _local_11.gesture);
                    _SafeStr_3224 = (getTimer() + 3000);
                    return;
                };
                if ((_arg_1 is RoomObjectAvatarSleepUpdateMessage))
                {
                    _local_6 = (_arg_1 as RoomObjectAvatarSleepUpdateMessage);
                    _local_7.setNumber("figure_sleep", Number(_local_6.isSleeping));
                    return;
                };
            };
            if ((_arg_1 is RoomObjectAvatarSelectedMessage))
            {
                _local_4 = (_arg_1 as RoomObjectAvatarSelectedMessage);
                _selected = _local_4.selected;
                _SafeStr_3217 = null;
                return;
            };
            if ((_arg_1 is RoomObjectAvatarExperienceUpdateMessage))
            {
                _local_12 = (_arg_1 as RoomObjectAvatarExperienceUpdateMessage);
                _local_7.setNumber("figure_experience_timestamp", getTimer());
                _local_7.setNumber("figure_gained_experience", _local_12.gainedExperience);
                return;
            };
            if ((_arg_1 is RoomObjectAvatarFigureUpdateMessage))
            {
                _local_8 = (_arg_1 as RoomObjectAvatarFigureUpdateMessage);
                _local_9 = _local_7.getString("figure");
                _local_3 = new PetFigureData(_local_8.figure);
                _local_7.setString("figure", _local_8.figure);
                _local_7.setString("race", _local_8.race);
                _local_7.setNumber("pet_palette_index", _local_3.paletteId);
                _local_7.setNumber("pet_color", _local_3.color);
                _local_7.setNumber("pet_type", _local_3.typeId);
                _local_7.setNumberArray("pet_custom_layer_ids", _local_3.customLayerIds);
                _local_7.setNumberArray("pet_custom_part_ids", _local_3.customPartIds);
                _local_7.setNumberArray("pet_custom_palette_ids", _local_3.customPaletteIds);
                _local_7.setNumber("pet_is_riding", ((_local_8.isRiding) ? 1 : 0));
                return;
            };
        }

        override public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
            var _local_5:int;
            var _local_8:RoomObjectEvent;
            if (((object == null) || (_arg_1 == null)))
            {
                return;
            };
            var _local_6:IRoomObjectModelController = object.getModelController();
            var _local_3:IVector3d;
            var _local_4:Vector3d;
            var _local_7:String;
            switch (_arg_1.type)
            {
                case "click":
                    _local_7 = "ROE_MOUSE_CLICK";
                    if (_SafeStr_3233)
                    {
                        debugMouseEvent(_arg_1);
                    };
                    break;
                case "doubleClick":
                    break;
                case "mouseDown":
                    if (!_SafeStr_3233)
                    {
                        _local_5 = _local_6.getNumber("pet_type");
                        if (_local_5 == 16)
                        {
                            if (eventDispatcher != null)
                            {
                                _local_8 = new RoomObjectMouseEvent("ROE_MOUSE_DOWN", object, _arg_1.eventId, _arg_1.altKey, _arg_1.ctrlKey, _arg_1.shiftKey, _arg_1.buttonDown);
                                eventDispatcher.dispatchEvent(_local_8);
                            };
                        };
                    };
            };
            if (_local_7 != null)
            {
                if (eventDispatcher != null)
                {
                    _local_8 = new RoomObjectMouseEvent(_local_7, object, _arg_1.eventId, _arg_1.altKey, _arg_1.ctrlKey, _arg_1.shiftKey, _arg_1.buttonDown);
                    eventDispatcher.dispatchEvent(_local_8);
                };
            };
        }

        private function debugMouseEvent(_arg_1:RoomSpriteMouseEvent):void
        {
            var _local_3:int;
            var _local_2:IRoomObjectModelController = object.getModelController();
            if (((!(_arg_1.altKey)) && (!(_arg_1.ctrlKey))))
            {
                _local_3 = _directions[_SafeStr_3236];
                object.setDirection(new Vector3d(_local_3));
                _local_2.setNumber("head_direction", (_local_3 + _headDirectionDelta));
                _SafeStr_3236++;
                if (_SafeStr_3236 == _directions.length)
                {
                    _SafeStr_3236 = 0;
                };
            }
            else
            {
                if (((_arg_1.altKey) && (!(_arg_1.ctrlKey))))
                {
                    _SafeStr_3234++;
                    _local_2.setNumber("figure_posture", _SafeStr_3234);
                    _local_2.setNumber("figure_gesture", NaN);
                }
                else
                {
                    if (((_arg_1.ctrlKey) && (!(_arg_1.altKey))))
                    {
                        _SafeStr_3235++;
                        _local_2.setNumber("figure_gesture", _SafeStr_3235);
                    }
                    else
                    {
                        _headDirectionDelta = (_headDirectionDelta + 45);
                        if (_headDirectionDelta > 45)
                        {
                            _headDirectionDelta = -45;
                        };
                        _local_3 = object.getDirection().x;
                        _local_2.setNumber("head_direction", (_local_3 + _headDirectionDelta));
                    };
                };
            };
        }

        override public function update(_arg_1:int):void
        {
            var _local_2:IVector3d;
            var _local_3:RoomObjectEvent;
            super.update(_arg_1);
            if (((_selected) && (!(object == null))))
            {
                if (eventDispatcher != null)
                {
                    _local_2 = object.getLocation();
                    if (((((_SafeStr_3217 == null) || (!(_SafeStr_3217.x == _local_2.x))) || (!(_SafeStr_3217.y == _local_2.y))) || (!(_SafeStr_3217.z == _local_2.z))))
                    {
                        if (_SafeStr_3217 == null)
                        {
                            _SafeStr_3217 = new Vector3d();
                        };
                        _SafeStr_3217.assign(_local_2);
                        _local_3 = new RoomObjectMoveEvent("ROME_POSITION_CHANGED", object);
                        eventDispatcher.dispatchEvent(_local_3);
                    };
                };
            };
            if (((!(object == null)) && (!(object.getModelController() == null))))
            {
                updateActions(_arg_1, object.getModelController());
            };
        }

        private function updateActions(_arg_1:int, _arg_2:IRoomObjectModelController):void
        {
            if (((_SafeStr_3224 > 0) && (_arg_1 > _SafeStr_3224)))
            {
                _arg_2.setString("figure_gesture", null);
                _SafeStr_3224 = 0;
            };
            if (_SafeStr_3220 > 0)
            {
                if (_arg_1 > _SafeStr_3220)
                {
                    _arg_2.setNumber("figure_talk", 0);
                    _SafeStr_3220 = 0;
                };
            };
            if (((_SafeStr_3232 > 0) && (_arg_1 > _SafeStr_3232)))
            {
                _arg_2.setNumber("figure_expression", 0);
                _SafeStr_3232 = 0;
            };
        }


    }
}