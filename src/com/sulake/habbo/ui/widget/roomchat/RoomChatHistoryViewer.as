package com.sulake.habbo.ui.widget.roomchat
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.IScrollableWindow;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.display.DisplayObject;
    import flash.display.Stage;
    import flash.events.MouseEvent;

    public class RoomChatHistoryViewer implements IDisposable 
    {

        private static const CHAT_ITEM_HEIGHT:int = 18;
        private static const SCROLLBAR_WIDTH:int = 20;
        public static const MOUSE_HYSTERESIS_TOLERANCE:int = 3;

        private var _historyPulldown:RoomChatHistoryPulldown;
        private var _active:Boolean = false;
        private var _historyViewerDragStartY:Number = -1;
        private var _SafeStr_4246:IScrollbarWindow;
        private var _SafeStr_4247:Number = 1;
        private var _SafeStr_4248:Boolean = false;
        private var _SafeStr_1324:RoomChatWidget;
        private var _disposed:Boolean = false;
        private var _SafeStr_4249:Boolean = false;
        private var _SafeStr_4250:Boolean = false;

        public function RoomChatHistoryViewer(_arg_1:RoomChatWidget, _arg_2:IHabboWindowManager, _arg_3:IWindowContainer, _arg_4:IAssetLibrary)
        {
            _disposed = false;
            _SafeStr_1324 = _arg_1;
            _historyPulldown = new RoomChatHistoryPulldown(_arg_1, _arg_2, _arg_3, _arg_4);
            _historyPulldown.state = 0;
            var _local_5:IItemListWindow = (_arg_3.getChildByName("chat_contentlist") as IItemListWindow);
            if (_local_5 == null)
            {
                return;
            };
            _arg_3.removeChild(_local_5);
            _arg_3.addChild(_local_5);
            _SafeStr_4246 = (_arg_2.createWindow("chatscroller", "", 131, 0, (0x10 | 0x00), new Rectangle((_arg_3.right - 20), _arg_3.y, 20, (_arg_3.height - 39)), null, 0) as IScrollbarWindow);
            _arg_3.addChild(_SafeStr_4246);
            _SafeStr_4246.visible = false;
            _SafeStr_4246.scrollable = (_local_5 as IScrollableWindow);
        }

        public function set disabled(_arg_1:Boolean):void
        {
            _SafeStr_4248 = _arg_1;
        }

        public function set visible(_arg_1:Boolean):void
        {
            if (((_historyPulldown == null) || (_SafeStr_4248)))
            {
                return;
            };
            _historyPulldown.state = ((_arg_1) ? 1 : 0);
        }

        public function get active():Boolean
        {
            return (_active);
        }

        public function get scrollbarWidth():Number
        {
            return ((_active) ? 20 : 0);
        }

        public function get pulldownBarHeight():Number
        {
            return (39);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get visible():Boolean
        {
            if (_historyPulldown == null)
            {
                return (false);
            };
            return ((_historyPulldown.state == 1) || (_historyPulldown.state == 2));
        }

        public function dispose():void
        {
            hideHistoryViewer();
            if (_SafeStr_4246 != null)
            {
                _SafeStr_4246.dispose();
                _SafeStr_4246 = null;
            };
            if (_historyPulldown != null)
            {
                _historyPulldown.dispose();
                _historyPulldown = null;
            };
            _disposed = true;
        }

        public function update(_arg_1:uint):void
        {
            if (_historyPulldown != null)
            {
                _historyPulldown.update(_arg_1);
            };
            moveHistoryScroll();
        }

        public function toggleHistoryViewer():void
        {
            if (_active)
            {
                hideHistoryViewer();
            }
            else
            {
                showHistoryViewer();
            };
        }

        public function hideHistoryViewer():void
        {
            _SafeStr_4247 = 1;
            cancelDrag();
            _active = false;
            setHistoryViewerScrollbar(false);
            _historyPulldown.state = 0;
            if (_SafeStr_1324 != null)
            {
                _SafeStr_1324.resetArea();
                _SafeStr_1324.enableDragTooltips();
                _SafeStr_1324.handler.container.toolbar.extensionView.extraMargin = 0;
            };
        }

        public function showHistoryViewer():void
        {
            var _local_3:int;
            if (((!(_active)) && (!(_SafeStr_4248))))
            {
                _active = true;
                setHistoryViewerScrollbar(true);
                _historyPulldown.state = 1;
                if (_SafeStr_1324 != null)
                {
                    _SafeStr_1324.reAlignItemsToHistoryContent();
                    _SafeStr_1324.disableDragTooltips();
                };
            };
        }

        private function setHistoryViewerScrollbar(_arg_1:Boolean):void
        {
            if (_SafeStr_4246 != null)
            {
                _SafeStr_4246.visible = _arg_1;
                if (_arg_1)
                {
                    _SafeStr_4246.scrollV = 1;
                    _SafeStr_4247 = 1;
                }
                else
                {
                    _active = false;
                    _historyViewerDragStartY = -1;
                };
            };
        }

        public function containerResized(_arg_1:Rectangle, _arg_2:Boolean=false):void
        {
            if (_SafeStr_4246 != null)
            {
                _SafeStr_4246.x = ((_arg_1.x + _arg_1.width) - _SafeStr_4246.width);
                _SafeStr_4246.y = _arg_1.y;
                _SafeStr_4246.height = (_arg_1.height - 39);
                if (_arg_2)
                {
                    _SafeStr_4246.scrollV = _SafeStr_4247;
                };
            };
            if (_historyPulldown != null)
            {
                _historyPulldown.containerResized(_arg_1);
            };
        }

        private function processDrag(_arg_1:Number, _arg_2:Boolean=false):void
        {
            var _local_8:Number;
            var _local_4:Number;
            var _local_5:Number;
            var _local_3:int;
            var _local_6:Boolean;
            var _local_7:Boolean;
            if (((_historyViewerDragStartY > 0) && (_arg_2)))
            {
                if (_SafeStr_4250)
                {
                    if (Math.abs((_arg_1 - _historyViewerDragStartY)) > 3)
                    {
                        _SafeStr_4250 = false;
                    }
                    else
                    {
                        return;
                    };
                };
                if (!_active)
                {
                    _SafeStr_1324.resizeContainerToLowestItem();
                    showHistoryViewer();
                    moveHistoryScroll();
                };
                if (_active)
                {
                    _SafeStr_1324.handler.container.toolbar.extensionView.extraMargin = 20;
                    moveHistoryScroll();
                    _local_4 = (_SafeStr_4246.scrollable.scrollableRegion.height / _SafeStr_4246.scrollable.visibleRegion.height);
                    _local_5 = ((_arg_1 - _historyViewerDragStartY) / _SafeStr_4246.height);
                    _local_8 = (_SafeStr_4247 - (_local_5 / _local_4));
                    _local_8 = Math.max(0, _local_8);
                    _local_8 = Math.min(1, _local_8);
                    _local_3 = (_arg_1 - _historyViewerDragStartY);
                    _local_6 = true;
                    _local_7 = true;
                    if (_SafeStr_4246.scrollV < (1 - (18 / _SafeStr_4246.scrollable.scrollableRegion.height)))
                    {
                        _local_7 = false;
                    };
                    if (((_local_7) || (_SafeStr_4249)))
                    {
                        _SafeStr_1324.stretchAreaBottomBy(_local_3);
                        _local_6 = false;
                        _SafeStr_4247 = 1;
                        _SafeStr_4246.scrollV = 1;
                    };
                    if (_local_6)
                    {
                        _SafeStr_4247 = _local_8;
                    };
                    _historyViewerDragStartY = _arg_1;
                };
            }
            else
            {
                _historyViewerDragStartY = -1;
            };
        }

        public function beginDrag(_arg_1:Number, _arg_2:Boolean=false):void
        {
            var _local_3:DisplayObject;
            var _local_4:Stage;
            if (_SafeStr_4248)
            {
                return;
            };
            _historyViewerDragStartY = _arg_1;
            _SafeStr_4249 = _arg_2;
            _SafeStr_4250 = true;
            if (_SafeStr_4246 != null)
            {
                _SafeStr_4247 = _SafeStr_4246.scrollV;
            };
            if (_SafeStr_4246 != null)
            {
                _local_3 = _SafeStr_4246.context.getDesktopWindow().getDisplayObject();
                if (_local_3 != null)
                {
                    _local_4 = _local_3.stage;
                    if (_local_4 != null)
                    {
                        _local_4.addEventListener("mouseMove", onStageMouseMove);
                        _local_4.addEventListener("mouseUp", onStageMouseUp);
                    };
                };
            };
        }

        public function cancelDrag():void
        {
            var _local_1:DisplayObject;
            var _local_2:Stage;
            _historyViewerDragStartY = -1;
            if (_SafeStr_4246 != null)
            {
                _local_1 = _SafeStr_4246.context.getDesktopWindow().getDisplayObject();
                if (_local_1 != null)
                {
                    _local_2 = _local_1.stage;
                    if (_local_2 != null)
                    {
                        _local_2.removeEventListener("mouseMove", onStageMouseMove);
                        _local_2.removeEventListener("mouseUp", onStageMouseUp);
                    };
                };
            };
        }

        private function moveHistoryScroll():void
        {
            if (!_active)
            {
                return;
            };
            if (_historyViewerDragStartY < 0)
            {
                return;
            };
            if (_SafeStr_4249)
            {
                return;
            };
            var _local_1:Number = (_SafeStr_4247 - _SafeStr_4246.scrollV);
            if (_local_1 == 0)
            {
                return;
            };
            if (Math.abs(_local_1) < 0.01)
            {
                _SafeStr_4246.scrollV = _SafeStr_4247;
            }
            else
            {
                _SafeStr_4246.scrollV = (_SafeStr_4246.scrollV + (_local_1 / 2));
            };
        }

        private function onStageMouseUp(_arg_1:MouseEvent):void
        {
            cancelDrag();
            if (_SafeStr_1324 != null)
            {
                _SafeStr_1324.mouseUp();
            };
        }

        private function onStageMouseMove(_arg_1:MouseEvent):void
        {
            processDrag(_arg_1.stageY, _arg_1.buttonDown);
        }


    }
}

