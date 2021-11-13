package com.sulake.habbo.ui.widget.furniture.dimmer
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.events.RoomWidgetDimmerUpdateEventPresetItem;
    import com.sulake.habbo.ui.widget.events.RoomWidgetDimmerUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerPreviewMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetDimmerStateUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerSavePresetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerChangeStateMessage;

    public class DimmerFurniWidget extends RoomWidgetBase 
    {

        private static const _colors:Array = new Array(7665141, 21495, 15161822, 15353138, 15923281, 8581961, 0);
        private static const _minLights:Array = new Array(76, 76);

        private var _SafeStr_570:DimmerView;
        private var _presets:Array;
        private var _selectedPresetIndex:int;
        private var _dimmerState:int;
        private var _SafeStr_4083:int;
        private var _color:uint = 0xFFFFFF;
        private var _SafeStr_4084:uint = 0xFF;

        public function DimmerFurniWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null, _arg_4:IHabboLocalizationManager=null)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        public function get dimmerState():int
        {
            return (_dimmerState);
        }

        public function get presets():Array
        {
            return (_presets);
        }

        public function get colors():Array
        {
            return (_colors);
        }

        public function get minLights():Array
        {
            return (_minLights);
        }

        public function get selectedPresetIndex():int
        {
            return (_selectedPresetIndex);
        }

        public function set selectedPresetIndex(_arg_1:int):void
        {
            _selectedPresetIndex = _arg_1;
        }

        override public function dispose():void
        {
            disposeInterface();
            _presets = null;
            super.dispose();
        }

        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addEventListener("RWDUE_PRESETS", onPresets);
            _arg_1.addEventListener("RWDUE_HIDE", onHide);
            _arg_1.addEventListener("RWDSUE_DIMMER_STATE", onDimmerState);
            super.registerUpdateEvents(_arg_1);
        }

        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.removeEventListener("RWDUE_PRESETS", onPresets);
            _arg_1.removeEventListener("RWDUE_HIDE", onHide);
            _arg_1.removeEventListener("RWDSUE_DIMMER_STATE", onDimmerState);
        }

        private function onPresets(_arg_1:RoomWidgetDimmerUpdateEvent):void
        {
            var _local_3:int;
            var _local_4:RoomWidgetDimmerUpdateEventPresetItem;
            var _local_2:DimmerFurniWidgetPresetItem;
            _selectedPresetIndex = (_arg_1.selectedPresetId - 1);
            _presets = [];
            _local_3 = 0;
            while (_local_3 < _arg_1.presets.length)
            {
                _local_4 = _arg_1.presets[_local_3];
                _local_2 = new DimmerFurniWidgetPresetItem(_local_4.id, _local_4.type, _local_4.color, _local_4.light);
                _presets.push(_local_2);
                _local_3++;
            };
            showInterface();
        }

        private function onHide(_arg_1:RoomWidgetDimmerUpdateEvent):void
        {
            disposeInterface();
        }

        private function disposeInterface():void
        {
            if (_SafeStr_570 != null)
            {
                _SafeStr_570.dispose();
                _SafeStr_570 = null;
            };
        }

        private function onDimmerState(_arg_1:RoomWidgetDimmerStateUpdateEvent):void
        {
            var _local_2:RoomWidgetDimmerPreviewMessage;
            if (_arg_1 == null)
            {
                return;
            };
            _dimmerState = _arg_1.state;
            _SafeStr_4083 = _arg_1.effectId;
            _color = _arg_1.color;
            _SafeStr_4084 = _arg_1.brightness;
            if (_SafeStr_570 != null)
            {
                _SafeStr_570.update();
            };
            if (!validateBrightness(_SafeStr_4084, _SafeStr_4083))
            {
                return;
            };
            _local_2 = new RoomWidgetDimmerPreviewMessage(_color, _SafeStr_4084, (_SafeStr_4083 == 2));
            messageListener.processWidgetMessage(_local_2);
        }

        private function showInterface():void
        {
            if (_SafeStr_570 == null)
            {
                _SafeStr_570 = new DimmerView(this);
            };
            if (_SafeStr_570 != null)
            {
                _SafeStr_570.showInterface();
            };
        }

        public function storeCurrentSetting(_arg_1:Boolean):void
        {
            var _local_6:RoomWidgetDimmerSavePresetMessage;
            if (_dimmerState == 0)
            {
                return;
            };
            if (messageListener == null)
            {
                return;
            };
            var _local_7:int = (_selectedPresetIndex + 1);
            if ((((_presets == null) || (_local_7 < 0)) || (_local_7 > _presets.length)))
            {
                return;
            };
            var _local_5:int = _SafeStr_570.selectedType;
            var _local_4:uint = colors[_SafeStr_570.selectedColorIndex];
            var _local_3:int = _SafeStr_570.selectedBrightness;
            var _local_2:DimmerFurniWidgetPresetItem = (_presets[_selectedPresetIndex] as DimmerFurniWidgetPresetItem);
            if ((((((!(_local_2 == null)) && (_local_2.type == _local_5)) && (_local_2.color == _local_4)) && (_local_2.light == _local_3)) && (!(_arg_1))))
            {
                return;
            };
            _local_2.type = _local_5;
            _local_2.color = _local_4;
            _local_2.light = _local_3;
            if (!validateBrightness(_local_3, _local_5))
            {
                return;
            };
            _local_6 = new RoomWidgetDimmerSavePresetMessage(_local_7, _local_5, _local_4, _local_3, _arg_1);
            messageListener.processWidgetMessage(_local_6);
        }

        public function previewCurrentSetting():void
        {
            var _local_1:RoomWidgetDimmerPreviewMessage;
            if (_dimmerState == 0)
            {
                return;
            };
            if (messageListener == null)
            {
                return;
            };
            if (!validateBrightness(_SafeStr_570.selectedBrightness, _SafeStr_570.selectedType))
            {
                return;
            };
            _local_1 = new RoomWidgetDimmerPreviewMessage(colors[_SafeStr_570.selectedColorIndex], _SafeStr_570.selectedBrightness, (_SafeStr_570.selectedType == 2));
            messageListener.processWidgetMessage(_local_1);
        }

        public function changeRoomDimmerState():void
        {
            var _local_1:RoomWidgetDimmerChangeStateMessage;
            if (messageListener != null)
            {
                _local_1 = new RoomWidgetDimmerChangeStateMessage();
                messageListener.processWidgetMessage(_local_1);
            };
        }

        public function removePreview():void
        {
            var _local_1:RoomWidgetDimmerPreviewMessage;
            if (messageListener == null)
            {
                return;
            };
            if (!validateBrightness(_SafeStr_4084, _SafeStr_4083))
            {
                return;
            };
            _local_1 = new RoomWidgetDimmerPreviewMessage(_color, _SafeStr_4084, (_SafeStr_4083 == 2));
            messageListener.processWidgetMessage(_local_1);
        }

        private function validateBrightness(_arg_1:uint, _arg_2:int):Boolean
        {
            return (true);
        }


    }
}

