package com.sulake.habbo.ui.widget.avatarinfo
{
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class DecorateModeView extends AvatarContextInfoButtonView 
    {

        public function DecorateModeView(_arg_1:AvatarInfoWidget, _arg_2:int, _arg_3:String, _arg_4:int)
        {
            super(_arg_1);
            _SafeStr_3885 = false;
            AvatarContextInfoButtonView.setup(this, _arg_2, _arg_3, _arg_4, 1);
        }

        override protected function updateWindow():void
        {
            var _local_1:XML;
            if ((((!(_SafeStr_1324)) || (!(_SafeStr_1324.assets))) || (!(_SafeStr_1324.windowManager))))
            {
                return;
            };
            if (!_window)
            {
                _local_1 = (XmlAsset(_SafeStr_1324.assets.getAssetByName("own_avatar_decorating")).content as XML);
                _window = (_SafeStr_1324.windowManager.buildFromXML(_local_1, 0) as IWindowContainer);
                if (!_window)
                {
                    return;
                };
                _window.addEventListener("WME_OVER", onMouseHoverEvent);
                _window.addEventListener("WME_OUT", onMouseHoverEvent);
                _buttons = (_window.findChildByName("buttons") as IItemListWindow);
                _buttons.procedure = eventProc;
                updateButtons();
            };
            activeView = _window;
        }

        override public function show():void
        {
            if (_SafeStr_3884 != null)
            {
                _SafeStr_3884.visible = true;
                _SafeStr_3884.activate();
            };
        }

        override public function hide(_arg_1:Boolean):void
        {
            if (_SafeStr_3884 != null)
            {
                _SafeStr_3884.visible = false;
            };
            _lockPosition = false;
        }

        override protected function set activeView(_arg_1:IWindowContainer):void
        {
            if (!_arg_1)
            {
                return;
            };
            _SafeStr_3884 = _arg_1;
        }

        public function isVisible():Boolean
        {
            return ((_SafeStr_3884) && (_SafeStr_3884.visible));
        }

        public function updateButtons():void
        {
            showButton("decorate");
        }

        private function eventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (disposed)
            {
                return;
            };
            if (((!(_window)) || (_window.disposed)))
            {
                return;
            };
            if (_arg_1.type == "WME_CLICK")
            {
                if (_arg_2.name == "button")
                {
                    switch (_arg_2.parent.name)
                    {
                        case "decorate":
                            widget.isUserDecorating = false;
                    };
                };
            }
            else
            {
                if (_arg_1.type == "WME_OVER")
                {
                    super.buttonEventProc(_arg_1, _arg_2);
                    _lockPosition = true;
                }
                else
                {
                    if (_arg_1.type == "WME_OUT")
                    {
                        super.buttonEventProc(_arg_1, _arg_2);
                        _lockPosition = false;
                    }
                    else
                    {
                        super.buttonEventProc(_arg_1, _arg_2);
                    };
                };
            };
        }

        override public function get maximumBlend():Number
        {
            return (0.8);
        }

        private function get widget():AvatarInfoWidget
        {
            return (_SafeStr_1324 as AvatarInfoWidget);
        }


    }
}

