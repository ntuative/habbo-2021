package com.sulake.habbo.ui.widget.furniture
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.handler.FurnitureCustomStackHeightWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetCustomStackingHeightComposer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class CustomStackHeightWidget extends RoomWidgetBase 
    {

        private static const SLIDER_RANGE:int = 10;
        private static const MAX_HEIGHT:int = 40;
        private static const SLIDER_BUTTON_WIDTH:int = 20;

        private var _mainWindow:IWindowContainer;
        private var _SafeStr_1936:int;

        public function CustomStackHeightWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null, _arg_4:IHabboLocalizationManager=null)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            FurnitureCustomStackHeightWidgetHandler(_arg_1).widget = this;
        }

        override public function dispose():void
        {
            destroyWindow();
            super.dispose();
        }

        override public function get mainWindow():IWindow
        {
            return (_mainWindow);
        }

        private function createWindow():void
        {
            if (!_mainWindow)
            {
                _mainWindow = IWindowContainer(windowManager.buildFromXML(XML(assets.getAssetByName("custom_stack_height_xml").content)));
                _mainWindow.procedure = windowProcedure;
                _mainWindow.center();
            };
        }

        public function open(_arg_1:int, _arg_2:Number):void
        {
            _SafeStr_1936 = _arg_1;
            _arg_2 = Math.min(_arg_2, 40);
            if (_mainWindow == null)
            {
                createWindow();
            };
            _mainWindow.findChildByName("input_height").caption = _arg_2.toString();
            updateSlider();
            _mainWindow.visible = true;
        }

        public function hide():void
        {
            if (_mainWindow == null)
            {
                return;
            };
            _mainWindow.visible = false;
        }

        private function destroyWindow():void
        {
            if (_mainWindow)
            {
                _mainWindow.procedure = null;
                _mainWindow.dispose();
                _mainWindow = null;
            };
        }

        private function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_2 == null)
            {
                return;
            };
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "button_floor_level":
                        altitude = 0;
                        sendCurrentHeight();
                        break;
                    case "button_above_stack":
                        handler.container.connection.send(new SetCustomStackingHeightComposer(_SafeStr_1936));
                        break;
                    case "header_button_close":
                        destroyWindow();
                        break;
                    case "slider":
                        _mainWindow.findChildByName("slider_button").x = WindowMouseEvent(_arg_1).localX;
                        sendCurrentHeight();
                };
            }
            else
            {
                if (((_arg_1.type == "WME_UP") || (_arg_1.type == "WME_UP_OUTSIDE")))
                {
                    switch (_arg_2.name)
                    {
                        case "slider_button":
                            sendCurrentHeight();
                    };
                }
                else
                {
                    if (_arg_1.type == "WME_DOUBLE_CLICK")
                    {
                        switch (_arg_2.name)
                        {
                            case "slider_button":
                                updateHeightSelection(true);
                                sendCurrentHeight();
                        };
                    }
                    else
                    {
                        if (_arg_1.type == "WE_RELOCATED")
                        {
                            switch (_arg_2.name)
                            {
                                case "slider_button":
                                    updateHeightSelection();
                            };
                        }
                        else
                        {
                            if (_arg_1.type == "WKE_KEY_DOWN")
                            {
                                if (_arg_2.name == "input_height")
                                {
                                    if (WindowKeyboardEvent(_arg_1).keyCode == 13)
                                    {
                                        updateSlider();
                                        sendCurrentHeight();
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }

        private function sendCurrentHeight():void
        {
            var _local_1:int = (parseFloat(_mainWindow.findChildByName("input_height").caption) * 100);
            handler.container.connection.send(new SetCustomStackingHeightComposer(_SafeStr_1936, _local_1));
        }

        private function updateSlider():void
        {
            var _local_3:Number = parseFloat(_mainWindow.findChildByName("input_height").caption);
            var _local_1:Number = (_local_3 / 10);
            _local_1 = Math.min(_local_1, 1);
            var _local_2:Number = (_mainWindow.findChildByName("slider").width - 20);
            _mainWindow.procedure = null;
            _mainWindow.findChildByName("slider_button").x = (_local_2 * _local_1);
            _mainWindow.procedure = windowProcedure;
        }

        private function updateHeightSelection(_arg_1:Boolean=false):void
        {
            var _local_4:int = ((_arg_1) ? 1 : 100);
            var _local_3:Number = (_mainWindow.findChildByName("slider").width - 20);
            var _local_2:Number = (_mainWindow.findChildByName("slider_button").x / _local_3);
            var _local_5:Number = ((_local_2 * 10) * _local_4);
            _mainWindow.findChildByName("input_height").caption = (_local_5 / (_local_4 * 1)).toString();
        }

        private function get handler():FurnitureCustomStackHeightWidgetHandler
        {
            return (_SafeStr_3915 as FurnitureCustomStackHeightWidgetHandler);
        }

        private function set altitude(_arg_1:Number):void
        {
            if (_mainWindow != null)
            {
                _mainWindow.findChildByName("input_height").caption = _arg_1.toString();
                updateSlider();
            };
        }

        public function updateHeight(_arg_1:int, _arg_2:Number):void
        {
            if (_SafeStr_1936 == _arg_1)
            {
                altitude = _arg_2;
            };
        }


    }
}

