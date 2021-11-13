package com.sulake.habbo.groups.badge
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.groups.HabboGroupsManager;
    import com.sulake.core.window.IWindowContainer;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.groups.events.HabboGroupsEditorData;
    import com.sulake.habbo.communication.messages.incoming.users.GuildBadgeSettings;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.habbo.groups.*;

    public class BadgeEditorCtrl implements IDisposable 
    {

        private var _SafeStr_825:HabboGroupsManager;
        private var _window:IWindowContainer;
        private var _SafeStr_2607:IWindowContainer;
        private var _SafeStr_2606:Array;
        private var _badgeSelectPartCtrl:BadgeSelectPartCtrl;
        private var _disposed:Boolean = false;
        private var _layers:Vector.<BadgeLayerCtrl>;
        private var _currentLayerOptions:BadgeLayerOptions;
        private var _partSelectContainer:IWindowContainer;
        private var _partSelectGrid:IItemGridWindow;
        private var _partEditContainer:IWindowContainer;
        private var _SafeStr_2608:Vector.<IBitmapWrapperWindow>;

        public function BadgeEditorCtrl(_arg_1:HabboGroupsManager)
        {
            _SafeStr_825 = _arg_1;
            _SafeStr_825.events.addEventListener("HGE_EDIT_INFO", onHabboGroupsEditorData);
            _badgeSelectPartCtrl = new BadgeSelectPartCtrl(_SafeStr_825, this);
            _layers = new Vector.<BadgeLayerCtrl>();
            _layers.push(new BadgeLayerCtrl(_SafeStr_825, this, 0));
            _layers.push(new BadgeLayerCtrl(_SafeStr_825, this, 1));
            _layers.push(new BadgeLayerCtrl(_SafeStr_825, this, 2));
            _layers.push(new BadgeLayerCtrl(_SafeStr_825, this, 3));
            _layers.push(new BadgeLayerCtrl(_SafeStr_825, this, 4));
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get partEditContainer():IWindowContainer
        {
            return (_partEditContainer);
        }

        public function get partSelectContainer():IWindowContainer
        {
            return (_partSelectContainer);
        }

        public function get partSelectGrid():IItemGridWindow
        {
            return (_partSelectGrid);
        }

        public function get currentLayerOptions():BadgeLayerOptions
        {
            return (_currentLayerOptions);
        }

        public function get badgeSelectPartCtrl():BadgeSelectPartCtrl
        {
            return (_badgeSelectPartCtrl);
        }

        public function get isIntialized():Boolean
        {
            return ((!(_window == null)) && (!(_SafeStr_2606 == null)));
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_layers)
                {
                    for each (var _local_1:BadgeLayerCtrl in _layers)
                    {
                        _local_1.dispose();
                    };
                    _layers = null;
                };
                if (_badgeSelectPartCtrl)
                {
                    _badgeSelectPartCtrl.dispose();
                    _badgeSelectPartCtrl = null;
                };
                if (_partSelectContainer)
                {
                    _partSelectContainer.dispose();
                    _partSelectContainer = null;
                };
                if (_partSelectGrid)
                {
                    _partSelectGrid.dispose();
                    _partSelectGrid = null;
                };
                if (_partEditContainer)
                {
                    _partEditContainer.dispose();
                    _partEditContainer = null;
                };
                if (_SafeStr_2608)
                {
                    for each (var _local_2:IBitmapWrapperWindow in _SafeStr_2608)
                    {
                        _local_2.dispose();
                    };
                    _SafeStr_2608 = null;
                };
                if (_window)
                {
                    _window.dispose();
                    _window = null;
                };
                _SafeStr_2606 = null;
                _currentLayerOptions = null;
                _window = null;
                _SafeStr_825 = null;
                _disposed = true;
            };
        }

        public function onHabboGroupsEditorData(_arg_1:HabboGroupsEditorData):void
        {
            _badgeSelectPartCtrl.loadData();
            createWindow(null, null);
        }

        public function createWindow(_arg_1:IWindowContainer, _arg_2:Array):void
        {
            var _local_3:int;
            if (((!(_window == null)) || (_disposed)))
            {
                return;
            };
            if (_arg_1 != null)
            {
                _SafeStr_2607 = _arg_1;
            };
            if (_arg_2 != null)
            {
                _SafeStr_2606 = _arg_2;
            };
            if (((((_SafeStr_2607 == null) || (_SafeStr_2606 == null)) || (_SafeStr_825 == null)) || (_SafeStr_825.guildEditorData == null)))
            {
                return;
            };
            _window = (_SafeStr_825.getXmlWindow("badge_editor") as IWindowContainer);
            var _local_4:IWindowContainer = (_window.findChildByName("guild_badge") as IWindowContainer);
            _SafeStr_2608 = new Vector.<IBitmapWrapperWindow>();
            _SafeStr_2608.push((_local_4.findChildByName("layer_0") as IBitmapWrapperWindow));
            _SafeStr_2608.push((_local_4.findChildByName("layer_1") as IBitmapWrapperWindow));
            _SafeStr_2608.push((_local_4.findChildByName("layer_2") as IBitmapWrapperWindow));
            _SafeStr_2608.push((_local_4.findChildByName("layer_3") as IBitmapWrapperWindow));
            _SafeStr_2608.push((_local_4.findChildByName("layer_4") as IBitmapWrapperWindow));
            _partEditContainer = (_window.findChildByName("part_edit") as IWindowContainer);
            _partSelectContainer = (_window.findChildByName("part_select") as IWindowContainer);
            _partSelectContainer.visible = false;
            _partSelectGrid = (_partSelectContainer.findChildByName("part_select_grid") as IItemGridWindow);
            _local_3 = 0;
            while (_local_3 < _layers.length)
            {
                _layers[_local_3].createWindow();
                _local_3++;
            };
            resetLayerOptions(_SafeStr_2606);
            _SafeStr_2607.addChild(_window);
        }

        public function resetLayerOptions(_arg_1:Array):void
        {
            var _local_2:int;
            if (!this.isIntialized)
            {
                return;
            };
            if (_partSelectContainer.visible)
            {
                _partSelectContainer.visible = false;
                _partEditContainer.visible = true;
            };
            _SafeStr_2606 = _arg_1;
            _currentLayerOptions = null;
            _partEditContainer.visible = true;
            _partSelectContainer.visible = false;
            _badgeSelectPartCtrl.loadData();
            _local_2 = 0;
            while (_local_2 < _layers.length)
            {
                _layers[_local_2].setLayerOptions(createLayerOption(_local_2));
                _layers[_local_2].updateSelectedPart();
                _local_2++;
            };
        }

        private function createLayerOption(_arg_1:int):BadgeLayerOptions
        {
            var _local_3:int;
            var _local_2:GuildBadgeSettings = (_SafeStr_2606[_arg_1] as GuildBadgeSettings);
            var _local_4:BadgeLayerOptions = new BadgeLayerOptions();
            _local_4.layerIndex = _arg_1;
            _local_4.colorIndex = 0;
            _local_4.setGrid(_local_2.position);
            _local_3 = 0;
            while (_local_3 < _SafeStr_825.guildEditorData.badgeColors.length)
            {
                if (_SafeStr_825.guildEditorData.badgeColors[_local_3].id == _local_2.colorId)
                {
                    _local_4.colorIndex = _local_3;
                    break;
                };
                _local_3++;
            };
            if (_arg_1 == BadgeLayerCtrl.BASE_LAYER_INDEX)
            {
                _local_3 = 0;
                while (_local_3 < _SafeStr_825.guildEditorData.baseParts.length)
                {
                    if (_SafeStr_825.guildEditorData.baseParts[_local_3].id == _local_2.partId)
                    {
                        _local_4.partIndex = _local_3;
                        break;
                    };
                    _local_3++;
                };
            }
            else
            {
                _local_3 = 0;
                while (_local_3 < _SafeStr_825.guildEditorData.layerParts.length)
                {
                    if (_SafeStr_825.guildEditorData.layerParts[_local_3].id == _local_2.partId)
                    {
                        _local_4.partIndex = _local_3;
                        break;
                    };
                    _local_3++;
                };
            };
            return (_local_4);
        }

        public function onPartSelected(_arg_1:BadgeSelectPartCtrl):void
        {
            _currentLayerOptions.partIndex = _arg_1.getSelectedPartIndex();
            _layers[_currentLayerOptions.layerIndex].setLayerOptions(currentLayerOptions);
            _partEditContainer.visible = true;
            _partSelectContainer.visible = false;
        }

        public function onPartHover(_arg_1:BadgeSelectPartCtrl):void
        {
            updatePreviewImage(_arg_1.layerOptions);
        }

        public function onPartChanged(_arg_1:BadgeLayerCtrl):void
        {
            updatePreviewImage(_arg_1.layerOptions);
        }

        public function updatePreviewImage(_arg_1:BadgeLayerOptions):void
        {
            var _local_2:BitmapData = _badgeSelectPartCtrl.getPartItemImage(_arg_1);
            if (_local_2 != null)
            {
                _SafeStr_2608[_arg_1.layerIndex].bitmap = _local_2.clone();
                _SafeStr_2608[_arg_1.layerIndex].visible = true;
            }
            else
            {
                _SafeStr_2608[_arg_1.layerIndex].visible = false;
            };
        }

        public function onShowSelectPart(_arg_1:BadgeLayerCtrl):void
        {
            var _local_2:BadgeLayerOptions = _currentLayerOptions;
            _currentLayerOptions = _arg_1.layerOptions.clone();
            if (!_arg_1.layerOptions.equalVisuals(_local_2))
            {
                _badgeSelectPartCtrl.updateGrid();
            }
            else
            {
                _badgeSelectPartCtrl.layerOptions = _currentLayerOptions.clone();
            };
            _partEditContainer.visible = false;
            _partSelectContainer.visible = true;
        }

        public function onViewChange():void
        {
            if (((isIntialized) && (_partSelectContainer.visible)))
            {
                updatePreviewImage(_currentLayerOptions);
                _partEditContainer.visible = true;
                _partSelectContainer.visible = false;
            };
        }

        public function getBadgeSettings():Array
        {
            var _local_2:int;
            var _local_3:int;
            var _local_1:Array = [];
            for each (var _local_4:BadgeLayerCtrl in _layers)
            {
                _local_2 = getLayerPartId(_local_4.layerOptions);
                if (_local_2 >= 0)
                {
                    _local_3 = getLayerColorId(_local_4.layerOptions);
                    if (_local_3 >= 0)
                    {
                        _local_1.push(_local_2);
                        _local_1.push(_local_3);
                        _local_1.push(_local_4.layerOptions.position);
                    };
                };
            };
            return (_local_1);
        }

        public function get primaryColorIndex():int
        {
            if (_layers == null)
            {
                return (0);
            };
            var _local_1:int;
            for each (var _local_2:BadgeLayerCtrl in _layers)
            {
                if (!((getLayerPartId(_local_2.layerOptions) < 0) || (getLayerColorId(_local_2.layerOptions) < 0)))
                {
                    _local_1 = _local_2.layerOptions.colorIndex;
                };
            };
            return (_local_1);
        }

        public function get secondaryColorIndex():int
        {
            if (_layers != null)
            {
                return (_layers[0].layerOptions.colorIndex);
            };
            return (0);
        }

        public function getBadgeBitmap():BitmapData
        {
            var _local_1:BitmapData = new BitmapData(BadgeEditorPartItem.IMAGE_WIDTH, BadgeEditorPartItem.IMAGE_HEIGHT, true, 15329761);
            for each (var _local_2:IBitmapWrapperWindow in _SafeStr_2608)
            {
                if (_local_2.visible)
                {
                    _local_1.copyPixels(_local_2.bitmap, _local_1.rect, new Point(), null, null, true);
                };
            };
            return (_local_1);
        }

        private function getLayerPartId(_arg_1:BadgeLayerOptions):int
        {
            if (_arg_1.partIndex < 0)
            {
                return (-1);
            };
            if (_arg_1.layerIndex == BadgeLayerCtrl.BASE_LAYER_INDEX)
            {
                if (_arg_1.partIndex >= _SafeStr_825.guildEditorData.baseParts.length)
                {
                    return (-1);
                };
                return (_SafeStr_825.guildEditorData.baseParts[_arg_1.partIndex].id);
            };
            if (_arg_1.partIndex >= _SafeStr_825.guildEditorData.layerParts.length)
            {
                return (-1);
            };
            return (_SafeStr_825.guildEditorData.layerParts[_arg_1.partIndex].id);
        }

        private function getLayerColorId(_arg_1:BadgeLayerOptions):int
        {
            if (((_arg_1.colorIndex < 0) || (_arg_1.colorIndex >= _SafeStr_825.guildEditorData.badgeColors.length)))
            {
                return (-1);
            };
            return (_SafeStr_825.guildEditorData.badgeColors[_arg_1.colorIndex].id);
        }


    }
}

