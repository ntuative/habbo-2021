package com.sulake.habbo.groups.badge
{
    import com.sulake.habbo.groups.HabboGroupsManager;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.groups.ColorGridCtrl;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.components.IItemListWindow;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class BadgeLayerCtrl 
    {

        public static var BASE_LAYER_INDEX:int = 0;
        public static var PARENT_CONTAINER_NAME:String = "part_edit_list";

        private var _SafeStr_825:HabboGroupsManager;
        private var _SafeStr_2610:BadgeEditorCtrl;
        private var _SafeStr_2613:int = 0;
        private var _layerOptions:BadgeLayerOptions;
        private var _SafeStr_2614:IWindowContainer;
        private var _SafeStr_2615:ColorGridCtrl;
        private var _disposed:Boolean = false;
        private var _SafeStr_2616:BitmapData;
        private var _SafeStr_2617:IBitmapWrapperWindow;
        private var _partSelectButton:_SafeStr_101;
        private var _SafeStr_2618:IWindowContainer;
        private var _SafeStr_2619:IBitmapWrapperWindow;
        private var _SafeStr_2620:IBitmapWrapperWindow;

        public function BadgeLayerCtrl(_arg_1:HabboGroupsManager, _arg_2:BadgeEditorCtrl, _arg_3:int)
        {
            _SafeStr_825 = _arg_1;
            _SafeStr_2610 = _arg_2;
            _SafeStr_2613 = _arg_3;
            _layerOptions = new BadgeLayerOptions();
            _layerOptions.layerIndex = _arg_3;
            _SafeStr_2616 = _SafeStr_825.getButtonImage("badge_part_add");
        }

        public function createWindow():void
        {
            if (_SafeStr_2614 != null)
            {
                return;
            };
            var _local_1:IItemListWindow = (_SafeStr_2610.partEditContainer.findChildByName(PARENT_CONTAINER_NAME) as IItemListWindow);
            _SafeStr_2614 = (_SafeStr_825.getXmlWindow("badge_layer") as IWindowContainer);
            var _local_2:IWindowContainer = (_SafeStr_2614.findChildByName("preview_container") as IWindowContainer);
            _SafeStr_2617 = (_local_2.findChildByName("part_preview") as IBitmapWrapperWindow);
            _SafeStr_2617.bitmap = _SafeStr_825.getButtonImage("badge_part_add");
            _partSelectButton = (_local_2.findChildByName("part_button") as _SafeStr_101);
            _partSelectButton.procedure = onPartPreviewButtonClick;
            _SafeStr_2618 = (_SafeStr_2614.findChildByName("position_container") as IWindowContainer);
            _SafeStr_2619 = (_SafeStr_2618.findChildByName("position_picker") as IBitmapWrapperWindow);
            _SafeStr_2619.bitmap = _SafeStr_825.getButtonImage("position_picker");
            _SafeStr_2620 = (_SafeStr_2618.findChildByName("position_grid") as IBitmapWrapperWindow);
            _SafeStr_2620.bitmap = _SafeStr_825.getButtonImage("position_grid");
            if (_SafeStr_2613 == 0)
            {
                _SafeStr_2620.visible = false;
                _SafeStr_2619.visible = false;
            }
            else
            {
                _SafeStr_2620.procedure = onPositionGridClick;
            };
            _SafeStr_2615 = new ColorGridCtrl(_SafeStr_825, onColorSelected);
            _SafeStr_2615.createAndAttach(_SafeStr_2614, "color_selector", _SafeStr_825.guildEditorData.badgeColors);
            if (_layerOptions.layerIndex == BASE_LAYER_INDEX)
            {
                _local_1.addListItem(_SafeStr_2614);
            }
            else
            {
                _local_1.addListItemAt(_SafeStr_2614, 0);
            };
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_SafeStr_2615)
                {
                    _SafeStr_2615.dispose();
                    _SafeStr_2615 = null;
                };
                if (_SafeStr_2614)
                {
                    _SafeStr_2614.dispose();
                    _SafeStr_2614 = null;
                };
                _SafeStr_2617 = null;
                _partSelectButton = null;
                _SafeStr_2618 = null;
                _SafeStr_2619 = null;
                _SafeStr_2620 = null;
                _SafeStr_825 = null;
                _disposed = true;
            };
        }

        public function setLayerOptions(_arg_1:BadgeLayerOptions):void
        {
            if (_arg_1.layerIndex != _layerOptions.layerIndex)
            {
                throw (new Error("Tried to set layer option with invalid layerIndex value"));
            };
            var _local_2:Boolean;
            var _local_3:BadgeLayerOptions = _layerOptions;
            _layerOptions = _arg_1.clone();
            if (!_layerOptions.isGridEqual(_local_3))
            {
                updatePositionPicker(false);
                _local_2 = true;
            };
            if (_local_3.colorIndex != _layerOptions.colorIndex)
            {
                _SafeStr_2615.setSelectedColorIndex(_layerOptions.colorIndex, false);
                _layerOptions.colorIndex = _SafeStr_2615.selectedColorIndex;
                _local_2 = true;
            };
            if (((_local_2) || (!(_local_3.partIndex == _layerOptions.partIndex))))
            {
                updateSelectedPart();
            };
        }

        public function get layerOptions():BadgeLayerOptions
        {
            return (_layerOptions);
        }

        public function updateSelectedPart():void
        {
            var _local_1:BitmapData;
            if (_SafeStr_2610.badgeSelectPartCtrl)
            {
                _local_1 = _SafeStr_2610.badgeSelectPartCtrl.getPartItemImage(layerOptions);
            };
            if (_local_1 == null)
            {
                _local_1 = _SafeStr_2616;
            };
            _SafeStr_2617.bitmap.dispose();
            _SafeStr_2617.bitmap = new BitmapData(_local_1.width, _local_1.height);
            _SafeStr_2617.bitmap.copyPixels(_local_1, _local_1.rect, new Point());
            _SafeStr_2610.onPartChanged(this);
        }

        private function updatePositionPicker(_arg_1:Boolean=true):void
        {
            _SafeStr_2619.x = ((_layerOptions.gridX * 14) + 1);
            _SafeStr_2619.y = ((_layerOptions.gridY * 14) + 1);
            if (_arg_1)
            {
                updateSelectedPart();
            };
        }

        private function onPositionGridClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((!(_arg_1.type == "WME_CLICK")) || (!(_SafeStr_2619))))
            {
                return;
            };
            var _local_3:WindowMouseEvent = (_arg_1 as WindowMouseEvent);
            _layerOptions.gridX = Math.min(2, Math.max(0, Math.floor((_local_3.localX / 14))));
            _layerOptions.gridY = Math.min(2, Math.max(0, Math.floor((_local_3.localY / 14))));
            updatePositionPicker();
        }

        private function onPartPreviewButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            _SafeStr_2610.onShowSelectPart(this);
        }

        public function onColorSelected(_arg_1:ColorGridCtrl):void
        {
            if (_layerOptions.colorIndex != _arg_1.selectedColorIndex)
            {
                _layerOptions.colorIndex = _arg_1.selectedColorIndex;
                updateSelectedPart();
            };
        }


    }
}

