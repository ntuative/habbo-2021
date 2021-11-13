package com.sulake.habbo.freeflowchat.history.visualization
{
    import flash.display.Sprite;
    import flash.display.Stage;
    import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
    import flash.geom.Rectangle;
    import flash.display.BitmapData;
    import flash.events.Event;
    import flash.events.MouseEvent;

    public class ChatHistoryScrollBar 
    {

        public static const RIGHT_MARGIN:int = 0;

        private var _SafeStr_2179:ChatHistoryScrollView;
        private var _displayObject:Sprite;
        private var _background:Sprite;
        private var _SafeStr_2178:Sprite;
        private var _SafeStr_662:int;
        private var _SafeStr_2180:int;
        private var _SafeStr_660:Stage;

        public function ChatHistoryScrollBar(_arg_1:ChatHistoryScrollView, _arg_2:HabboFreeFlowChat)
        {
            _SafeStr_2179 = _arg_1;
            _SafeStr_2178 = HabboFreeFlowChat.create9SliceSprite(new Rectangle(2, 2, 1, 1), (_arg_2.assets.getAssetByName("scrollbar_thumb").content as BitmapData));
            _SafeStr_2178.x = 2;
            _SafeStr_2178.y = 2;
            _background = HabboFreeFlowChat.create9SliceSprite(new Rectangle(2, 2, 5, 5), (_arg_2.assets.getAssetByName("scrollbar_back").content as BitmapData));
            _displayObject = new Sprite();
            _displayObject.addChild(_background);
            _displayObject.addChild(_SafeStr_2178);
            _SafeStr_2178.addEventListener("addedToStage", onAddedToStage);
            _SafeStr_2178.addEventListener("removedFromStage", onRemovedFromStage);
            _SafeStr_2178.addEventListener("mouseDown", mouseDownEventHandler);
        }

        public function set height(_arg_1:int):void
        {
            _background.height = _arg_1;
            updateThumbTrack();
        }

        public function get displayObject():Sprite
        {
            return (_displayObject);
        }

        public function updateThumbTrack():void
        {
            var _local_1:int = (_SafeStr_2179.topY + (_SafeStr_2179.viewPort.height - _background.height));
            _SafeStr_2178.height = Math.min((_background.height - 4), Math.max(5, int(((_background.height - 4) * (_background.height / _SafeStr_2179.bufferHeight)))));
            _SafeStr_2178.y = Math.min(((_background.height - 2) - _SafeStr_2178.height), Math.max(2, int((((_background.height - 4) * (Math.max(1, _local_1) / _SafeStr_2179.bufferHeight)) - (_SafeStr_2178.height / 2)))));
        }

        private function onAddedToStage(_arg_1:Event):void
        {
            _SafeStr_660 = _SafeStr_2178.stage;
        }

        private function onRemovedFromStage(_arg_1:Event):void
        {
            _SafeStr_660 = null;
        }

        private function mouseDownEventHandler(_arg_1:Event):void
        {
            _SafeStr_662 = MouseEvent(_arg_1).stageY;
            _SafeStr_2180 = _SafeStr_2179.topY;
            _SafeStr_660.addEventListener("mouseUp", mouseDragEventHandler);
            _SafeStr_660.addEventListener("mouseMove", mouseDragEventHandler);
            _arg_1.stopImmediatePropagation();
        }

        private function mouseDragEventHandler(_arg_1:Event):void
        {
            var _local_4:Number;
            var _local_2:int;
            var _local_3:MouseEvent = MouseEvent(_arg_1);
            switch (_local_3.type)
            {
                case "mouseMove":
                    _local_4 = (_SafeStr_2179.bufferHeight / _background.height);
                    _local_2 = ((_local_3.stageY - _SafeStr_662) * _local_4);
                    _SafeStr_2179.topY = (_SafeStr_2180 + _local_2);
                    break;
                case "mouseUp":
                    endScroll();
            };
            _arg_1.stopImmediatePropagation();
        }

        public function endScroll():void
        {
            if (_SafeStr_660)
            {
                _SafeStr_660.removeEventListener("mouseUp", mouseDragEventHandler);
                _SafeStr_660.removeEventListener("mouseMove", mouseDragEventHandler);
            };
        }


    }
}

