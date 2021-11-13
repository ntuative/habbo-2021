package com.sulake.habbo.ui.widget.roomchat
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.ui.widget.roomchat.style.ChatBubbleFactory;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import flash.geom.Point;
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.ICoreConfiguration;
    import com.sulake.habbo.ui.handler.ChatWidgetHandler;
    import com.sulake.core.window.components.IDesktopWindow;
    import flash.geom.Rectangle;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.IWindow;
    import flash.utils.getTimer;
    import flash.events.IEventDispatcher;
    import com.sulake.room.utils.RoomEnterEffect;
    import com.sulake.habbo.ui.widget.events.RoomWidgetChatUpdateEvent;
    import flash.display.BitmapData;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomViewUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChatSelectAvatarMessage;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class RoomChatWidget extends RoomWidgetBase implements IUpdateReceiver 
    {

        private static const CHAT_ITEM_LEVEL_HEIGHT:int = 19;
        private static const CHAT_ITEM_LEVEL_HEIGHT_SMALL:int = 10;
        private static const CHAT_ITEM_NONVISIBLE_MARGIN:int = 20;
        private static const CHAT_ITEM_REAL_HEIGHT:int = 32;
        private static const ANIMATION_STEP_INTERVAL_MS:int = 25;
        private static const ANIMATION_TIMEOUT_MS:int = 4000;
        private static const ANIMATION_TIMEOUT_SLOW_MS:int = 6000;
        private static const ANIMATION_STEP_PIXELS:int = 3;
        private static const MAX_BUFFER_SIZE:int = 1;
        private static const MAX_FAST_LEVELS_LORES:int = 8;
        private static const MAX_FAST_LEVELS_MIDRES:int = 10;
        private static const MAX_FAST_LEVELS_HIRES:int = 12;
        private static const MAX_SLOW_LEVELS:int = 0;
        private static const CHAT_AREA_HEIGHT_LORES:int = 171;
        private static const CHAT_AREA_HEIGHT_MIDRES:int = 209;
        private static const CHAT_AREA_HEIGHT_HIRES:int = 247;
        private static const CHAT_AREA_MARGIN_BOTTOM:int = 23;
        private static const FRIEND_BAR_MARGIN:int = 40;
        private static const DESKTOP_WINDOW_LAYER:uint = 1;
        private static const _SafeStr_4265:int = 750;
        private static const _SafeStr_4266:int = 1000;

        private static var _chatBubbleFactory:ChatBubbleFactory = null;

        private var _timeoutTime:int = 0;
        private var _SafeStr_4267:int = 0;
        private var _mainWindow:IWindowContainer;
        private var _SafeStr_4263:IItemListWindow;
        private var _SafeStr_4264:IWindowContainer;
        private var _itemList:Array = [];
        private var _SafeStr_4268:Array = [];
        private var _movingItems:Array = [];
        private var _SafeStr_4269:int;
        private var _SafeStr_4270:int = 0;
        private var _SafeStr_4271:Number = 1;
        private var _SafeStr_3305:String;
        private var _SafeStr_4272:Number = 1;
        private var _SafeStr_4273:Number = 0;
        private var _cameraOffset:Point = new Point();
        private var _historyViewer:RoomChatHistoryViewer;
        private var _SafeStr_1388:Boolean = false;
        private var _SafeStr_4274:Boolean = false;
        private var _SafeStr_659:Component = null;
        private var _config:ICoreConfiguration;
        private var _SafeStr_4275:int = 150;
        private var _SafeStr_4262:int;
        private var _SafeStr_4276:int = 19;
        private var _SafeStr_4277:int = 100;
        private var _SafeStr_4278:int = 205;
        private var _SafeStr_4261:int;
        private var _maxFastLevels:int;

        public function RoomChatWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager, _arg_5:ICoreConfiguration, _arg_6:int, _arg_7:Component)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            (_arg_1 as ChatWidgetHandler).widget = this;
            _config = _arg_5;
            _SafeStr_4269 = _arg_6;
            var _local_9:IDesktopWindow = _arg_2.getDesktop(1);
            if (_local_9.height >= 1000)
            {
                _SafeStr_4261 = 247;
                _maxFastLevels = 12;
                Logger.log("Hi-res chat desktop selected");
            }
            else
            {
                if (_local_9.height >= 750)
                {
                    _SafeStr_4261 = 209;
                    _maxFastLevels = 10;
                    Logger.log("Mid-res chat desktop selected");
                }
                else
                {
                    _SafeStr_4261 = 171;
                    _maxFastLevels = 12;
                    Logger.log("Lo-res chat desktop selected");
                };
            };
            _SafeStr_4262 = (_SafeStr_4261 + 23);
            _mainWindow = (_arg_2.createWindow("chat_container", "", 4, 0, 0, new Rectangle(0, 0, 200, (_SafeStr_4262 + 39)), null, 0) as IWindowContainer);
            _mainWindow.background = true;
            _mainWindow.color = 0x1FFFFFF;
            _mainWindow.tags.push("room_widget_chat");
            _SafeStr_4263 = (_arg_2.createWindow("chat_contentlist", "", 50, 0, (0x10 | 0x0880), new Rectangle(0, 0, 200, _SafeStr_4262), null, 0) as IItemListWindow);
            _SafeStr_4263.disableAutodrag = true;
            _mainWindow.addChild(_SafeStr_4263);
            _SafeStr_4264 = (_arg_2.createWindow("chat_active_content", "", 4, 0, 16, new Rectangle(0, 0, 200, _SafeStr_4262), null, 0) as IWindowContainer);
            _SafeStr_4264.clipping = false;
            _SafeStr_4263.addListItem(_SafeStr_4264);
            _historyViewer = new RoomChatHistoryViewer(this, _arg_2, _mainWindow, _arg_3);
            _SafeStr_3305 = _arg_5.getProperty("site.url");
            _SafeStr_4275 = _arg_5.getInteger("chat.history.item.max.count", 150);
            var _local_8:Boolean = ((_arg_5.getBoolean("chat.history.disabled")) || (isGameSession));
            if (_historyViewer != null)
            {
                _historyViewer.disabled = _local_8;
            };
            if (_arg_7 != null)
            {
                _SafeStr_659 = _arg_7;
                _SafeStr_659.registerUpdateReceiver(this, 1);
            };
            if (!_chatBubbleFactory)
            {
                _chatBubbleFactory = new ChatBubbleFactory(_arg_3, _arg_2, XML(_assets.getAssetByName("roomchat_styles_chatstyles_xml").content));
            };
        }

        public static function get chatBubbleFactory():ChatBubbleFactory
        {
            return (_chatBubbleFactory);
        }


        override public function get mainWindow():IWindow
        {
            return (_mainWindow);
        }

        public function get config():ICoreConfiguration
        {
            return (_config);
        }

        public function get handler():ChatWidgetHandler
        {
            return (_SafeStr_3915 as ChatWidgetHandler);
        }

        override public function dispose():void
        {
            var _local_1:RoomChatItem;
            var _local_2:int;
            if (disposed)
            {
                return;
            };
            while (_movingItems.length > 0)
            {
                _local_1 = _movingItems.shift();
            };
            _historyViewer.dispose();
            _historyViewer = null;
            while (_itemList.length > 0)
            {
                _local_1 = _itemList.shift();
                _local_1.dispose();
            };
            while (_SafeStr_4268.length > 0)
            {
                _local_1 = _SafeStr_4268.shift();
                _local_1.dispose();
            };
            _mainWindow.dispose();
            if (_SafeStr_659 != null)
            {
                _SafeStr_659.removeUpdateReceiver(this);
                _SafeStr_659 = null;
            };
            super.dispose();
        }

        public function update(_arg_1:uint):void
        {
            var _local_2:int;
            if (((getTimer() > _timeoutTime) && (_timeoutTime > 0)))
            {
                _timeoutTime = -1;
                animationStart();
            };
            if (_SafeStr_1388)
            {
                _local_2 = int(((_arg_1 / 25) * 3));
                if ((_local_2 + _SafeStr_4267) > _SafeStr_4276)
                {
                    _local_2 = (_SafeStr_4276 - _SafeStr_4267);
                };
                if (_local_2 > 0)
                {
                    moveItemsUp(_local_2);
                    _SafeStr_4267 = (_SafeStr_4267 + _local_2);
                };
                if (_SafeStr_4267 >= _SafeStr_4276)
                {
                    _SafeStr_4276 = 19;
                    _SafeStr_4267 = 0;
                    animationStop();
                    processBuffer();
                    _timeoutTime = (getTimer() + 4000);
                };
            };
            if (_historyViewer != null)
            {
                _historyViewer.update(_arg_1);
            };
        }

        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addEventListener("RWCUE_EVENT_CHAT", onChatMessage);
            _arg_1.addEventListener("RWRVUE_ROOM_VIEW_SIZE_CHANGED", onRoomViewUpdate);
            _arg_1.addEventListener("RWRVUE_ROOM_VIEW_POSITION_CHANGED", onRoomViewUpdate);
            _arg_1.addEventListener("RWRVUE_ROOM_VIEW_SCALE_CHANGED", onRoomViewUpdate);
            super.registerUpdateEvents(_arg_1);
        }

        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.removeEventListener("RWCUE_EVENT_CHAT", onChatMessage);
            _arg_1.removeEventListener("RWRVUE_ROOM_VIEW_SIZE_CHANGED", onRoomViewUpdate);
            _arg_1.removeEventListener("RWRVUE_ROOM_VIEW_POSITION_CHANGED", onRoomViewUpdate);
            _arg_1.removeEventListener("RWRVUE_ROOM_VIEW_SCALE_CHANGED", onRoomViewUpdate);
        }

        private function onChatMessage(_arg_1:RoomWidgetChatUpdateEvent):void
        {
            if (((RoomEnterEffect.isRunning()) && (!(_arg_1.chatType == 1))))
            {
                return;
            };
            var _local_2:RoomChatItem = new RoomChatItem(this, windowManager, assets, getFreeItemId(), localizations, _SafeStr_3305);
            _local_2.define(_arg_1);
            addChatItem(_local_2);
        }

        public function addChatMessage(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:BitmapData, _arg_5:uint, _arg_6:Boolean):void
        {
            var _local_7:RoomChatItem = new RoomChatItem(this, windowManager, assets, getFreeItemId(), localizations, _SafeStr_3305);
            _local_7.message = _arg_1;
            _local_7.senderName = _arg_2;
            _local_7.senderX = _arg_3;
            _local_7.senderImage = _arg_4;
            _local_7.senderColor = _arg_5;
            if (_arg_6)
            {
                _local_7.chatType = 5;
            };
            _local_7.renderView();
            addChatItem(_local_7);
        }

        private function addChatItem(_arg_1:RoomChatItem):void
        {
            if (_SafeStr_4272 != 1)
            {
                _arg_1.senderX = (_arg_1.senderX / _SafeStr_4272);
            };
            _arg_1.senderX = (_arg_1.senderX - _cameraOffset.x);
            setChatItemLocHorizontal(_arg_1);
            _SafeStr_4268.push(_arg_1);
            processBuffer();
        }

        private function onRoomViewUpdate(_arg_1:RoomWidgetRoomViewUpdateEvent):void
        {
            var _local_2:Rectangle = _arg_1.rect;
            if (_arg_1.scale > 0)
            {
                if (_SafeStr_4273 == 0)
                {
                    _SafeStr_4273 = _arg_1.scale;
                }
                else
                {
                    _SafeStr_4272 = (_arg_1.scale / _SafeStr_4273);
                };
            };
            if (_arg_1.positionDelta != null)
            {
                _cameraOffset.x = (_cameraOffset.x + (_arg_1.positionDelta.x / _SafeStr_4272));
                _cameraOffset.y = (_cameraOffset.y + (_arg_1.positionDelta.y / _SafeStr_4272));
            };
            if (_arg_1.rect != null)
            {
                if (_historyViewer == null)
                {
                    return;
                };
                _mainWindow.width = _local_2.width;
                _mainWindow.height = (_SafeStr_4262 + _historyViewer.pulldownBarHeight);
                _SafeStr_4263.width = (_mainWindow.width - _historyViewer.scrollbarWidth);
                _SafeStr_4263.height = _SafeStr_4262;
                _SafeStr_4263.x = _mainWindow.x;
                _SafeStr_4263.y = _mainWindow.y;
                _SafeStr_4264.width = (_mainWindow.width - _historyViewer.scrollbarWidth);
                _SafeStr_4264.height = _SafeStr_4262;
                if (historyViewerActive())
                {
                    reAlignItemsToHistoryContent();
                };
                _historyViewer.containerResized(_mainWindow.rectangle, true);
            };
            alignItems();
        }

        private function processBuffer():void
        {
            if (_SafeStr_1388)
            {
                return;
            };
            if (_SafeStr_4268.length == 0)
            {
                return;
            };
            while (((_SafeStr_4268.length > 1) || ((historyViewerActive()) && (_SafeStr_4268.length > 0))))
            {
                activateItemFromBuffer();
            };
            var _local_1:Boolean;
            if (_itemList.length == 0)
            {
                _local_1 = true;
            }
            else
            {
                _local_1 = checkLastItemAllowsAdding(_SafeStr_4268[0]);
            };
            if (_local_1)
            {
                activateItemFromBuffer();
                _timeoutTime = (getTimer() + 4000);
            }
            else
            {
                if (((_itemList.length > 0) && (_SafeStr_4268.length > 0)))
                {
                    _SafeStr_4276 = getItemSpacing(_itemList[(_itemList.length - 1)], _SafeStr_4268[0]);
                }
                else
                {
                    _SafeStr_4276 = 19;
                };
                animationStart();
            };
        }

        private function activateItemFromBuffer():void
        {
            var _local_2:RoomChatItem;
            var _local_3:IWindowContainer;
            var _local_1:int;
            if (_SafeStr_4268.length == 0)
            {
                return;
            };
            if (historyViewerMinimized())
            {
                resetArea();
                hideHistoryViewer();
            };
            if (!checkLastItemAllowsAdding(_SafeStr_4268[0]))
            {
                selectItemsToMove();
                moveItemsUp(getItemSpacing(_itemList[(_itemList.length - 1)], _SafeStr_4268[0]));
                if (!checkLastItemAllowsAdding(_SafeStr_4268[0]))
                {
                    _SafeStr_4264.height = (_SafeStr_4264.height + 19);
                    if (_historyViewer != null)
                    {
                        _historyViewer.containerResized(_mainWindow.rectangle);
                    };
                };
            };
            _local_2 = _SafeStr_4268.shift();
            if (_local_2 != null)
            {
                _local_2.renderView();
                _local_3 = _local_2.view;
                if (_local_3 != null)
                {
                    _SafeStr_4264.addChild(_local_3);
                    _local_2.timeStamp = new Date().time;
                    _itemList.push(_local_2);
                    _local_1 = 0;
                    if (_itemList.length > 1)
                    {
                        _local_1 = _itemList[(_itemList.length - 2)].screenLevel;
                        if (historyViewerActive())
                        {
                            _local_2.screenLevel = (_local_1 + 1);
                        }
                        else
                        {
                            _local_2.screenLevel = (_local_1 + Math.max(_SafeStr_4271, 1));
                        };
                    }
                    else
                    {
                        _local_2.screenLevel = 100;
                    };
                    _local_2.aboveLevels = _SafeStr_4271;
                    if (_local_2.aboveLevels > ((_maxFastLevels + 0) + 2))
                    {
                        _local_2.aboveLevels = ((_maxFastLevels + 0) + 2);
                    };
                    _SafeStr_4271 = 0;
                    setChatItemLocHorizontal(_local_2);
                    setChatItemLocVertical(_local_2);
                    setChatItemRenderable(_local_2);
                };
            };
        }

        private function checkLastItemAllowsAdding(_arg_1:RoomChatItem):Boolean
        {
            if (_itemList.length == 0)
            {
                return (true);
            };
            var _local_2:RoomChatItem = _itemList[(_itemList.length - 1)];
            if (((_arg_1 == null) || (_local_2 == null)))
            {
                return (false);
            };
            if (_local_2.view == null)
            {
                return (true);
            };
            if (((_SafeStr_4264.bottom - ((_SafeStr_4264.y + _local_2.y) + _local_2.height)) - 23) <= getItemSpacing(_local_2, _arg_1))
            {
                return (false);
            };
            return (true);
        }

        public function alignItems():void
        {
            var _local_3:int;
            var _local_1:RoomChatItem;
            if (_historyViewer == null)
            {
                return;
            };
            _local_3 = (_itemList.length - 1);
            while (_local_3 >= 0)
            {
                _local_1 = _itemList[_local_3];
                if (_local_1 != null)
                {
                    setChatItemLocHorizontal(_local_1);
                    setChatItemLocVertical(_local_1);
                };
                _local_3--;
            };
            _local_3 = 0;
            while (_local_3 < _itemList.length)
            {
                _local_1 = _itemList[_local_3];
                if (_local_1 != null)
                {
                    setChatItemRenderable(_local_1);
                };
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < _SafeStr_4268.length)
            {
                _local_1 = _SafeStr_4268[_local_3];
                if (_local_1 != null)
                {
                    setChatItemLocHorizontal(_local_1);
                };
                _local_3++;
            };
        }

        private function animationStart():void
        {
            if (_SafeStr_1388)
            {
                return;
            };
            selectItemsToMove();
            _SafeStr_1388 = true;
        }

        private function animationStop():void
        {
            _SafeStr_1388 = false;
        }

        private function selectItemsToMove():void
        {
            var _local_3:int;
            var _local_1:RoomChatItem;
            if (_SafeStr_1388)
            {
                return;
            };
            purgeItems();
            _movingItems = [];
            var _local_2:int = new Date().time;
            var _local_4:int;
            if (_itemList.length == 0)
            {
                _SafeStr_4271 = 1;
                return;
            };
            if (historyViewerActive())
            {
                return;
            };
            _SafeStr_4271++;
            _local_3 = (_itemList.length - 1);
            while (_local_3 >= 0)
            {
                _local_1 = _itemList[_local_3];
                if (_local_1.view != null)
                {
                    if ((((_local_1.screenLevel > 0) || (_local_1.screenLevel == (_local_4 - 1))) || ((_local_2 - _local_1.timeStamp) >= 6000)))
                    {
                        _local_1.timeStamp = _local_2;
                        _local_4 = _local_1.screenLevel;
                        _local_1.screenLevel--;
                        _movingItems.push(_local_1);
                    };
                };
                _local_3--;
            };
        }

        private function moveItemsUp(_arg_1:int):void
        {
            var _local_2:Boolean;
            var _local_5:int;
            if (_movingItems == null)
            {
                return;
            };
            if (_movingItems.length == 0)
            {
                return;
            };
            var _local_3:RoomChatItem;
            var _local_4:int = -1;
            _local_5 = (_movingItems.length - 1);
            while (_local_5 >= 0)
            {
                _local_3 = _movingItems[_local_5];
                if (_local_3 != null)
                {
                    if (_local_4 == -1)
                    {
                        _local_4 = _itemList.indexOf(_local_3);
                    }
                    else
                    {
                        _local_4++;
                    };
                    _local_2 = true;
                    if (historyViewerActive())
                    {
                        if (((_local_3.y - _arg_1) + _local_3.height) < 0)
                        {
                            _local_2 = false;
                        };
                    };
                    if (_local_4 > 0)
                    {
                        if (_itemList[(_local_4 - 1)].view != null)
                        {
                            if (((_local_3.y - _arg_1) - _itemList[(_local_4 - 1)].y) < getItemSpacing(_itemList[(_local_4 - 1)], _local_3))
                            {
                                _local_2 = false;
                            };
                        };
                    };
                    if (_local_2)
                    {
                        _local_3.y = (_local_3.y - _arg_1);
                    };
                };
                _local_5--;
            };
        }

        private function setChatItemLocHorizontal(_arg_1:RoomChatItem):void
        {
            var _local_4:Number;
            var _local_5:Number;
            if (((_arg_1 == null) || (_historyViewer == null)))
            {
                return;
            };
            var _local_2:Number = ((_arg_1.senderX + _cameraOffset.x) * _SafeStr_4272);
            var _local_3:Number = (_local_2 - (_arg_1.width / 2));
            var _local_8:Number = (_local_3 + _arg_1.width);
            var _local_7:Number = (((-(_mainWindow.width) / 2) - 20) + _SafeStr_4277);
            var _local_6:Number = ((((_mainWindow.width / 2) + 20) - _historyViewer.scrollbarWidth) - _SafeStr_4278);
            var _local_9:Boolean = ((_local_3 >= _local_7) && (_local_3 <= _local_6));
            var _local_10:Boolean = ((_local_8 >= _local_7) && (_local_8 <= _local_6));
            if (((_local_9) && (_local_10)))
            {
                _local_4 = _local_3;
                _local_5 = _local_4;
            }
            else
            {
                if (_local_2 >= 0)
                {
                    _local_4 = (_local_6 - _arg_1.width);
                }
                else
                {
                    _local_4 = _local_7;
                };
            };
            _arg_1.x = ((_local_4 + (_mainWindow.width / 2)) + _mainWindow.x);
            if (((_local_2 < _local_7) || (_local_2 > _local_6)))
            {
                _arg_1.hidePointer();
            }
            else
            {
                _arg_1.setPointerOffset((_local_3 - _local_4));
            };
        }

        private function setChatItemLocVertical(_arg_1:RoomChatItem):void
        {
            var _local_2:int;
            var _local_4:Number;
            var _local_3:Number;
            if (_arg_1 != null)
            {
                _local_2 = _itemList.indexOf(_arg_1);
                _local_4 = ((historyViewerActive()) ? 0 : _SafeStr_4271);
                if (_local_2 == (_itemList.length - 1))
                {
                    _arg_1.y = ((getAreaBottom() - ((_local_4 + 1) * 19)) - 23);
                }
                else
                {
                    _local_3 = _itemList[(_local_2 + 1)].aboveLevels;
                    if (_local_3 < 2)
                    {
                        _arg_1.y = (_itemList[(_local_2 + 1)].y - getItemSpacing(_arg_1, _itemList[(_local_2 + 1)]));
                    }
                    else
                    {
                        _arg_1.y = (_itemList[(_local_2 + 1)].y - (_local_3 * 19));
                    };
                };
            };
        }

        private function setChatItemRenderable(_arg_1:RoomChatItem):void
        {
            if (_arg_1 != null)
            {
                if (_arg_1.y < -(32))
                {
                    if (_arg_1.view != null)
                    {
                        _SafeStr_4264.removeChild(_arg_1.view);
                        _arg_1.hideView();
                    };
                }
                else
                {
                    if (_arg_1.view == null)
                    {
                        _arg_1.renderView();
                        if (_arg_1.view != null)
                        {
                            _SafeStr_4264.addChild(_arg_1.view);
                        };
                    };
                };
            };
        }

        public function getTotalContentHeight():int
        {
            var _local_1:RoomChatItem;
            var _local_3:int;
            var _local_2:int;
            _local_3 = 0;
            while (_local_3 < _itemList.length)
            {
                _local_1 = _itemList[_local_3];
                if (_local_1 != null)
                {
                    if (_local_3 == 0)
                    {
                        _local_2 = (_local_2 + 19);
                    }
                    else
                    {
                        _local_2 = (_local_2 + getItemSpacing(_itemList[(_local_3 - 1)], _local_1));
                    };
                    _local_2 = (_local_2 + ((_local_1.aboveLevels - 1) * 19));
                };
                _local_3++;
            };
            return (_local_2);
        }

        private function getAreaBottom():Number
        {
            if (historyViewerActive())
            {
                return (_SafeStr_4264.height);
            };
            return (_SafeStr_4262 + _mainWindow.y);
        }

        private function getItemSpacing(_arg_1:RoomChatItem, _arg_2:RoomChatItem):Number
        {
            var _local_3:int = chatBubbleFactory.getActualBubbleHeight(_arg_1.chatStyle);
            if (_arg_1.checkOverlap(_local_3, _arg_2.x, _arg_1.y, _arg_2.width, _arg_2.height))
            {
                return (19);
            };
            return (10);
        }

        private function purgeItems():void
        {
            var _local_1:RoomChatItem;
            if (historyViewerActive())
            {
                return;
            };
            var _local_3:int;
            var _local_4:int;
            while (_itemList.length > _SafeStr_4275)
            {
                _local_1 = _itemList.shift();
                _local_4 = _movingItems.indexOf(_local_1);
                if (_local_4 > -1)
                {
                    _movingItems.splice(_local_4, 1);
                };
                if (_local_1.view != null)
                {
                    _SafeStr_4264.removeChild(_local_1.view);
                    _local_1.hideView();
                };
                _local_1.dispose();
                _local_1 = null;
            };
            var _local_2:Boolean;
            _local_3 = 0;
            while (_local_3 < _itemList.length)
            {
                _local_1 = _itemList[_local_3];
                if (_local_1 != null)
                {
                    if (_local_1.y <= -(32))
                    {
                        _local_1.aboveLevels = 1;
                        if (_local_1.view != null)
                        {
                            _local_4 = _movingItems.indexOf(_local_1);
                            if (_local_4 > -1)
                            {
                                _movingItems.splice(_local_4, 1);
                            };
                            _SafeStr_4264.removeChild(_local_1.view);
                            _local_1.hideView();
                        };
                    }
                    else
                    {
                        _local_2 = true;
                        break;
                    };
                };
                _local_3++;
            };
            if (_SafeStr_4268.length > 0)
            {
                _local_2 = true;
            };
            if ((((getTotalContentHeight() > 19) && (!(_local_2))) && (!(historyViewerActive()))))
            {
                if (_historyViewer != null)
                {
                    stretchAreaBottomTo(_mainWindow.y);
                    alignItems();
                    if (!historyViewerActive())
                    {
                        _historyViewer.showHistoryViewer();
                    };
                    if (!historyViewerVisible())
                    {
                        _historyViewer.visible = true;
                    };
                };
            }
            else
            {
                if (historyViewerVisible())
                {
                    _historyViewer.visible = false;
                };
            };
        }

        private function getFreeItemId():String
        {
            return ((("chat_" + _SafeStr_4269.toString()) + "_item_") + _SafeStr_4270++.toString());
        }

        public function onItemMouseClick(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:WindowMouseEvent):void
        {
            if (_arg_5.shiftKey)
            {
                if (_historyViewer != null)
                {
                    _historyViewer.toggleHistoryViewer();
                };
                return;
            };
            var _local_7:RoomWidgetRoomObjectMessage = new RoomWidgetRoomObjectMessage("RWROM_GET_OBJECT_INFO", _arg_1, _arg_3);
            messageListener.processWidgetMessage(_local_7);
            var _local_6:RoomWidgetChatSelectAvatarMessage = new RoomWidgetChatSelectAvatarMessage("RWCSAM_MESSAGE_SELECT_AVATAR", _arg_1, _arg_2, _arg_4);
            messageListener.processWidgetMessage(_local_6);
        }

        public function onItemMouseDown(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:WindowMouseEvent):void
        {
            if (historyViewerVisible())
            {
                return;
            };
            if (_historyViewer != null)
            {
                _historyViewer.beginDrag(_arg_4.stageY, true);
            };
        }

        public function onItemMouseOver(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:WindowMouseEvent):void
        {
        }

        public function onItemMouseOut(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:WindowMouseEvent):void
        {
        }

        public function onPulldownMouseDown(_arg_1:WindowMouseEvent):void
        {
            if (_historyViewer != null)
            {
                _historyViewer.beginDrag(_arg_1.stageY, true);
            };
        }

        public function onPulldownCloseButtonClicked(_arg_1:WindowMouseEvent):void
        {
            if (_historyViewer != null)
            {
                _historyViewer.hideHistoryViewer();
            };
        }

        public function stretchAreaBottomBy(_arg_1:Number):void
        {
            var _local_2:Number = ((_mainWindow.bottom + _arg_1) - 39);
            stretchAreaBottomTo(_local_2);
        }

        public function stretchAreaBottomTo(_arg_1:Number):void
        {
            var _local_2:int = ((_mainWindow.context.getDesktopWindow().height - 39) - 40);
            _arg_1 = Math.min(_arg_1, _local_2);
            _SafeStr_4262 = (_arg_1 - _mainWindow.y);
            _mainWindow.height = (_SafeStr_4262 + 39);
            if (_historyViewer != null)
            {
                _historyViewer.containerResized(_mainWindow.rectangle);
            };
        }

        public function resetArea(_arg_1:Boolean=true):void
        {
            if (_historyViewer == null)
            {
                return;
            };
            animationStop();
            _SafeStr_4262 = (_SafeStr_4261 + 23);
            _mainWindow.height = (_SafeStr_4262 + _historyViewer.pulldownBarHeight);
            _SafeStr_4263.width = (_mainWindow.width - _historyViewer.scrollbarWidth);
            _SafeStr_4263.height = _SafeStr_4262;
            _SafeStr_4264.width = (_mainWindow.width - _historyViewer.scrollbarWidth);
            if (historyViewerActive())
            {
                _SafeStr_4264.height = (getTotalContentHeight() + 23);
            }
            else
            {
                _SafeStr_4264.height = _SafeStr_4262;
            };
            _SafeStr_4263.scrollV = 1;
            if (!historyViewerActive())
            {
                _historyViewer.containerResized(_mainWindow.rectangle);
            };
            purgeItems();
            if (((historyViewerActive()) || (_arg_1)))
            {
                alignItems();
            };
        }

        private function historyViewerActive():Boolean
        {
            return ((_historyViewer == null) ? false : _historyViewer.active);
        }

        private function historyViewerVisible():Boolean
        {
            return ((_historyViewer == null) ? false : _historyViewer.visible);
        }

        public function hideHistoryViewer():void
        {
            if (_historyViewer != null)
            {
                _historyViewer.hideHistoryViewer();
            };
        }

        private function historyViewerMinimized():Boolean
        {
            return (_SafeStr_4263.height <= 1);
        }

        public function resizeContainerToLowestItem():void
        {
            var _local_3:int;
            var _local_1:RoomChatItem;
            var _local_4:int;
            _local_3 = 0;
            while (_local_3 < _itemList.length)
            {
                _local_1 = _itemList[_local_3];
                if (_local_1.y > _local_4)
                {
                    _local_4 = _local_1.y;
                };
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < _SafeStr_4268.length)
            {
                _local_1 = _SafeStr_4268[_local_3];
                if (_local_1.y > _local_4)
                {
                    _local_4 = _local_1.y;
                };
                _local_3++;
            };
            _local_4 = (_local_4 + 32);
            _local_4 = ((_local_4 < 0) ? 0 : _local_4);
            var _local_2:int = _mainWindow.bottom;
            stretchAreaBottomTo((_mainWindow.top + _local_4));
            _local_2 = (_local_2 - _mainWindow.bottom);
            if (Math.abs(_local_2) < 3)
            {
                resetArea();
                return;
            };
            _local_3 = 0;
            while (_local_3 < _itemList.length)
            {
                _local_1 = _itemList[_local_3];
                _local_1.y = (_local_1.y + _local_2);
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < _SafeStr_4268.length)
            {
                _local_1 = _SafeStr_4268[_local_3];
                _local_1.y = (_local_1.y + _local_2);
                _local_3++;
            };
            _SafeStr_4274 = true;
        }

        public function mouseUp():void
        {
            _SafeStr_4263.stopDragging();
            var _local_1:Number = (_mainWindow.bottom - 39);
            if (_local_1 < _SafeStr_4261)
            {
                if (_local_1 <= (_SafeStr_4262 + _mainWindow.y))
                {
                    if (historyViewerActive())
                    {
                        hideHistoryViewer();
                    };
                    resetArea();
                    return;
                };
            };
            if (((_SafeStr_4274) && (!(historyViewerActive()))))
            {
                resetArea();
                _SafeStr_4274 = false;
            };
        }

        public function reAlignItemsToHistoryContent():void
        {
            if (historyViewerActive())
            {
                _SafeStr_4264.height = (getTotalContentHeight() + 23);
                alignItems();
            };
        }

        public function enableDragTooltips():void
        {
            var _local_2:int;
            var _local_1:RoomChatItem;
            _local_2 = 0;
            while (_local_2 < _itemList.length)
            {
                _local_1 = _itemList[_local_2];
                _local_1.enableDragTooltip();
                _local_2++;
            };
            _local_2 = 0;
            while (_local_2 < _SafeStr_4268.length)
            {
                _local_1 = _SafeStr_4268[_local_2];
                _local_1.enableDragTooltip();
                _local_2++;
            };
        }

        public function disableDragTooltips():void
        {
            var _local_2:int;
            var _local_1:RoomChatItem;
            _local_2 = 0;
            while (_local_2 < _itemList.length)
            {
                _local_1 = _itemList[_local_2];
                _local_1.disableDragTooltip();
                _local_2++;
            };
            _local_2 = 0;
            while (_local_2 < _SafeStr_4268.length)
            {
                _local_1 = _SafeStr_4268[_local_2];
                _local_1.disableDragTooltip();
                _local_2++;
            };
        }

        public function get isGameSession():Boolean
        {
            return (handler.container.roomSession.isGameSession);
        }

        public function removeItem(_arg_1:RoomChatItem):void
        {
            var _local_2:int;
            _local_2 = _itemList.indexOf(_arg_1);
            if (_local_2 > -1)
            {
                _itemList.splice(_local_2, 1);
            };
            _local_2 = _movingItems.indexOf(_arg_1);
            if (_local_2 > -1)
            {
                _movingItems.splice(_local_2, 1);
            };
            if (_arg_1.view != null)
            {
                _SafeStr_4264.removeChild(_arg_1.view);
                _arg_1.hideView();
            };
            _arg_1.dispose();
            resetArea(false);
        }


    }
}

