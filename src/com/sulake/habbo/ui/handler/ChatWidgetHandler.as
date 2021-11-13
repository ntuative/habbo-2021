package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.connection.IConnection;
    import flash.geom.Point;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.ui.widget.roomchat.RoomChatWidget;
    import flash.display.BitmapData;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionChatEvent;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.session.IUserData;
    import flash.events.Event;
    import com.sulake.habbo.avatar.pets.PetFigureData;
    import com.sulake.habbo.ui.widget.events.RoomWidgetChatUpdateEvent;
    import com.sulake.habbo.game.events.GameChatEvent;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.structure.figure.IPartColor;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomViewUpdateEvent;
    import com.sulake.room.utils.RoomGeometry;
    import com.sulake.room.utils.PointMath;
    import com.sulake.habbo.room._SafeStr_147;

    public class ChatWidgetHandler implements IRoomWidgetHandler, IAvatarImageListener, IGetImageListener 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var _avatarImageCache:Map = null;
        private var _petImageCache:Map = null;
        private var _avatarColorCache:Map = null;
        private var _petImageIdToFigureString:Map = null;
        private var _SafeStr_2217:Array = [];
        private var _connection:IConnection = null;
        private var _SafeStr_3852:Number = 0;
        private var _SafeStr_3853:Point = null;
        private var _SafeStr_3854:Vector3d = new Vector3d();
        private var _SafeStr_1324:RoomChatWidget;

        public function ChatWidgetHandler()
        {
            _avatarImageCache = new Map();
            _petImageCache = new Map();
            _avatarColorCache = new Map();
            _petImageIdToFigureString = new Map();
        }

        public function set widget(_arg_1:RoomChatWidget):void
        {
            _SafeStr_1324 = _arg_1;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get type():String
        {
            return ("RWE_CHAT_WIDGET");
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            _container = _arg_1;
        }

        public function get container():IRoomWidgetHandlerContainer
        {
            return (_container);
        }

        public function set connection(_arg_1:IConnection):void
        {
            _connection = _arg_1;
        }

        public function dispose():void
        {
            var _local_3:int;
            var _local_1:BitmapData;
            _disposed = true;
            _container = null;
            _SafeStr_3853 = null;
            if (_avatarImageCache != null)
            {
                _local_3 = 0;
                while (_local_3 < _avatarImageCache.length)
                {
                    _local_1 = (_avatarImageCache.getWithIndex(_local_3) as BitmapData);
                    if (_local_1 != null)
                    {
                        _local_1.dispose();
                    };
                    _local_3++;
                };
                _avatarImageCache.dispose();
                _avatarImageCache = null;
            };
            if (_petImageCache != null)
            {
                _local_3 = 0;
                while (_local_3 < _petImageCache.length)
                {
                    _local_1 = (_petImageCache.getWithIndex(_local_3) as BitmapData);
                    if (_local_1 != null)
                    {
                        _local_1.dispose();
                    };
                    _local_3++;
                };
                _petImageCache.dispose();
                _petImageCache = null;
            };
            for each (var _local_2:BitmapData in _SafeStr_2217)
            {
                if (_local_2 != null)
                {
                    _local_2.dispose();
                };
            };
            _SafeStr_2217 = [];
            if (_avatarColorCache != null)
            {
                _avatarColorCache.dispose();
                _avatarColorCache = null;
            };
        }

        public function getWidgetMessages():Array
        {
            return (new Array(0));
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            _arg_1.type;
            return (null);
        }

        public function getProcessedEvents():Array
        {
            return (["RSCE_CHAT_EVENT", "gce_game_chat"]);
        }

        public function processEvent(_arg_1:Event):void
        {
            var _local_2:RoomSessionChatEvent;
            var _local_20:IRoomObject;
            var _local_34:IRoomGeometry;
            var _local_32:Number;
            var _local_33:Number;
            var _local_3:IVector3d;
            var _local_13:Point;
            var _local_6:Point;
            var _local_5:IUserData;
            var _local_26:String;
            var _local_29:uint;
            var _local_11:BitmapData;
            var _local_8:int;
            var _local_17:int;
            var _local_15:Boolean;
            var _local_21:String;
            var _local_18:int;
            var _local_16:int;
            var _local_36:int;
            var _local_23:int;
            var _local_25:String;
            var _local_12:IRoomObject;
            var _local_14:String;
            var _local_24:String;
            var _local_27:String;
            var _local_7:String;
            var _local_10:String;
            var _local_22:String;
            var _local_19:String;
            var _local_4:String;
            var _local_28:String;
            var _local_30:IRoomObject;
            var _local_31:IUserData;
            var _local_9:String;
            if (((_container.freeFlowChat) && (!(_container.freeFlowChat.isDisabledInPreferences))))
            {
                return;
            };
            var _local_35:Event;
            switch (_arg_1.type)
            {
                case "RSCE_CHAT_EVENT":
                    _local_2 = (_arg_1 as RoomSessionChatEvent);
                    if (_local_2 != null)
                    {
                        _local_20 = _container.roomEngine.getRoomObject(_local_2.session.roomId, _local_2.userId, 100);
                        if (_local_20 != null)
                        {
                            _local_34 = _container.roomEngine.getRoomCanvasGeometry(_local_2.session.roomId, _container.getFirstCanvasId());
                            if (_local_34 != null)
                            {
                                updateWidgetPosition();
                                _local_32 = 0;
                                _local_33 = 0;
                                _local_3 = _local_20.getLocation();
                                _local_13 = _local_34.getScreenPoint(_local_3);
                                if (_local_13 != null)
                                {
                                    _local_32 = _local_13.x;
                                    _local_33 = _local_13.y;
                                    _local_6 = _container.roomEngine.getRoomCanvasScreenOffset(_local_2.session.roomId, _container.getFirstCanvasId());
                                    if (_local_6 != null)
                                    {
                                        _local_32 = (_local_32 + _local_6.x);
                                        _local_33 = (_local_33 + _local_6.y);
                                    };
                                };
                                _local_5 = _container.roomSession.userDataManager.getUserDataByIndex(_local_2.userId);
                                _local_26 = "";
                                _local_29 = 0;
                                _local_11 = null;
                                _local_8 = 32;
                                _local_17 = 2;
                                _local_15 = true;
                                _local_21 = null;
                                _local_18 = _local_2.chatType;
                                _local_16 = _local_2.style;
                                _local_36 = 0;
                                _local_23 = -1;
                                if (_local_5 != null)
                                {
                                    _local_36 = _local_5.type;
                                    _local_25 = _local_5.figure;
                                    switch (_local_36)
                                    {
                                        case 2:
                                            _local_12 = getRoomUserObject(_local_5.roomObjectId);
                                            if (_local_12 != null)
                                            {
                                                _local_21 = _local_12.getModel().getString("figure_posture");
                                            };
                                            _local_11 = getPetImage(_local_25, _local_17, _local_15, _local_8, _local_21);
                                            _local_23 = new PetFigureData(_local_25).typeId;
                                            break;
                                        case 1:
                                            _local_11 = getUserImage(_local_25);
                                            break;
                                        case 3:
                                        case 4:
                                            _local_16 = 2;
                                        default:
                                    };
                                    _local_29 = _avatarColorCache.getValue(_local_25);
                                    _local_26 = _local_5.name;
                                };
                                _local_14 = _local_2.text;
                                if (_local_18 == 5)
                                {
                                    _local_24 = "widget.chatbubble.handitem";
                                    _local_27 = _container.localization.getLocalization(("handitem" + _local_2.extraParam), ("handitem" + _local_2.extraParam));
                                    _container.localization.registerParameter(_local_24, "username", _local_26);
                                    _container.localization.registerParameter(_local_24, "handitem", _local_27);
                                    _local_14 = _container.localization.getLocalizationRaw(_local_24).value;
                                    _local_16 = 1;
                                };
                                if (_local_18 == 10)
                                {
                                    _local_7 = "widget.chatbubble.mutetime";
                                    _local_10 = String((_local_2.extraParam % 60));
                                    _local_22 = String(((_local_2.extraParam > 0) ? Math.floor(((_local_2.extraParam % 3600) / 60)) : 0));
                                    _local_19 = String(((_local_2.extraParam > 0) ? Math.floor((_local_2.extraParam / 3600)) : 0));
                                    _container.localization.registerParameter(_local_7, "hours", _local_19);
                                    _container.localization.registerParameter(_local_7, "minutes", _local_22);
                                    _container.localization.registerParameter(_local_7, "seconds", _local_10);
                                    _local_14 = _container.localization.getLocalizationRaw(_local_7).value;
                                    _local_16 = 1;
                                };
                                if ((((_local_18 == 7) || (_local_18 == 8)) || (_local_18 == 9)))
                                {
                                    _local_4 = "widget.chatbubble.petrevived";
                                    if (_local_18 == 8)
                                    {
                                        _local_4 = "widget.chatbubble.petrefertilized";
                                    }
                                    else
                                    {
                                        if (_local_18 == 9)
                                        {
                                            _local_4 = "widget.chatbubble.petspeedfertilized";
                                        };
                                    };
                                    _local_28 = "";
                                    _local_30 = getRoomUserObject(_local_2.extraParam);
                                    if (_local_30 != null)
                                    {
                                        _local_31 = _local_2.session.userDataManager.getUserDataByIndex(_local_30.getId());
                                        if (_local_31 != null)
                                        {
                                            _local_28 = _local_31.name;
                                        };
                                    };
                                    _container.localization.registerParameter(_local_4, "petName", _local_26);
                                    _container.localization.registerParameter(_local_4, "userName", _local_28);
                                    _local_14 = _container.localization.getLocalizationRaw(_local_4).value;
                                    _local_16 = 1;
                                };
                                _local_9 = "RWCUE_EVENT_CHAT";
                                _local_35 = new RoomWidgetChatUpdateEvent(_local_9, _local_2.userId, _local_14, _local_26, 100, _local_36, _local_23, _local_32, _local_33, _local_11, _local_29, _local_2.session.roomId, _local_18, _local_16, _local_2.links);
                            };
                        };
                    };
                    break;
                case "gce_game_chat":
                    gameChatEventHandler((_arg_1 as GameChatEvent));
            };
            if ((((!(_container == null)) && (!(_container.events == null))) && (!(_local_35 == null))))
            {
                _container.events.dispatchEvent(_local_35);
            };
        }

        private function getRoomUserObject(_arg_1:int):IRoomObject
        {
            return (container.roomEngine.getRoomObject(container.roomEngine.activeRoomId, _arg_1, 100));
        }

        public function getUserImage(_arg_1:String):BitmapData
        {
            var _local_4:IAvatarImage;
            var _local_3:IPartColor;
            var _local_2:BitmapData = (_avatarImageCache.getValue(_arg_1) as BitmapData);
            if (_local_2 == null)
            {
                _local_4 = _container.avatarRenderManager.createAvatarImage(_arg_1, "h", null, this);
                if (_local_4 != null)
                {
                    _local_2 = _local_4.getCroppedImage("head", 0.5);
                    _local_3 = _local_4.getPartColor("ch");
                    _local_4.dispose();
                    if (_local_3 != null)
                    {
                        _avatarColorCache.add(_arg_1, _local_3.rgb);
                    };
                };
            };
            if (_local_2 != null)
            {
                _avatarImageCache.add(_arg_1, _local_2);
            };
            return (_local_2);
        }

        private function gameChatEventHandler(_arg_1:GameChatEvent):void
        {
            _SafeStr_1324.addChatMessage(_arg_1.message, _arg_1.name, _arg_1.locX, getUserImage(_arg_1.figure), _arg_1.color, _arg_1.notify);
        }

        public function update():void
        {
            updateWidgetPosition();
        }

        private function updateWidgetPosition():void
        {
            var _local_3:Number;
            var _local_7:String;
            var _local_8:RoomWidgetRoomViewUpdateEvent;
            var _local_1:Point;
            var _local_4:Point;
            var _local_5:Point;
            if (((((_container == null) || (_container.roomSession == null)) || (_container.roomEngine == null)) || (_container.events == null)))
            {
                return;
            };
            var _local_2:int = _container.getFirstCanvasId();
            var _local_9:int = _container.roomSession.roomId;
            var _local_6:RoomGeometry = (_container.roomEngine.getRoomCanvasGeometry(_local_9, _local_2) as RoomGeometry);
            if (_local_6 != null)
            {
                _local_3 = 1;
                if (_SafeStr_3852 > 0)
                {
                    _local_3 = (_local_6.scale / _SafeStr_3852);
                };
                if (_SafeStr_3853 == null)
                {
                    _SafeStr_3854.x = 0;
                    _SafeStr_3854.y = 0;
                    _SafeStr_3854.z = 0;
                    _SafeStr_3853 = _local_6.getScreenPoint(_SafeStr_3854);
                    _SafeStr_3852 = (_local_6.scale - 10);
                };
                _local_7 = "";
                _local_8 = null;
                _SafeStr_3854.x = 0;
                _SafeStr_3854.y = 0;
                _SafeStr_3854.z = 0;
                _local_1 = _local_6.getScreenPoint(_SafeStr_3854);
                if (_local_1 != null)
                {
                    _local_4 = _container.roomEngine.getRoomCanvasScreenOffset(_local_9, _local_2);
                    if (_local_4 != null)
                    {
                        _local_1.offset(_local_4.x, _local_4.y);
                    };
                    if (((!(_local_1.x == _SafeStr_3853.x)) || (!(_local_1.y == _SafeStr_3853.y))))
                    {
                        _local_5 = PointMath.sub(_local_1, PointMath.mul(_SafeStr_3853, _local_3));
                        if (((!(_local_5.x == 0)) || (!(_local_5.y == 0))))
                        {
                            _local_7 = "RWRVUE_ROOM_VIEW_POSITION_CHANGED";
                            _local_8 = new RoomWidgetRoomViewUpdateEvent(_local_7, null, _local_5);
                            _container.events.dispatchEvent(_local_8);
                        };
                        _SafeStr_3853 = _local_1;
                    };
                };
                if (_local_6.scale != _SafeStr_3852)
                {
                    _local_7 = "RWRVUE_ROOM_VIEW_SCALE_CHANGED";
                    _local_8 = new RoomWidgetRoomViewUpdateEvent(_local_7, null, null, _local_6.scale);
                    _container.events.dispatchEvent(_local_8);
                    _SafeStr_3852 = _local_6.scale;
                };
            };
        }

        public function petImageReady(_arg_1:String):void
        {
            var _local_2:BitmapData;
            if (_petImageCache)
            {
                _local_2 = (_petImageCache.remove(_arg_1) as BitmapData);
                if (_local_2 != null)
                {
                    _SafeStr_2217.push(_local_2);
                };
            };
        }

        public function avatarImageReady(_arg_1:String):void
        {
            var _local_2:BitmapData;
            if (_avatarImageCache)
            {
                _local_2 = (_avatarImageCache.remove(_arg_1) as BitmapData);
                if (_local_2 != null)
                {
                    _SafeStr_2217.push(_local_2);
                };
            };
        }

        private function getPetImage(_arg_1:String, _arg_2:int, _arg_3:Boolean, _arg_4:int=64, _arg_5:String=null):BitmapData
        {
            var _local_6:PetFigureData;
            var _local_8:int;
            var _local_7:uint;
            var _local_11:Boolean;
            var _local_9:_SafeStr_147;
            var _local_10:BitmapData = (_petImageCache.getValue((_arg_1 + _arg_5)) as BitmapData);
            if (_local_10 == null)
            {
                _local_6 = new PetFigureData(_arg_1);
                _local_8 = _local_6.typeId;
                _local_7 = 0;
                _local_11 = (!(_local_8 == 15));
                _local_9 = _container.roomEngine.getPetImage(_local_8, _local_6.paletteId, _local_6.color, new Vector3d((_arg_2 * 45)), _arg_4, this, _local_11, _local_7, _local_6.customParts, _arg_5);
                if (_local_9 != null)
                {
                    _local_10 = _local_9.data;
                    if (_local_9.id > 0)
                    {
                        _petImageIdToFigureString.add(_local_9.id, _local_6.figureString);
                    };
                };
            };
            if (_local_10 != null)
            {
                _petImageCache.add((_arg_1 + _arg_5), _local_10);
            };
            return (_local_10);
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            var _local_3:String = _petImageIdToFigureString.remove(_arg_1);
            if (_local_3 != null)
            {
                petImageReady(_local_3);
                if (_petImageCache)
                {
                    _petImageCache.add(_local_3, _arg_2);
                };
            };
        }

        public function imageFailed(_arg_1:int):void
        {
        }


    }
}

