package com.sulake.habbo.groups.badge
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.groups.HabboGroupsManager;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.communication.messages.incoming.users.BadgePartData;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.window.components._SafeStr_124;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class BadgeSelectPartCtrl implements IDisposable 
    {

        private var _SafeStr_825:HabboGroupsManager;
        private var _SafeStr_2610:BadgeEditorCtrl;
        private var _SafeStr_2621:Vector.<BadgeEditorPartItem>;
        private var _SafeStr_2622:Vector.<BadgeEditorPartItem>;
        private var _layerOptions:BadgeLayerOptions;
        private var _SafeStr_2623:IWindowContainer;
        private var _SafeStr_2624:IBitmapWrapperWindow;
        private var _disposed:Boolean = false;

        public function BadgeSelectPartCtrl(_arg_1:HabboGroupsManager, _arg_2:BadgeEditorCtrl)
        {
            _SafeStr_825 = _arg_1;
            _SafeStr_2610 = _arg_2;
        }

        public function get layerOptions():BadgeLayerOptions
        {
            return (_layerOptions);
        }

        public function set layerOptions(_arg_1:BadgeLayerOptions):void
        {
            _layerOptions = _arg_1;
        }

        public function dispose():void
        {
            var _local_1:BadgeEditorPartItem;
            if (!_disposed)
            {
                if (((!(_SafeStr_2610.partSelectGrid == null)) && (_SafeStr_2610.partSelectGrid.numGridItems > 0)))
                {
                    _SafeStr_2610.partSelectGrid.destroyGridItems();
                };
                if (_SafeStr_2622)
                {
                    for each (_local_1 in _SafeStr_2622)
                    {
                        _local_1.dispose();
                    };
                    _SafeStr_2622 = null;
                };
                if (_SafeStr_2621)
                {
                    for each (_local_1 in _SafeStr_2621)
                    {
                        _local_1.dispose();
                    };
                    _SafeStr_2621 = null;
                };
                _layerOptions = null;
                _SafeStr_2624 = null;
                _SafeStr_2623 = null;
                _SafeStr_2610 = null;
                _SafeStr_825 = null;
                _disposed = true;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function getSelectedPartIndex():int
        {
            var _local_1:int = -1;
            if ((((!(_layerOptions == null)) && (!(_SafeStr_2610.partSelectGrid == null))) && (!(_SafeStr_2623 == null))))
            {
                _local_1 = _SafeStr_2610.partSelectGrid.getGridItemIndex(_SafeStr_2623);
                if (((!(_local_1 == -1)) && (!(_layerOptions.layerIndex == BadgeLayerCtrl.BASE_LAYER_INDEX))))
                {
                    _local_1 = (_local_1 - 1);
                };
            };
            return (_local_1);
        }

        public function loadData():void
        {
            var _local_1:BadgePartData;
            if (((!(_SafeStr_2622 == null)) || (!(_SafeStr_2621 == null))))
            {
                return;
            };
            _SafeStr_2622 = new Vector.<BadgeEditorPartItem>();
            for each (_local_1 in _SafeStr_825.guildEditorData.baseParts)
            {
                _SafeStr_2622.push(new BadgeEditorPartItem(_SafeStr_825, this, _SafeStr_2622.length, BadgeEditorPartItem.BASE_PART, _local_1));
            };
            _SafeStr_2621 = new Vector.<BadgeEditorPartItem>();
            _SafeStr_2621.push(new BadgeEditorPartItem(_SafeStr_825, this, -1, BadgeEditorPartItem.LAYER_PART));
            for each (_local_1 in _SafeStr_825.guildEditorData.layerParts)
            {
                _SafeStr_2621.push(new BadgeEditorPartItem(_SafeStr_825, this, (_SafeStr_2621.length - 1), BadgeEditorPartItem.LAYER_PART, _local_1));
            };
        }

        public function updateGrid():void
        {
            var _local_1:BadgeEditorPartItem;
            _SafeStr_2623 = null;
            _SafeStr_2624 = null;
            _layerOptions = _SafeStr_2610.currentLayerOptions.clone();
            _SafeStr_2610.partSelectGrid.destroyGridItems();
            if (_layerOptions.layerIndex == BadgeLayerCtrl.BASE_LAYER_INDEX)
            {
                for each (_local_1 in _SafeStr_2622)
                {
                    _SafeStr_2610.partSelectGrid.addGridItem(createGridItem(_local_1));
                };
            }
            else
            {
                for each (_local_1 in _SafeStr_2621)
                {
                    _SafeStr_2610.partSelectGrid.addGridItem(createGridItem(_local_1));
                };
            };
        }

        private function createGridItem(_arg_1:BadgeEditorPartItem):IWindowContainer
        {
            var _local_2:IWindowContainer = (_SafeStr_825.getXmlWindow("badge_part_item") as IWindowContainer);
            _local_2.procedure = onPartMouseEvent;
            setGridItemImage(_local_2, _arg_1);
            return (_local_2);
        }

        public function onBaseImageLoaded(_arg_1:BadgeEditorPartItem):void
        {
            var _local_2:IWindowContainer;
            if ((((!(_layerOptions == null)) && (_layerOptions.layerIndex == BadgeLayerCtrl.BASE_LAYER_INDEX)) && (_SafeStr_2610.partSelectContainer.visible)))
            {
                _local_2 = (_SafeStr_2610.partSelectGrid.getGridItemAt(_arg_1.partIndex) as IWindowContainer);
                setGridItemImage(_local_2, _arg_1);
            };
        }

        public function onLayerImageLoaded(_arg_1:BadgeEditorPartItem):void
        {
            var _local_2:IWindowContainer;
            if ((((!(_layerOptions == null)) && (!(_layerOptions.layerIndex == BadgeLayerCtrl.BASE_LAYER_INDEX))) && (_SafeStr_2610.partSelectContainer.visible)))
            {
                _local_2 = (_SafeStr_2610.partSelectGrid.getGridItemAt((_arg_1.partIndex + 1)) as IWindowContainer);
                setGridItemImage(_local_2, _arg_1);
            };
        }

        private function setGridItemImage(_arg_1:IWindowContainer, _arg_2:BadgeEditorPartItem):void
        {
            var _local_5:IBitmapWrapperWindow;
            var _local_4:BitmapData = _arg_2.getComposite(_layerOptions);
            if (_local_4 != null)
            {
                _local_5 = (_arg_1.findChildByName("part") as IBitmapWrapperWindow);
                _local_5.bitmap = new BitmapData(_local_4.width, _local_4.height);
                _local_5.bitmap.copyPixels(_local_4, _local_4.rect, new Point());
            };
            var _local_3:IBitmapWrapperWindow = (_arg_1.findChildByName("selected") as IBitmapWrapperWindow);
            _local_3.bitmap = _SafeStr_825.getButtonImage("badge_part_picker");
            if (_arg_2.partIndex == _layerOptions.partIndex)
            {
                _local_3.visible = true;
                _SafeStr_2624 = _local_3;
            }
            else
            {
                _local_3.visible = false;
            };
        }

        private function onPartMouseEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:_SafeStr_124;
            var _local_4:IWindowContainer;
            if (_arg_1.type == "WME_OVER")
            {
                if (_SafeStr_2623 != _arg_2)
                {
                    if (_SafeStr_2623 != null)
                    {
                        _local_3 = (_SafeStr_2623.findChildByName("background") as _SafeStr_124);
                        if (_local_3 != null)
                        {
                            _local_3.color = 15329761;
                        };
                    };
                    _SafeStr_2623 = (_arg_2 as IWindowContainer);
                    if (_SafeStr_2623 != null)
                    {
                        _local_3 = (_SafeStr_2623.findChildByName("background") as _SafeStr_124);
                        if (_local_3 != null)
                        {
                            _local_3.color = 14210761;
                        };
                        _layerOptions.partIndex = getSelectedPartIndex();
                        _SafeStr_2610.onPartHover(this);
                    };
                };
            };
            if (_arg_1.type == "WME_CLICK")
            {
                if (_SafeStr_2624 != null)
                {
                    _SafeStr_2624.visible = false;
                };
                _local_4 = (_arg_2 as IWindowContainer);
                if (_local_4 != null)
                {
                    _SafeStr_2624 = (_local_4.findChildByName("selected") as IBitmapWrapperWindow);
                    _SafeStr_2624.visible = true;
                };
                _SafeStr_2610.onPartSelected(this);
            };
        }

        public function getPartItemImage(_arg_1:BadgeLayerOptions):BitmapData
        {
            if (((_arg_1 == null) || (_arg_1.partIndex < 0)))
            {
                return (null);
            };
            if (_arg_1.layerIndex == BadgeLayerCtrl.BASE_LAYER_INDEX)
            {
                if (((!(_SafeStr_2622 == null)) && (_arg_1.partIndex < _SafeStr_2622.length)))
                {
                    return (_SafeStr_2622[_arg_1.partIndex].getComposite(_arg_1));
                };
            }
            else
            {
                if (((!(_SafeStr_2621 == null)) && ((_arg_1.partIndex + 1) < _SafeStr_2621.length)))
                {
                    return (_SafeStr_2621[(_arg_1.partIndex + 1)].getComposite(_arg_1));
                };
            };
            return (null);
        }


    }
}

