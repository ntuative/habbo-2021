package com.sulake.habbo.ui.widget.furniture.backgroundcolor
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.components.IFrameWindow;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.handler.FurnitureBackgroundColorWidgetHandler;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.room.utils.ColorConverter;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetRoomBackgroundColorDataComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class BackgroundColorFurniWidget extends RoomWidgetBase 
    {

        private static const PARAMETER_HUE:String = "hue";
        private static const PARAMETER_SATURATION:String = "saturation";
        private static const PARAMETER_LIGHTNESS:String = "lightness";

        private var _window:IFrameWindow;
        private var _SafeStr_1936:int;
        private var _sliders:Vector.<BackgroundColorWidgetSlider> = new Vector.<BackgroundColorWidgetSlider>();
        private var _SafeStr_1937:int;
        private var _saturation:int;
        private var _SafeStr_1938:int;

        public function BackgroundColorFurniWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null, _arg_4:IHabboLocalizationManager=null)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            this.handler.widget = this;
        }

        public function get handler():FurnitureBackgroundColorWidgetHandler
        {
            return (_SafeStr_3915 as FurnitureBackgroundColorWidgetHandler);
        }

        override public function dispose():void
        {
            destroyWindow();
            super.dispose();
        }

        public function open(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            _SafeStr_1936 = _arg_1;
            _SafeStr_1937 = Math.max(_arg_2, 0);
            _saturation = Math.max(_arg_3, 0);
            _SafeStr_1938 = Math.max(_arg_4, 0);
            createWindow();
        }

        public function setParameterCallback(_arg_1:String, _arg_2:int):void
        {
            switch (_arg_1)
            {
                case "hue":
                    _SafeStr_1937 = _arg_2;
                    break;
                case "saturation":
                    _saturation = _arg_2;
                    break;
                case "lightness":
                    _SafeStr_1938 = _arg_2;
            };
            renderColorPreview();
        }

        private function createWindow():void
        {
            if (!_window)
            {
                _window = IFrameWindow(windowManager.buildFromXML((assets.getAssetByName("background_color_ui_xml").content as XML)));
                _window.procedure = windowProcedure;
                _window.center();
                _sliders.push(new BackgroundColorWidgetSlider(this, "hue", IWindowContainer(_window.findChildByName("hue_container")), _SafeStr_1937));
                _sliders.push(new BackgroundColorWidgetSlider(this, "saturation", IWindowContainer(_window.findChildByName("saturation_container")), _saturation));
                _sliders.push(new BackgroundColorWidgetSlider(this, "lightness", IWindowContainer(_window.findChildByName("lightness_container")), _SafeStr_1938));
            };
        }

        private function destroyWindow():void
        {
            for each (var _local_1:BackgroundColorWidgetSlider in _sliders)
            {
                _local_1.dispose();
            };
            _sliders = new Vector.<BackgroundColorWidgetSlider>();
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
        }

        private function renderColorPreview():void
        {
            if (_window == null)
            {
                return;
            };
            var _local_3:IBitmapWrapperWindow = IBitmapWrapperWindow(_window.findChildByName("color_preview_bitmap"));
            var _local_2:BitmapData = new BitmapData(_local_3.width, _local_3.height, false);
            var _local_1:uint = ColorConverter.hslToRGB(((((_SafeStr_1937 & 0xFF) << 16) + ((_saturation & 0xFF) << 8)) + (_SafeStr_1938 & 0xFF)));
            _local_2.fillRect(_local_2.rect, _local_1);
            _local_3.bitmap = _local_2;
        }

        private function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((!(_arg_2 == null)) && (_arg_1.type == "WME_CLICK")))
            {
                switch (_arg_2.name)
                {
                    case "apply_button":
                        handler.container.connection.send(new SetRoomBackgroundColorDataComposer(_SafeStr_1936, _SafeStr_1937, _saturation, _SafeStr_1938));
                        return;
                    case "on_off_button":
                        handler.container.connection.send(new UseFurnitureMessageComposer(_SafeStr_1936));
                        return;
                    case "header_button_close":
                        destroyWindow();
                        return;
                };
            };
        }


    }
}

