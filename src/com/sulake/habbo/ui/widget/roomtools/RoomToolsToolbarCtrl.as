package com.sulake.habbo.ui.widget.roomtools
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import flash.geom.Point;
    import com.sulake.core.window.motion.Motion;
    import com.sulake.core.window.motion.Queue;
    import com.sulake.core.window.motion.EaseOut;
    import com.sulake.core.window.motion.MoveTo;
    import com.sulake.core.window.motion.Callback;
    import com.sulake.core.window.motion.Motions;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetZoomToggleMessage;
    import com.sulake.habbo.tracking.HabboTracking;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import flash.system.System;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class RoomToolsToolbarCtrl extends RoomToolsCtrlBase
    {

        private static const TOOLBAR_EXPAND_TARGET_X:int = 1;
        private static const TOOLBAR_COLLAPSE_TARGET_X:int = -130;

        private var _SafeStr_4289:RoomToolsHistory;

        public function RoomToolsToolbarCtrl(_arg_1:RoomToolsWidget, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            super(_arg_1, _arg_2, _arg_3);
            _window = (_arg_2.buildFromXML((_arg_3.getAssetByName("room_tools_toolbar_xml").content as XML)) as IWindowContainer);
            _window.procedure = onWindowEvent;
            _window.addEventListener("WME_OVER", onWindowEvent);
            _window.addEventListener("WME_OUT", onWindowEvent);
            updateVisuals();
        }

        override public function dispose():void
        {
            if (_SafeStr_4289)
            {
                _SafeStr_4289.dispose();
                _SafeStr_4289 = null;
            };
            var _local_1:IWindowContainer = (_SafeStr_1324.windowManager.getWindowByName("share_room_link") as IWindowContainer);
            if (_local_1)
            {
                _local_1.dispose();
            };
            super.dispose();
        }

        public function updateRoomHistoryButtons():void
        {
            if (_SafeStr_1324.currentRoomIndex >= (_SafeStr_1324.visitedRooms.length - 1))
            {
                _window.findChildByName("button_history_forward").disable();
            }
            else
            {
                _window.findChildByName("button_history_forward").enable();
            };
            if (_SafeStr_1324.currentRoomIndex == 0)
            {
                _window.findChildByName("button_history_back").disable();
            }
            else
            {
                _window.findChildByName("button_history_back").enable();
            };
            if (_SafeStr_1324.visitedRooms.length <= 1)
            {
                _window.findChildByName("button_history").disable();
            }
            else
            {
                _window.findChildByName("button_history").enable();
            };
        }

        public function disableRoomHistoryButtons():void
        {
            _window.findChildByName("button_history_forward").disable();
            _window.findChildByName("button_history_back").disable();
        }

        private function toggleHistory():void
        {
            if (_SafeStr_4289)
            {
                _SafeStr_4289.dispose();
                _SafeStr_4289 = null;
            }
            else
            {
                _SafeStr_4289 = new RoomToolsHistory(_windowManager, _assets, handler);
                _SafeStr_4289.populate(_SafeStr_1324.visitedRooms);
                updatePosition();
            };
        }

        public function setChatHistoryButton(_arg_1:Boolean):void
        {
            setElementVisible("button_chat_history", _arg_1);
        }

        public function setCameraButton(_arg_1:Boolean):void
        {
            setElementVisible("button_camera", _arg_1);
        }

        public function setLikeButton(_arg_1:Boolean):void
        {
            setElementVisible("button_like", _arg_1);
        }

        override public function setElementVisible(_arg_1:String, _arg_2:Boolean):void
        {
            if (!_window)
            {
                return;
            };
            _window.visible = true;
            super.setElementVisible(_arg_1, _arg_2);
            updatePosition();
        }

        public function updatePosition():void
        {
            var _local_3:IWindow;
            var _local_5:IWindow;
            var _local_7:IItemListWindow;
            var _local_4:IWindow;
            var _local_1:int;
            var _local_6:int;
            var _local_2:IWindow;
            if (_SafeStr_4284)
            {
                _local_3 = _window.findChildByName("side_bar_expand");
                _local_3.y = (_window.height - _local_3.height);
            }
            else
            {
                _local_5 = _window.findChildByName("arrow_collapse");
                _local_7 = (_window.findChildByName("itemlist_buttons") as IItemListWindow);
                _local_4 = _window.findChildByName("side_bar_collapse");
                _local_1 = 0;
                _local_6 = 0;
                while (_local_6 < _local_7.numListItems)
                {
                    _local_2 = _local_7.getListItemAt(_local_6);
                    if (_local_2.visible)
                    {
                        _local_1 = (_local_1 + _local_2.height);
                    };
                    _local_6++;
                };
                _local_4.height = _local_1;
                var _local_8:int = _local_1;
                _window.findChildByName("window_bg").height = _local_8;
                _local_7.height = _local_8;
                _window.height = _local_8;
                _local_5.y = ((_local_1 * 0.5) - (_local_5.height * 0.5));
            };
            _window.position = new Point(-5, ((_window.desktop.height - 55) - _window.height));
            if (_SafeStr_4289)
            {
                _SafeStr_4289.window.position = new Point((right - _SafeStr_4289.window.width), (_window.position.y - _SafeStr_4289.window.height));
            };
        }

        override public function setCollapsed(_arg_1:Boolean):void
        {
            var _local_3:Motion;
            if (((_SafeStr_4284 == _arg_1) || (!(_window))))
            {
                return;
            };
            _SafeStr_4284 = _arg_1;
            var _local_2:IWindow = _window.findChildByName("window_bg");
            if (!_local_2)
            {
                return;
            };
            if (_SafeStr_4284)
            {
                _local_3 = new Queue(new EaseOut(new MoveTo(_local_2, 100, -130, _local_2.y), 1), new Callback(motionComplete));
            }
            else
            {
                _local_2.x = -130;
                updateVisuals();
                _local_3 = new EaseOut(new MoveTo(_local_2, 100, 1, _local_2.y), 1);
            };
            Motions.runMotion(_local_3);
        }

        private function motionComplete(_arg_1:Motion):void
        {
            updateVisuals();
        }

        private function updateVisuals():void
        {
            if (((!(_window)) || (!(_window.findChildByName("window_bg")))))
            {
                return;
            };
            _window.findChildByName("window_bg").visible = (!(_SafeStr_4284));
            _window.findChildByName("side_bar_collapse").visible = (!(_SafeStr_4284));
            _window.findChildByName("side_bar_expand").visible = _SafeStr_4284;
            updatePosition();
        }

        private function onWindowEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var event:WindowEvent = _arg_1;
            var target:IWindow = _arg_2;
            if (((((event.type == "WE_PARENT_RESIZED") && (_window)) && (_window.parent)) && (event.target == _window.parent)))
            {
                return (updatePosition());
            };
            switch (event.type)
            {
                case "WME_CLICK":
                    clearCollapseTimer();
                    switch (target.name)
                    {
                        case "button_settings":
                            handler.toggleRoomInfoWindow();
                            break;
                        case "button_zoom":
                            if (_SafeStr_1324.messageListener)
                            {
                                var message:RoomWidgetZoomToggleMessage = new RoomWidgetZoomToggleMessage();
                                _SafeStr_1324.messageListener.processWidgetMessage(message);
                            };
                            break;
                        case "button_collapse":
                        case "button_expand":
                            _SafeStr_1324.setCollapsed((!(_SafeStr_4284)));
                            handler.sessionDataManager.setRoomToolsState((!(_SafeStr_4284)));
                            break;
                        case "button_history_back":
                            _SafeStr_1324.goToPreviousRoom();
                            break;
                        case "button_history_forward":
                            _SafeStr_1324.goToNextRoom();
                            break;
                        case "button_history":
                            toggleHistory();
                            break;
                        case "button_chat_history":
                            if (_SafeStr_1324.freeFlowChat)
                            {
                                _SafeStr_1324.freeFlowChat.toggleVisibility();
                            };
                            break;
                        case "button_like":
                            handler.rateRoom();
                            _window.findChildByName("button_like").disable();
                            break;
                        case "button_share":
                            var link:String = getEmbedData();
                            var window:IWindowContainer = (_SafeStr_1324.windowManager.getWindowByName("share_room_link") as IWindowContainer);
                            if (window == null)
                            {
                                var asset:XML = (_assets.getAssetByName("share_room_xml").content as XML);
                                if (asset)
                                {
                                    window = (_SafeStr_1324.windowManager.buildFromXML(asset) as IWindowContainer);
                                };
                            };
                            if (window)
                            {
                                HabboTracking.getInstance().trackEventLog("RoomLink", "click", "client.room_link.clicked");
                                window.name = "share_room_link";
                                window.center();
                                window.findChildByTag("close").addEventListener("WME_CLICK", function (_arg_1:WindowMouseEvent, _arg_2:IWindow=null):void
                                {
                                    window.dispose();
                                });
                                window.findChildByName("embed_src_txt").caption = getEmbedData();
                                window.findChildByName("embed_src_direct_txt").caption = getEmbedData("embed_src_direct_txt", "${url.prefix}/hotel?room=%roomId%");
                                IStaticBitmapWrapperWindow(window.findChildByName("thumbnail_image")).assetUri = getThumbnailUrl();
                            };
                            try
                            {
                                System.setClipboard(getEmbedData());
                            }
                            catch(error:Error)
                            {
                            };
                            break;
                        case "button_camera":
                            var openCameraEvent:HabboToolbarEvent = new HabboToolbarEvent("HTE_ICON_CAMERA");
                            openCameraEvent.iconName = "roomToolsMenu";
                            handler.container.toolbar.events.dispatchEvent(openCameraEvent);
                    };
                    return;
            };
        }

        private function getEmbedData(_arg_1:String="navigator.embed.src", _arg_2:String=""):String
        {
            var _local_4:String;
            var _local_5:String;
            if (_SafeStr_1324.handler.navigator.enteredGuestRoomData != null)
            {
                _local_4 = "private";
                _local_5 = ("" + _SafeStr_1324.handler.navigator.enteredGuestRoomData.flatId);
            };
            var _local_3:String = _SafeStr_1324.handler.container.config.getProperty("user.hash");
            if (_SafeStr_1324.localizations.hasLocalization(_arg_1))
            {
                _SafeStr_1324.localizations.registerParameter(_arg_1, "roomType", _local_4);
                _SafeStr_1324.localizations.registerParameter(_arg_1, "embedCode", _local_3);
                _SafeStr_1324.localizations.registerParameter(_arg_1, "roomId", _local_5);
            }
            else
            {
                if (_arg_2 != "")
                {
                    _arg_2 = _arg_2.replace("${url.prefix}", _SafeStr_1324.handler.container.config.getProperty("url.prefix"));
                    return (_arg_2.replace("%roomId%", _local_5));
                };
            };
            return (_SafeStr_1324.localizations.getLocalization(_arg_1, _arg_2));
        }

        private function getThumbnailUrl():String
        {
            var _local_1:String;
            var _local_2:String = "";
            if (_SafeStr_1324.handler.navigator.enteredGuestRoomData.officialRoomPicRef != null)
            {
                if (_SafeStr_1324.handler.container.config.getBoolean("new.navigator.official.room.thumbnails.in.amazon"))
                {
                    _local_1 = _SafeStr_1324.handler.container.config.getProperty("navigator.thumbnail.url_base");
                    _local_2 = ((_local_1 + _SafeStr_1324.handler.navigator.enteredGuestRoomData.flatId) + ".png");
                }
                else
                {
                    _local_2 = (_SafeStr_1324.handler.container.config.getProperty("image.library.url") + _SafeStr_1324.handler.navigator.enteredGuestRoomData.officialRoomPicRef);
                };
            }
            else
            {
                _local_1 = _SafeStr_1324.handler.container.config.getProperty("navigator.thumbnail.url_base");
                _local_2 = ((_local_1 + _SafeStr_1324.handler.navigator.enteredGuestRoomData.flatId) + ".png");
            };
            return (_local_2);
        }

        public function get right():int
        {
            var _local_1:IWindow;
            if (!_window)
            {
                return (0);
            };
            if (_SafeStr_4284)
            {
                _local_1 = _window.findChildByName("side_bar_expand");
                return ((_local_1) ? (_local_1.width + -5) : 0);
            };
            return (_window.width + -5);
        }


    }
}