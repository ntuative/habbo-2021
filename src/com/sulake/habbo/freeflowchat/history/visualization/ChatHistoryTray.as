package com.sulake.habbo.freeflowchat.history.visualization
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IUpdateReceiver;
    import flash.display.DisplayObjectContainer;
    import flash.display.Stage;
    import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
    import flash.display.Sprite;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.events.Event;
    import flash.events.MouseEvent;

    public class ChatHistoryTray implements IDisposable, IUpdateReceiver 
    {

        private var _rootDisplayObject:DisplayObjectContainer;
        private var _SafeStr_660:Stage;
        private var _SafeStr_659:HabboFreeFlowChat;
        private var _SafeStr_2179:ChatHistoryScrollView;
        private var _tab:Sprite;
        private var _SafeStr_2181:Bitmap;
        private var _SafeStr_2182:Bitmap;
        private var _bg:Bitmap;
        private var _openedWidth:int;
        private var _flagUpdateDisableRoomMouseEvents:Boolean = false;

        public function ChatHistoryTray(_arg_1:HabboFreeFlowChat, _arg_2:ChatHistoryScrollView)
        {
            _SafeStr_659 = _arg_1;
            _SafeStr_2179 = _arg_2;
            _rootDisplayObject = new Sprite();
            _SafeStr_2181 = new Bitmap();
            _SafeStr_2181.bitmapData = BitmapData(_SafeStr_659.assets.getAssetByName("tray_bar").content);
            _SafeStr_2181.width = _SafeStr_2181.bitmapData.width;
            _SafeStr_2181.height = 0;
            _SafeStr_2181.scaleX = 1;
            _SafeStr_2181.x = -(_SafeStr_2181.bitmapData.width);
            _SafeStr_2182 = new Bitmap();
            _SafeStr_2182.bitmapData = BitmapData(_SafeStr_659.assets.getAssetByName("tray_handle_open").content);
            _SafeStr_2182.scaleX = 1;
            _SafeStr_2182.scaleY = 1;
            _SafeStr_2182.x = -(0);
            _SafeStr_2182.y = 350;
            _SafeStr_2182.visible = false;
            _tab = new Sprite();
            _tab.scaleX = 1;
            _tab.scaleY = 1;
            _tab.visible = true;
            _tab.addChild(_SafeStr_2181);
            _tab.addChild(_SafeStr_2182);
            _rootDisplayObject.addChild(_tab);
            _bg = new Bitmap();
            _bg.bitmapData = new BitmapData(1, 1, true, 2720277278);
            _bg.width = 0;
            _bg.height = 0;
            _rootDisplayObject.addChild(_bg);
            _rootDisplayObject.addEventListener("addedToStage", onAddedToStage);
            _openedWidth = ((350 + 62) + 1);
        }

        public function dispose():void
        {
            _SafeStr_659.disableRoomMouseEventsLeftOfX(0);
            if (_rootDisplayObject)
            {
                _SafeStr_2179.deactivateScrolling();
                if (_SafeStr_660)
                {
                    _SafeStr_660.removeEventListener("mouseDown", stageMouseClickedEventHandler);
                };
            };
            _rootDisplayObject = null;
        }

        public function get disposed():Boolean
        {
            return (_rootDisplayObject == null);
        }

        public function get rootDisplayObject():DisplayObjectContainer
        {
            return (_rootDisplayObject);
        }

        public function resize(_arg_1:int, _arg_2:int):void
        {
            _tab.height = (_arg_2 - 50);
            _SafeStr_2181.height = (_arg_2 - 50);
            _bg.height = (_arg_2 - 50);
            _tab.scaleY = 1;
            _SafeStr_2182.scaleY = 1;
            _SafeStr_2182.y = (_arg_2 - 215);
        }

        private function onAddedToStage(_arg_1:Event):void
        {
            resize(_rootDisplayObject.stage.stageWidth, _rootDisplayObject.stage.stageHeight);
            _rootDisplayObject.stage.addEventListener("click", stageMouseClickedEventHandler);
            _SafeStr_660 = _rootDisplayObject.stage;
        }

        public function toggleHistoryVisibility():void
        {
            if (_SafeStr_2179.isActive)
            {
                _SafeStr_2179.deactivateScrolling();
                _rootDisplayObject.removeChild(_SafeStr_2179.rootDisplayObject);
                _SafeStr_2179.deactivateView();
                _bg.width = 0;
                _SafeStr_2181.x = -(_SafeStr_2181.bitmapData.width);
                _SafeStr_2182.x = -(0);
                _SafeStr_2182.visible = false;
                _SafeStr_2179.viewWidth = 0;
                _SafeStr_2182.bitmapData = BitmapData(_SafeStr_659.assets.getAssetByName("tray_handle_open").content);
            }
            else
            {
                _rootDisplayObject.addChild(_SafeStr_2179.rootDisplayObject);
                _SafeStr_2179.scrollToBottom();
                _SafeStr_2179.activateScrolling();
                _SafeStr_2179.activateView();
                _bg.width = _openedWidth;
                _SafeStr_2181.x = _openedWidth;
                _SafeStr_2182.visible = true;
                _SafeStr_2182.x = ((_openedWidth - 0) + _SafeStr_2181.bitmapData.width);
                _SafeStr_2179.viewWidth = _openedWidth;
                _SafeStr_2182.bitmapData = BitmapData(_SafeStr_659.assets.getAssetByName("tray_handle_close").content);
            };
            _flagUpdateDisableRoomMouseEvents = true;
        }

        private function stageMouseClickedEventHandler(_arg_1:Event):void
        {
            if (((!(_rootDisplayObject)) || (!(_rootDisplayObject.stage))))
            {
                return;
            };
            var _local_2:MouseEvent = MouseEvent(_arg_1);
            if ((((((_SafeStr_2179.isActive) && (_SafeStr_2182.x <= _local_2.stageX)) && (_local_2.stageX <= (_SafeStr_2182.x + _SafeStr_2182.width))) && (_SafeStr_2182.y <= _local_2.stageY)) && (_local_2.stageY <= (_SafeStr_2182.y + _SafeStr_2182.height))))
            {
                toggleHistoryVisibility();
            };
        }

        public function update(_arg_1:uint):void
        {
            if (((_flagUpdateDisableRoomMouseEvents) && (_arg_1 > 20)))
            {
                _SafeStr_659.disableRoomMouseEventsLeftOfX(((_SafeStr_2179.isActive) ? (_openedWidth + _SafeStr_2181.bitmapData.width) : 0));
                _flagUpdateDisableRoomMouseEvents = false;
            };
        }


    }
}

