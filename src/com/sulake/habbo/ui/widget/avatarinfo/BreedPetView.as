package com.sulake.habbo.ui.widget.avatarinfo
{
    import com.sulake.habbo.ui.widget.events.UseProductItem;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;

    public class BreedPetView extends AvatarContextInfoButtonView 
    {

        private static const MODE_NORMAL:int = 0;

        private var _SafeStr_1493:int;
        private var _SafeStr_3927:UseProductItem;
        private var _SafeStr_3928:Boolean;

        public function BreedPetView(_arg_1:AvatarInfoWidget)
        {
            super(_arg_1);
            _SafeStr_3885 = false;
        }

        public static function setup(_arg_1:BreedPetView, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:int, _arg_6:UseProductItem, _arg_7:Boolean):void
        {
            _arg_1._SafeStr_3927 = _arg_6;
            _arg_1._SafeStr_3928 = _arg_7;
            AvatarContextInfoButtonView.setup(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, false);
        }


        public function get objectId():int
        {
            return (_SafeStr_3927.id);
        }

        public function get requestRoomObjectId():int
        {
            return (_SafeStr_3927.requestRoomObjectId);
        }

        override public function dispose():void
        {
            if (_window)
            {
                _window.removeEventListener("WME_OVER", onMouseHoverEvent);
                _window.removeEventListener("WME_OUT", onMouseHoverEvent);
            };
            if (_SafeStr_3927)
            {
                _SafeStr_3927.dispose();
            };
            _SafeStr_3927 = null;
            super.dispose();
        }

        private function resolveMode():void
        {
            var _local_1:int = widget.handler.roomSession.roomId;
            _SafeStr_1493 = 0;
        }

        override protected function updateWindow():void
        {
            var _local_1:XML;
            if ((((!(_SafeStr_1324)) || (!(_SafeStr_1324.assets))) || (!(_SafeStr_1324.windowManager))))
            {
                return;
            };
            resolveMode();
            if (_SafeStr_2776)
            {
                activeView = getMinimizedView();
            }
            else
            {
                if (!_window)
                {
                    _local_1 = (XmlAsset(_SafeStr_1324.assets.getAssetByName("breed_pet_menu")).content as XML);
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
                _buttons = (_window.findChildByName("buttons") as IItemListWindow);
                _buttons.procedure = buttonEventProc;
                _window.findChildByName("name").caption = _userName;
                _window.visible = false;
                activeView = _window;
                updateButtons();
            };
        }

        public function updateButtons():void
        {
            var _local_2:int;
            if (((!(_window)) || (!(_buttons))))
            {
                return;
            };
            _buttons.autoArrangeItems = false;
            var _local_1:int = _buttons.numListItems;
            _local_2 = 0;
            while (_local_2 < _local_1)
            {
                _buttons.getListItemAt(_local_2).visible = false;
                _local_2++;
            };
            switch (_SafeStr_1493)
            {
                case 0:
                    if (_SafeStr_3928)
                    {
                        showButton("breed");
                    };
                default:
            };
            _buttons.autoArrangeItems = true;
            _buttons.visible = true;
        }

        override protected function buttonEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:RoomWidgetMessage = null;
            if (disposed)
            {
                return;
            };
            if (((!(_window)) || (_window.disposed)))
            {
                return;
            };
            var _local_3:Boolean;
            if (_arg_1.type == "WME_CLICK")
            {
                if (_arg_2.name == "button")
                {
                    _local_3 = true;
                    switch (_arg_2.parent.name)
                    {
                        case "breed":
                            widget.showBreedMonsterPlantsConfirmationView(_SafeStr_3927.requestRoomObjectId, _SafeStr_3927.targetRoomObjectId, false);
                    };
                };
                if (_local_4)
                {
                    _SafeStr_1324.messageListener.processWidgetMessage(_local_4);
                };
            }
            else
            {
                super.buttonEventProc(_arg_1, _arg_2);
            };
            if (_local_3)
            {
                widget.removeBreedPetViews();
            };
        }

        private function changeMode(_arg_1:int):void
        {
            _SafeStr_1493 = _arg_1;
            updateButtons();
        }

        private function get widget():AvatarInfoWidget
        {
            return (_SafeStr_1324 as AvatarInfoWidget);
        }


    }
}

