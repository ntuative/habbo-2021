package com.sulake.habbo.ui.widget.furniture.video
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.handler.FurnitureYoutubeDisplayWidgetHandler;
    import com.sulake.core.window.components.IItemListWindow;
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import flash.events.Event;
    import flash.display.DisplayObject;
    import flash.events.MouseEvent;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.YoutubeDisplayPlaylist;
    import __AS3__.vec.Vector;

    public class YoutubeDisplayWidget extends RoomWidgetBase 
    {

        private static const _SafeStr_4139:uint = 4291611903;
        private static const _SafeStr_4140:uint = 0xFFFFFFFF;

        private var _habboTracking:IHabboTracking;
        private var _SafeStr_4138:Object;
        private var _mainWindow:IWindowContainer;
        private var _roomObject:IRoomObject;
        private var _SafeStr_2623:IWindowContainer;
        private var _SafeStr_4141:IWindow;
        private var _queuedVideoParams:Object;
        private var _SafeStr_4142:String;
        private var _canControlPlayback:Boolean;
        private var _SafeStr_4143:int = -1;

        public function YoutubeDisplayWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager, _arg_5:IHabboTracking)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            _habboTracking = _arg_5;
            ownHandler.widget = this;
        }

        private function get ownHandler():FurnitureYoutubeDisplayWidgetHandler
        {
            return (_SafeStr_3915 as FurnitureYoutubeDisplayWidgetHandler);
        }

        override public function get mainWindow():IWindow
        {
            return (_mainWindow);
        }

        public function show(_arg_1:IRoomObject, _arg_2:Boolean):void
        {
            _roomObject = _arg_1;
            _canControlPlayback = _arg_2;
            createWindow(_arg_2);
            _mainWindow.visible = true;
        }

        private function createWindow(_arg_1:Boolean):void
        {
            if (_mainWindow != null)
            {
                return;
            };
            _mainWindow = (windowManager.buildFromXML(XML(assets.getAssetByName("video_viewer_xml").content)) as IWindowContainer);
            if (_arg_1)
            {
                _SafeStr_4141 = IItemListWindow(_mainWindow.findChildByName("playlists")).removeListItemAt(0);
            }
            else
            {
                _mainWindow.findChildByName("right_pane").dispose();
                _mainWindow.findChildByName("video_background").width = (_mainWindow.width - 20);
                _mainWindow.findChildByName("video_background").setParamFlag(128);
                _mainWindow.width = (_mainWindow.width - 250);
            };
            _mainWindow.procedure = windowProcedure;
            _mainWindow.center();
        }

        private function onPlayerLoaderInit(_arg_1:Event):void
        {
            var _local_2:Loader;
            if (_mainWindow == null)
            {
                return;
            };
            var _local_3:LoaderInfo = (_arg_1.target as LoaderInfo);
            if (_local_3)
            {
                _local_2 = _local_3.loader;
                IDisplayObjectWrapper(_mainWindow.findChildByName("video_wrapper")).setDisplayObject(_local_2);
                _local_2.content.addEventListener("onReady", onPlayerReady);
                _local_2.content.addEventListener("onStateChange", onPlayerStateChange);
                _local_2.content.addEventListener("mouseUp", onVideoMouseEvent);
                _local_2.content.addEventListener("mouseMove", onVideoMouseEvent);
            };
        }

        private function onVideoMouseEvent(_arg_1:MouseEvent):void
        {
            if (((!(_mainWindow == null)) && (_canControlPlayback)))
            {
                DisplayObject(_arg_1.target).stage.dispatchEvent(new MouseEvent(_arg_1.type));
                if ((((_SafeStr_4138) && (_arg_1.type == "mouseUp")) && (!(_SafeStr_4142 == ""))))
                {
                    if (_SafeStr_4138.getPlayerState() == 1)
                    {
                        ownHandler.pauseVideo(_roomObject.getId());
                    }
                    else
                    {
                        if (_SafeStr_4138.getPlayerState() == 2)
                        {
                            ownHandler.continueVideo(_roomObject.getId());
                        };
                    };
                };
            };
        }

        private function onPlayerReady(_arg_1:Event):void
        {
            var _local_2:IWindow;
            _SafeStr_4138 = _arg_1.target;
            if (_mainWindow != null)
            {
                _local_2 = _mainWindow.findChildByName("video_wrapper");
                _SafeStr_4138.setSize(_local_2.width, _local_2.height);
                if (_queuedVideoParams != null)
                {
                    loadVideo(_queuedVideoParams);
                    _queuedVideoParams = null;
                };
            }
            else
            {
                _SafeStr_4138.destroy();
            };
        }

        private function onPlayerStateChange(_arg_1:Event):void
        {
            _SafeStr_4138 = _arg_1.target;
            if (_mainWindow != null)
            {
                switch (_SafeStr_4138.getPlayerState())
                {
                    case -1:
                    case 1:
                        if (_SafeStr_4143 == 2)
                        {
                            _SafeStr_4138.pauseVideo();
                        };
                        return;
                };
            };
        }

        public function hide(_arg_1:IRoomObject):void
        {
            if (_roomObject != _arg_1)
            {
                return;
            };
            if (_mainWindow != null)
            {
                _mainWindow.dispose();
                _mainWindow = null;
            };
            if (_SafeStr_4141 != null)
            {
                _SafeStr_4141.dispose();
                _SafeStr_4141 = null;
            };
            if (_SafeStr_4138 != null)
            {
                _SafeStr_4138.destroy();
                _SafeStr_4138 = null;
            };
            if (_SafeStr_4142 != null)
            {
                _habboTracking.trackEventLog("YouTubeTVs", _SafeStr_4142, "video.closed");
            };
            _queuedVideoParams = null;
            _SafeStr_2623 = null;
            _roomObject = null;
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            hide(_roomObject);
            _habboTracking = null;
            super.dispose();
        }

        private function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_5:IWindow;
            var _local_6:int;
            var _local_3:int;
            var _local_8:IWindow;
            var _local_9:IItemListWindow;
            var _local_7:int;
            var _local_4:IWindowContainer;
            switch (_arg_1.type)
            {
                case "WME_CLICK":
                    switch (_arg_2.name)
                    {
                        case "header_button_close":
                            hide(_roomObject);
                            break;
                        case "playlist_prev":
                            ownHandler.switchToPreviousVideo(_roomObject.getId());
                            break;
                        case "playlist_next":
                            ownHandler.switchToNextVideo(_roomObject.getId());
                            break;
                        default:
                            if ((_arg_2 is IRegionWindow))
                            {
                                if (_SafeStr_2623 != null)
                                {
                                    _SafeStr_2623.findChildByName("item_background").color = 0xFFFFFFFF;
                                };
                                if (_SafeStr_2623 == _arg_2)
                                {
                                    _SafeStr_2623 = null;
                                    ownHandler.selectPlaylist(_roomObject.getId(), "");
                                }
                                else
                                {
                                    _SafeStr_2623 = (_arg_2 as IWindowContainer);
                                    _SafeStr_2623.findChildByName("item_background").color = 4291611903;
                                    ownHandler.selectPlaylist(_roomObject.getId(), _SafeStr_2623.name);
                                };
                                updateButtons();
                            };
                    };
                    return;
                case "WE_RESIZE":
                    switch (_arg_2.name)
                    {
                        case "video_viewer":
                            if (_mainWindow != null)
                            {
                                _local_5 = _mainWindow.findChildByName("right_pane");
                                if (_local_5 != null)
                                {
                                    _local_6 = (_mainWindow.width - 29);
                                    _local_3 = (_local_6 * 0.66);
                                    _local_8 = _mainWindow.findChildByName("video_background");
                                    _local_8.width = _local_3;
                                    _local_5.x = (_local_8.right + 9);
                                    _local_5.width = (_local_6 - _local_3);
                                };
                            };
                            break;
                        case "playlists":
                            _local_9 = (_arg_2 as IItemListWindow);
                            if (_local_9 != null)
                            {
                                _local_7 = 0;
                                while (_local_7 < _local_9.numListItems)
                                {
                                    _local_4 = (_local_9.getListItemAt(_local_7) as IWindowContainer);
                                    _local_4.findChildByName("item_background").width = _local_9.width;
                                    _local_4.findChildByName("item_contents").width = _local_9.width;
                                    _local_4.findChildByName("item_description").width = (_local_9.width - 22);
                                    _local_7++;
                                };
                            };
                            break;
                        case "video_wrapper":
                            if (_SafeStr_4138 != null)
                            {
                                _SafeStr_4138.setSize(_arg_2.width, _arg_2.height);
                            };
                    };
                    return;
            };
        }

        public function showVideo(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:int):void
        {
            if (((_roomObject == null) || (!(_roomObject.getId() == _arg_1))))
            {
                return;
            };
            var _local_6:Object = (((_arg_3 > 0) || (_arg_4 > 0)) ? {
    "videoId":_arg_2,
    "startSeconds":_arg_3,
    "endSeconds":_arg_4,
    "suggestedQuality":"large"
} : {
    "videoId":_arg_2,
    "suggestedQuality":"large"
});
            if (_SafeStr_4138 != null)
            {
                loadVideo(_local_6);
                _queuedVideoParams = null;
            }
            else
            {
                _queuedVideoParams = _local_6;
            };
            _SafeStr_4143 = _arg_5;
        }

        public function controlVideo(_arg_1:int, _arg_2:int):void
        {
            if (((_roomObject == null) || (!(_roomObject.getId() == _arg_1))))
            {
                return;
            };
            if (_mainWindow != null)
            {
                if (_SafeStr_4138)
                {
                    switch (_arg_2)
                    {
                        case 1:
                            _SafeStr_4143 = 1;
                            _SafeStr_4138.playVideo();
                            return;
                        case 2:
                            _SafeStr_4143 = 2;
                            _SafeStr_4138.pauseVideo();
                        default:
                    };
                };
            };
        }

        private function loadVideo(_arg_1:Object):void
        {
            _SafeStr_4142 = _arg_1.videoId;
            var _local_2:Boolean = (!(_SafeStr_4142 == ""));
            if (_local_2)
            {
                _SafeStr_4138.loadVideoById(_arg_1);
                _habboTracking.trackEventLog("YouTubeTVs", _SafeStr_4142, "video.started");
            }
            else
            {
                _SafeStr_4138.stopVideo();
            };
            if (_mainWindow != null)
            {
                _mainWindow.findChildByName("no_videos_label").visible = (!(_local_2));
                _mainWindow.findChildByName("video_wrapper").visible = _local_2;
            };
        }

        public function populatePlaylists(_arg_1:int, _arg_2:Vector.<YoutubeDisplayPlaylist>, _arg_3:String):void
        {
            var _local_4:IWindowContainer;
            if (((((_roomObject == null) || (!(_roomObject.getId() == _arg_1))) || (_mainWindow == null)) || (_SafeStr_4141 == null)))
            {
                return;
            };
            var _local_6:IItemListWindow = (_mainWindow.findChildByName("playlists") as IItemListWindow);
            if (_local_6 == null)
            {
                return;
            };
            _local_6.destroyListItems();
            _SafeStr_2623 = null;
            for each (var _local_5:YoutubeDisplayPlaylist in _arg_2)
            {
                _local_4 = (_SafeStr_4141.clone() as IWindowContainer);
                _local_4.name = _local_5.playlistId;
                _local_4.findChildByName("item_background").width = _local_6.width;
                if (_local_5.playlistId == _arg_3)
                {
                    _local_4.findChildByName("item_background").color = 4291611903;
                    _SafeStr_2623 = _local_4;
                };
                _local_4.findChildByName("item_contents").width = _local_6.width;
                _local_4.findChildByName("item_title").caption = _local_5.title;
                _local_4.findChildByName("item_description").caption = _local_5.description.replace(/\r/g, "");
                _local_4.findChildByName("item_description").width = (_local_6.width - 22);
                _local_6.addListItem(_local_4);
            };
            updateButtons();
        }

        private function updateButtons():void
        {
            if (_mainWindow == null)
            {
                return;
            };
            if (_SafeStr_2623 != null)
            {
                _mainWindow.findChildByName("playlist_prev").enable();
                _mainWindow.findChildByName("playlist_next").enable();
            }
            else
            {
                _mainWindow.findChildByName("playlist_prev").disable();
                _mainWindow.findChildByName("playlist_next").disable();
            };
        }


    }
}

