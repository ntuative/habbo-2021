package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.furniture.highscore.HighScoreDisplayWidget;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.room.object.data.HighScoreStuffData;
    import flash.events.Event;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.geom.Point;

    public class HighScoreFurniWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var _SafeStr_1324:HighScoreDisplayWidget = null;
        private var _SafeStr_3870:RoomEngineObjectEvent = null;


        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get type():String
        {
            return ("RWE_HIGH_SCORE_DISPLAY");
        }

        public function get container():IRoomWidgetHandlerContainer
        {
            return (_container);
        }

        public function set widget(_arg_1:HighScoreDisplayWidget):void
        {
            _SafeStr_1324 = _arg_1;
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            _container = _arg_1;
            _container.addUpdateListener(this);
        }

        public function dispose():void
        {
            if (_container)
            {
                _container.removeUpdateListener(this);
            };
            _disposed = true;
            _container = null;
            _SafeStr_1324 = null;
        }

        public function getProcessedEvents():Array
        {
            return (["RETWE_REQUEST_HIGH_SCORE_DISPLAY", "RETWE_REQUEST_HIDE_HIGH_SCORE_DISPLAY"]);
        }

        public function processEvent(_arg_1:Event):void
        {
            var _local_4:RoomEngineObjectEvent;
            var _local_2:IRoomObject;
            var _local_5:IRoomObjectModel;
            var _local_3:HighScoreStuffData;
            if (((disposed) || (_arg_1 == null)))
            {
                return;
            };
            switch (_arg_1.type)
            {
                case "RETWE_REQUEST_HIGH_SCORE_DISPLAY":
                    _local_4 = RoomEngineObjectEvent(_arg_1);
                    _local_2 = _container.roomEngine.getRoomObject(_local_4.roomId, _local_4.objectId, _local_4.category);
                    if (_local_2 != null)
                    {
                        _local_5 = _local_2.getModel();
                        if (_local_5 != null)
                        {
                            _local_3 = new HighScoreStuffData();
                            _local_3.initializeFromRoomObjectModel(_local_5);
                            _SafeStr_1324.open(_local_4.objectId, _local_4.roomId, _local_3);
                        };
                        _SafeStr_3870 = _local_4;
                    };
                    return;
                case "RETWE_REQUEST_HIDE_HIGH_SCORE_DISPLAY":
                    _local_4 = RoomEngineObjectEvent(_arg_1);
                    if (((_local_4.roomId == _SafeStr_1324.roomId) && (_local_4.objectId == _SafeStr_1324.roomObjId)))
                    {
                        _SafeStr_1324.close();
                    };
                    return;
            };
        }

        public function getWidgetMessages():Array
        {
            return (null);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            return (null);
        }

        public function update():void
        {
            var _local_1:IRoomObject;
            var _local_2:Point;
            if (((((_SafeStr_3870) && (_SafeStr_1324.isOpen)) && (_SafeStr_1324.roomId == _SafeStr_3870.roomId)) && (_SafeStr_1324.roomObjId == _SafeStr_3870.objectId)))
            {
                _local_1 = _container.roomEngine.getRoomObject(_SafeStr_3870.roomId, _SafeStr_3870.objectId, _SafeStr_3870.category);
                if (_local_1 != null)
                {
                    _local_2 = _container.roomEngine.getRoomObjectScreenLocation(_SafeStr_3870.roomId, _SafeStr_3870.objectId, _SafeStr_3870.category);
                    if (_local_2 != null)
                    {
                        _SafeStr_1324.setRelativePositionToRoomObjectAt(_local_2.x, _local_2.y);
                    };
                };
            };
        }


    }
}

