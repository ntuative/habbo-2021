package com.sulake.habbo.ui.widget.avatarinfo
{
    import com.sulake.habbo.ui.widget.events.UseProductItem;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;

    public class UseProductView extends AvatarContextInfoButtonView 
    {

        private static const MODE_NORMAL:int = 0;
        private static const MODE_SHAMPOO:int = 1;
        private static const MODE_CUSTOM_PART:int = 2;
        private static const MODE_CUSTOM_PART_SHAMPOO:int = 3;
        private static const MODE_SADDLE:int = 4;
        private static const MODE_REVIVE:int = 5;
        private static const MODE_REBREED:int = 6;
        private static const MODE_FERTILIZE:int = 7;

        private var _SafeStr_1493:int;
        private var _SafeStr_3927:UseProductItem;

        public function UseProductView(_arg_1:AvatarInfoWidget)
        {
            super(_arg_1);
            _SafeStr_3885 = false;
        }

        public static function setup(_arg_1:UseProductView, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:int, _arg_6:UseProductItem):void
        {
            _arg_1._SafeStr_3927 = _arg_6;
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
            var _local_1:IFurnitureData;
            var _local_2:int = widget.handler.roomSession.roomId;
            var _local_3:IRoomObject = widget.handler.roomEngine.getRoomObject(_local_2, _SafeStr_3927.requestRoomObjectId, 10);
            if (_local_3 != null)
            {
                _local_1 = widget.handler.getFurniData(_local_3);
            }
            else
            {
                _local_1 = widget.handler.container.sessionDataManager.getFloorItemData(_SafeStr_3927.requestRoomObjectId);
            };
            if (!_local_1)
            {
                return;
            };
            _SafeStr_1493 = 0;
            switch (_local_1.category)
            {
                case 13:
                    _SafeStr_1493 = 1;
                    return;
                case 14:
                    _SafeStr_1493 = 2;
                    return;
                case 15:
                    _SafeStr_1493 = 3;
                    return;
                case 16:
                    _SafeStr_1493 = 4;
                    return;
                case 20:
                    _SafeStr_1493 = 5;
                    return;
                case 21:
                    _SafeStr_1493 = 6;
                    return;
                case 22:
                    _SafeStr_1493 = 7;
                    return;
                default:
                    Logger.log(("[UseProductView.open()] Unsupported furniture category: " + _local_1.category));
            };
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
                    _local_1 = (XmlAsset(_SafeStr_1324.assets.getAssetByName("use_product_menu")).content as XML);
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
                    showButton("use_product");
                    break;
                case 1:
                    showButton("use_product_shampoo");
                    break;
                case 2:
                    showButton("use_product_custom_part");
                    break;
                case 3:
                    showButton("use_product_custom_part_shampoo");
                    break;
                case 4:
                    if (_SafeStr_3927.replace)
                    {
                        showButton("replace_product_saddle");
                    }
                    else
                    {
                        showButton("use_product_saddle");
                    };
                    break;
                case 5:
                    showButton("revive_monsterplant");
                    break;
                case 6:
                    showButton("rebreed_monsterplant");
                    break;
                case 7:
                    showButton("fertilize_monsterplant");
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
                        case "use_product":
                        case "use_product_shampoo":
                        case "use_product_custom_part":
                        case "use_product_custom_part_shampoo":
                        case "use_product_saddle":
                        case "replace_product_saddle":
                        case "revive_monsterplant":
                        case "rebreed_monsterplant":
                        case "fertilize_monsterplant":
                            widget.showUseProductConfirmation(_SafeStr_3927.requestRoomObjectId, _SafeStr_3927.targetRoomObjectId, _SafeStr_3927.requestInventoryStripId);
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
                widget.removeUseProductViews();
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

