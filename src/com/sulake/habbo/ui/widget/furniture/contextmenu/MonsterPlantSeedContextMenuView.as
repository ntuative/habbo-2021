package com.sulake.habbo.ui.widget.furniture.contextmenu
{
    import com.sulake.habbo.ui.widget.contextmenu.IContextMenuParentWidget;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowEvent;

    public class MonsterPlantSeedContextMenuView extends FurnitureContextInfoView 
    {

        private var _SafeStr_1924:int;

        public function MonsterPlantSeedContextMenuView(_arg_1:IContextMenuParentWidget)
        {
            super(_arg_1);
        }

        override protected function updateWindow():void
        {
            var _local_1:XML;
            var _local_2:IWindow;
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
                    _local_1 = (XmlAsset(_SafeStr_1324.assets.getAssetByName("monsterplant_seed_menu")).content as XML);
                    _window = (_SafeStr_1324.windowManager.buildFromXML(_local_1, 0) as IWindowContainer);
                    if (!_window)
                    {
                        return;
                    };
                    _window.addEventListener("WME_OVER", onMouseHoverEvent);
                    _window.addEventListener("WME_OUT", onMouseHoverEvent);
                    _local_2 = _window.findChildByName("minimize");
                    if (_local_2 != null)
                    {
                        _local_2.addEventListener("WME_CLICK", onMinimize);
                        _local_2.addEventListener("WME_OVER", onMinimizeHover);
                        _local_2.addEventListener("WME_OUT", onMinimizeHover);
                    };
                };
                _window.findChildByName("furni_name").caption = "${furni.mnstr_seed.name}";
                _window.findChildByName("buttons").procedure = buttonEventProc;
                _window.visible = false;
                activeView = _window;
                _lockPosition = false;
            };
        }

        override protected function buttonEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:FurnitureContextMenuWidget;
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
                            _local_4 = (_SafeStr_1324 as FurnitureContextMenuWidget);
                            if (_local_4 != null)
                            {
                                _local_4.showPlantSeedConfirmationDialog(_SafeStr_4065);
                            };
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

