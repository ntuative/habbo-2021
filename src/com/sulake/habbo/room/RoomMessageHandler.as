package com.sulake.habbo.room
{
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.room.object.RoomPlaneParser;
    import com.sulake.habbo.communication.messages.parser.room.layout.RoomEntryTileMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomReadyMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomPropertyMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.FloorHeightMapMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.HeightMapMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.HeightMapUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomVisualizationSettingsEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.FurnitureAliasesMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectAddMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectDataUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectsDataUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectRemoveMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemAddMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemRemoveMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemDataUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UsersMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserUpdateMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserRemoveMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.action.ExpressionMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.action.DanceMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.action.AvatarEffectMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.action.SleepMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.action.CarryObjectMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.action.UseObjectMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.SlideObjectBundleMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.chat.ChatMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.chat.WhisperMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.chat.ShoutMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.chat.UserTypingMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.DiceValueMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.OneWayDoorStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetExperienceEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.YouArePlayingGameMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.GamePlayerValueMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetFigureUpdateEvent;
    import com.sulake.habbo.communication.messages.incoming.users.IgnoreResultMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionStartedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionEndedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.help.GuideSessionErrorMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.SpecialRoomEffectMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomReadyMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.GetFurnitureAliasesMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine._SafeStr_46;
    import com.sulake.habbo.communication.messages.parser.room.engine.FurnitureAliasesMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.HeightMapMessageParser;
    import com.sulake.habbo.room.utils.FurniStackingHeightMap;
    import com.sulake.habbo.communication.messages.parser.room.engine.HeightMapUpdateMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomVisualizationSettingsParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomPropertyMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.FloorHeightMapMessageParser;
    import com.sulake.habbo.room.utils.LegacyWallGeometry;
    import com.sulake.habbo.communication.messages.parser.room.layout.RoomEntryTileMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectMessageData;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectsMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectAddMessageParser;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectUpdateMessageParser;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectDataUpdateMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectData;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectsDataUpdateMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectRemoveMessageParser;
    import flash.utils.setTimeout;
    import com.sulake.habbo.communication.messages.incoming.room.engine.ItemMessageData;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemsMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemAddMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemRemoveMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemUpdateMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.ItemDataUpdateMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserMessageData;
    import com.sulake.habbo.communication.messages.parser.room.engine.UsersMessageParser;
    import com.sulake.habbo.room.object.RoomObjectUserTypes;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserUpdateMessageData;
    import com.sulake.habbo.communication.messages.parser.room.engine.UserUpdateMessageParser;
    import com.sulake.room.IRoomInstance;
    import com.sulake.habbo.communication.messages.incoming.room.engine.AvatarActionMessageData;
    import com.sulake.habbo.communication.messages.parser.room.engine.UserRemoveMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetFigureUpdateMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.action.ExpressionMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.action.DanceMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.action.AvatarEffectMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.action.SleepMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.action.CarryObjectMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.action.UseObjectMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.SlideObjectBundleMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.engine.SlideObjectMessageData;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.communication.messages.parser.room.chat.ChatMessageParser;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.communication.messages.parser.room.chat.UserTypingMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.pets.PetExperienceParser;
    import com.sulake.habbo.communication.messages.parser.room.furniture.DiceValueMessageParser;
    import com.sulake.habbo.room.object.data.LegacyStuffData;
    import com.sulake.habbo.communication.messages.parser.room.furniture.OneWayDoorStatusMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.session.YouArePlayingGameMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.session.GamePlayerValueMessageParser;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.communication.messages.parser.help.GuideSessionStartedMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.SpecialRoomEffectMessageParser;
    import com.sulake.room.utils.RoomRotatingEffect;
    import com.sulake.room.utils.RoomShakingEffect;
    import com.sulake.habbo.room.events.RoomEngineZoomEvent;
    import flash.utils.Timer;
    import flash.events.TimerEvent;

        public class RoomMessageHandler
    {

        public static const _SafeStr_3648:int = 0;
        public static const EFFECT_ROOM_SHAKE:int = 1;
        public static const _SafeStr_3649:int = 2;
        public static const EFFECT_ROOM_DISCO:int = 3;

        private var _connection:IConnection = null;
        private var _SafeStr_3650:IRoomCreator = null;
        private var _SafeStr_3207:RoomPlaneParser = null;
        private var _SafeStr_3651:RoomEntryTileMessageEvent = null;
        private var _SafeStr_2513:int = -1;
        private var _initialConnection:Boolean = true;
        private var _SafeStr_3652:int = -1000000000;
        private var _SafeStr_555:int = 0;
        private var _SafeStr_3653:Object = {};
        private var _SafeStr_3654:int = -1;
        private var _SafeStr_3655:int = -1;

        public function RoomMessageHandler(_arg_1:IRoomCreator)
        {
            _SafeStr_3650 = _arg_1;
            _SafeStr_3207 = new RoomPlaneParser();
            _initialConnection = true;
        }

        public function dispose():void
        {
            _connection = null;
            _SafeStr_3650 = null;
            if (_SafeStr_3207 != null)
            {
                _SafeStr_3207.dispose();
                _SafeStr_3207 = null;
            };
            _SafeStr_3651 = null;
        }

        public function setCurrentRoom(_arg_1:int):void
        {
            if (_SafeStr_555 != 0)
            {
                if (_SafeStr_3650 != null)
                {
                    _SafeStr_3650.disposeRoom(_SafeStr_555);
                };
            };
            _SafeStr_555 = _arg_1;
            _SafeStr_3651 = null;
        }

        public function resetCurrentRoom():void
        {
            _SafeStr_555 = 0;
            _SafeStr_3651 = null;
        }

        private function getRoomId(_arg_1:int):int
        {
            return (_SafeStr_555);
        }

        public function set connection(_arg_1:IConnection):void
        {
            if (_connection != null)
            {
                return;
            };
            if (_arg_1 != null)
            {
                _connection = _arg_1;
                _arg_1.addMessageEvent(new UserObjectEvent(onOwnUserEvent));
                _arg_1.addMessageEvent(new RoomReadyMessageEvent(onRoomReady));
                _arg_1.addMessageEvent(new RoomPropertyMessageEvent(onRoomProperty));
                _arg_1.addMessageEvent(new RoomEntryTileMessageEvent(onEntryTileData));
                _arg_1.addMessageEvent(new FloorHeightMapMessageEvent(onFloorHeightMap));
                _arg_1.addMessageEvent(new HeightMapMessageEvent(onHeightMap));
                _arg_1.addMessageEvent(new HeightMapUpdateMessageEvent(onHeightMapUpdate));
                _arg_1.addMessageEvent(new RoomVisualizationSettingsEvent(onRoomVisualizationSettings));
                _arg_1.addMessageEvent(new FurnitureAliasesMessageEvent(onFurnitureAliases));
                _arg_1.addMessageEvent(new ObjectsMessageEvent(onObjects));
                _arg_1.addMessageEvent(new ObjectAddMessageEvent(onObjectAdd));
                _arg_1.addMessageEvent(new ObjectUpdateMessageEvent(onObjectUpdate));
                _arg_1.addMessageEvent(new ObjectDataUpdateMessageEvent(onObjectDataUpdate));
                _arg_1.addMessageEvent(new ObjectsDataUpdateMessageEvent(onObjectsDataUpdate));
                _arg_1.addMessageEvent(new ObjectRemoveMessageEvent(onObjectRemove));
                _arg_1.addMessageEvent(new ItemsMessageEvent(onItems));
                _arg_1.addMessageEvent(new ItemAddMessageEvent(onItemAdd));
                _arg_1.addMessageEvent(new ItemRemoveMessageEvent(onItemRemove));
                _arg_1.addMessageEvent(new ItemUpdateMessageEvent(onItemUpdate));
                _arg_1.addMessageEvent(new ItemDataUpdateMessageEvent(onItemDataUpdate));
                _arg_1.addMessageEvent(new UsersMessageEvent(onUsers));
                _arg_1.addMessageEvent(new UserUpdateMessageEvent(onUserUpdate));
                _arg_1.addMessageEvent(new UserRemoveMessageEvent(onUserRemove));
                _arg_1.addMessageEvent(new UserChangeMessageEvent(onUserChange));
                _arg_1.addMessageEvent(new ExpressionMessageEvent(onExpression));
                _arg_1.addMessageEvent(new DanceMessageEvent(onDance));
                _arg_1.addMessageEvent(new AvatarEffectMessageEvent(onAvatarEffect));
                _arg_1.addMessageEvent(new SleepMessageEvent(onAvatarSleep));
                _arg_1.addMessageEvent(new CarryObjectMessageEvent(onCarryObject));
                _arg_1.addMessageEvent(new UseObjectMessageEvent(onUseObject));
                _arg_1.addMessageEvent(new SlideObjectBundleMessageEvent(onSlideUpdate));
                _arg_1.addMessageEvent(new ChatMessageEvent(onChat));
                _arg_1.addMessageEvent(new WhisperMessageEvent(onChat));
                _arg_1.addMessageEvent(new ShoutMessageEvent(onChat));
                _arg_1.addMessageEvent(new UserTypingMessageEvent(onTypingStatus));
                _arg_1.addMessageEvent(new DiceValueMessageEvent(onDiceValue));
                _arg_1.addMessageEvent(new OneWayDoorStatusMessageEvent(onOneWayDoorStatus));
                _arg_1.addMessageEvent(new PetExperienceEvent(onPetExperience));
                _arg_1.addMessageEvent(new YouArePlayingGameMessageEvent(onPlayingGame));
                _arg_1.addMessageEvent(new GamePlayerValueMessageEvent(onGamePlayerNumberValue));
                _arg_1.addMessageEvent(new PetFigureUpdateEvent(onPetFigureUpdate));
                _arg_1.addMessageEvent(new IgnoreResultMessageEvent(onIgnoreResult));
                _arg_1.addMessageEvent(new GuideSessionStartedMessageEvent(onGuideSessionStarted));
                _arg_1.addMessageEvent(new GuideSessionEndedMessageEvent(onGuideSessionEnded));
                _arg_1.addMessageEvent(new GuideSessionErrorMessageEvent(onGuideSessionError));
                _arg_1.addMessageEvent(new SpecialRoomEffectMessageEvent(onSpecialRoomEvent));
            };
        }

        private function onOwnUserEvent(_arg_1:IMessageEvent):void
        {
            var _local_2:UserObjectEvent = (_arg_1 as UserObjectEvent);
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:UserObjectMessageParser = _local_2.getParser();
            if (_local_3 != null)
            {
                _SafeStr_2513 = _local_3.id;
            };
        }

        private function onRoomReady(_arg_1:IMessageEvent):void
        {
            var _local_4:RoomReadyMessageEvent = (_arg_1 as RoomReadyMessageEvent);
            if ((((_local_4 == null) || (_local_4.getParser() == null)) || (_arg_1.connection == null)))
            {
                return;
            };
            var _local_2:RoomReadyMessageParser = _local_4.getParser();
            if (_SafeStr_555 != _local_2.roomId)
            {
                setCurrentRoom(_local_2.roomId);
            };
            var _local_3:String = _local_2.roomType;
            if (_SafeStr_3650 != null)
            {
                _SafeStr_3650.setWorldType(_local_2.roomId, _local_3);
            };
            if (_initialConnection)
            {
                _arg_1.connection.send(new GetFurnitureAliasesMessageComposer());
                _initialConnection = false;
            }
            else
            {
                _arg_1.connection.send(new _SafeStr_46());
            };
        }

        private function onFurnitureAliases(_arg_1:IMessageEvent):void
        {
            var _local_5:FurnitureAliasesMessageEvent;
            var _local_2:FurnitureAliasesMessageParser;
            var _local_3:int;
            var _local_6:int;
            var _local_4:String;
            var _local_7:String;
            if (_SafeStr_3650 != null)
            {
                _local_5 = (_arg_1 as FurnitureAliasesMessageEvent);
                if (((_local_5 == null) || (_local_5.getParser() == null)))
                {
                    return;
                };
                _local_2 = _local_5.getParser();
                if (_local_2 != null)
                {
                    _local_3 = _local_2.aliasCount;
                    _local_6 = 0;
                    while (_local_6 < _local_3)
                    {
                        _local_4 = _local_2.getName(_local_6);
                        _local_7 = _local_2.getAlias(_local_6);
                        _SafeStr_3650.setRoomObjectAlias(_local_4, _local_7);
                        _local_6++;
                    };
                };
            };
            _arg_1.connection.send(new _SafeStr_46());
        }

        private function onHeightMap(_arg_1:IMessageEvent):void
        {
            var _local_8:int;
            var _local_7:int;
            var _local_11:Number;
            var _local_4:Boolean;
            var _local_2:Boolean;
            var _local_6:HeightMapMessageEvent = (_arg_1 as HeightMapMessageEvent);
            if (((_local_6 == null) || (_local_6.getParser() == null)))
            {
                return;
            };
            if (_SafeStr_3650 == null)
            {
                return;
            };
            var _local_3:HeightMapMessageParser = _local_6.getParser();
            var _local_10:int = _local_3.width;
            var _local_9:int = _local_3.height;
            var _local_5:FurniStackingHeightMap = new FurniStackingHeightMap(_local_10, _local_9);
            _local_8 = 0;
            while (_local_8 < _local_9)
            {
                _local_7 = 0;
                while (_local_7 < _local_10)
                {
                    _local_11 = _local_3.getTileHeight(_local_7, _local_8);
                    _local_4 = _local_3.getStackingBlocked(_local_7, _local_8);
                    _local_2 = _local_3.isRoomTile(_local_7, _local_8);
                    _local_5.setTileHeight(_local_7, _local_8, _local_11);
                    _local_5.setStackingBlocked(_local_7, _local_8, _local_4);
                    _local_5.setIsRoomTile(_local_7, _local_8, _local_2);
                    _local_7++;
                };
                _local_8++;
            };
            _SafeStr_3650.setFurniStackingHeightMap(_SafeStr_555, _local_5);
        }

        private function onHeightMapUpdate(_arg_1:IMessageEvent):void
        {
            var _local_5:int;
            var _local_6:int;
            var _local_4:HeightMapUpdateMessageEvent = (_arg_1 as HeightMapUpdateMessageEvent);
            if (((_local_4 == null) || (_local_4.getParser() == null)))
            {
                return;
            };
            if (_SafeStr_3650 == null)
            {
                return;
            };
            var _local_2:HeightMapUpdateMessageParser = _local_4.getParser();
            var _local_3:FurniStackingHeightMap = _SafeStr_3650.getFurniStackingHeightMap(_SafeStr_555);
            if (_local_3 == null)
            {
                return;
            };
            while (_local_2.next())
            {
                _local_5 = _local_2.x;
                _local_6 = _local_2.y;
                _local_3.setTileHeight(_local_5, _local_6, _local_2.tileHeight);
                _local_3.setStackingBlocked(_local_5, _local_6, _local_2.isStackingBlocked);
                _local_3.setIsRoomTile(_local_5, _local_6, _local_2.isRoomTile);
            };
            _SafeStr_3650.refreshTileObjectMap(_SafeStr_555, "RoomMessageHandler.onHeightMapUpdate()");
        }

        private function onRoomVisualizationSettings(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomVisualizationSettingsEvent = (_arg_1 as RoomVisualizationSettingsEvent);
            if (((_local_2 == null) || (_local_2.getParser() == null)))
            {
                return;
            };
            var _local_3:RoomVisualizationSettingsParser = _local_2.getParser();
            var _local_7:Boolean = (!(_local_3.wallsHidden));
            var _local_5:Boolean = true;
            var _local_4:Number = _local_3.wallThicknessMultiplier;
            var _local_6:Number = _local_3.floorThicknessMultiplier;
            if (_SafeStr_3650 != null)
            {
                _SafeStr_3650.updateObjectRoomVisibilities(_SafeStr_555, _local_7, _local_5);
                _SafeStr_3650.updateObjectRoomPlaneThicknesses(_SafeStr_555, _local_4, _local_6);
            };
        }

        private function onRoomProperty(_arg_1:IMessageEvent):void
        {
            var _local_6:RoomPropertyMessageEvent = (_arg_1 as RoomPropertyMessageEvent);
            if (((_local_6 == null) || (_local_6.getParser() == null)))
            {
                return;
            };
            var _local_2:RoomPropertyMessageParser = _local_6.getParser();
            var _local_4:String = _local_2.floorType;
            var _local_5:String = _local_2.wallType;
            var _local_3:String = _local_2.landscapeType;
            if (_SafeStr_3650 != null)
            {
                _SafeStr_3650.updateObjectRoom(_SafeStr_555, _local_4, _local_5, _local_3);
            };
        }

        private function onEntryTileData(_arg_1:RoomEntryTileMessageEvent):void
        {
            _SafeStr_3651 = _arg_1;
        }

        private function onFloorHeightMap(_arg_1:IMessageEvent):void
        {
            var _local_16:int;
            var _local_15:int;
            var _local_19:int;
            var _local_9:int;
            var _local_8:int;
            var _local_13:FloorHeightMapMessageEvent = (_arg_1 as FloorHeightMapMessageEvent);
            if (((_local_13 == null) || (_local_13.getParser() == null)))
            {
                return;
            };
            var _local_11:FloorHeightMapMessageParser = _local_13.getParser();
            if (_SafeStr_3650 == null)
            {
                return;
            };
            var _local_17:LegacyWallGeometry = _SafeStr_3650.getLegacyGeometry(_SafeStr_555);
            if (_local_17 == null)
            {
                return;
            };
            _SafeStr_3207.reset();
            var _local_14:int = _local_11.width;
            var _local_18:int = _local_11.height;
            _SafeStr_3207.initializeTileMap(_local_14, _local_18);
            var _local_5:Number = -1;
            var _local_6:int = -1;
            var _local_2:int = 0;
            var _local_10:int = 0;
            var _local_3:RoomEntryTileMessageParser;
            if (_SafeStr_3651 != null)
            {
                _local_3 = _SafeStr_3651.getParser();
            };
            var _local_12:FurniStackingHeightMap = _SafeStr_3650.getFurniStackingHeightMap(_SafeStr_555);
            if (_local_12 == null)
            {
                return;
            };
            _local_16 = 0;
            while (_local_16 < _local_18)
            {
                _local_15 = 0;
                while (_local_15 < _local_14)
                {
                    _local_19 = _local_11.getTileHeight(_local_15, _local_16);
                    if ((((((_local_16 > 0) && (_local_16 < (_local_18 - 1))) || ((_local_15 > 0) && (_local_15 < (_local_14 - 1)))) && (!(_local_19 == -110))) && ((_local_3 == null) || ((_local_15 == _local_3.x) && (_local_16 == _local_3.y)))))
                    {
                        if ((((_local_11.getTileHeight(_local_15, (_local_16 - 1)) == -110) && (_local_11.getTileHeight((_local_15 - 1), _local_16) == -110)) && (_local_11.getTileHeight(_local_15, (_local_16 + 1)) == -110)))
                        {
                            _local_5 = (_local_15 + 0.5);
                            _local_6 = _local_16;
                            _local_2 = _local_19;
                            _local_10 = 90;
                        };
                        if ((((_local_11.getTileHeight(_local_15, (_local_16 - 1)) == -110) && (_local_11.getTileHeight((_local_15 - 1), _local_16) == -110)) && (_local_11.getTileHeight((_local_15 + 1), _local_16) == -110)))
                        {
                            _local_5 = _local_15;
                            _local_6 = (_local_16 + 0.5);
                            _local_2 = _local_19;
                            _local_10 = 180;
                        };
                    };
                    _SafeStr_3207.setTileHeight(_local_15, _local_16, _local_19);
                    _local_15++;
                };
                _local_16++;
            };
            _SafeStr_3207.setTileHeight(Math.floor(_local_5), Math.floor(_local_6), _local_2);
            _SafeStr_3207.initializeFromTileData(_local_13.getParser().fixedWallsHeight);
            _SafeStr_3207.setTileHeight(Math.floor(_local_5), Math.floor(_local_6), (_local_2 + _SafeStr_3207.wallHeight));
            _local_17.scale = _local_11.scale;
            _local_17.initialize(_local_14, _local_18, _SafeStr_3207.floorHeight);
            _local_9 = (_local_11.height - 1);
            while (_local_9 >= 0)
            {
                _local_8 = (_local_11.width - 1);
                while (_local_8 >= 0)
                {
                    _local_17.setTileHeight(_local_8, _local_9, _SafeStr_3207.getTileHeight(_local_8, _local_9));
                    _local_8--;
                };
                _local_9--;
            };
            var _local_7:XML = _SafeStr_3207.getXML();
            var _local_4:XML = new XML((((((((("<doors><door x=" + (('"' + _local_5) + '"')) + " y=") + (('"' + _local_6) + '"')) + " z=") + (('"' + _local_2) + '"')) + " dir=") + (('"' + _local_10) + '"')) + "/></doors>"));
            _local_7.appendChild(_local_4);
            _SafeStr_3650.initializeRoom(_SafeStr_555, _local_7);
            if (_SafeStr_3653.objectData)
            {
                addActiveObject(_SafeStr_555, _SafeStr_3653.objectData);
                _SafeStr_3653.objectData = null;
            }
            else
            {
                _SafeStr_3653.floorReady = true;
            };
        }

        private function onObjects(_arg_1:IMessageEvent):void
        {
            var _local_6:int;
            var _local_4:ObjectMessageData;
            var _local_3:ObjectsMessageEvent = (_arg_1 as ObjectsMessageEvent);
            if (((_local_3 == null) || (_local_3.getParser() == null)))
            {
                return;
            };
            var _local_2:ObjectsMessageParser = _local_3.getParser();
            var _local_5:int = _local_2.getObjectCount();
            _local_6 = 0;
            while (_local_6 < _local_5)
            {
                _local_4 = _local_2.getObject(_local_6);
                addActiveObject(_SafeStr_555, _local_4);
                _local_6++;
            };
        }

        private function onObjectAdd(_arg_1:IMessageEvent):void
        {
            var _local_2:ObjectAddMessageEvent = (_arg_1 as ObjectAddMessageEvent);
            if (((_local_2 == null) || (_local_2.getParser() == null)))
            {
                return;
            };
            var _local_3:ObjectAddMessageParser = _local_2.getParser();
            var _local_4:ObjectMessageData = _local_3.data;
            addActiveObject(_SafeStr_555, _local_4);
        }

        private function onObjectUpdate(_arg_1:IMessageEvent):void
        {
            var _local_2:IVector3d;
            var _local_6:IVector3d;
            var _local_3:ObjectUpdateMessageEvent = (_arg_1 as ObjectUpdateMessageEvent);
            if (((_local_3 == null) || (_local_3.getParser() == null)))
            {
                return;
            };
            if (_SafeStr_3650 == null)
            {
                return;
            };
            var _local_4:ObjectUpdateMessageParser = _local_3.getParser();
            var _local_5:ObjectMessageData = _local_4.data;
            if (_local_5 != null)
            {
                _local_2 = new Vector3d(_local_5.x, _local_5.y, _local_5.z);
                _local_6 = new Vector3d(_local_5.dir);
                _SafeStr_3650.updateObjectFurniture(_SafeStr_555, _local_5.id, _local_2, _local_6, _local_5.state, _local_5.data, _local_5.extra);
                _SafeStr_3650.updateObjectFurnitureHeight(_SafeStr_555, _local_5.id, _local_5.sizeZ);
                _SafeStr_3650.updateObjectFurnitureExpiryTime(_SafeStr_555, _local_5.id, _local_5.expiryTime);
            };
        }

        private function onObjectDataUpdate(_arg_1:IMessageEvent):void
        {
            var _local_4:ObjectDataUpdateMessageEvent = (_arg_1 as ObjectDataUpdateMessageEvent);
            if (((_local_4 == null) || (_local_4.getParser() == null)))
            {
                return;
            };
            if (_SafeStr_3650 == null)
            {
                return;
            };
            var _local_2:ObjectDataUpdateMessageParser = _local_4.getParser();
            var _local_5:int = _local_2.id;
            var _local_6:int = _local_2.state;
            var _local_3:IStuffData = _local_2.data;
            _SafeStr_3650.updateObjectFurniture(_SafeStr_555, _local_5, null, null, _local_6, _local_3);
        }

        private function onObjectsDataUpdate(_arg_1:IMessageEvent):void
        {
            var _local_6:int;
            var _local_5:ObjectData;
            var _local_7:int;
            var _local_8:int;
            var _local_3:IStuffData;
            var _local_4:ObjectsDataUpdateMessageEvent = (_arg_1 as ObjectsDataUpdateMessageEvent);
            if (((_local_4 == null) || (_local_4.getParser() == null)))
            {
                return;
            };
            if (_SafeStr_3650 == null)
            {
                return;
            };
            var _local_2:ObjectsDataUpdateMessageParser = _local_4.getParser();
            _local_6 = 0;
            while (_local_6 < _local_2.objectCount)
            {
                _local_5 = _local_2.getObjectData(_local_6);
                if (_local_5 != null)
                {
                    _local_7 = _local_5.id;
                    _local_8 = _local_5.state;
                    _local_3 = _local_5.data;
                    _SafeStr_3650.updateObjectFurniture(_SafeStr_555, _local_7, null, null, _local_8, _local_3);
                };
                _local_6++;
            };
        }

        private function onObjectRemove(_arg_1:IMessageEvent):void
        {
            var event:IMessageEvent = _arg_1;
            var objectRemoveEvent:ObjectRemoveMessageEvent = (event as ObjectRemoveMessageEvent);
            if (((objectRemoveEvent == null) || (objectRemoveEvent.getParser() == null)))
            {
                return;
            };
            if (_SafeStr_3650 == null)
            {
                return;
            };
            var parser:ObjectRemoveMessageParser = objectRemoveEvent.getParser();
            var id:int = parser.id;
            var delay:int = parser.delay;
            if (delay > 0)
            {
                (setTimeout(function ():void
                {
                    _SafeStr_3650.disposeObjectFurniture(_SafeStr_555, id, ((parser.isExpired) ? -1 : parser.pickerId), true);
                }, delay));
            }
            else
            {
                _SafeStr_3650.disposeObjectFurniture(_SafeStr_555, id, ((parser.isExpired) ? -1 : parser.pickerId), true);
            };
        }

        private function addActiveObject(_arg_1:int, _arg_2:ObjectMessageData):void
        {
            if (((_arg_2 == null) || (_SafeStr_3650 == null)))
            {
                return;
            };
            var _local_3:IVector3d = new Vector3d(_arg_2.x, _arg_2.y, _arg_2.z);
            var _local_4:IVector3d = new Vector3d(_arg_2.dir);
            if (_arg_2.staticClass != null)
            {
                Logger.log("Add Object FUrniture by Name");
                _SafeStr_3650.addObjectFurnitureByName(_arg_1, _arg_2.id, _arg_2.staticClass, _local_3, _local_4, _arg_2.state, _arg_2.data, _arg_2.extra);
            }
            else
            {
                Logger.log("Add Object FUrniture");
                _SafeStr_3650.addObjectFurniture(_arg_1, _arg_2.id, _arg_2.type, _local_3, _local_4, _arg_2.state, _arg_2.data, _arg_2.extra, _arg_2.expiryTime, _arg_2.usagePolicy, _arg_2.ownerId, _arg_2.ownerName, true, true, _arg_2.sizeZ);
            };
        }

        private function onItems(_arg_1:IMessageEvent):void
        {
            var _local_5:int;
            var _local_3:ItemMessageData;
            var _local_6:ItemsMessageEvent = (_arg_1 as ItemsMessageEvent);
            if (((_local_6 == null) || (_local_6.getParser() == null)))
            {
                return;
            };
            var _local_2:ItemsMessageParser = _local_6.getParser();
            var _local_4:int = _local_2.getItemCount();
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_3 = _local_2.getItem(_local_5);
                addWallItem(_SafeStr_555, _local_3);
                _local_5++;
            };
        }

        private function onItemAdd(_arg_1:IMessageEvent):void
        {
            var _local_2:ItemAddMessageEvent = (_arg_1 as ItemAddMessageEvent);
            if (((_local_2 == null) || (_local_2.getParser() == null)))
            {
                return;
            };
            var _local_3:ItemAddMessageParser = _local_2.getParser();
            var _local_4:ItemMessageData = _local_3.data;
            if (_local_4 != null)
            {
                addWallItem(_SafeStr_555, _local_4);
            };
        }

        private function onItemRemove(_arg_1:IMessageEvent):void
        {
            var _local_3:ItemRemoveMessageEvent = (_arg_1 as ItemRemoveMessageEvent);
            if (((_local_3 == null) || (_local_3.getParser() == null)))
            {
                return;
            };
            if (_SafeStr_3650 == null)
            {
                return;
            };
            var _local_2:ItemRemoveMessageParser = _local_3.getParser();
            _SafeStr_3650.disposeObjectWallItem(_SafeStr_555, _local_2.itemId, _local_2.pickerId);
        }

        private function onItemUpdate(_arg_1:IMessageEvent):void
        {
            var _local_2:IVector3d;
            var _local_5:IVector3d;
            var _local_6:ItemUpdateMessageEvent = (_arg_1 as ItemUpdateMessageEvent);
            if (((_local_6 == null) || (_local_6.getParser() == null)))
            {
                return;
            };
            var _local_3:ItemUpdateMessageParser = _local_6.getParser();
            var _local_7:LegacyWallGeometry = _SafeStr_3650.getLegacyGeometry(_SafeStr_555);
            if (((_SafeStr_3650 == null) || (_local_7 == null)))
            {
                return;
            };
            var _local_4:ItemMessageData = _local_3.data;
            if (_local_4 != null)
            {
                _local_2 = _local_7.getLocation(_local_4.wallX, _local_4.wallY, _local_4.localX, _local_4.localY, _local_4.dir);
                _local_5 = new Vector3d(_local_7.getDirection(_local_4.dir));
                _SafeStr_3650.updateObjectWallItem(_SafeStr_555, _local_4.id, _local_2, _local_5, _local_4.state, _local_4.data);
                _SafeStr_3650.updateObjectWallItemExpiryTime(_SafeStr_555, _local_4.id, _local_4.secondsToExpiration);
            };
        }

        private function onItemDataUpdate(_arg_1:IMessageEvent):void
        {
            var _local_3:ItemDataUpdateMessageEvent = (_arg_1 as ItemDataUpdateMessageEvent);
            if (((_local_3 == null) || (_local_3.getParser() == null)))
            {
                return;
            };
            var _local_2:ItemDataUpdateMessageParser = _local_3.getParser();
            _SafeStr_3650.updateObjectWallItemData(_SafeStr_555, _local_2.id, _local_2.itemData);
        }

        private function addWallItem(_arg_1:int, _arg_2:ItemMessageData):void
        {
            if (((_arg_2 == null) || (_SafeStr_3650 == null)))
            {
                return;
            };
            var _local_5:LegacyWallGeometry = _SafeStr_3650.getLegacyGeometry(_arg_1);
            if (_local_5 == null)
            {
                return;
            };
            var _local_3:IVector3d;
            if (!_arg_2.isOldFormat)
            {
                _local_3 = _local_5.getLocation(_arg_2.wallX, _arg_2.wallY, _arg_2.localX, _arg_2.localY, _arg_2.dir);
            }
            else
            {
                _local_3 = _local_5.getLocationOldFormat(_arg_2.y, _arg_2.z, _arg_2.dir);
            };
            var _local_4:IVector3d = new Vector3d(_local_5.getDirection(_arg_2.dir));
            _SafeStr_3650.addObjectWallItem(_arg_1, _arg_2.id, _arg_2.type, _local_3, _local_4, _arg_2.state, _arg_2.data, _arg_2.usagePolicy, _arg_2.ownerId, _arg_2.ownerName, _arg_2.secondsToExpiration);
        }

        private function onUsers(_arg_1:IMessageEvent):void
        {
            var _local_4:int;
            var _local_7:UserMessageData;
            var _local_2:IVector3d;
            var _local_6:IVector3d;
            var _local_5:int;
            var _local_8:UsersMessageEvent = (_arg_1 as UsersMessageEvent);
            if (((_local_8 == null) || (_local_8.getParser() == null)))
            {
                return;
            };
            if (_SafeStr_3650 == null)
            {
                return;
            };
            var _local_3:UsersMessageParser = _local_8.getParser();
            _local_4 = 0;
            while (_local_4 < _local_3.getUserCount())
            {
                _local_7 = _local_3.getUser(_local_4);
                if (_local_7 != null)
                {
                    _local_2 = new Vector3d(_local_7.x, _local_7.y, _local_7.z);
                    _local_6 = new Vector3d(_local_7.dir);
                    _local_5 = _local_7.userType;
                    _SafeStr_3650.addObjectUser(_SafeStr_555, _local_7.roomIndex, _local_2, _local_6, _local_7.dir, _local_5, _local_7.figure);
                    if (_local_7.webID == _SafeStr_2513)
                    {
                        _SafeStr_3650.setOwnUserId(_SafeStr_555, _local_7.roomIndex);
                        _SafeStr_3650.updateObjectUserOwnUserAvatar(_SafeStr_555, _local_7.roomIndex);
                    };
                    _SafeStr_3650.updateObjectUserFigure(_SafeStr_555, _local_7.roomIndex, _local_7.figure, _local_7.sex, _local_7.subType, _local_7.isRiding);
                    if (RoomObjectUserTypes.getName(_local_5) == "pet")
                    {
                        if (_SafeStr_3650.getPetTypeId(_local_7.figure) == 16)
                        {
                            _SafeStr_3650.updateObjectUserPosture(_SafeStr_555, _local_7.roomIndex, _local_7.petPosture);
                        };
                    };
                    if (_SafeStr_3650.configuration.getBoolean("avatar.ignored.bubble.enabled"))
                    {
                        _SafeStr_3650.updateObjectUserAction(_SafeStr_555, _local_7.roomIndex, "figure_is_muted", int(_SafeStr_3650.sessionDataManager.isIgnored(_local_7.name)));
                    };
                };
                _local_4++;
            };
            updateGuideMarker();
        }

        private function onUserUpdate(_arg_1:IMessageEvent):void
        {
            var _local_10:int;
            var _local_6:UserUpdateMessageData;
            var _local_16:Number;
            var _local_3:IVector3d;
            var _local_11:IVector3d;
            var _local_13:IVector3d;
            var _local_18:Boolean;
            var _local_8:Boolean;
            var _local_9:String;
            var _local_7:String;
            var _local_5:Boolean;
            var _local_15:Boolean;
            var _local_2:uint;
            var _local_4:UserUpdateMessageEvent = (_arg_1 as UserUpdateMessageEvent);
            if (((_local_4 == null) || (_local_4.getParser() == null)))
            {
                return;
            };
            if (_SafeStr_3650 == null)
            {
                return;
            };
            var _local_14:UserUpdateMessageParser = _local_4.getParser();
            var _local_12:IRoomInstance = _SafeStr_3650.getRoom(_SafeStr_555);
            if (_local_12 == null)
            {
                return;
            };
            var _local_19:Number = _local_12.getNumber("room_z_scale");
            _local_10 = 0;
            while (_local_10 < _local_14.userUpdateCount)
            {
                _local_6 = _local_14.getUserUpdateData(_local_10);
                if (_local_6 != null)
                {
                    _local_16 = _local_6.localZ;
                    if (_local_19 != 0)
                    {
                        _local_16 = (_local_16 / _local_19);
                    };
                    _local_3 = new Vector3d(_local_6.x, _local_6.y, (_local_6.z + _local_16));
                    _local_11 = new Vector3d(_local_6.dir);
                    _local_13 = null;
                    if (_local_6.isMoving)
                    {
                        _local_13 = new Vector3d(_local_6.targetX, _local_6.targetY, _local_6.targetZ);
                    };
                    _SafeStr_3650.updateObjectUser(_SafeStr_555, _local_6.id, _local_3, _local_13, _local_6.canStandUp, _local_16, _local_11, _local_6.dirHead);
                    _local_18 = true;
                    _local_8 = false;
                    _local_9 = "std";
                    _local_7 = "";
                    _SafeStr_3650.updateObjectUserFlatControl(_SafeStr_555, _local_6.id, null);
                    _local_5 = false;
                    _local_15 = false;
                    _local_2 = _local_6.actions.length;
                    for each (var _local_17:AvatarActionMessageData in _local_6.actions)
                    {
                        switch (_local_17.actionType)
                        {
                            case "flatctrl":
                                _SafeStr_3650.updateObjectUserFlatControl(_SafeStr_555, _local_6.id, _local_17.actionParameter);
                                break;
                            case "sign":
                                if (_local_2 == 1)
                                {
                                    _local_18 = false;
                                };
                                _SafeStr_3650.updateObjectUserAction(_SafeStr_555, _local_6.id, "figure_sign", int(_local_17.actionParameter));
                                break;
                            case "gst":
                                if (_local_2 == 1)
                                {
                                    _local_18 = false;
                                };
                                _SafeStr_3650.updateObjectPetGesture(_SafeStr_555, _local_6.id, _local_17.actionParameter);
                                break;
                            case "wav":
                            case "mv":
                                _local_15 = true;
                                _local_8 = true;
                                _local_9 = _local_17.actionType;
                                _local_7 = _local_17.actionParameter;
                                break;
                            case "swim":
                                _local_5 = true;
                                _local_8 = true;
                                _local_9 = _local_17.actionType;
                                _local_7 = _local_17.actionParameter;
                                break;
                            case "trd":
                                break;
                            default:
                                _local_8 = true;
                                _local_9 = _local_17.actionType;
                                _local_7 = _local_17.actionParameter;
                        };
                    };
                    if (((!(_local_15)) && (_local_5)))
                    {
                        _local_8 = true;
                        _local_9 = "float";
                    };
                    if (_local_8)
                    {
                        _SafeStr_3650.updateObjectUserPosture(_SafeStr_555, _local_6.id, _local_9, _local_7);
                    }
                    else
                    {
                        if (_local_18)
                        {
                            _SafeStr_3650.updateObjectUserPosture(_SafeStr_555, _local_6.id, "std", "");
                        };
                    };
                };
                _local_10++;
            };
            updateGuideMarker();
        }

        private function onUserRemove(_arg_1:IMessageEvent):void
        {
            var _local_3:UserRemoveMessageEvent = (_arg_1 as UserRemoveMessageEvent);
            if (((_local_3 == null) || (_local_3.getParser() == null)))
            {
                return;
            };
            if (_SafeStr_3650 == null)
            {
                return;
            };
            var _local_2:UserRemoveMessageParser = _local_3.getParser();
            _SafeStr_3650.disposeObjectUser(_SafeStr_555, _local_2.id);
            updateGuideMarker();
        }

        private function onUserChange(_arg_1:IMessageEvent):void
        {
            var _local_2:UserChangeMessageEvent = (_arg_1 as UserChangeMessageEvent);
            if (_local_2 == null)
            {
                return;
            };
            _SafeStr_3650.updateObjectUserFigure(_SafeStr_555, _local_2.id, _local_2.figure, _local_2.sex);
        }

        private function onPetFigureUpdate(_arg_1:IMessageEvent):void
        {
            var _local_3:PetFigureUpdateEvent = (_arg_1 as PetFigureUpdateEvent);
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:PetFigureUpdateMessageParser = _local_3.getParser();
            _SafeStr_3650.updateObjectUserFigure(_SafeStr_555, _local_2.roomIndex, _local_2.figureData.figureString, "", "", _local_2.isRiding);
        }

        private function onExpression(_arg_1:IMessageEvent):void
        {
            var _local_2:ExpressionMessageEvent = (_arg_1 as ExpressionMessageEvent);
            if (_local_2 == null)
            {
                return;
            };
            if (_SafeStr_3650 == null)
            {
                return;
            };
            var _local_3:ExpressionMessageParser = _local_2.getParser();
            if (_local_3 == null)
            {
                return;
            };
            _SafeStr_3650.updateObjectUserAction(_SafeStr_555, _local_3.userId, "figure_expression", _local_3.expressionType);
        }

        private function onDance(_arg_1:IMessageEvent):void
        {
            var _local_2:DanceMessageEvent = (_arg_1 as DanceMessageEvent);
            if (((_local_2 == null) || (_local_2.getParser() == null)))
            {
                return;
            };
            if (_SafeStr_3650 == null)
            {
                return;
            };
            var _local_3:DanceMessageParser = _local_2.getParser();
            _SafeStr_3650.updateObjectUserAction(_SafeStr_555, _local_3.userId, "figure_dance", _local_3.danceStyle);
        }

        private function onAvatarEffect(_arg_1:IMessageEvent):void
        {
            var _local_3:AvatarEffectMessageEvent = (_arg_1 as AvatarEffectMessageEvent);
            if (((_local_3 == null) || (_local_3.getParser() == null)))
            {
                return;
            };
            if (_SafeStr_3650 == null)
            {
                return;
            };
            var _local_2:AvatarEffectMessageParser = _local_3.getParser();
            _SafeStr_3650.updateObjectUserEffect(_SafeStr_555, _local_2.userId, _local_2.effectId, _local_2.delayMilliSeconds);
        }

        private function onAvatarSleep(_arg_1:IMessageEvent):void
        {
            var _local_4:SleepMessageEvent = (_arg_1 as SleepMessageEvent);
            if (((_local_4 == null) || (_local_4.getParser() == null)))
            {
                return;
            };
            if (_SafeStr_3650 == null)
            {
                return;
            };
            var _local_3:SleepMessageParser = _local_4.getParser();
            var _local_2:int = 1;
            if (!_local_3.sleeping)
            {
                _local_2 = 0;
            };
            _SafeStr_3650.updateObjectUserAction(_SafeStr_555, _local_3.userId, "figure_sleep", _local_2);
        }

        private function onCarryObject(_arg_1:IMessageEvent):void
        {
            var _local_2:CarryObjectMessageParser;
            if (_SafeStr_3650 == null)
            {
                return;
            };
            if ((_arg_1 is CarryObjectMessageEvent))
            {
                _local_2 = (_arg_1 as CarryObjectMessageEvent).getParser();
                _SafeStr_3650.updateObjectUserAction(_SafeStr_555, _local_2.userId, "figure_carry_object", _local_2.itemType);
            };
        }

        private function onUseObject(_arg_1:IMessageEvent):void
        {
            var _local_2:UseObjectMessageParser;
            if (_SafeStr_3650 == null)
            {
                return;
            };
            if ((_arg_1 is UseObjectMessageEvent))
            {
                _local_2 = (_arg_1 as UseObjectMessageEvent).getParser();
                _SafeStr_3650.updateObjectUserAction(_SafeStr_555, _local_2.userId, "figure_use_object", _local_2.itemType);
            };
        }

        private function onSlideUpdate(_arg_1:IMessageEvent):void
        {
            var _local_4:SlideObjectBundleMessageParser;
            var _local_9:Array;
            var _local_7:int;
            var _local_3:SlideObjectMessageData;
            var _local_8:SlideObjectMessageData;
            var _local_5:IRoomObject;
            var _local_2:IRoomInstance;
            var _local_6:String;
            if (_SafeStr_3650 == null)
            {
                return;
            };
            if ((_arg_1 is SlideObjectBundleMessageEvent))
            {
                _local_4 = (_arg_1 as SlideObjectBundleMessageEvent).getParser();
                _SafeStr_3650.updateObjectFurniture(_SafeStr_555, _local_4.id, null, null, 1, null);
                _SafeStr_3650.updateObjectFurniture(_SafeStr_555, _local_4.id, null, null, 2, null);
                _local_9 = _local_4.objectList;
                _local_7 = 0;
                while (_local_7 < _local_9.length)
                {
                    _local_3 = _local_9[_local_7];
                    if (_local_3 != null)
                    {
                        _SafeStr_3650.updateObjectFurnitureLocation(_SafeStr_555, _local_3.id, _local_3.loc, _local_3.target);
                    };
                    _local_7++;
                };
                if (_local_4.avatar != null)
                {
                    _local_8 = _local_4.avatar;
                    _SafeStr_3650.updateObjectUser(_SafeStr_555, _local_8.id, _local_8.loc, _local_8.target);
                    if (_SafeStr_3650)
                    {
                        _local_2 = _SafeStr_3650.getRoom(_SafeStr_555);
                        if (_local_2)
                        {
                            _local_5 = _local_2.getObject(_local_8.id, 100);
                        };
                    };
                    if (((!(_local_5 == null)) && (!(_local_5.getType() == "monsterplant"))))
                    {
                        switch (_local_8.moveType)
                        {
                            case "mv":
                                _local_6 = "mv";
                                break;
                            case "sld":
                                _local_6 = "std";
                        };
                        _SafeStr_3650.updateObjectUserPosture(_SafeStr_555, _local_8.id, _local_6);
                    };
                };
            };
        }

        private function onChat(_arg_1:IMessageEvent):void
        {
            var _local_2:ChatMessageParser;
            if (_SafeStr_3650 == null)
            {
                return;
            };
            var _local_3:IRoomSession = _SafeStr_3650.roomSessionManager.getSession(_SafeStr_555);
            if ((_arg_1 is ChatMessageEvent))
            {
                _local_2 = (_arg_1 as ChatMessageEvent).getParser();
            }
            else
            {
                if ((_arg_1 is WhisperMessageEvent))
                {
                    _local_2 = (_arg_1 as WhisperMessageEvent).getParser();
                    if ((((_local_2) && (_local_3)) && (_local_2.userId == _local_3.ownUserRoomId)))
                    {
                        return;
                    };
                }
                else
                {
                    if ((_arg_1 is ShoutMessageEvent))
                    {
                        _local_2 = (_arg_1 as ShoutMessageEvent).getParser();
                    };
                };
            };
            if (_local_2 == null)
            {
                return;
            };
            _SafeStr_3650.updateObjectUserGesture(_SafeStr_555, _local_2.userId, _local_2.gesture);
            _SafeStr_3650.updateObjectUserAction(_SafeStr_555, _local_2.userId, "figure_talk", Math.ceil((_local_2.text.length / 10)));
        }

        private function onTypingStatus(_arg_1:IMessageEvent):void
        {
            var _local_2:UserTypingMessageEvent = (_arg_1 as UserTypingMessageEvent);
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:UserTypingMessageParser = _local_2.getParser();
            var _local_4:int = 1;
            if (!_local_3.isTyping)
            {
                _local_4 = 0;
            };
            _SafeStr_3650.updateObjectUserAction(_SafeStr_555, _local_3.userId, "figure_is_typing", _local_4);
        }

        private function onPetExperience(_arg_1:PetExperienceEvent):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            var _local_2:PetExperienceParser = _arg_1.getParser();
            _SafeStr_3650.updateObjectUserAction(_SafeStr_555, _local_2.petRoomIndex, "figure_gained_experience", _local_2.gainedExperience);
        }

        private function onDiceValue(_arg_1:IMessageEvent):void
        {
            var _local_5:DiceValueMessageEvent = (_arg_1 as DiceValueMessageEvent);
            if (((_local_5 == null) || (_local_5.getParser() == null)))
            {
                return;
            };
            if (_SafeStr_3650 == null)
            {
                return;
            };
            var _local_2:DiceValueMessageParser = _local_5.getParser();
            var _local_4:int = _local_2.id;
            var _local_6:int = _local_2.value;
            var _local_3:IStuffData = new LegacyStuffData();
            _SafeStr_3650.updateObjectFurniture(_SafeStr_555, _local_4, null, null, _local_6, _local_3);
        }

        private function onOneWayDoorStatus(_arg_1:IMessageEvent):void
        {
            var _local_2:OneWayDoorStatusMessageEvent = (_arg_1 as OneWayDoorStatusMessageEvent);
            if (((_local_2 == null) || (_local_2.getParser() == null)))
            {
                return;
            };
            if (_SafeStr_3650 == null)
            {
                return;
            };
            var _local_3:OneWayDoorStatusMessageParser = _local_2.getParser();
            var _local_5:int = _local_3.id;
            var _local_6:int = _local_3.status;
            var _local_4:IStuffData = new LegacyStuffData();
            _SafeStr_3650.updateObjectFurniture(_SafeStr_555, _local_5, null, null, _local_6, _local_4);
        }

        private function onPlayingGame(_arg_1:YouArePlayingGameMessageEvent):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            var _local_3:YouArePlayingGameMessageParser = _arg_1.getParser();
            var _local_2:Boolean = _local_3.isPlaying;
            _SafeStr_3650.setIsPlayingGame(_SafeStr_555, _local_2);
        }

        private function onGamePlayerNumberValue(_arg_1:IMessageEvent):void
        {
            var _local_2:GamePlayerValueMessageParser;
            var _local_3:int;
            if (_SafeStr_3650 == null)
            {
                return;
            };
            if ((_arg_1 is GamePlayerValueMessageEvent))
            {
                _local_2 = (_arg_1 as GamePlayerValueMessageEvent).getParser();
                _local_3 = getRoomId(0);
                _SafeStr_3650.updateObjectUserAction(_local_3, _local_2.userId, "figure_number_value", _local_2.value);
            };
        }

        private function onIgnoreResult(_arg_1:IMessageEvent):void
        {
            if (!_SafeStr_3650.configuration.getBoolean("avatar.ignored.bubble.enabled"))
            {
                return;
            };
            var _local_2:IgnoreResultMessageEvent = (_arg_1 as IgnoreResultMessageEvent);
            var _local_3:IUserData = _SafeStr_3650.roomSessionManager.getSession(_SafeStr_555).userDataManager.getUserDataByName(_local_2.name);
            if (_local_3 != null)
            {
                switch (_local_2.result)
                {
                    case 1:
                    case 2:
                        _SafeStr_3650.updateObjectUserAction(_SafeStr_555, _local_3.roomObjectId, "figure_is_muted", 1);
                        return;
                    case 3:
                        _SafeStr_3650.updateObjectUserAction(_SafeStr_555, _local_3.roomObjectId, "figure_is_muted", 0);
                    default:
                };
            };
        }

        private function onGuideSessionStarted(_arg_1:IMessageEvent):void
        {
            var _local_2:GuideSessionStartedMessageParser = (_arg_1.parser as GuideSessionStartedMessageParser);
            _SafeStr_3654 = _local_2.guideUserId;
            _SafeStr_3655 = _local_2.requesterUserId;
            updateGuideMarker();
        }

        private function onGuideSessionEnded(_arg_1:IMessageEvent):void
        {
            removeGuideMarker();
        }

        private function onGuideSessionError(_arg_1:IMessageEvent):void
        {
            removeGuideMarker();
        }

        public function onSpecialRoomEvent(_arg_1:IMessageEvent):void
        {
            var event:IMessageEvent = _arg_1;
            var eventParser:SpecialRoomEffectMessageParser = (event.parser as SpecialRoomEffectMessageParser);
            switch (eventParser.effectId)
            {
                case 0:
                    RoomRotatingEffect.init(250, 5000);
                    RoomRotatingEffect.turnVisualizationOn();
                    return;
                case 1:
                    RoomShakingEffect.init(250, 5000);
                    RoomShakingEffect.turnVisualizationOn();
                    return;
                case 2:
                    _SafeStr_3650.roomSessionManager.events.dispatchEvent(new RoomEngineZoomEvent(_SafeStr_555, -1, true));
                    return;
                case 3:
                    var arrayIndex:int = 0;
                    var discoColours:Array = [29371, 16731195, 16764980, 0x99FF00, 29371, 16731195, 16764980, 0x99FF00, 0];
                    var discoTimer:Timer = new Timer(1000, (discoColours.length + 1));
                    discoTimer.addEventListener("timer", function (_arg_1:TimerEvent):void
                    {
                        if (arrayIndex == discoColours.length)
                        {
                            _SafeStr_3650.updateObjectRoomColor(_SafeStr_555, discoColours[arrayIndex++], 176, true);
                        }
                        else
                        {
                            _SafeStr_3650.updateObjectRoomColor(_SafeStr_555, discoColours[arrayIndex++], 176, false);
                        };
                    });
                    discoTimer.start();
                default:
            };
        }

        private function updateGuideMarker():void
        {
            var _local_1:int = _SafeStr_3650.sessionDataManager.userId;
            setUserGuideStatus(_SafeStr_3654, ((_SafeStr_3655 == _local_1) ? 1 : 0));
            setUserGuideStatus(_SafeStr_3655, ((_SafeStr_3654 == _local_1) ? 2 : 0));
        }

        private function removeGuideMarker():void
        {
            setUserGuideStatus(_SafeStr_3654, 0);
            setUserGuideStatus(_SafeStr_3655, 0);
            _SafeStr_3654 = -1;
            _SafeStr_3655 = -1;
        }

        private function setUserGuideStatus(_arg_1:int, _arg_2:int):void
        {
            if (((!(_SafeStr_3650)) || (!(_SafeStr_3650.roomSessionManager))))
            {
                return;
            };
            var _local_4:IRoomSession = _SafeStr_3650.roomSessionManager.getSession(_SafeStr_555);
            if (_local_4 == null)
            {
                return;
            };
            var _local_3:IUserData = _local_4.userDataManager.getUserDataByType(_arg_1, 1);
            if (_local_3 != null)
            {
                _SafeStr_3650.updateObjectUserAction(_SafeStr_555, _local_3.roomObjectId, "figure_guide_status", _arg_2);
            };
        }


    }
}