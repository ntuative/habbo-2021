package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.furniture.video.YoutubeDisplayWidget;
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.YoutubeDisplayVideoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.YoutubeDisplayPlaylistsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.YoutubeControlVideoMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.YoutubeDisplayVideoMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.furniture.YoutubeControlVideoMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.furniture.YoutubeDisplayPlaylistsMessageParser;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.GetYoutubeDisplayStatusMessageComposer;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetYoutubeDisplayPlaylistMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.ControlYoutubeDisplayPlaybackMessageComposer;

    public class FurnitureYoutubeDisplayWidgetHandler implements IRoomWidgetHandler 
    {

        private static const CONTROL_COMMAND_PREVIOUS_VIDEO:int = 0;
        private static const CONTROL_COMMAND_NEXT_VIDEO:int = 1;
        private static const CONTROL_COMMAND_PAUSE_VIDEO:int = 2;
        private static const CONTROL_COMMAND_CONTINUE_VIDEO:int = 3;

        private var _container:IRoomWidgetHandlerContainer;
        private var _SafeStr_1324:YoutubeDisplayWidget;
        private var _SafeStr_913:Vector.<IMessageEvent>;


        public function get type():String
        {
            return ("RWE_YOUTUBE");
        }

        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            _container = _arg_1;
            addMessageEvent(new YoutubeDisplayVideoMessageEvent(onVideo));
            addMessageEvent(new YoutubeDisplayPlaylistsMessageEvent(onPlaylists));
            addMessageEvent(new YoutubeControlVideoMessageEvent(onControlVideo));
        }

        private function addMessageEvent(_arg_1:IMessageEvent):void
        {
            if (_SafeStr_913 == null)
            {
                _SafeStr_913 = new Vector.<IMessageEvent>(0);
            };
            _SafeStr_913.push(_arg_1);
            _container.connection.addMessageEvent(_arg_1);
        }

        private function removeEvents():void
        {
            for each (var _local_1:IMessageEvent in _SafeStr_913)
            {
                _container.connection.removeMessageEvent(_local_1);
                _local_1.dispose();
            };
        }

        private function onVideo(_arg_1:YoutubeDisplayVideoMessageEvent):void
        {
            var _local_2:YoutubeDisplayVideoMessageParser = _arg_1.getParser();
            _SafeStr_1324.showVideo(_local_2.furniId, _local_2.videoId, _local_2.startAtSeconds, _local_2.endAtSeconds, _local_2.state);
        }

        private function onControlVideo(_arg_1:YoutubeControlVideoMessageEvent):void
        {
            var _local_2:YoutubeControlVideoMessageParser = _arg_1.getParser();
            _SafeStr_1324.controlVideo(_local_2.furniId, _local_2.commandId);
        }

        private function onPlaylists(_arg_1:YoutubeDisplayPlaylistsMessageEvent):void
        {
            var _local_2:YoutubeDisplayPlaylistsMessageParser = _arg_1.getParser();
            _SafeStr_1324.populatePlaylists(_local_2.furniId, _local_2.playlists, _local_2.selectedPlaylistId);
        }

        public function set widget(_arg_1:YoutubeDisplayWidget):void
        {
            _SafeStr_1324 = _arg_1;
        }

        public function getWidgetMessages():Array
        {
            return (null);
        }

        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            return (null);
        }

        public function getProcessedEvents():Array
        {
            return ([]);
        }

        public function processEvent(_arg_1:Event):void
        {
            var _local_3:Boolean;
            if (_container.roomEngine == null)
            {
                return;
            };
            var _local_4:RoomEngineToWidgetEvent = (_arg_1 as RoomEngineToWidgetEvent);
            if (_local_4 == null)
            {
                return;
            };
            var _local_2:IRoomObject = _container.roomEngine.getRoomObject(_local_4.roomId, _local_4.objectId, _local_4.category);
            switch (_arg_1.type)
            {
                case "RETWE_OPEN_WIDGET":
                    if (_local_2 != null)
                    {
                        _local_3 = ((_container.isOwnerOfFurniture(_local_2)) || (_container.sessionDataManager.hasSecurity(4)));
                        _SafeStr_1324.show(_local_2, _local_3);
                        _container.connection.send(new GetYoutubeDisplayStatusMessageComposer(_local_2.getId()));
                    };
                    return;
                case "RETWE_CLOSE_WIDGET":
                    _SafeStr_1324.hide(_local_2);
                    return;
            };
        }

        public function update():void
        {
        }

        public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            removeEvents();
            _container = null;
        }

        public function get disposed():Boolean
        {
            return (_container == null);
        }

        public function selectPlaylist(_arg_1:int, _arg_2:String):void
        {
            _container.connection.send(new SetYoutubeDisplayPlaylistMessageComposer(_arg_1, _arg_2));
        }

        public function switchToPreviousVideo(_arg_1:int):void
        {
            _container.connection.send(new ControlYoutubeDisplayPlaybackMessageComposer(_arg_1, 0));
        }

        public function switchToNextVideo(_arg_1:int):void
        {
            _container.connection.send(new ControlYoutubeDisplayPlaybackMessageComposer(_arg_1, 1));
        }

        public function pauseVideo(_arg_1:int):void
        {
            _container.connection.send(new ControlYoutubeDisplayPlaybackMessageComposer(_arg_1, 2));
        }

        public function continueVideo(_arg_1:int):void
        {
            _container.connection.send(new ControlYoutubeDisplayPlaybackMessageComposer(_arg_1, 3));
        }


    }
}

