package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.avatar.IHabboAvatarEditorDataSaver;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetClothingChangeMessage;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.ui.widget.events.RoomWidgetClothingChangeUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;

    public class FurnitureClothingChangeWidgetHandler implements IRoomWidgetHandler, IHabboAvatarEditorDataSaver 
    {

        private static const DEFAULT_BOY_CLOTHES:String = "hd-99999-99999.lg-270-62";
        private static const DEFAULT_GIRL_CLOTHES:String = "hd-99999-99999.ch-630-62.lg-695-62";

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var _SafeStr_1922:int = -1;


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get type():String
        {
            return ("RWE_CLOTHING_CHANGE");
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            _container = _arg_1;
        }

        public function dispose():void
        {
            if (((_container) && (_container.avatarEditor)))
            {
                _container.avatarEditor.close(1);
            };
            _disposed = true;
            _container = null;
        }

        public function getWidgetMessages():Array
        {
            return (["RWFWM_MESSAGE_REQUEST_CLOTHING_CHANGE", "RWCCM_REQUEST_EDITOR", "RWCM_OPEN_AVATAR_EDITOR"]);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_6:RoomWidgetFurniToWidgetMessage;
            var _local_3:Boolean;
            var _local_7:RoomWidgetClothingChangeMessage;
            var _local_5:String;
            var _local_8:String;
            var _local_4:IRoomObject;
            var _local_9:IRoomObjectModel;
            var _local_2:RoomWidgetClothingChangeUpdateEvent;
            switch (_arg_1.type)
            {
                case "RWFWM_MESSAGE_REQUEST_CLOTHING_CHANGE":
                    _local_6 = (_arg_1 as RoomWidgetFurniToWidgetMessage);
                    _local_4 = _container.roomEngine.getRoomObject(_local_6.roomId, _local_6.id, _local_6.category);
                    if (_local_4 != null)
                    {
                        _local_9 = _local_4.getModel();
                        if (_local_9 != null)
                        {
                            _local_3 = (((_container.roomSession.isRoomOwner) || (_container.sessionDataManager.isAnyRoomController)) || (_container.roomSession.roomControllerLevel >= 1));
                            if (_local_3)
                            {
                                _local_2 = new RoomWidgetClothingChangeUpdateEvent("RWCCUE_SHOW_GENDER_SELECTION", _local_6.id, _local_6.category, _local_6.roomId);
                                _container.events.dispatchEvent(_local_2);
                            };
                        };
                    };
                    break;
                case "RWCCM_REQUEST_EDITOR":
                    _local_7 = (_arg_1 as RoomWidgetClothingChangeMessage);
                    _local_4 = _container.roomEngine.getRoomObject(_local_7.roomId, _local_7.objectId, _local_7.objectCategory);
                    if (_local_4 != null)
                    {
                        _local_9 = _local_4.getModel();
                        if (_local_9 != null)
                        {
                            _SafeStr_1922 = _local_7.objectId;
                            _local_5 = "M";
                            _local_8 = _local_9.getString("furniture_clothing_boy");
                            if (((_local_8 == null) || (_local_8 == "")))
                            {
                                _local_8 = "hd-99999-99999.lg-270-62";
                            };
                            if (_local_7.gender == "F")
                            {
                                _local_5 = "F";
                                _local_8 = _local_9.getString("furniture_clothing_girl");
                                if (((_local_8 == null) || (_local_8 == "")))
                                {
                                    _local_8 = "hd-99999-99999.ch-630-62.lg-695-62";
                                };
                            };
                            if (_container.avatarEditor.openEditor(1, this, ["torso", "legs"], false, "${widget.furni.clothingchange.editor.title}"))
                            {
                                _container.avatarEditor.loadAvatarInEditor(1, _local_8, _local_5, 0);
                                _local_2 = new RoomWidgetClothingChangeUpdateEvent("RWCCUE_SHOW_GENDER_SELECTION", _local_7.objectId, _local_7.objectCategory, _local_7.roomId);
                                _container.events.dispatchEvent(_local_2);
                            };
                        };
                    };
            };
            return (null);
        }

        public function update():void
        {
        }

        public function getProcessedEvents():Array
        {
            return ([]);
        }

        public function processEvent(_arg_1:Event):void
        {
        }

        public function saveFigure(_arg_1:String, _arg_2:String):void
        {
            if (_container == null)
            {
                return;
            };
            _container.roomSession.sendUpdateClothingChangeFurniture(_SafeStr_1922, _arg_2, _arg_1);
            _container.avatarEditor.close(1);
        }


    }
}

