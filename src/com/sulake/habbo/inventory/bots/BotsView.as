package com.sulake.habbo.inventory.bots
{
    import com.sulake.habbo.inventory.IInventoryView;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.communication.messages.parser.inventory.bots.BotData;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components._SafeStr_101;

    public class BotsView implements IInventoryView, IAvatarImageListener 
    {

        private const STATE_NULL:int = 0;
        private const STATE_INITIALIZING:int = 1;
        private const STATE_EMPTY:int = 2;
        private const STATE_CONTENT:int = 3;

        private var _windowManager:IHabboWindowManager;
        private var _SafeStr_1354:IAssetLibrary;
        private var _SafeStr_570:IWindowContainer;
        private var _SafeStr_1275:BotsModel;
        private var _disposed:Boolean = false;
        private var _SafeStr_1654:IItemGridWindow;
        private var _roomEngine:IRoomEngine;
        private var _avatarRenderer:IAvatarRenderManager;
        private var _gridItems:Map;
        private var _SafeStr_1563:BotGridItem;
        private var _SafeStr_2727:int = 0;
        private var _SafeStr_2728:int;
        private var _SafeStr_573:Boolean = false;

        public function BotsView(_arg_1:BotsModel, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IRoomEngine, _arg_5:IAvatarRenderManager)
        {
            _SafeStr_1275 = _arg_1;
            _SafeStr_1354 = _arg_3;
            _windowManager = _arg_2;
            _roomEngine = _arg_4;
            _avatarRenderer = _arg_5;
            _gridItems = new Map();
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get isVisible():Boolean
        {
            return (((_SafeStr_570) && (!(_SafeStr_570.parent == null))) && (_SafeStr_570.visible));
        }

        public function dispose():void
        {
            _windowManager = null;
            _avatarRenderer = null;
            _roomEngine = null;
            _SafeStr_1354 = null;
            _SafeStr_1275 = null;
            _SafeStr_570 = null;
            _disposed = true;
        }

        public function update():void
        {
            if (!_SafeStr_573)
            {
                return;
            };
            updateGrid();
            updatePreview(_SafeStr_1563);
            updateContainerVisibility();
        }

        public function removeItem(_arg_1:int):void
        {
            if (!_SafeStr_573)
            {
                return;
            };
            var _local_2:BotGridItem = (_gridItems.remove(_arg_1) as BotGridItem);
            if (_local_2 == null)
            {
                return;
            };
            _SafeStr_1654.removeGridItem(_local_2.window);
            if (_SafeStr_1563 == _local_2)
            {
                _SafeStr_1563 = null;
                selectFirst();
            };
        }

        public function addItem(_arg_1:BotData):void
        {
            if (!_SafeStr_573)
            {
                return;
            };
            if (_arg_1 == null)
            {
                return;
            };
            if (_gridItems.getValue(_arg_1.id) != null)
            {
                return;
            };
            var _local_2:BotGridItem = new BotGridItem(this, _arg_1, _windowManager, _SafeStr_1354, _SafeStr_1275.isUnseen(_arg_1.id));
            if (_local_2 != null)
            {
                _SafeStr_1654.addGridItem(_local_2.window);
                _gridItems.add(_arg_1.id, _local_2);
                if (_SafeStr_1563 == null)
                {
                    selectFirst();
                };
            };
        }

        public function placeItemToRoom(_arg_1:int, _arg_2:Boolean=false):void
        {
            _SafeStr_1275.placeItemToRoom(_arg_1, _arg_2);
        }

        public function getWindowContainer():IWindowContainer
        {
            if (!_SafeStr_573)
            {
                init();
            };
            if (_SafeStr_570 == null)
            {
                return (null);
            };
            if (_SafeStr_570.disposed)
            {
                return (null);
            };
            return (_SafeStr_570);
        }

        public function setSelectedGridItem(_arg_1:BotGridItem):void
        {
            if (!_SafeStr_573)
            {
                return;
            };
            if (_SafeStr_1563 != null)
            {
                _SafeStr_1563.setSelected(false);
            };
            _SafeStr_1563 = _arg_1;
            if (_SafeStr_1563 != null)
            {
                _SafeStr_1563.setSelected(true);
            };
            updatePreview(_arg_1);
        }

        public function updateState():void
        {
            var _local_1:int;
            if (!_SafeStr_573)
            {
                return;
            };
            var _local_2:Map = _SafeStr_1275.items;
            if (!_SafeStr_1275.isListInitialized())
            {
                _local_1 = 1;
            }
            else
            {
                if (((!(_local_2)) || (_local_2.length == 0)))
                {
                    _local_1 = 2;
                }
                else
                {
                    _local_1 = 3;
                };
            };
            if (_SafeStr_2727 == _local_1)
            {
                return;
            };
            _SafeStr_2727 = _local_1;
            updateContainerVisibility();
            if (_SafeStr_2727 == 3)
            {
                updateGrid();
                updatePreview();
            };
        }

        public function getGridItemImage(_arg_1:BotData):BitmapData
        {
            var _local_2:int = 3;
            return (getItemImage(_arg_1, _local_2, false, "h"));
        }

        public function getItemImage(_arg_1:BotData, _arg_2:int, _arg_3:Boolean, _arg_4:String):BitmapData
        {
            var _local_5:BitmapData;
            var _local_6:IAvatarImage = _avatarRenderer.createAvatarImage(_arg_1.figure, _arg_4, _arg_1.gender, this);
            _local_6.setDirection("full", _arg_2);
            if (_arg_3)
            {
                _local_5 = _local_6.getCroppedImage("full");
            }
            else
            {
                _local_5 = _local_6.getCroppedImage("head");
            };
            _local_6.dispose();
            return (_local_5);
        }

        public function avatarImageReady(_arg_1:String):void
        {
            if (disposed)
            {
                return;
            };
            for each (var _local_2:BotGridItem in _gridItems)
            {
                if (_local_2.data.figure == _arg_1)
                {
                    _local_2.setImage(getGridItemImage(_local_2.data));
                };
            };
        }

        private function selectFirst():void
        {
            if (((_gridItems == null) || (_gridItems.length == 0)))
            {
                updatePreview();
                return;
            };
            setSelectedGridItem(_gridItems.getWithIndex(0));
        }

        public function selectById(_arg_1:int):void
        {
            setSelectedGridItem(_gridItems.getValue(_arg_1));
        }

        private function updateGrid():void
        {
            var _local_4:int;
            var _local_3:BotGridItem;
            if (_SafeStr_570 == null)
            {
                return;
            };
            var _local_1:Array = _gridItems.getKeys();
            var _local_2:Array = ((_SafeStr_1275.items) ? _SafeStr_1275.items.getKeys() : []);
            _SafeStr_1654.lock();
            for each (_local_4 in _local_1)
            {
                if (_local_2.indexOf(_local_4) == -1)
                {
                    removeItem(_local_4);
                };
            };
            for each (_local_4 in _local_2)
            {
                if (_local_1.indexOf(_local_4) == -1)
                {
                    addItem(_SafeStr_1275.items.getValue(_local_4));
                };
                _local_3 = _gridItems.getValue(_local_4);
                _local_3.setUnseen(_SafeStr_1275.isUnseen(_local_4));
            };
            _SafeStr_1654.unlock();
        }

        private function startPlacingHandler(_arg_1:WindowMouseEvent):void
        {
            if (_SafeStr_1563 == null)
            {
                return;
            };
            var _local_2:BotData = _SafeStr_1563.data;
            if (_local_2 == null)
            {
                return;
            };
            placeItemToRoom(_local_2.id);
        }

        private function windowEventHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
        }

        private function updateContainerVisibility():void
        {
            if (_SafeStr_1275.controller.currentCategoryId != "bots")
            {
                return;
            };
            var _local_1:IWindowContainer = _SafeStr_1275.controller.view.loadingContainer;
            var _local_3:IWindowContainer = _SafeStr_1275.controller.view.emptyContainer;
            var _local_4:IWindow = _SafeStr_570.findChildByName("grid");
            var _local_2:IWindow = _SafeStr_570.findChildByName("preview_container");
            switch (_SafeStr_2727)
            {
                case 1:
                    if (_local_1)
                    {
                        _local_1.visible = true;
                    };
                    if (_local_3)
                    {
                        _local_3.visible = false;
                    };
                    _local_4.visible = false;
                    _local_2.visible = false;
                    return;
                case 2:
                    if (_local_1)
                    {
                        _local_1.visible = false;
                    };
                    if (_local_3)
                    {
                        _local_3.visible = true;
                    };
                    _local_4.visible = false;
                    _local_2.visible = false;
                    return;
                case 3:
                    if (_local_1)
                    {
                        _local_1.visible = false;
                    };
                    if (_local_3)
                    {
                        _local_3.visible = false;
                    };
                    _local_4.visible = true;
                    _local_2.visible = true;
                default:
            };
        }

        private function updatePreview(_arg_1:BotGridItem=null):void
        {
            var _local_3:BitmapData;
            var _local_11:String;
            var _local_13:String;
            var _local_10:Boolean;
            var _local_4:BotData;
            var _local_5:BitmapData = null;
            if (_SafeStr_570 == null)
            {
                return;
            };
            _SafeStr_2728 = -1;
            if (((_arg_1 == null) || (_arg_1.data == null)))
            {
                _local_3 = new BitmapData(1, 1);
                _local_11 = "";
                _local_13 = "";
                _local_10 = false;
            }
            else
            {
                _local_4 = _arg_1.data;
                _local_11 = _local_4.name;
                _local_13 = _local_4.motto;
                _local_3 = getItemImage(_local_4, 4, true, "h");
                _local_10 = true;
            };
            var _local_9:IBitmapWrapperWindow = (_SafeStr_570.findChildByName("preview_image") as IBitmapWrapperWindow);
            if (_local_9 != null)
            {
                _local_5 = new BitmapData(_local_9.width, _local_9.height);
                _local_5.fillRect(_local_5.rect, 0);
                _local_5.copyPixels(_local_3, _local_3.rect, new Point(((_local_5.width / 2) - (_local_3.width / 2)), ((_local_5.height / 2) - (_local_3.height / 2))));
                _local_9.bitmap = _local_5;
            };
            _local_3.dispose();
            var _local_6:ITextWindow = (_SafeStr_570.findChildByName("bot_name") as ITextWindow);
            if (_local_6 != null)
            {
                _local_6.caption = _local_11;
            };
            _local_6 = (_SafeStr_570.findChildByName("bot_description") as ITextWindow);
            if (_local_6 != null)
            {
                _local_6.caption = _local_13;
            };
            var _local_8:Boolean;
            var _local_12:Boolean;
            if (_SafeStr_1275.roomSession != null)
            {
                _local_8 = _SafeStr_1275.roomSession.areBotsAllowed;
                _local_12 = _SafeStr_1275.roomSession.isRoomOwner;
            };
            var _local_2:String = "";
            if (!_local_12)
            {
                if (_local_8)
                {
                    _local_2 = "${inventory.bots.allowed}";
                }
                else
                {
                    _local_2 = "${inventory.bots.forbidden}";
                };
            };
            _local_6 = (_SafeStr_570.findChildByName("preview_info") as ITextWindow);
            if (_local_6 != null)
            {
                _local_6.caption = _local_2;
            };
            var _local_7:_SafeStr_101 = (_SafeStr_570.findChildByName("place_button") as _SafeStr_101);
            if (_local_7 != null)
            {
                if (((_local_10) && ((_local_12) || (_local_8))))
                {
                    _local_7.enable();
                }
                else
                {
                    _local_7.disable();
                };
            };
        }

        private function addUnseenItemSymbols():void
        {
        }

        private function init():void
        {
            var _local_1:_SafeStr_101;
            _SafeStr_570 = _SafeStr_1275.controller.view.getView("bots");
            _SafeStr_570.visible = false;
            _SafeStr_570.procedure = windowEventHandler;
            addUnseenItemSymbols();
            _SafeStr_1654 = (_SafeStr_570.findChildByName("grid") as IItemGridWindow);
            _local_1 = (_SafeStr_570.findChildByName("place_button") as _SafeStr_101);
            if (_local_1 != null)
            {
                _local_1.addEventListener("WME_CLICK", startPlacingHandler);
            };
            var _local_2:IBitmapWrapperWindow = (_SafeStr_570.findChildByName("preview_image") as IBitmapWrapperWindow);
            if (_local_2 != null)
            {
                _local_2.addEventListener("WME_DOWN", startPlacingHandler);
            };
            updatePreview();
            updateState();
            selectFirst();
            _SafeStr_573 = true;
        }


    }
}

