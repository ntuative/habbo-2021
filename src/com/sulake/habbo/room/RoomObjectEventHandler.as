package com.sulake.habbo.room
{
    import com.sulake.room.renderer.IRoomRenderingCanvasMouseListener;
    import com.sulake.core.utils.Map;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.room.utils.SelectedRoomObjectData;
    import com.sulake.room.object.IRoomObjectController;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.room.messages.RoomObjectSelectedMessage;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.room.utils.RoomEnterEffect;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.events.RoomObjectMouseEvent;
    import com.sulake.habbo.room.events.RoomObjectStateChangeEvent;
    import com.sulake.habbo.room.events.RoomObjectPlaySoundIdEvent;
    import com.sulake.habbo.room.events.RoomObjectSamplePlaybackEvent;
    import com.sulake.habbo.room.events.RoomObjectHSLColorEnableEvent;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.events.RoomObjectTileMouseEvent;
    import com.sulake.habbo.room.events.RoomObjectWallMouseEvent;
    import com.sulake.habbo.room.messages.RoomObjectTileCursorUpdateMessage;
    import com.sulake.room.IRoomInstance;
    import com.sulake.habbo.room.utils.TileObjectMap;
    import com.sulake.habbo.room.utils.FurniStackingHeightMap;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
    import com.sulake.habbo.room.events.RoomEngineUseProductEvent;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.GetGuildFurniContextMenuInfoMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.game.lobby.GetResolutionAchievementsMessageComposer;
    import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.room.events.RoomEngineSoundMachineEvent;
    import com.sulake.habbo.room.events.RoomObjectBadgeAssetEvent;
    import com.sulake.habbo.room.events.RoomObjectDimmerStateUpdateEvent;
    import com.sulake.habbo.room.events.RoomEngineDimmerStateEvent;
    import com.sulake.habbo.room.events.RoomEngineObjectPlaySoundEvent;
    import com.sulake.habbo.room.events.RoomEngineObjectSamplePlaybackEvent;
    import com.sulake.habbo.room.events.RoomEngineHSLColorEnableEvent;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.habbo.room.utils.LegacyWallGeometry;
    import com.sulake.habbo.room.messages.RoomObjectAvatarSelectedMessage;
    import com.sulake.habbo.communication.messages.outgoing.room.avatar.LookToMessageComposer;
    import com.sulake.habbo.room.messages.RoomObjectVisibilityUpdateMessage;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.SetObjectDataMessageComposer;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.MovePetMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.MoveObjectMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.PickupObjectMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.RemoveBotFromFlatMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.MoveWallItemMessageComposer;
    import com.sulake.habbo.room.events.RoomEngineObjectPlacedOnUserEvent;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.PlacePetMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.PlaceBotMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.PlacePostItMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.PlaceObjectMessageComposer;
    import com.sulake.habbo.room.events.RoomEngineObjectPlacedEvent;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetRandomStateMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.UseWallItemMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.ThrowDiceMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.DiceOffMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.SpinWheelOfFortuneMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.GetItemDataMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.EnterOneWayDoorMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.SetItemDataMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.RemoveItemMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.MoveAvatarMessageComposer;

        public class RoomObjectEventHandler implements IRoomRenderingCanvasMouseListener
    {

        private var _roomEngine:IRoomEngineServices = null;
        private var _SafeStr_3656:Map = null;
        private var _SafeStr_3657:int = -1;
        private var _SafeStr_3658:int = -1;
        private var _SafeStr_3659:int = -2;
        private var _SafeStr_3660:Boolean = true;
        private var _SafeStr_3661:String;

        public function RoomObjectEventHandler(_arg_1:IRoomEngineServices)
        {
            _SafeStr_3656 = new Map();
            _roomEngine = _arg_1;
        }

        protected function get roomEngine():IRoomEngineServices
        {
            return (_roomEngine);
        }

        public function dispose():void
        {
            if (_SafeStr_3656 != null)
            {
                _SafeStr_3656.dispose();
                _SafeStr_3656 = null;
            };
            _roomEngine = null;
        }

        public function initializeRoomObjectInsert(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:String=null, _arg_7:IStuffData=null, _arg_8:int=-1, _arg_9:int=-1, _arg_10:String=null):Boolean
        {
            _SafeStr_3661 = _arg_1;
            var _local_11:IVector3d = new Vector3d(-100, -100);
            var _local_12:IVector3d = new Vector3d(0);
            setSelectedObjectData(_arg_2, _arg_3, _arg_4, _local_11, _local_12, "OBJECT_PLACE", _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10);
            if (_roomEngine != null)
            {
                _roomEngine.setObjectMoverIconSprite(_arg_5, _arg_4, false, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10);
                _roomEngine.setObjectMoverIconSpriteVisible(false);
            };
            return (true);
        }

        public function cancelRoomObjectInsert(_arg_1:int):Boolean
        {
            resetSelectedObjectData(_arg_1);
            return (true);
        }

        private function getSelectedObjectData(_arg_1:int):SelectedRoomObjectData
        {
            if (_roomEngine == null)
            {
                return (null);
            };
            var _local_2:ISelectedRoomObjectData = _roomEngine.getSelectedObjectData(_arg_1);
            return (_local_2 as SelectedRoomObjectData);
        }

        private function setSelectedObjectData(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:IVector3d, _arg_5:IVector3d, _arg_6:String, _arg_7:int=0, _arg_8:String=null, _arg_9:IStuffData=null, _arg_10:int=-1, _arg_11:int=-1, _arg_12:String=null):void
        {
            resetSelectedObjectData(_arg_1);
            if (_roomEngine == null)
            {
                return;
            };
            var _local_13:SelectedRoomObjectData = new SelectedRoomObjectData(_arg_2, _arg_3, _arg_6, _arg_4, _arg_5, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11, _arg_12);
            _roomEngine.setSelectedObjectData(_arg_1, _local_13);
        }

        private function updateSelectedObjectData(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:IVector3d, _arg_5:IVector3d, _arg_6:String, _arg_7:int=0, _arg_8:String=null, _arg_9:IStuffData=null, _arg_10:int=-1, _arg_11:int=-1, _arg_12:String=null):void
        {
            if (_roomEngine == null)
            {
                return;
            };
            var _local_13:SelectedRoomObjectData = new SelectedRoomObjectData(_arg_2, _arg_3, _arg_6, _arg_4, _arg_5, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11, _arg_12);
            _roomEngine.setSelectedObjectData(_arg_1, _local_13);
        }

        private function resetSelectedObjectData(_arg_1:int):void
        {
            var _local_5:IRoomObjectController;
            var _local_3:int;
            var _local_4:int;
            if (_roomEngine == null)
            {
                return;
            };
            if (_roomEngine != null)
            {
                _roomEngine.removeObjectMoverIconSprite();
            };
            var _local_2:SelectedRoomObjectData = getSelectedObjectData(_arg_1);
            if (_local_2 != null)
            {
                if (((_local_2.operation == "OBJECT_MOVE") || (_local_2.operation == "OBJECT_MOVE_TO")))
                {
                    _local_5 = (_roomEngine.getRoomObject(_arg_1, _local_2.id, _local_2.category) as IRoomObjectController);
                    if (((!(_local_5 == null)) && (!(_local_2.operation == "OBJECT_MOVE_TO"))))
                    {
                        _local_5.setLocation(_local_2.loc);
                        _local_5.setDirection(_local_2.dir);
                    };
                    setObjectAlphaMultiplier(_local_5, 1);
                    if (_local_2.category == 20)
                    {
                        _roomEngine.updateObjectRoomWindow(_arg_1, _local_2.id, true);
                    };
                    updateSelectedObjectData(_arg_1, _local_2.id, _local_2.category, _local_2.loc, _local_2.dir, "OBJECT_MOVE", _local_2.typeId, _local_2.instanceData, _local_2.stuffData, _local_2.state, _local_2.animFrame, _local_2.posture);
                };
                if (_local_2.operation == "OBJECT_PLACE")
                {
                    _local_3 = _local_2.id;
                    _local_4 = _local_2.category;
                    switch (_local_4)
                    {
                        case 10:
                            _roomEngine.disposeObjectFurniture(_arg_1, _local_3);
                            break;
                        case 20:
                            _roomEngine.disposeObjectWallItem(_arg_1, _local_3);
                            break;
                        case 100:
                            _roomEngine.disposeObjectUser(_arg_1, _local_3);
                    };
                };
                _roomEngine.setSelectedObjectData(_arg_1, null);
            };
        }

        public function setSelectedObject(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_5:IRoomObjectController;
            if (_roomEngine == null)
            {
                return;
            };
            var _local_4:IEventDispatcher = _roomEngine.events;
            if (_local_4 == null)
            {
                return;
            };
            switch (_arg_3)
            {
                case 100:
                case 10:
                case 20:
                    if (_arg_3 == 100)
                    {
                        deselectObject(_arg_1);
                        setSelectedAvatar(_arg_1, _arg_2, true);
                    }
                    else
                    {
                        setSelectedAvatar(_arg_1, 0, false);
                        if (_arg_2 != _SafeStr_3658)
                        {
                            deselectObject(_arg_1);
                            _local_5 = (_roomEngine.getRoomObject(_arg_1, _arg_2, _arg_3) as IRoomObjectController);
                            if (((!(_local_5 == null)) && (!(_local_5.getEventHandler() == null))))
                            {
                                _local_5.getEventHandler().processUpdateMessage(new RoomObjectSelectedMessage(true));
                                _SafeStr_3658 = _arg_2;
                                _SafeStr_3659 = _arg_3;
                            };
                        };
                    };
                    _local_4.dispatchEvent(new RoomEngineObjectEvent("REOE_SELECTED", _arg_1, _arg_2, _arg_3));
                    return;
            };
        }

        private function deselectObject(_arg_1:int):void
        {
            var _local_2:IRoomObjectController;
            if (_SafeStr_3658 != -1)
            {
                _local_2 = (_roomEngine.getRoomObject(_arg_1, _SafeStr_3658, _SafeStr_3659) as IRoomObjectController);
                if (((!(_local_2 == null)) && (!(_local_2.getEventHandler() == null))))
                {
                    _local_2.getEventHandler().processUpdateMessage(new RoomObjectSelectedMessage(false));
                    _SafeStr_3658 = -1;
                    _SafeStr_3659 = -2;
                };
            };
        }

        public function processRoomCanvasMouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomObject, _arg_3:IRoomGeometry):void
        {
            if (RoomEnterEffect.isRunning())
            {
                return;
            };
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return;
            };
            var _local_7:String = _arg_2.getType();
            var _local_6:int = _roomEngine.getRoomObjectCategory(_local_7);
            var _local_4:int = _local_6;
            if (_local_6 != 0)
            {
                if (!_roomEngine.getActiveRoomIsPlayingGame())
                {
                    _local_6 = -2;
                }
                else
                {
                    if (_local_6 != 100)
                    {
                        _local_6 = -2;
                    };
                };
            };
            var _local_5:String = getMouseEventId(_local_6, _arg_1.type);
            if (_local_5 == _arg_1.eventId)
            {
                if ((((((_arg_1.type == "click") || (_arg_1.type == "doubleClick")) || (_arg_1.type == "mouseDown")) || (_arg_1.type == "mouseUp")) || (_arg_1.type == "mouseMove")))
                {
                    return;
                };
            }
            else
            {
                if (_arg_1.eventId != null)
                {
                    setMouseEventId(_local_6, _arg_1.type, _arg_1.eventId);
                };
            };
            if (_arg_2.getMouseHandler() != null)
            {
                _arg_2.getMouseHandler().mouseEvent(_arg_1, _arg_3);
            };
        }

        public function handleRoomObjectEvent(_arg_1:RoomObjectEvent, _arg_2:int):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            if ((_arg_1 is RoomObjectMouseEvent))
            {
                handleRoomObjectMouseEvent((_arg_1 as RoomObjectMouseEvent), _arg_2);
                return;
            };
            switch (_arg_1.type)
            {
                case "ROSCE_STATE_CHANGE":
                    handleObjectStateChange((_arg_1 as RoomObjectStateChangeEvent), _arg_2);
                    return;
                case "ROSCE_STATE_RANDOM":
                    handleObjectRandomStateChange((_arg_1 as RoomObjectStateChangeEvent), _arg_2);
                    return;
                case "RODSUE_DIMMER_STATE":
                    handleObjectDimmerStateEvent(_arg_1, _arg_2);
                    return;
                case "ROME_POSITION_CHANGED":
                    handleSelectedObjectMove(_arg_1, _arg_2);
                    return;
                case "ROME_OBJECT_REMOVED":
                    handleSelectedObjectRemove(_arg_1, _arg_2);
                    return;
                case "ROWRE_OPEN_WIDGET":
                case "ROWRE_CLOSE_WIDGET":
                case "ROWRE_OPEN_FURNI_CONTEXT_MENU":
                case "ROWRE_CLOSE_FURNI_CONTEXT_MENU":
                case "ROWRE_PLACEHOLDER":
                case "ROWRE__CREDITFURNI":
                case "ROWRE__STICKIE":
                case "ROWRE_PRESENT":
                case "ROWRE_TROPHY":
                case "ROWRE_TEASER":
                case "ROWRE_ECOTRONBOX":
                case "ROWRE_DIMMER":
                case "ROWRE_WIDGET_REMOVE_DIMMER":
                case "ROWRE_CLOTHING_CHANGE":
                case "ROWRE_JUKEBOX_PLAYLIST_EDITOR":
                case "ROWRE_MANNEQUIN":
                case "ROWRE_PET_PRODUCT_MENU":
                case "ROWRE_GUILD_FURNI_CONTEXT_MENU":
                case "ROWRE_MONSTERPLANT_SEED_PLANT_CONFIRMATION_DIALOG":
                case "ROWRE_PURCHASABLE_CLOTHING_CONFIRMATION_DIALOG":
                case "ROWRE_BACKGROUND_COLOR":
                case "ROWRE_MYSTERYBOX_OPEN_DIALOG":
                case "ROWRE_EFFECTBOX_OPEN_DIALOG":
                case "ROWRE_MYSTERYTROPHY_OPEN_DIALOG":
                case "ROWRE_ACHIEVEMENT_RESOLUTION_OPEN":
                case "ROWRE_ACHIEVEMENT_RESOLUTION_ENGRAVING":
                case "ROWRE_ACHIEVEMENT_RESOLUTION_FAILED":
                case "ROWRE_FRIEND_FURNITURE_CONFIRM":
                case "ROWRE_FRIEND_FURNITURE_ENGRAVING":
                case "ROWRE_BADGE_DISPLAY_ENGRAVING":
                case "ROWRE_HIGH_SCORE_DISPLAY":
                case "ROWRE_HIDE_HIGH_SCORE_DISPLAY":
                case "ROWRE_INTERNAL_LINK":
                case "ROWRE_ROOM_LINK":
                    handleObjectWidgetRequestEvent(_arg_1, _arg_2);
                    return;
                case "ROFCAE_DICE_ACTIVATE":
                case "ROFCAE_DICE_OFF":
                case "ROFCAE_USE_HABBOWHEEL":
                case "ROFCAE_STICKIE":
                case "ROFCAE_ENTER_ONEWAYDOOR":
                    handleObjectActionEvent(_arg_1, _arg_2);
                    return;
                case "ROFCAE_SOUND_MACHINE_INIT":
                case "ROFCAE_SOUND_MACHINE_START":
                case "ROFCAE_SOUND_MACHINE_STOP":
                case "ROFCAE_SOUND_MACHINE_DISPOSE":
                    handleObjectSoundMachineEvent(_arg_1, _arg_2);
                    return;
                case "ROFCAE_JUKEBOX_INIT":
                case "ROFCAE_JUKEBOX_START":
                case "ROFCAE_JUKEBOX_MACHINE_STOP":
                case "ROFCAE_JUKEBOX_DISPOSE":
                    handleObjectJukeboxEvent(_arg_1, _arg_2);
                    return;
                case "ROFHO_ADD_HOLE":
                case "ROFHO_REMOVE_HOLE":
                    handleObjectFloorHoleEvent(_arg_1, _arg_2);
                    return;
                case "RORAE_ROOM_AD_FURNI_CLICK":
                case "RORAE_ROOM_AD_FURNI_DOUBLE_CLICK":
                case "RORAE_ROOM_AD_TOOLTIP_SHOW":
                case "RORAE_ROOM_AD_TOOLTIP_HIDE":
                case "RORAE_ROOM_AD_LOAD_IMAGE":
                    handleObjectRoomAdEvent(_arg_1, _arg_2);
                    return;
                case "ROGBE_LOAD_BADGE":
                    handleObjectGroupBadgeEvent(_arg_1, _arg_2);
                    return;
                case "ROFCAE_MOUSE_ARROW":
                case "ROFCAE_MOUSE_BUTTON":
                    handleRoomActionMouseRequestEvent(_arg_1, _arg_2);
                    return;
                case "ROPSIE_PLAY_SOUND":
                case "ROPSIE_PLAY_SOUND_AT_PITCH":
                    handleRoomObjectPlaySoundEvent(RoomObjectPlaySoundIdEvent(_arg_1), _arg_2);
                    return;
                case "ROPSPE_ROOM_OBJECT_INITIALIZED":
                case "ROPSPE_ROOM_OBJECT_DISPOSED":
                case "ROPSPE_PLAY_SAMPLE":
                    handleRoomObjectSamplePlaybackEvent(RoomObjectSamplePlaybackEvent(_arg_1), _arg_2);
                    return;
                case "ROHSLCEE_ROOM_BACKGROUND_COLOR":
                    handleRoomObjectHSLColorEnableEvent(RoomObjectHSLColorEnableEvent(_arg_1), _arg_2);
                    return;
                case "RODRE_CURRENT_USER_ID":
                case "RODRE_URL_PREFIX":
                    handleRoomObjectDataRequestEvent(_arg_1, _arg_2);
                    return;
                default:
                    Logger.log("*** Unhandled room object event in RoomObjectEventHandler::handleRoomObjectEvent !!! ***");
                    return;
            };
        }

        private function setMouseEventId(_arg_1:int, _arg_2:String, _arg_3:String):void
        {
            var _local_4:Map = (_SafeStr_3656.getValue(String(_arg_1)) as Map);
            if (_local_4 == null)
            {
                _local_4 = new Map();
                _SafeStr_3656.add(_arg_1, _local_4);
            };
            _local_4.remove(_arg_2);
            _local_4.add(_arg_2, _arg_3);
        }

        private function getMouseEventId(_arg_1:int, _arg_2:String):String
        {
            var _local_4:Map = (_SafeStr_3656.getValue(String(_arg_1)) as Map);
            if (_local_4 == null)
            {
                return (null);
            };
            return (_local_4.getValue(_arg_2) as String);
        }

        private function handleRoomObjectMouseEvent(_arg_1:RoomObjectMouseEvent, _arg_2:int):void
        {
            switch (_arg_1.type)
            {
                case "ROE_MOUSE_CLICK":
                    handleRoomObjectMouseClick(_arg_1, _arg_2);
                    return;
                case "ROE_MOUSE_MOVE":
                    handleRoomObjectMouseMove(_arg_1, _arg_2);
                    return;
                case "ROE_MOUSE_DOWN":
                    handleRoomObjectMouseDown(_arg_1, _arg_2);
                    return;
                case "ROE_MOUSE_ENTER":
                    handleRoomObjectMouseEnter(_arg_1, _arg_2);
                    return;
                case "ROE_MOUSE_LEAVE":
                    handleRoomObjectMouseLeave(_arg_1, _arg_2);
                    return;
            };
        }

        private function handleRoomObjectMouseClick(_arg_1:RoomObjectMouseEvent, _arg_2:int):void
        {
            var _local_10:Boolean;
            var _local_11:String;
            var _local_6:String;
            if (_arg_1 == null)
            {
                return;
            };
            var _local_9:Boolean;
            var _local_5:String = "OBJECT_UNDEFINED";
            var _local_8:SelectedRoomObjectData = getSelectedObjectData(_arg_2);
            if (_local_8 != null)
            {
                _local_5 = _local_8.operation;
            };
            if (_SafeStr_3660)
            {
                if (((_local_5 == null) || (_local_5 == "OBJECT_UNDEFINED")))
                {
                    _local_9 = handleMoveTargetFurni(_arg_2, _arg_1);
                };
            };
            var _local_15:int = _arg_1.objectId;
            var _local_12:String = _arg_1.objectType;
            var _local_14:int = _roomEngine.getRoomObjectCategory(_local_12);
            var _local_3:String = _arg_1.eventId;
            var _local_13:RoomObjectTileMouseEvent = (_arg_1 as RoomObjectTileMouseEvent);
            var _local_4:RoomObjectWallMouseEvent = (_arg_1 as RoomObjectWallMouseEvent);
            var _local_16:Boolean;
            var _local_7:IEventDispatcher = _roomEngine.events;
            switch (_local_5)
            {
                case "OBJECT_MOVE":
                    if (_local_14 == 0)
                    {
                        if (_local_8 != null)
                        {
                            modifyRoomObject(_arg_2, _local_8.id, _local_8.category, "OBJECT_MOVE_TO");
                        };
                    }
                    else
                    {
                        if (_local_14 == 100)
                        {
                            if (((!(_local_8 == null)) && (_local_12 == "monsterplant")))
                            {
                                modifyRoomObject(_arg_2, _local_8.id, _local_8.category, "OBJECT_MOVE_TO");
                            };
                            if (_local_3 != null)
                            {
                                setMouseEventId(0, "click", _local_3);
                            };
                            placeObjectOnUser(_arg_2, _local_15, _local_14);
                        };
                    };
                    _local_16 = true;
                    if (_local_15 != -1)
                    {
                        setSelectedObject(_arg_2, _local_15, _local_14);
                    };
                    break;
                case "OBJECT_PLACE":
                    if (_local_14 == 0)
                    {
                        placeObject(_arg_2, (!(_local_13 == null)), (!(_local_4 == null)));
                    }
                    else
                    {
                        if (_local_14 == 100)
                        {
                            switch (_local_12)
                            {
                                case "monsterplant":
                                case "rentable_bot":
                                    placeObject(_arg_2, (!(_local_13 == null)), (!(_local_4 == null)));
                                    break;
                                default:
                                    if (_local_3 != null)
                                    {
                                        setMouseEventId(0, "click", _local_3);
                                    };
                                    placeObjectOnUser(_arg_2, _local_15, _local_14);
                            };
                        };
                    };
                    break;
                case "OBJECT_UNDEFINED":
                    if (_local_14 == 0)
                    {
                        if (((!(_local_13 == null)) && (!(_local_9))))
                        {
                            handleClickOnTile(_arg_2, _local_13);
                        };
                    }
                    else
                    {
                        setSelectedObject(_arg_2, _local_15, _local_14);
                        _local_10 = false;
                        if (_local_14 == 100)
                        {
                            if (((((_arg_1.ctrlKey) && (!(_arg_1.altKey))) && (!(_arg_1.shiftKey))) && (_local_12 == "rentable_bot")))
                            {
                                modifyRoomObject(_arg_2, _local_15, _local_14, "OBJECT_PICKUP_BOT");
                            }
                            else
                            {
                                if (((((_arg_1.ctrlKey) && (!(_arg_1.altKey))) && (!(_arg_1.shiftKey))) && (_local_12 == "monsterplant")))
                                {
                                    modifyRoomObject(_arg_2, _local_15, _local_14, "OBJECT_PICKUP_PET");
                                }
                                else
                                {
                                    if (((((!(_arg_1.ctrlKey)) && (!(_arg_1.altKey))) && (_arg_1.shiftKey)) && (_local_12 == "monsterplant")))
                                    {
                                        modifyRoomObject(_arg_2, _local_15, _local_14, "OBJECT_ROTATE_POSITIVE");
                                    }
                                    else
                                    {
                                        handleClickOnAvatar(_local_15, _arg_1);
                                    };
                                };
                            };
                            if (!_roomEngine.getActiveRoomIsPlayingGame())
                            {
                                _local_9 = true;
                            }
                            else
                            {
                                _local_10 = true;
                            };
                        }
                        else
                        {
                            if (((_local_14 == 10) || (_local_14 == 20)))
                            {
                                if (((((_arg_1.altKey) || (_arg_1.ctrlKey)) || (_arg_1.shiftKey)) && (!(_roomEngine.isGameMode))))
                                {
                                    if ((((!(_arg_1.ctrlKey)) && (!(_arg_1.altKey))) && (_arg_1.shiftKey)))
                                    {
                                        if (_local_14 == 10)
                                        {
                                            if (_local_7 != null)
                                            {
                                                _local_7.dispatchEvent(new RoomEngineObjectEvent("REOE_REQUEST_ROTATE", _arg_2, _local_15, _local_14));
                                            };
                                        };
                                    }
                                    else
                                    {
                                        if ((((_arg_1.ctrlKey) && (!(_arg_1.altKey))) && (!(_arg_1.shiftKey))))
                                        {
                                            modifyRoomObject(_arg_2, _local_15, _local_14, "OBJECT_PICKUP");
                                        };
                                    };
                                    if (!_roomEngine.getActiveRoomIsPlayingGame())
                                    {
                                        _local_9 = true;
                                    }
                                    else
                                    {
                                        _local_10 = true;
                                    };
                                };
                            };
                        };
                        if (_local_3 != null)
                        {
                            if (_local_9)
                            {
                                setMouseEventId(0, "click", _local_3);
                            };
                            if (_local_10)
                            {
                                setMouseEventId(-2, "click", _local_3);
                            };
                        };
                    };
            };
            if (_local_14 == 0)
            {
                _local_11 = getMouseEventId(-2, "click");
                _local_6 = getMouseEventId(100, "click");
                if ((((!(_local_11 == _local_3)) && (!(_local_6 == _local_3))) && (!(_local_16))))
                {
                    deselectObject(_arg_2);
                    if (_local_7 != null)
                    {
                        _local_7.dispatchEvent(new RoomEngineObjectEvent("REOE_DESELECTED", _arg_2, -1, -2));
                    };
                    setSelectedAvatar(_arg_2, 0, false);
                };
            };
        }

        private function handleRoomObjectMouseMove(_arg_1:RoomObjectMouseEvent, _arg_2:int):void
        {
            var _local_7:IRoomObjectController;
            var _local_5:RoomObjectTileCursorUpdateMessage;
            if (_arg_1 == null)
            {
                return;
            };
            var _local_3:String = "OBJECT_UNDEFINED";
            var _local_4:SelectedRoomObjectData = getSelectedObjectData(_arg_2);
            if (_local_4 != null)
            {
                _local_3 = _local_4.operation;
            };
            var _local_8:String = _arg_1.objectType;
            var _local_6:int = _roomEngine.getRoomObjectCategory(_local_8);
            if (_roomEngine != null)
            {
                _local_7 = _roomEngine.getTileCursor(_arg_2);
                if (((!(_local_7 == null)) && (!(_local_7.getEventHandler() == null))))
                {
                    if ((_arg_1 is RoomObjectTileMouseEvent))
                    {
                        _local_5 = handleMouseOverTile((_arg_1 as RoomObjectTileMouseEvent), _arg_2);
                    }
                    else
                    {
                        if (((!(_arg_1.object == null)) && (!(_arg_1.object.getId() == -1))))
                        {
                            if (_SafeStr_3660)
                            {
                                _local_5 = handleMouseOverObject(_local_6, _arg_2, _arg_1);
                            };
                        }
                        else
                        {
                            _local_5 = new RoomObjectTileCursorUpdateMessage(null, 0, false, _arg_1.eventId);
                        };
                    };
                    _local_7.getEventHandler().processUpdateMessage(_local_5);
                };
            };
            switch (_local_3)
            {
                case "OBJECT_MOVE":
                    if (_local_6 == 0)
                    {
                        handleObjectMove(_arg_1, _arg_2);
                    };
                    return;
                case "OBJECT_PLACE":
                    if (_local_6 == 0)
                    {
                        handleObjectPlace(_arg_1, _arg_2);
                    };
                    return;
            };
        }

        private function handleMouseOverTile(_arg_1:RoomObjectTileMouseEvent, _arg_2:int):RoomObjectTileCursorUpdateMessage
        {
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_11:IRoomInstance;
            var _local_3:TileObjectMap;
            var _local_8:IRoomObject;
            var _local_4:FurniStackingHeightMap;
            var _local_12:Number;
            var _local_10:Number;
            if (_SafeStr_3660)
            {
                return (new RoomObjectTileCursorUpdateMessage(new Vector3d(_arg_1.tileXAsInt, _arg_1.tileYAsInt, _arg_1.tileZAsInt), 0, true, _arg_1.eventId));
            };
            var _local_9:IRoomObjectController = _roomEngine.getTileCursor(_arg_2);
            if (((!(_local_9 == null)) && (!(_local_9.getEventHandler() == null))))
            {
                _local_5 = _arg_1.tileXAsInt;
                _local_6 = _arg_1.tileYAsInt;
                _local_7 = _arg_1.tileZAsInt;
                _local_11 = _roomEngine.getRoom(_arg_2);
                if (_local_11 != null)
                {
                    _local_3 = _roomEngine.getTileObjectMap(_arg_2);
                    if (_local_3)
                    {
                        _local_8 = _local_3.getObjectIntTile(_local_5, _local_6);
                        _local_4 = _roomEngine.getFurniStackingHeightMap(_arg_2);
                        if (_local_4)
                        {
                            if ((((_local_8) && (_local_8.getModel())) && (_local_8.getModel().getNumber("furniture_is_variable_height") > 0)))
                            {
                                _local_12 = _local_4.getTileHeight(_local_5, _local_6);
                                _local_10 = _roomEngine.getLegacyGeometry(_arg_2).getTileHeight(_local_5, _local_6);
                                return (new RoomObjectTileCursorUpdateMessage(new Vector3d(_local_5, _local_6, _local_7), (_local_12 - _local_10), true, _arg_1.eventId));
                            };
                            return (new RoomObjectTileCursorUpdateMessage(new Vector3d(_local_5, _local_6, _local_7), 0, true, _arg_1.eventId));
                        };
                    };
                };
            };
            return (null);
        }

        private function handleMouseOverObject(_arg_1:int, _arg_2:int, _arg_3:RoomObjectMouseEvent):RoomObjectTileCursorUpdateMessage
        {
            var _local_5:Vector3d;
            var _local_6:FurniStackingHeightMap;
            var _local_7:int;
            var _local_8:int;
            var _local_9:Number;
            var _local_4:IRoomObject;
            if (_arg_1 == 10)
            {
                _local_4 = _roomEngine.getRoomObject(_arg_2, _arg_3.objectId, 10);
                if (_local_4)
                {
                    _local_5 = getActiveSurfaceLocation(_local_4, _arg_3);
                    if (_local_5)
                    {
                        _local_6 = _roomEngine.getFurniStackingHeightMap(_arg_2);
                        if (_local_6)
                        {
                            _local_7 = _local_5.x;
                            _local_8 = _local_5.y;
                            _local_9 = _local_5.z;
                            return (new RoomObjectTileCursorUpdateMessage(new Vector3d(_local_7, _local_8, _local_4.getLocation().z), _local_9, true, _arg_3.eventId));
                        };
                    };
                };
            };
            return (null);
        }

        private function handleRoomObjectMouseEnter(_arg_1:RoomObjectMouseEvent, _arg_2:int):void
        {
            var _local_6:String = _arg_1.objectType;
            var _local_4:int = _arg_1.objectId;
            var _local_3:int = _roomEngine.getRoomObjectCategory(_local_6);
            if (_local_3 != 0)
            {
                if (_local_3 == 100)
                {
                    handleMouseEnterAvatar(_local_4, _arg_1, _arg_2);
                };
            };
            var _local_5:IEventDispatcher = _roomEngine.events;
            if (_local_5 != null)
            {
                _local_5.dispatchEvent(new RoomEngineObjectEvent("REOE_MOUSE_ENTER", _arg_2, _arg_1.objectId, _roomEngine.getRoomObjectCategory(_arg_1.objectType)));
            };
        }

        private function handleRoomObjectMouseLeave(_arg_1:RoomObjectMouseEvent, _arg_2:int):void
        {
            var _local_4:IRoomObjectController;
            var _local_5:RoomObjectDataUpdateMessage;
            var _local_7:String = _arg_1.objectType;
            var _local_3:int = _roomEngine.getRoomObjectCategory(_local_7);
            if (_local_3 != 0)
            {
                if (_local_3 == 100)
                {
                    _local_4 = _roomEngine.getTileCursor(_arg_2);
                    if (_local_4)
                    {
                        _local_5 = new RoomObjectDataUpdateMessage(0, null);
                        _local_4.getEventHandler().processUpdateMessage(_local_5);
                    };
                };
            };
            var _local_6:IEventDispatcher = _roomEngine.events;
            if (_local_6 != null)
            {
                _local_6.dispatchEvent(new RoomEngineObjectEvent("REOE_MOUSE_LEAVE", _arg_2, _arg_1.objectId, _roomEngine.getRoomObjectCategory(_arg_1.objectType)));
            };
        }

        private function handleRoomObjectMouseDown(_arg_1:RoomObjectMouseEvent, _arg_2:int):void
        {
            var _local_7:IEventDispatcher;
            if (_arg_1 == null)
            {
                return;
            };
            var _local_3:String = "OBJECT_UNDEFINED";
            var _local_4:SelectedRoomObjectData = getSelectedObjectData(_arg_2);
            if (_local_4 != null)
            {
                _local_3 = _local_4.operation;
            };
            var _local_6:int = _arg_1.objectId;
            var _local_8:String = _arg_1.objectType;
            var _local_5:int = _roomEngine.getRoomObjectCategory(_local_8);
            switch (_local_3)
            {
                case "OBJECT_UNDEFINED":
                    if ((((_local_5 == 10) || (_local_5 == 20)) || (_local_8 == "monsterplant")))
                    {
                        if ((((((_arg_1.altKey) && (!(_arg_1.ctrlKey))) && (!(_arg_1.shiftKey))) || (decorateModeMove(_arg_1))) && (!(_roomEngine.isGameMode))))
                        {
                            _local_7 = _roomEngine.events;
                            if (_local_7 != null)
                            {
                                _local_7.dispatchEvent(new RoomEngineObjectEvent("REOE_REQUEST_MOVE", _arg_2, _local_6, _local_5));
                            };
                        };
                    };
                    return;
            };
        }

        private function decorateModeMove(_arg_1:RoomObjectMouseEvent):Boolean
        {
            return ((_roomEngine.isDecorateMode) && (!((_arg_1.ctrlKey) || (_arg_1.shiftKey))));
        }

        private function handleObjectMove(_arg_1:RoomObjectMouseEvent, _arg_2:int):void
        {
            var _local_14:Boolean;
            var _local_9:FurniStackingHeightMap;
            var _local_10:RoomObjectTileMouseEvent;
            var _local_3:RoomObjectWallMouseEvent;
            var _local_12:IVector3d;
            var _local_8:IVector3d;
            var _local_6:IVector3d;
            var _local_11:Number;
            var _local_13:Number;
            var _local_7:Number;
            if (((_arg_1 == null) || (_roomEngine == null)))
            {
                return;
            };
            var _local_15:IEventDispatcher = _roomEngine.events;
            if (_local_15 == null)
            {
                return;
            };
            var _local_4:SelectedRoomObjectData = getSelectedObjectData(_arg_2);
            if (_local_4 == null)
            {
                return;
            };
            var _local_5:IRoomObjectController = (_roomEngine.getRoomObject(_arg_2, _local_4.id, _local_4.category) as IRoomObjectController);
            if (_local_5 != null)
            {
                _local_14 = true;
                if (((_local_4.category == 10) || (_local_4.category == 100)))
                {
                    _local_9 = _roomEngine.getFurniStackingHeightMap(_arg_2);
                    _local_10 = (_arg_1 as RoomObjectTileMouseEvent);
                    if (!((!(_local_10 == null)) && (handleFurnitureMove(_local_5, _local_4, (_local_10.tileX + 0.5), (_local_10.tileY + 0.5), _local_9))))
                    {
                        handleFurnitureMove(_local_5, _local_4, _local_4.loc.x, _local_4.loc.y, _local_9);
                        _local_14 = false;
                    };
                }
                else
                {
                    if (_local_4.category == 20)
                    {
                        _local_14 = false;
                        _local_3 = (_arg_1 as RoomObjectWallMouseEvent);
                        if (_local_3 != null)
                        {
                            _local_12 = _local_3.wallLocation;
                            _local_8 = _local_3.wallWidth;
                            _local_6 = _local_3.wallHeight;
                            _local_11 = _local_3.x;
                            _local_13 = _local_3.y;
                            _local_7 = _local_3.direction;
                            if (handleWallItemMove(_local_5, _local_4, _local_12, _local_8, _local_6, _local_11, _local_13, _local_7))
                            {
                                _local_14 = true;
                            };
                        };
                        if (!_local_14)
                        {
                            _local_5.setLocation(_local_4.loc);
                            _local_5.setDirection(_local_4.dir);
                        };
                        _roomEngine.updateObjectRoomWindow(_arg_2, _local_4.id, _local_14);
                    };
                };
                if (_local_14)
                {
                    setObjectAlphaMultiplier(_local_5, 0.5);
                    _roomEngine.setObjectMoverIconSpriteVisible(false);
                }
                else
                {
                    setObjectAlphaMultiplier(_local_5, 0);
                    _roomEngine.setObjectMoverIconSpriteVisible(true);
                };
            };
        }

        private function handleObjectPlace(_arg_1:RoomObjectMouseEvent, _arg_2:int):void
        {
            var _local_13:IRoomObject;
            var _local_4:IRoomObjectModelController;
            var _local_12:Array;
            var _local_5:IVector3d;
            var _local_7:Boolean;
            var _local_15:FurniStackingHeightMap;
            var _local_17:IVector3d;
            var _local_11:IVector3d;
            var _local_9:IVector3d;
            var _local_16:Number;
            var _local_18:Number;
            var _local_10:Number;
            if (((_arg_1 == null) || (_roomEngine == null)))
            {
                return;
            };
            var _local_19:IEventDispatcher = _roomEngine.events;
            if (_local_19 == null)
            {
                return;
            };
            var _local_6:SelectedRoomObjectData = getSelectedObjectData(_arg_2);
            if (_local_6 == null)
            {
                return;
            };
            var _local_8:IRoomObjectController = (_roomEngine.getRoomObject(_arg_2, _local_6.id, _local_6.category) as IRoomObjectController);
            var _local_14:RoomObjectTileMouseEvent = (_arg_1 as RoomObjectTileMouseEvent);
            var _local_3:RoomObjectWallMouseEvent = (_arg_1 as RoomObjectWallMouseEvent);
            if (_local_8 == null)
            {
                if (((_local_6.category == 10) && (!(_local_14 == null))))
                {
                    _roomEngine.addObjectFurniture(_arg_2, _local_6.id, _local_6.typeId, _local_6.loc, _local_6.dir, 0, _local_6.stuffData, Number(_local_6.instanceData), -1, 0, 0, "", false);
                }
                else
                {
                    if (((_local_6.category == 20) && (!(_local_3 == null))))
                    {
                        _roomEngine.addObjectWallItem(_arg_2, _local_6.id, _local_6.typeId, _local_6.loc, _local_6.dir, 0, _local_6.instanceData, 0);
                    }
                    else
                    {
                        if (((_local_6.category == 100) && (!(_local_14 == null))))
                        {
                            _roomEngine.addObjectUser(_arg_2, _local_6.id, new Vector3d(), new Vector3d(180), 180, _local_6.typeId, _local_6.instanceData);
                            _local_13 = _roomEngine.getRoomObject(_arg_2, _local_6.id, _local_6.category);
                            if (_local_13)
                            {
                                _local_4 = (_local_13.getModel() as IRoomObjectModelController);
                                if (((!(_local_4 == null)) && (!(_local_6.posture == null))))
                                {
                                    _local_4.setString("figure_posture", _local_6.posture);
                                };
                            };
                        };
                    };
                };
                _local_8 = (_roomEngine.getRoomObject(_arg_2, _local_6.id, _local_6.category) as IRoomObjectController);
                if (_local_8 != null)
                {
                    if (_local_6.category == 10)
                    {
                        if (_local_8.getModel() != null)
                        {
                            _local_12 = _local_8.getModel().getNumberArray("furniture_allowed_directions");
                            if (((!(_local_12 == null)) && (_local_12.length > 0)))
                            {
                                _local_5 = new Vector3d(_local_12[0]);
                                _local_8.setDirection(_local_5);
                                updateSelectedObjectData(_arg_2, _local_6.id, _local_6.category, _local_6.loc, _local_5, _local_6.operation, _local_6.typeId, _local_6.instanceData, _local_6.stuffData, _local_6.state, _local_6.animFrame, _local_6.posture);
                                _local_6 = getSelectedObjectData(_arg_2);
                                if (_local_6 == null)
                                {
                                    return;
                                };
                            };
                        };
                    };
                };
                setObjectAlphaMultiplier(_local_8, 0.5);
                _roomEngine.setObjectMoverIconSpriteVisible(true);
            };
            if (_local_8 != null)
            {
                _local_7 = true;
                _local_15 = _roomEngine.getFurniStackingHeightMap(_arg_2);
                if (_local_6.category == 10)
                {
                    if (!((!(_local_14 == null)) && (handleFurnitureMove(_local_8, _local_6, (_local_14.tileX + 0.5), (_local_14.tileY + 0.5), _local_15))))
                    {
                        _roomEngine.disposeObjectFurniture(_arg_2, _local_6.id);
                        _local_7 = false;
                    };
                }
                else
                {
                    if (_local_6.category == 20)
                    {
                        _local_7 = false;
                        if (_local_3 != null)
                        {
                            _local_17 = _local_3.wallLocation;
                            _local_11 = _local_3.wallWidth;
                            _local_9 = _local_3.wallHeight;
                            _local_16 = _local_3.x;
                            _local_18 = _local_3.y;
                            _local_10 = _local_3.direction;
                            if (handleWallItemMove(_local_8, _local_6, _local_17, _local_11, _local_9, _local_16, _local_18, _local_10))
                            {
                                _local_7 = true;
                            };
                        };
                        if (!_local_7)
                        {
                            _roomEngine.disposeObjectWallItem(_arg_2, _local_6.id);
                        };
                        _roomEngine.updateObjectRoomWindow(_arg_2, _local_6.id, _local_7);
                    }
                    else
                    {
                        if (_local_6.category == 100)
                        {
                            if (!((!(_local_14 == null)) && (handleUserPlace(_local_8, (_local_14.tileX + 0.5), (_local_14.tileY + 0.5), _roomEngine.getLegacyGeometry(_arg_2)))))
                            {
                                _roomEngine.disposeObjectUser(_arg_2, _local_6.id);
                                _local_7 = false;
                            };
                        };
                    };
                };
                _roomEngine.setObjectMoverIconSpriteVisible((!(_local_7)));
            };
        }

        private function handleMoveTargetFurni(_arg_1:int, _arg_2:RoomObjectEvent):Boolean
        {
            var _local_4:IRoomObject = _roomEngine.getRoomObject(_arg_1, _arg_2.objectId, 10);
            var _local_3:Vector3d = getActiveSurfaceLocation(_local_4, (_arg_2 as RoomObjectMouseEvent));
            if (_local_3)
            {
                walkTo(_local_3.x, _local_3.y);
                return (true);
            };
            return (false);
        }

        private function getActiveSurfaceLocation(_arg_1:IRoomObject, _arg_2:RoomObjectMouseEvent):Vector3d
        {
            var _local_20:IRoomObjectModel;
            var _local_15:int;
            var _local_13:int;
            var _local_14:int;
            var _local_12:int;
            var _local_11:Number;
            var _local_9:int;
            var _local_16:int;
            var _local_5:int;
            var _local_17:Boolean;
            var _local_19:Number;
            var _local_6:Number;
            var _local_7:Number;
            var _local_3:Number;
            var _local_10:Number;
            var _local_8:int;
            var _local_4:int;
            var _local_21:Boolean;
            var _local_22:Number;
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return (null);
            };
            var _local_18:IFurnitureData = _roomEngine.sessionDataManager.getFloorItemDataByName(_arg_1.getType());
            if (_local_18 == null)
            {
                return (null);
            };
            if ((((_local_18.canStandOn) || (_local_18.canSitOn)) || (_local_18.canLayOn)))
            {
                _local_20 = _arg_1.getModel();
                if (_local_20 == null)
                {
                    return (null);
                };
                _local_15 = _arg_1.getLocation().x;
                _local_13 = _arg_1.getLocation().y;
                _local_14 = _local_20.getNumber("furniture_size_x");
                _local_12 = _local_20.getNumber("furniture_size_y");
                _local_11 = _local_20.getNumber("furniture_size_z");
                _local_9 = _arg_1.getDirection().x;
                if (((_local_9 == 90) || (_local_9 == 270)))
                {
                    _local_16 = _local_14;
                    _local_14 = _local_12;
                    _local_12 = _local_16;
                };
                if (_local_14 < 1)
                {
                    _local_14 = 1;
                };
                if (_local_12 < 1)
                {
                    _local_12 = 1;
                };
                if (_roomEngine.getActiveRoomActiveCanvas() == null)
                {
                    return (null);
                };
                _local_5 = _roomEngine.getActiveRoomActiveCanvas().geometry.scale;
                _local_17 = _local_18.canSitOn;
                _local_19 = ((_local_17) ? 0.5 : 0);
                _local_6 = ((((_local_5 / 2) + _arg_2.spriteOffsetX) + _arg_2.localX) / (_local_5 / 4));
                _local_7 = (((_arg_2.spriteOffsetY + _arg_2.localY) + (((_local_11 - _local_19) * _local_5) / 2)) / (_local_5 / 4));
                _local_3 = ((_local_6 + (2 * _local_7)) / 4);
                _local_10 = ((_local_6 - (2 * _local_7)) / 4);
                _local_8 = Math.floor((_local_15 + _local_3));
                _local_4 = Math.floor(((_local_13 - _local_10) + 1));
                _local_21 = false;
                if (((_local_8 < _local_15) || (_local_8 >= (_local_15 + _local_14))))
                {
                    _local_21 = true;
                }
                else
                {
                    if (((_local_4 < _local_13) || (_local_4 >= (_local_13 + _local_12))))
                    {
                        _local_21 = true;
                    };
                };
                _local_22 = ((_local_17) ? (_local_11 - 0.5) : _local_11);
                if (!_local_21)
                {
                    return (new Vector3d(_local_8, _local_4, _local_22));
                };
            };
            return (null);
        }

        protected function handleObjectStateChange(_arg_1:RoomObjectStateChangeEvent, _arg_2:int):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            changeObjectState(_arg_2, _arg_1.objectId, _arg_1.objectType, _arg_1.param, false);
        }

        private function handleObjectRandomStateChange(_arg_1:RoomObjectStateChangeEvent, _arg_2:int):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            changeObjectState(_arg_2, _arg_1.objectId, _arg_1.objectType, _arg_1.param, true);
        }

        private function handleObjectWidgetRequestEvent(_arg_1:RoomObjectEvent, _arg_2:int):void
        {
            var _local_3:String;
            var _local_4:String;
            var _local_6:int;
            if (((_roomEngine == null) || (_arg_1 == null)))
            {
                return;
            };
            var _local_7:int = _arg_1.objectId;
            var _local_9:String = _arg_1.objectType;
            var _local_5:int = _roomEngine.getRoomObjectCategory(_local_9);
            var _local_8:IEventDispatcher = _roomEngine.events;
            if (_local_8 != null)
            {
                switch (_arg_1.type)
                {
                    case "ROWRE_OPEN_WIDGET":
                        _local_3 = IRoomObjectController(_arg_1.object).getEventHandler().widget;
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_OPEN_WIDGET", _arg_2, _local_7, _local_5, _local_3));
                        return;
                    case "ROWRE_CLOSE_WIDGET":
                        _local_3 = IRoomObjectController(_arg_1.object).getEventHandler().widget;
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_CLOSE_WIDGET", _arg_2, _local_7, _local_5, _local_3));
                        return;
                    case "ROWRE_OPEN_FURNI_CONTEXT_MENU":
                        _local_4 = IRoomObjectController(_arg_1.object).getEventHandler().contextMenu;
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_OPEN_FURNI_CONTEXT_MENU", _arg_2, _local_7, _local_5, _local_4));
                        return;
                    case "ROWRE_CLOSE_FURNI_CONTEXT_MENU":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_CLOSE_FURNI_CONTEXT_MENU", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_PLACEHOLDER":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_PLACEHOLDER", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE__CREDITFURNI":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_CREDITFURNI", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE__STICKIE":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_STICKIE", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_PRESENT":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_PRESENT", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_TROPHY":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_TROPHY", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_TEASER":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_TEASER", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_ECOTRONBOX":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_ECOTRONBOX", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_DIMMER":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_DIMMER", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_WIDGET_REMOVE_DIMMER":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REMOVE_DIMMER", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_CLOTHING_CHANGE":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_CLOTHING_CHANGE", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_JUKEBOX_PLAYLIST_EDITOR":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_PLAYLIST_EDITOR", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_MANNEQUIN":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_MANNEQUIN", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_PET_PRODUCT_MENU":
                        _local_8.dispatchEvent(new RoomEngineUseProductEvent("ROSM_USE_PRODUCT_FROM_ROOM", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_GUILD_FURNI_CONTEXT_MENU":
                        _local_6 = _arg_1.object.getModel().getNumber("furniture_guild_customized_guild_id");
                        _roomEngine.connection.send(new GetGuildFurniContextMenuInfoMessageComposer(_arg_1.objectId, _local_6));
                        return;
                    case "ROWRE_MONSTERPLANT_SEED_PLANT_CONFIRMATION_DIALOG":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("ROWRE_REQUEST_MONSTERPLANT_SEED_PLANT_CONFIRMATION_DIALOG", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_PURCHASABLE_CLOTHING_CONFIRMATION_DIALOG":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("ROWRE_REQUEST_PURCHASABLE_CLOTHING_CONFIRMATION_DIALOG", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_BACKGROUND_COLOR":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_BACKGROUND_COLOR", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_MYSTERYBOX_OPEN_DIALOG":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_MYSTERYBOX_OPEN_DIALOG", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_EFFECTBOX_OPEN_DIALOG":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_EFFECTBOX_OPEN_DIALOG", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_MYSTERYTROPHY_OPEN_DIALOG":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_MYSTERYTROPHY_OPEN_DIALOG", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_ACHIEVEMENT_RESOLUTION_OPEN":
                        _roomEngine.connection.send(new GetResolutionAchievementsMessageComposer(_arg_1.objectId, 0));
                        return;
                    case "ROWRE_ACHIEVEMENT_RESOLUTION_ENGRAVING":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_ACHIEVEMENT_RESOLUTION_FAILED":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_ACHIEVEMENT_RESOLUTION_FAILED", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_FRIEND_FURNITURE_CONFIRM":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_FRIEND_FURNITURE_CONFIRM", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_FRIEND_FURNITURE_ENGRAVING":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_FRIEND_FURNITURE_ENGRAVING", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_BADGE_DISPLAY_ENGRAVING":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_BADGE_DISPLAY_ENGRAVING", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_HIGH_SCORE_DISPLAY":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_HIGH_SCORE_DISPLAY", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_HIDE_HIGH_SCORE_DISPLAY":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_HIDE_HIGH_SCORE_DISPLAY", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_INTERNAL_LINK":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_INTERNAL_LINK", _arg_2, _local_7, _local_5));
                        return;
                    case "ROWRE_ROOM_LINK":
                        _local_8.dispatchEvent(new RoomEngineToWidgetEvent("RETWE_REQUEST_ROOM_LINK", _arg_2, _local_7, _local_5));
                        return;
                };
            };
        }

        private function handleObjectRoomAdEvent(_arg_1:RoomObjectEvent, _arg_2:int):void
        {
            var _local_7:String;
            var _local_3:String;
            var _local_6:String;
            var _local_4:String;
            if ((((_roomEngine == null) || (_roomEngine.events == null)) || (_arg_1 == null)))
            {
                return;
            };
            var _local_9:int = _arg_1.objectId;
            var _local_10:String = _arg_1.objectType;
            var _local_8:int = _roomEngine.getRoomObjectCategory(_local_10);
            var _local_5:RoomObjectRoomAdEvent = (_arg_1 as RoomObjectRoomAdEvent);
            switch (_arg_1.type)
            {
                case "RORAE_ROOM_AD_FURNI_CLICK":
                    _roomEngine.events.dispatchEvent(_arg_1);
                    if (((!(_local_5 == null)) && (!(_roomEngine.toolbar == null))))
                    {
                        if (_local_5.clickUrl == "NAVIGATOR_GAMES")
                        {
                            _roomEngine.toolbar.toggleWindowVisibility("GAMES");
                        }
                        else
                        {
                            if (_local_5.clickUrl != "")
                            {
                                (_roomEngine as Component).context.createLinkEvent(_local_5.clickUrl);
                            };
                        };
                    };
                    _local_7 = "RERAE_FURNI_CLICK";
                    break;
                case "RORAE_ROOM_AD_FURNI_DOUBLE_CLICK":
                    if (((!(_local_5 == null)) && (!(_roomEngine.catalog == null))))
                    {
                        _local_3 = _local_5.clickUrl;
                        _local_6 = "CATALOG_PAGE:";
                        if (((_local_3) && (_local_3.indexOf(_local_6) == 0)))
                        {
                            _local_4 = _local_3.substr(_local_6.length);
                            _roomEngine.catalog.openCatalogPage(_local_4);
                        };
                    };
                    _local_7 = "RERAE_FURNI_DOUBLE_CLICK";
                    break;
                case "RORAE_ROOM_AD_TOOLTIP_SHOW":
                    _local_7 = "RERAE_TOOLTIP_SHOW";
                    break;
                case "RORAE_ROOM_AD_TOOLTIP_HIDE":
                    _local_7 = "RERAE_TOOLTIP_HIDE";
                    break;
                case "RORAE_ROOM_AD_LOAD_IMAGE":
                    if (_local_5 != null)
                    {
                        _roomEngine.requestRoomAdImage(_arg_2, _local_9, _local_8, _local_5.imageUrl, _local_5.clickUrl);
                    };
            };
            if (_local_7 == null)
            {
                return;
            };
            _roomEngine.events.dispatchEvent(new RoomEngineObjectEvent(_local_7, _arg_2, _local_9, _local_8));
        }

        private function handleObjectActionEvent(_arg_1:RoomObjectEvent, _arg_2:int):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            useObject(_arg_2, _arg_1.objectId, _arg_1.objectType, _arg_1.type);
        }

        private function handleObjectSoundMachineEvent(_arg_1:RoomObjectEvent, _arg_2:int):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            var _local_3:int = _roomEngine.getRoomObjectCategory(_arg_1.objectType);
            var _local_4:SelectedRoomObjectData = getSelectedObjectData(_arg_2);
            if (_local_4 != null)
            {
                if (((_local_4.category == _local_3) && (_local_4.id == _arg_1.objectId)))
                {
                    if (_local_4.operation == "OBJECT_PLACE")
                    {
                        return;
                    };
                };
            };
            switch (_arg_1.type)
            {
                case "ROFCAE_SOUND_MACHINE_INIT":
                    _roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent("ROSM_SOUND_MACHINE_INIT", _arg_2, _arg_1.objectId, _local_3));
                    return;
                case "ROFCAE_SOUND_MACHINE_START":
                    _roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent("ROSM_SOUND_MACHINE_SWITCHED_ON", _arg_2, _arg_1.objectId, _local_3));
                    return;
                case "ROFCAE_SOUND_MACHINE_STOP":
                    _roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent("ROSM_SOUND_MACHINE_SWITCHED_OFF", _arg_2, _arg_1.objectId, _local_3));
                    return;
                case "ROFCAE_SOUND_MACHINE_DISPOSE":
                    _roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent("ROSM_SOUND_MACHINE_DISPOSE", _arg_2, _arg_1.objectId, _local_3));
                    return;
            };
        }

        private function handleObjectJukeboxEvent(_arg_1:RoomObjectEvent, _arg_2:int):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            var _local_3:int = _roomEngine.getRoomObjectCategory(_arg_1.objectType);
            var _local_4:SelectedRoomObjectData = getSelectedObjectData(_arg_2);
            if (_local_4 != null)
            {
                if (((_local_4.category == _local_3) && (_local_4.id == _arg_1.objectId)))
                {
                    if (_local_4.operation == "OBJECT_PLACE")
                    {
                        return;
                    };
                };
            };
            switch (_arg_1.type)
            {
                case "ROFCAE_JUKEBOX_INIT":
                    _roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent("ROSM_JUKEBOX_INIT", _arg_2, _arg_1.objectId, _local_3));
                    return;
                case "ROFCAE_JUKEBOX_START":
                    _roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent("ROSM_JUKEBOX_SWITCHED_ON", _arg_2, _arg_1.objectId, _local_3));
                    return;
                case "ROFCAE_JUKEBOX_MACHINE_STOP":
                    _roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent("ROSM_JUKEBOX_SWITCHED_OFF", _arg_2, _arg_1.objectId, _local_3));
                    return;
                case "ROFCAE_JUKEBOX_DISPOSE":
                    _roomEngine.events.dispatchEvent(new RoomEngineSoundMachineEvent("ROSM_JUKEBOX_DISPOSE", _arg_2, _arg_1.objectId, _local_3));
                    return;
            };
        }

        private function handleObjectGroupBadgeEvent(_arg_1:RoomObjectEvent, _arg_2:int):void
        {
            var _local_3:RoomObjectBadgeAssetEvent;
            if ((((_roomEngine == null) || (_roomEngine.events == null)) || (_arg_1 == null)))
            {
                return;
            };
            var _local_5:int = _arg_1.objectId;
            var _local_6:String = _arg_1.objectType;
            var _local_4:int = _roomEngine.getRoomObjectCategory(_local_6);
            if (_arg_1.type == "ROGBE_LOAD_BADGE")
            {
                _local_3 = (_arg_1 as RoomObjectBadgeAssetEvent);
                if (_local_3 != null)
                {
                    _roomEngine.requestBadgeImageAsset(_arg_2, _local_5, _local_4, _local_3.badgeId, _local_3.groupBadge);
                };
            };
        }

        private function handleObjectFloorHoleEvent(_arg_1:RoomObjectEvent, _arg_2:int):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            switch (_arg_1.type)
            {
                case "ROFHO_ADD_HOLE":
                    _roomEngine.addFloorHole(_arg_2, _arg_1.objectId);
                    return;
                case "ROFHO_REMOVE_HOLE":
                    _roomEngine.removeFloorHole(_arg_2, _arg_1.objectId);
                    return;
            };
        }

        private function handleRoomActionMouseRequestEvent(_arg_1:RoomObjectEvent, _arg_2:int):void
        {
            _roomEngine.requestMouseCursor(_arg_1.type, _arg_1.objectId, _arg_1.objectType);
        }

        private function handleObjectDimmerStateEvent(_arg_1:RoomObjectEvent, _arg_2:int):void
        {
            var _local_4:RoomObjectDimmerStateUpdateEvent;
            var _local_3:RoomEngineDimmerStateEvent;
            if (_arg_1 == null)
            {
                return;
            };
            var _local_5:int = _arg_1.objectId;
            if (((!(_roomEngine == null)) && (!(_roomEngine.connection == null))))
            {
                switch (_arg_1.type)
                {
                    case "RODSUE_DIMMER_STATE":
                        _local_4 = (_arg_1 as RoomObjectDimmerStateUpdateEvent);
                        if (_local_4 != null)
                        {
                            _local_3 = new RoomEngineDimmerStateEvent(_arg_2, _local_4.state, _local_4.presetId, _local_4.effectId, _local_4.color, _local_4.brightness);
                            _roomEngine.events.dispatchEvent(_local_3);
                        };
                        return;
                };
            };
        }

        private function handleRoomObjectPlaySoundEvent(_arg_1:RoomObjectPlaySoundIdEvent, _arg_2:int):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            var _local_3:int = _roomEngine.getRoomObjectCategory(_arg_1.objectType);
            if (((!(_roomEngine == null)) && (!(_roomEngine.connection == null))))
            {
                switch (_arg_1.type)
                {
                    case "ROPSIE_PLAY_SOUND":
                        _roomEngine.events.dispatchEvent(new RoomEngineObjectPlaySoundEvent("REPSE_PLAY_SOUND", _arg_2, _arg_1.objectId, _local_3, _arg_1.soundId, _arg_1.pitch));
                        return;
                    case "ROPSIE_PLAY_SOUND_AT_PITCH":
                        _roomEngine.events.dispatchEvent(new RoomEngineObjectPlaySoundEvent("REPSE_PLAY_SOUND_AT_PITCH", _arg_2, _arg_1.objectId, _local_3, _arg_1.soundId, _arg_1.pitch));
                        return;
                };
            };
        }

        private function handleRoomObjectSamplePlaybackEvent(_arg_1:RoomObjectSamplePlaybackEvent, _arg_2:int):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            var _local_3:int = _roomEngine.getRoomObjectCategory(_arg_1.objectType);
            if (((!(_roomEngine == null)) && (!(_roomEngine.connection == null))))
            {
                switch (_arg_1.type)
                {
                    case "ROPSPE_ROOM_OBJECT_INITIALIZED":
                        _roomEngine.events.dispatchEvent(new RoomEngineObjectSamplePlaybackEvent("REOSPE_ROOM_OBJECT_INITIALIZED", _arg_2, _arg_1.objectId, _local_3, _arg_1.sampleId, _arg_1.pitch));
                        return;
                    case "ROPSPE_ROOM_OBJECT_DISPOSED":
                        _roomEngine.events.dispatchEvent(new RoomEngineObjectSamplePlaybackEvent("REOSPE_ROOM_OBJECT_DISPOSED", _arg_2, _arg_1.objectId, _local_3, _arg_1.sampleId, _arg_1.pitch));
                        return;
                    case "ROPSPE_PLAY_SAMPLE":
                        _roomEngine.events.dispatchEvent(new RoomEngineObjectSamplePlaybackEvent("REOSPE_PLAY_SAMPLE", _arg_2, _arg_1.objectId, _local_3, _arg_1.sampleId, _arg_1.pitch));
                        return;
                    case "ROPSPE_CHANGE_PITCH":
                        _roomEngine.events.dispatchEvent(new RoomEngineObjectSamplePlaybackEvent("REOSPE_CHANGE_PITCH", _arg_2, _arg_1.objectId, _local_3, _arg_1.sampleId, _arg_1.pitch));
                        return;
                };
            };
        }

        private function handleRoomObjectHSLColorEnableEvent(_arg_1:RoomObjectHSLColorEnableEvent, _arg_2:int):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            if (((!(_roomEngine == null)) && (!(_roomEngine.connection == null))))
            {
                switch (_arg_1.type)
                {
                    case "ROHSLCEE_ROOM_BACKGROUND_COLOR":
                        _roomEngine.events.dispatchEvent(new RoomEngineHSLColorEnableEvent("ROHSLCEE_ROOM_BACKGROUND_COLOR", _arg_2, _arg_1.enable, _arg_1.hue, _arg_1.saturation, _arg_1.lightness));
                        return;
                };
            };
        }

        private function handleRoomObjectDataRequestEvent(_arg_1:RoomObjectEvent, _arg_2:int):void
        {
            if ((((_roomEngine == null) || (_arg_1 == null)) || (_arg_1.object == null)))
            {
                return;
            };
            var _local_3:IRoomObjectModelController = (_arg_1.object.getModel() as IRoomObjectModelController);
            switch (_arg_1.type)
            {
                case "RODRE_CURRENT_USER_ID":
                    _local_3.setNumber("session_current_user_id", _roomEngine.sessionDataManager.userId);
                    return;
                case "RODRE_URL_PREFIX":
                    _local_3.setString("session_url_prefix", _roomEngine.configuration.getProperty("url.prefix"));
                    return;
            };
        }

        private function handleSelectedObjectMove(_arg_1:RoomObjectEvent, _arg_2:int):void
        {
            var _local_3:IVector3d;
            var _local_8:RoomObjectUpdateMessage;
            if (_roomEngine == null)
            {
                return;
            };
            var _local_7:int = _arg_1.objectId;
            var _local_9:String = _arg_1.objectType;
            var _local_6:int = _roomEngine.getRoomObjectCategory(_local_9);
            var _local_4:IRoomObjectController = (_roomEngine.getRoomObject(_arg_2, _local_7, _local_6) as IRoomObjectController);
            var _local_5:IRoomObjectController = _roomEngine.getSelectionArrow(_arg_2);
            if ((((!(_local_4 == null)) && (!(_local_5 == null))) && (!(_local_5.getEventHandler() == null))))
            {
                _local_3 = _local_4.getLocation();
                _local_8 = new RoomObjectUpdateMessage(_local_3, null);
                _local_5.getEventHandler().processUpdateMessage(_local_8);
            };
        }

        private function handleSelectedObjectRemove(_arg_1:RoomObjectEvent, _arg_2:int):void
        {
            setSelectedAvatar(_arg_2, 0, false);
        }

        private function handleFurnitureMove(_arg_1:IRoomObjectController, _arg_2:SelectedRoomObjectData, _arg_3:int, _arg_4:int, _arg_5:FurniStackingHeightMap):Boolean
        {
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return (false);
            };
            var _local_6:Vector3d = new Vector3d();
            _local_6.assign(_arg_1.getDirection());
            _arg_1.setDirection(_arg_2.dir);
            var _local_8:Vector3d = new Vector3d(_arg_3, _arg_4, 0);
            var _local_7:Vector3d = new Vector3d();
            _local_7.assign(_arg_1.getDirection());
            var _local_9:Vector3d = validateFurnitureLocation(_arg_1, _local_8, _arg_2.loc, _arg_2.dir, _arg_5);
            if (_local_9 == null)
            {
                _local_7.x = getValidRoomObjectDirection(_arg_1, true);
                _arg_1.setDirection(_local_7);
                _local_9 = validateFurnitureLocation(_arg_1, _local_8, _arg_2.loc, _arg_2.dir, _arg_5);
            };
            if (_local_9 == null)
            {
                _arg_1.setDirection(_local_6);
                return (false);
            };
            _arg_1.setLocation(_local_9);
            if (_local_7)
            {
                _arg_1.setDirection(_local_7);
            };
            return (true);
        }

        private function handleWallItemMove(_arg_1:IRoomObjectController, _arg_2:SelectedRoomObjectData, _arg_3:IVector3d, _arg_4:IVector3d, _arg_5:IVector3d, _arg_6:Number, _arg_7:Number, _arg_8:Number):Boolean
        {
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return (false);
            };
            var _local_9:Vector3d = new Vector3d(_arg_8);
            var _local_10:Vector3d = validateWallItemLocation(_arg_1, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_2);
            if (_local_10 == null)
            {
                return (false);
            };
            _arg_1.setLocation(_local_10);
            _arg_1.setDirection(_local_9);
            return (true);
        }

        private function handleUserPlace(_arg_1:IRoomObjectController, _arg_2:int, _arg_3:int, _arg_4:LegacyWallGeometry):Boolean
        {
            if (!_arg_4.isRoomTile(_arg_2, _arg_3))
            {
                return (false);
            };
            _arg_1.setLocation(new Vector3d(_arg_2, _arg_3, _arg_4.getTileHeight(_arg_2, _arg_3)));
            return (true);
        }

        private function validateFurnitureDirection(_arg_1:IRoomObject, _arg_2:IVector3d, _arg_3:FurniStackingHeightMap):Boolean
        {
            var _local_11:Boolean;
            if ((((_arg_1 == null) || (_arg_1.getModel() == null)) || (_arg_2 == null)))
            {
                return (false);
            };
            var _local_7:IVector3d = _arg_1.getDirection();
            var _local_4:IVector3d = _arg_1.getLocation();
            if (((_local_7 == null) || (_local_4 == null)))
            {
                return (false);
            };
            if ((_local_7.x % 180) == (_arg_2.x % 180))
            {
                return (true);
            };
            var _local_10:int = _arg_1.getModel().getNumber("furniture_size_x");
            var _local_8:int = _arg_1.getModel().getNumber("furniture_size_y");
            if (_local_10 < 1)
            {
                _local_10 = 1;
            };
            if (_local_8 < 1)
            {
                _local_8 = 1;
            };
            var _local_12:int = _local_10;
            var _local_9:int = _local_8;
            var _local_5:int;
            var _local_6:int = int((((_arg_2.x + 45) % 360) / 90));
            if (((_local_6 == 1) || (_local_6 == 3)))
            {
                _local_5 = _local_10;
                _local_10 = _local_8;
                _local_8 = _local_5;
            };
            _local_6 = int((((_local_7.x + 45) % 360) / 90));
            if (((_local_6 == 1) || (_local_6 == 3)))
            {
                _local_5 = _local_12;
                _local_12 = _local_9;
                _local_9 = _local_5;
            };
            if (((!(_arg_3 == null)) && (!(_local_4 == null))))
            {
                _local_11 = (_arg_1.getModel().getNumber("furniture_always_stackable") == 1);
                if (_arg_3.validateLocation(_local_4.x, _local_4.y, _local_10, _local_8, _local_4.x, _local_4.y, _local_12, _local_9, _local_11, _local_4.z))
                {
                    return (true);
                };
                return (false);
            };
            return (false);
        }

        private function validateFurnitureLocation(_arg_1:IRoomObject, _arg_2:IVector3d, _arg_3:IVector3d, _arg_4:IVector3d, _arg_5:FurniStackingHeightMap):Vector3d
        {
            var _local_16:Vector3d;
            var _local_12:Boolean;
            if ((((_arg_1 == null) || (_arg_1.getModel() == null)) || (_arg_2 == null)))
            {
                return (null);
            };
            var _local_8:IVector3d = _arg_1.getDirection();
            if (_local_8 == null)
            {
                return (null);
            };
            if (((_arg_3 == null) || (_arg_4 == null)))
            {
                return (null);
            };
            if (((_arg_2.x == _arg_3.x) && (_arg_2.y == _arg_3.y)))
            {
                if (_local_8.x == _arg_4.x)
                {
                    _local_16 = new Vector3d();
                    _local_16.assign(_arg_3);
                    return (_local_16);
                };
            };
            var _local_11:int = _arg_1.getModel().getNumber("furniture_size_x");
            var _local_9:int = _arg_1.getModel().getNumber("furniture_size_y");
            if (_local_11 < 1)
            {
                _local_11 = 1;
            };
            if (_local_9 < 1)
            {
                _local_9 = 1;
            };
            var _local_6:int = _arg_3.x;
            var _local_7:int = _arg_3.y;
            var _local_13:int = _local_11;
            var _local_10:int = _local_9;
            var _local_14:int;
            var _local_15:int = int((((_local_8.x + 45) % 360) / 90));
            if (((_local_15 == 1) || (_local_15 == 3)))
            {
                _local_14 = _local_11;
                _local_11 = _local_9;
                _local_9 = _local_14;
            };
            _local_15 = int((((_arg_4.x + 45) % 360) / 90));
            if (((_local_15 == 1) || (_local_15 == 3)))
            {
                _local_14 = _local_13;
                _local_13 = _local_10;
                _local_10 = _local_14;
            };
            if (((!(_arg_5 == null)) && (!(_arg_2 == null))))
            {
                _local_12 = (_arg_1.getModel().getNumber("furniture_always_stackable") == 1);
                if (_arg_5.validateLocation(_arg_2.x, _arg_2.y, _local_11, _local_9, _local_6, _local_7, _local_13, _local_10, _local_12))
                {
                    return (new Vector3d(_arg_2.x, _arg_2.y, _arg_5.getTileHeight(_arg_2.x, _arg_2.y)));
                };
                return (null);
            };
            return (null);
        }

        private function validateWallItemLocation(_arg_1:IRoomObject, _arg_2:IVector3d, _arg_3:IVector3d, _arg_4:IVector3d, _arg_5:Number, _arg_6:Number, _arg_7:SelectedRoomObjectData):Vector3d
        {
            if (((((((_arg_1 == null) || (_arg_1.getModel() == null)) || (_arg_2 == null)) || (_arg_3 == null)) || (_arg_4 == null)) || (_arg_7 == null)))
            {
                return (null);
            };
            var _local_11:Number = _arg_1.getModel().getNumber("furniture_size_x");
            var _local_10:Number = _arg_1.getModel().getNumber("furniture_size_z");
            var _local_8:Number = _arg_1.getModel().getNumber("furniture_center_z");
            if (((((_arg_5 < (_local_11 / 2)) || (_arg_5 > (_arg_3.length - (_local_11 / 2)))) || (_arg_6 < _local_8)) || (_arg_6 > (_arg_4.length - (_local_10 - _local_8)))))
            {
                if (((_arg_5 < (_local_11 / 2)) && (_arg_5 <= (_arg_3.length - (_local_11 / 2)))))
                {
                    _arg_5 = (_local_11 / 2);
                }
                else
                {
                    if (((_arg_5 >= (_local_11 / 2)) && (_arg_5 > (_arg_3.length - (_local_11 / 2)))))
                    {
                        _arg_5 = (_arg_3.length - (_local_11 / 2));
                    };
                };
                if (((_arg_6 < _local_8) && (_arg_6 <= (_arg_4.length - (_local_10 - _local_8)))))
                {
                    _arg_6 = _local_8;
                }
                else
                {
                    if (((_arg_6 >= _local_8) && (_arg_6 > (_arg_4.length - (_local_10 - _local_8)))))
                    {
                        _arg_6 = (_arg_4.length - (_local_10 - _local_8));
                    };
                };
            };
            if (((((_arg_5 < (_local_11 / 2)) || (_arg_5 > (_arg_3.length - (_local_11 / 2)))) || (_arg_6 < _local_8)) || (_arg_6 > (_arg_4.length - (_local_10 - _local_8)))))
            {
                return (null);
            };
            var _local_9:Vector3d = Vector3d.sum(Vector3d.product(_arg_3, (_arg_5 / _arg_3.length)), Vector3d.product(_arg_4, (_arg_6 / _arg_4.length)));
            _local_9 = Vector3d.sum(_arg_2, _local_9);
            return (_local_9);
        }

        private function setObjectAlphaMultiplier(_arg_1:IRoomObjectController, _arg_2:Number):void
        {
            if (((!(_arg_1 == null)) && (!(_arg_1.getModelController() == null))))
            {
                _arg_1.getModelController().setNumber("furniture_alpha_multiplier", _arg_2);
            };
        }

        public function setSelectedAvatar(_arg_1:int, _arg_2:int, _arg_3:Boolean):void
        {
            if (_roomEngine == null)
            {
                return;
            };
            var _local_6:int = 100;
            var _local_7:IRoomObjectController = (_roomEngine.getRoomObject(_arg_1, _SafeStr_3657, _local_6) as IRoomObjectController);
            if (((!(_local_7 == null)) && (!(_local_7.getEventHandler() == null))))
            {
                _local_7.getEventHandler().processUpdateMessage(new RoomObjectAvatarSelectedMessage(false));
                _SafeStr_3657 = -1;
            };
            var _local_4:Boolean;
            if (_arg_3)
            {
                _local_7 = (_roomEngine.getRoomObject(_arg_1, _arg_2, _local_6) as IRoomObjectController);
                if (((!(_local_7 == null)) && (!(_local_7.getEventHandler() == null))))
                {
                    _local_7.getEventHandler().processUpdateMessage(new RoomObjectAvatarSelectedMessage(true));
                    _local_4 = true;
                    _SafeStr_3657 = _arg_2;
                    try
                    {
                        _roomEngine.connection.send(new LookToMessageComposer(_local_7.getLocation().x, _local_7.getLocation().y));
                    }
                    catch(e:Error)
                    {
                    };
                };
            };
            var _local_5:IRoomObjectController = _roomEngine.getSelectionArrow(_arg_1);
            if (((!(_local_5 == null)) && (!(_local_5.getEventHandler() == null))))
            {
                if (((_local_4) && (!(_roomEngine.getActiveRoomIsPlayingGame()))))
                {
                    _local_5.getEventHandler().processUpdateMessage(new RoomObjectVisibilityUpdateMessage("ROVUM_ENABLED"));
                }
                else
                {
                    _local_5.getEventHandler().processUpdateMessage(new RoomObjectVisibilityUpdateMessage("ROVUM_DISABLED"));
                };
            };
        }

        public function getSelectedAvatarId():int
        {
            return (_SafeStr_3657);
        }

        private function getValidRoomObjectDirection(_arg_1:IRoomObjectController, _arg_2:Boolean):int
        {
            var _local_4:int;
            var _local_5:int;
            if (((_arg_1 == null) || (_arg_1.getModel() == null)))
            {
                return (0);
            };
            var _local_3:Array;
            var _local_6:String = _arg_1.getType();
            if (_arg_1.getModel() != null)
            {
                if (_local_6 == "monsterplant")
                {
                    _local_3 = _arg_1.getModel().getNumberArray("pet_allowed_directions");
                }
                else
                {
                    _local_3 = _arg_1.getModel().getNumberArray("furniture_allowed_directions");
                };
            };
            var _local_7:int = _arg_1.getDirection().x;
            if (((!(_local_3 == null)) && (_local_3.length > 0)))
            {
                _local_4 = _local_3.indexOf(_local_7);
                if (_local_4 < 0)
                {
                    _local_4 = 0;
                    _local_5 = 0;
                    while (_local_5 < _local_3.length)
                    {
                        if (_local_7 <= _local_3[_local_5]) break;
                        _local_4++;
                        _local_5++;
                    };
                    _local_4 = (_local_4 % _local_3.length);
                };
                if (_arg_2)
                {
                    _local_4 = ((_local_4 + 1) % _local_3.length);
                }
                else
                {
                    _local_4 = (((_local_4 - 1) + _local_3.length) % _local_3.length);
                };
                _local_7 = _local_3[_local_4];
            };
            return (_local_7);
        }

        public function modifyRoomObjectData(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:Map):Boolean
        {
            if (_roomEngine == null)
            {
                return (false);
            };
            var _local_6:IRoomObjectController = (_roomEngine.getRoomObject(_arg_1, _arg_2, _arg_3) as IRoomObjectController);
            if (_local_6 == null)
            {
                return (false);
            };
            switch (_arg_4)
            {
                case "OBJECT_SAVE_STUFF_DATA":
                    if (_roomEngine.connection)
                    {
                        _roomEngine.connection.send(new SetObjectDataMessageComposer(_arg_2, _arg_5));
                    };
                    break;
                default:
                    Logger.log(("could not modify room object data, unknown operation " + _arg_4));
            };
            return (true);
        }

        public function modifyRoomObject(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String):Boolean
        {
            var _local_6:SelectedRoomObjectData;
            var _local_7:int;
            var _local_12:LegacyWallGeometry;
            var _local_9:String;
            if (_roomEngine == null)
            {
                return (false);
            };
            var _local_13:IRoomObjectController = (_roomEngine.getRoomObject(_arg_1, _arg_2, _arg_3) as IRoomObjectController);
            if (_local_13 == null)
            {
                return (false);
            };
            var _local_8:int;
            var _local_10:int;
            var _local_14:int;
            var _local_11:Boolean = true;
            var _local_15:IRoomSession;
            var _local_5:IUserData;
            switch (_arg_4)
            {
                case "OBJECT_ROTATE_POSITIVE":
                case "OBJECT_ROTATE_NEGATIVE":
                    if (_roomEngine.connection)
                    {
                        if (_arg_4 == "OBJECT_ROTATE_NEGATIVE")
                        {
                            _local_14 = getValidRoomObjectDirection(_local_13, false);
                        }
                        else
                        {
                            _local_14 = getValidRoomObjectDirection(_local_13, true);
                        };
                        _local_8 = _local_13.getLocation().x;
                        _local_10 = _local_13.getLocation().y;
                        if (validateFurnitureDirection(_local_13, new Vector3d(_local_14), _roomEngine.getFurniStackingHeightMap(_arg_1)))
                        {
                            _local_14 = int((_local_14 / 45));
                            if (_local_13.getType() == "monsterplant")
                            {
                                _local_15 = _roomEngine.roomSessionManager.getSession(_arg_1);
                                if (_local_15 != null)
                                {
                                    _local_5 = _local_15.userDataManager.getUserDataByIndex(_arg_2);
                                    if (_local_5 != null)
                                    {
                                        _roomEngine.connection.send(new MovePetMessageComposer(_local_5.webID, _local_8, _local_10, _local_14));
                                    };
                                };
                            }
                            else
                            {
                                _roomEngine.connection.send(new MoveObjectMessageComposer(_arg_2, _local_8, _local_10, _local_14));
                            };
                        };
                    };
                    break;
                case "OBJECT_EJECT":
                case "OBJECT_PICKUP":
                    if (_roomEngine.connection)
                    {
                        _roomEngine.connection.send(new PickupObjectMessageComposer(_arg_2, _arg_3));
                    };
                    break;
                case "OBJECT_PICKUP_PET":
                    if (_roomEngine.connection)
                    {
                        _local_15 = _roomEngine.roomSessionManager.getSession(_arg_1);
                        if (_local_15 != null)
                        {
                            _local_5 = _local_15.userDataManager.getUserDataByIndex(_arg_2);
                            _local_15.pickUpPet(_local_5.webID);
                        };
                    };
                    break;
                case "OBJECT_PICKUP_BOT":
                    if (_roomEngine.connection)
                    {
                        _local_15 = _roomEngine.roomSessionManager.getSession(_arg_1);
                        if (_local_15 != null)
                        {
                            _local_5 = _local_15.userDataManager.getUserDataByIndex(_arg_2);
                            if (_local_5 != null)
                            {
                                _roomEngine.connection.send(new RemoveBotFromFlatMessageComposer(_local_5.webID));
                            };
                        };
                    };
                    break;
                case "OBJECT_MOVE":
                    _local_11 = false;
                    setObjectAlphaMultiplier(_local_13, 0.5);
                    setSelectedObjectData(_arg_1, _local_13.getId(), _arg_3, _local_13.getLocation(), _local_13.getDirection(), _arg_4);
                    _roomEngine.setObjectMoverIconSprite(_local_13.getId(), _arg_3, true);
                    _roomEngine.setObjectMoverIconSpriteVisible(false);
                    break;
                case "OBJECT_MOVE_TO":
                    _local_6 = getSelectedObjectData(_arg_1);
                    updateSelectedObjectData(_arg_1, _local_6.id, _local_6.category, _local_6.loc, _local_6.dir, "OBJECT_MOVE_TO", _local_6.typeId, _local_6.instanceData, _local_6.stuffData, _local_6.state, _local_6.animFrame, _local_6.posture);
                    setObjectAlphaMultiplier(_local_13, 1);
                    _roomEngine.removeObjectMoverIconSprite();
                    if (_roomEngine.connection)
                    {
                        if (_arg_3 == 10)
                        {
                            _local_14 = (_local_13.getDirection().x % 360);
                            _local_8 = _local_13.getLocation().x;
                            _local_10 = _local_13.getLocation().y;
                            _local_14 = int((_local_14 / 45));
                            _local_15 = _roomEngine.roomSessionManager.getSession(_arg_1);
                            if (_local_15 != null)
                            {
                                _local_15.trackEventLogOncePerSession("Tutorial", "interaction", "furniture.move");
                            };
                            _roomEngine.connection.send(new MoveObjectMessageComposer(_arg_2, _local_8, _local_10, _local_14));
                        }
                        else
                        {
                            if (_arg_3 == 100)
                            {
                                _local_14 = (_local_13.getDirection().x % 360);
                                _local_8 = _local_13.getLocation().x;
                                _local_10 = _local_13.getLocation().y;
                                _local_14 = int((_local_14 / 45));
                                _local_7 = parseInt(_local_13.getModel().getString("race"));
                                _local_15 = _roomEngine.roomSessionManager.getSession(_arg_1);
                                if (_local_15 != null)
                                {
                                    _local_5 = _local_15.userDataManager.getUserDataByIndex(_arg_2);
                                    if (_local_5 != null)
                                    {
                                        _roomEngine.connection.send(new MovePetMessageComposer(_local_5.webID, _local_8, _local_10, _local_14));
                                    };
                                };
                            }
                            else
                            {
                                if (_arg_3 == 20)
                                {
                                    _local_14 = (_local_13.getDirection().x % 360);
                                    _local_12 = _roomEngine.getLegacyGeometry(_arg_1);
                                    if (((_roomEngine.connection) && (_local_12)))
                                    {
                                        _local_9 = _local_12.getOldLocationString(_local_13.getLocation(), _local_14);
                                        if (_local_9 != null)
                                        {
                                            _local_15 = _roomEngine.roomSessionManager.getSession(_arg_1);
                                            if (_local_15 != null)
                                            {
                                                _local_15.trackEventLogOncePerSession("Tutorial", "interaction", "furniture.move");
                                            };
                                            _roomEngine.connection.send(new MoveWallItemMessageComposer(_arg_2, 20, _local_9));
                                        };
                                    };
                                };
                            };
                        };
                    };
            };
            if (_local_11)
            {
                resetSelectedObjectData(_arg_1);
            };
            return (true);
        }

        private function placeObjectOnUser(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_4:SelectedRoomObjectData = getSelectedObjectData(_arg_1);
            if (_local_4 == null)
            {
                return;
            };
            var _local_5:IRoomObjectController = (_roomEngine.getRoomObject(_arg_1, _arg_2, _arg_3) as IRoomObjectController);
            if (_local_5 == null)
            {
                return;
            };
            if (((_roomEngine) && (_roomEngine.events)))
            {
                _roomEngine.events.dispatchEvent(new RoomEngineObjectPlacedOnUserEvent("REOE_PLACED_ON_USER", _arg_1, _arg_2, _arg_3, _local_4.id, _local_4.category));
            };
        }

        private function placeObject(_arg_1:int, _arg_2:Boolean, _arg_3:Boolean):void
        {
            var _local_6:IRoomObjectController;
            var _local_4:IVector3d;
            var _local_16:LegacyWallGeometry;
            var _local_9:Boolean;
            var _local_5:SelectedRoomObjectData = getSelectedObjectData(_arg_1);
            if (_local_5 == null)
            {
                return;
            };
            var _local_14:int = _local_5.id;
            var _local_15:int = _local_5.category;
            var _local_11:String = "";
            var _local_10:Number = 0;
            var _local_12:Number = 0;
            var _local_13:Number = 0;
            var _local_7:int;
            if (((!(_roomEngine == null)) && (!(_roomEngine.connection == null))))
            {
                _local_6 = (_roomEngine.getRoomObject(_arg_1, _local_14, _local_15) as IRoomObjectController);
                if (_local_6 != null)
                {
                    _local_7 = _local_6.getDirection().x;
                    _local_4 = _local_6.getLocation();
                    if (((_local_15 == 10) || (_local_15 == 100)))
                    {
                        _local_10 = _local_4.x;
                        _local_12 = _local_4.y;
                        _local_13 = _local_4.z;
                    }
                    else
                    {
                        if (_local_15 == 20)
                        {
                            _local_10 = _local_4.x;
                            _local_12 = _local_4.y;
                            _local_13 = _local_4.z;
                            _local_16 = _roomEngine.getLegacyGeometry(_arg_1);
                            if (_local_16 != null)
                            {
                                _local_11 = _local_16.getOldLocationString(_local_4, _local_7);
                            };
                        };
                    };
                    _local_7 = int(((((_local_7 / 45) % 8) + 8) % 8));
                    if (((_local_6.getType() == "free_placement_room") && (roomEngine.getRoom(_arg_1).getObjectCountForType("free_placement_room", 10) > 1)))
                    {
                        roomEngine.windowManager.alert("One free placement furni already in room!", "There can be only one free_placement_room furni in a room. See intraweb for instructions on how to use it.", 0, null);
                        return;
                    };
                    if (((_local_14 < 0) && (_local_15 == 100)))
                    {
                        _local_14 = (_local_14 * -1);
                    };
                    if ((((_roomEngine.catalog == null) || (_roomEngine.catalog.catalogType == "NORMAL")) || (!(_SafeStr_3661 == "catalog"))))
                    {
                        if (((_local_15 == 100) && (_local_5.typeId == 2)))
                        {
                            _roomEngine.connection.send(new PlacePetMessageComposer(_local_14, _local_10, _local_12));
                        }
                        else
                        {
                            if (((_local_15 == 100) && (_local_5.typeId == 4)))
                            {
                                _roomEngine.connection.send(new PlaceBotMessageComposer(_local_14, _local_10, _local_12));
                            }
                            else
                            {
                                if (_local_6.getModelController().getString("furniture_is_stickie") != null)
                                {
                                    _roomEngine.connection.send(new PlacePostItMessageComposer(_local_14, _local_11));
                                }
                                else
                                {
                                    _roomEngine.connection.send(new PlaceObjectMessageComposer(_local_14, _local_15, _local_11, _local_10, _local_12, _local_7));
                                };
                            };
                        };
                    };
                };
            };
            var _local_8:SelectedRoomObjectData = new SelectedRoomObjectData(_local_5.id, _local_5.category, null, null, null);
            _roomEngine.setPlacedObjectData(_arg_1, _local_8);
            resetSelectedObjectData(_arg_1);
            if (((_roomEngine) && (_roomEngine.events)))
            {
                _local_9 = ((_local_6) && (_local_6.getId() == _local_5.id));
                _roomEngine.events.dispatchEvent(new RoomEngineObjectPlacedEvent("REOE_PLACED", _arg_1, _local_14, _local_15, _local_11, _local_10, _local_12, _local_13, _local_7, _local_9, _arg_2, _arg_3, _local_5.instanceData));
            };
        }

        private function changeObjectState(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:Boolean):void
        {
            var _local_6:int = _roomEngine.getRoomObjectCategory(_arg_3);
            changeRoomObjectState(_arg_1, _arg_2, _local_6, _arg_4, _arg_5);
        }

        private function changeRoomObjectState(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Boolean):Boolean
        {
            var _local_6:IRoomSession;
            if (((!(_roomEngine == null)) && (!(_roomEngine.connection == null))))
            {
                if (_arg_3 == 10)
                {
                    if (!_arg_5)
                    {
                        _roomEngine.connection.send(new UseFurnitureMessageComposer(_arg_2, _arg_4));
                    }
                    else
                    {
                        _roomEngine.connection.send(new SetRandomStateMessageComposer(_arg_2, _arg_4));
                    };
                }
                else
                {
                    if (_arg_3 == 20)
                    {
                        _roomEngine.connection.send(new UseWallItemMessageComposer(_arg_2, _arg_4));
                    };
                };
                _local_6 = _roomEngine.roomSessionManager.getSession(_arg_1);
                if (_local_6 != null)
                {
                    _local_6.trackEventLogOncePerSession("Achievements", "interaction", "furniture.use");
                };
            };
            return (true);
        }

        private function useObject(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:String):void
        {
            if (((!(_roomEngine == null)) && (!(_roomEngine.connection == null))))
            {
                switch (_arg_4)
                {
                    case "ROFCAE_DICE_ACTIVATE":
                        _roomEngine.connection.send(new ThrowDiceMessageComposer(_arg_2));
                        return;
                    case "ROFCAE_DICE_OFF":
                        _roomEngine.connection.send(new DiceOffMessageComposer(_arg_2));
                        return;
                    case "ROFCAE_USE_HABBOWHEEL":
                        _roomEngine.connection.send(new SpinWheelOfFortuneMessageComposer(_arg_2));
                        return;
                    case "ROFCAE_STICKIE":
                        _roomEngine.connection.send(new GetItemDataMessageComposer(_arg_2));
                        return;
                    case "ROFCAE_ENTER_ONEWAYDOOR":
                        _roomEngine.connection.send(new EnterOneWayDoorMessageComposer(_arg_2));
                        return;
                };
            };
        }

        public function modifyWallItemData(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:String):Boolean
        {
            if (((_roomEngine == null) || (_roomEngine.connection == null)))
            {
                return (false);
            };
            _roomEngine.connection.send(new SetItemDataMessageComposer(_arg_2, _arg_3, _arg_4));
            return (true);
        }

        public function deleteWallItem(_arg_1:int, _arg_2:int):Boolean
        {
            if (((_roomEngine == null) || (_roomEngine.connection == null)))
            {
                return (false);
            };
            _roomEngine.connection.send(new RemoveItemMessageComposer(_arg_2));
            return (true);
        }

        private function handleClickOnTile(_arg_1:int, _arg_2:RoomObjectTileMouseEvent):void
        {
            if (_roomEngine == null)
            {
                return;
            };
            if (_roomEngine.isDecorateMode)
            {
                return;
            };
            if (!_roomEngine.roomSessionManager)
            {
                return;
            };
            var _local_3:IRoomSession = _roomEngine.roomSessionManager.getSession(_arg_1);
            if (((!(_local_3 == null)) && (_local_3.isSpectatorMode)))
            {
                return;
            };
            if (_roomEngine.isGameMode)
            {
                if (_roomEngine.playerUnderCursor >= 0)
                {
                    _roomEngine.gameEngine.handleClickOnHuman(_roomEngine.playerUnderCursor, _arg_2.altKey, _arg_2.shiftKey);
                }
                else
                {
                    _roomEngine.gameEngine.handleClickOnTile(_arg_2);
                };
            }
            else
            {
                _local_3.trackEventLogOncePerSession("Tutorial", "interaction", "avatar.move");
                walkTo(_arg_2.tileXAsInt, _arg_2.tileYAsInt);
            };
        }

        private function walkTo(_arg_1:int, _arg_2:int):void
        {
            if (_roomEngine.connection)
            {
                _roomEngine.connection.send(new MoveAvatarMessageComposer(_arg_1, _arg_2));
            };
        }

        private function handleClickOnAvatar(_arg_1:int, _arg_2:RoomObjectMouseEvent):void
        {
            if (_roomEngine == null)
            {
                return;
            };
            if (roomEngine.isDecorateMode)
            {
                return;
            };
            if (_roomEngine.isGameMode)
            {
                _roomEngine.gameEngine.handleClickOnHuman(_arg_1, _arg_2.altKey, _arg_2.shiftKey);
            };
        }

        private function handleMouseEnterAvatar(_arg_1:int, _arg_2:RoomObjectMouseEvent, _arg_3:int):void
        {
            var _local_8:IRoomObjectController;
            var _local_10:IRoomObjectController;
            var _local_9:RoomObjectUpdateMessage;
            var _local_4:IVector3d;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            if (_roomEngine == null)
            {
                return;
            };
            if (roomEngine.isDecorateMode)
            {
                return;
            };
            if (_roomEngine.isGameMode)
            {
                _local_8 = _roomEngine.getTileCursor(_arg_3);
                if (((!(_local_8 == null)) && (!(_local_8.getEventHandler() == null))))
                {
                    _local_10 = (_roomEngine.getRoomObject(_arg_3, _arg_1, 100) as IRoomObjectController);
                    _local_9 = null;
                    if (_local_10 != null)
                    {
                        _local_4 = _local_10.getLocation();
                        _local_5 = _local_4.x;
                        _local_6 = _local_4.y;
                        _local_7 = _local_4.z;
                        _local_9 = new RoomObjectUpdateMessage(new Vector3d(_local_5, _local_6, _local_7), null);
                        _local_8.getEventHandler().processUpdateMessage(_local_9);
                    };
                };
                _roomEngine.gameEngine.handleMouseOverOnHuman(_arg_1, _arg_2.altKey, _arg_2.shiftKey);
            };
        }


    }
}