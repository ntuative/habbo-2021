package com.sulake.habbo.ui.widget.furniture.contextmenu
{
    import com.sulake.habbo.ui.widget.contextmenu.IContextMenuParentWidget;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniActionMessage;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class RandomTeleportContextMenuView extends FurnitureContextInfoView 
    {

        private var _SafeStr_1924:int;

        public function RandomTeleportContextMenuView(_arg_1:IContextMenuParentWidget)
        {
            super(_arg_1);
        }

        override protected function updateWindow():void
        {
            var _local_1:XML;
            if ((((!(_SafeStr_1324)) || (!(_SafeStr_1324.assets))) || (!(_SafeStr_1324.windowManager))))
            {
                return;
            };
            if (_SafeStr_2776)
            {
                activeView = getMinimizedView();
            }
            else
            {
                if (!_window)
                {
                    _local_1 = (XmlAsset(_SafeStr_1324.assets.getAssetByName("random_teleport_menu")).content as XML);
                    _window = (_SafeStr_1324.windowManager.buildFromXML(_local_1, 0) as IWindowContainer);
                    if (!_window)
                    {
                        return;
                    };
                    _window.addEventListener("WME_OVER", onMouseHoverEvent);
                    _window.addEventListener("WME_OUT", onMouseHoverEvent);
                    _window.findChildByName("minimize").addEventListener("WME_CLICK", onMinimize);
                    _window.findChildByName("minimize").addEventListener("WME_OVER", onMinimizeHover);
                    _window.findChildByName("minimize").addEventListener("WME_OUT", onMinimizeHover);
                };
                _window.findChildByName("furni_name").caption = "${furni.random_teleport.name}";
                _window.findChildByName("buttons").procedure = buttonEventProc;
                _window.visible = false;
                activeView = _window;
                _lockPosition = false;
            };
        }

        override protected function buttonEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if ((((disposed) || (!(_window))) || (_window.disposed)))
            {
                return;
            };
            var _local_3:Boolean;
            if (_arg_1.type == "WME_CLICK")
            {
                if (_arg_2.name == "button")
                {
                    switch (_arg_2.parent.name)
                    {
                        case "use":
                            _SafeStr_1324.messageListener.processWidgetMessage(new RoomWidgetFurniActionMessage("RWFAM_USE", _SafeStr_4065.getId(), _SafeStr_1924));
                    };
                };
                _local_3 = true;
            }
            else
            {
                super.buttonEventProc(_arg_1, _arg_2);
            };
            if (_local_3)
            {
                _SafeStr_1324.removeView(this, false);
            };
        }

        public function set objectCategory(_arg_1:int):void
        {
            _SafeStr_1924 = _arg_1;
        }


    }
}

