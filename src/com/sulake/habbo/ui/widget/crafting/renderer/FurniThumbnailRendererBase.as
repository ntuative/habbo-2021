package com.sulake.habbo.ui.widget.crafting.renderer
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
    import com.sulake.habbo.ui.widget.crafting.utils.CraftingFurnitureItem;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.room._SafeStr_147;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowEvent;

    public class FurniThumbnailRendererBase implements IGetImageListener 
    {

        private const THUMB_BLEND_ITEMS_AVAILABLE:Number = 1;
        private const THUMB_BLEND_ITEMS_NOT_AVAILABLE:Number = 0.2;

        protected var _SafeStr_1324:CraftingWidget;
        protected var _SafeStr_690:CraftingFurnitureItem;
        protected var _window:IWindowContainer;

        public function FurniThumbnailRendererBase(_arg_1:CraftingFurnitureItem, _arg_2:IWindowContainer, _arg_3:CraftingWidget)
        {
            _SafeStr_1324 = _arg_3;
            _window = _arg_2;
            _SafeStr_690 = _arg_1;
            requestIconFromRoomEngine(furnitureData);
            updateItemCount();
            _window.procedure = onMouseDown;
            var _local_4:IRegionWindow = (_arg_2.findChildByName("tooltip") as IRegionWindow);
            _local_4.toolTipCaption = _arg_1.furnitureData.localizedName;
        }

        public function dispose():void
        {
            if (_window)
            {
                _window.removeEventListener("mouseDown", onMouseDown);
                _window.dispose();
                _window = null;
            };
        }

        private function requestIconFromRoomEngine(_arg_1:IFurnitureData):void
        {
            var _local_2:_SafeStr_147;
            switch (_arg_1.type)
            {
                case "s":
                    _local_2 = _SafeStr_1324.handler.container.roomEngine.getFurnitureIcon(_arg_1.id, this);
                    break;
                case "i":
                    _local_2 = _SafeStr_1324.handler.container.roomEngine.getWallItemIcon(_arg_1.id, this);
            };
            if (_local_2.data)
            {
                imageReady(0, _local_2.data);
            };
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            if (!_window)
            {
                return;
            };
            var _local_3:IBitmapWrapperWindow = (_window.findChildByTag("BITMAP") as IBitmapWrapperWindow);
            if (((_local_3) && (_arg_2)))
            {
                _local_3.bitmap = _arg_2;
            };
        }

        public function imageFailed(_arg_1:int):void
        {
        }

        public function updateItemCount():void
        {
        }

        protected function hideItemCount():void
        {
            var _local_1:IWindow = _window.findChildByName("number_container");
            if (_local_1)
            {
                _local_1.visible = false;
            };
        }

        protected function updateGroupItemCount(_arg_1:int):void
        {
            var _local_3:ITextWindow;
            if (((!(_window)) || (_window.disposed)))
            {
                return;
            };
            var _local_2:IWindow = _window.findChildByName("number_container");
            _local_2.visible = (_arg_1 > 0);
            if (_arg_1 > 0)
            {
                _local_3 = (_window.findChildByName("number") as ITextWindow);
                _local_3.text = String(_arg_1);
            };
        }

        protected function updateBitmapBlend(_arg_1:Boolean):void
        {
            var _local_2:IBitmapWrapperWindow = (_window.findChildByName("bitmap") as IBitmapWrapperWindow);
            if (_arg_1)
            {
                _local_2.blend = 1;
            }
            else
            {
                _local_2.blend = 0.2;
            };
        }

        private function onMouseDown(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_DOWN")
            {
                return;
            };
            onTriggered();
        }

        protected function onTriggered():void
        {
        }

        public function get content():CraftingFurnitureItem
        {
            return (_SafeStr_690);
        }

        protected function get furnitureData():IFurnitureData
        {
            return ((content) ? content.furnitureData : null);
        }

        public function get window():IWindowContainer
        {
            return (_window);
        }


    }
}

