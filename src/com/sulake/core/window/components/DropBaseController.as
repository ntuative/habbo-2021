package com.sulake.core.window.components
{
    import com.sulake.core.window.utils.tablet.ITouchAwareWindow;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.utils.PropertyStruct;

    public class DropBaseController extends InteractiveController implements ITouchAwareWindow 
    {

        protected static const CAPTION_BLEND_CHANGE:Number = 0.5;
        protected static const TEXT_FIELD_NAME:String = "_DROPLIST_TITLETEXT";
        protected static const ITEM_LIST_NAME:String = "_DROPLIST_ITEMLIST";
        protected static const REGION_NAME:String = "_DROPLIST_REGION";
        private static const SUB_WINDOW_MAX_DESKTOP_PADDING:int = 30;

        private var _SafeStr_901:Boolean = false;
        private var _SafeStr_902:Boolean = false;
        protected var _itemArray:Vector.<IWindow> = new Vector.<IWindow>();
        protected var _SafeStr_903:int = -1;
        protected var _menuIsOpen:Boolean = false;
        protected var _SafeStr_904:DropBaseController;

        public function DropBaseController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            _arg_4 = (_arg_4 | 0x01);
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            getRegion().addEventListener("WME_DOWN", menuItemEventHandler);
        }

        public function get selection():int
        {
            return (_SafeStr_903);
        }

        public function set selection(_arg_1:int):void
        {
            if (_arg_1 > (numMenuItems - 1))
            {
                throw (new Error("Menu selection index out of range!"));
            };
            var _local_2:WindowEvent = WindowEvent.allocate("WE_SELECT", this, null, true);
            update(this, _local_2);
            if (!_local_2.isWindowOperationPrevented())
            {
                _local_2.recycle();
                _SafeStr_903 = _arg_1;
                closeExpandedMenuView();
                _local_2 = WindowEvent.allocate("WE_SELECTED", this, null);
                update(this, _local_2);
            };
            _local_2.recycle();
        }

        override public function set caption(_arg_1:String):void
        {
            super.caption = _arg_1;
            var _local_2:ILabelWindow = getTitleLabel();
            if (_local_2)
            {
                _local_2.text = _arg_1;
            };
        }

        override public function dispose():void
        {
            getRegion().removeEventListener("WME_DOWN", menuItemEventHandler);
            if (((!(_SafeStr_904 == null)) && (!(_SafeStr_904.disposed))))
            {
                _SafeStr_904.destroy();
                _SafeStr_904 = null;
            };
            for each (var _local_1:IWindow in _itemArray)
            {
                _local_1.dispose();
            };
            _itemArray = null;
            super.dispose();
        }

        override public function activate():Boolean
        {
            if (_menuIsOpen)
            {
                return (true);
            };
            return (super.activate());
        }

        public function getTitleLabel():ILabelWindow
        {
            return (getChildByName("_DROPLIST_TITLETEXT") as ILabelWindow);
        }

        public function getItemList():IItemListWindow
        {
            return (getChildByName("_DROPLIST_ITEMLIST") as IItemListWindow);
        }

        public function getRegion():IRegionWindow
        {
            return (getChildByName("_DROPLIST_REGION") as IRegionWindow);
        }

        override public function populate(_arg_1:Array):void
        {
            var _local_2:IWindow;
            _menuIsOpen = true;
            closeExpandedMenuView();
            _SafeStr_903 = -1;
            while (_itemArray.length > 0)
            {
                _local_2 = _itemArray.pop();
                if (_arg_1.indexOf(_local_2) == -1)
                {
                    _local_2.dispose();
                };
            };
            var _local_3:uint;
            while (_local_3 < _arg_1.length)
            {
                _itemArray.push(_arg_1[_local_3]);
                _local_3++;
            };
        }

        protected function openExpandedMenuView():void
        {
            if (!_menuIsOpen)
            {
                if (open())
                {
                    if (numMenuItems > 0)
                    {
                        _menuIsOpen = true;
                        populateExpandedMenu(_itemArray, getExpandedMenuView(), subMenuEventProc);
                    };
                };
            };
        }

        protected function closeExpandedMenuView():void
        {
            var _local_1:IDropListItemWindow;
            var _local_4:IWindow;
            var _local_2:IItemListWindow;
            var _local_3:int;
            var _local_5:ILabelWindow;
            if (close())
            {
                if (_SafeStr_904 != null)
                {
                    _local_2 = _SafeStr_904.getItemList();
                    _local_2.autoArrangeItems = false;
                    _local_3 = 0;
                    while (_local_3 < _local_2.numListItems)
                    {
                        _local_1 = (_local_2.getListItemAt(_local_3) as IDropListItemWindow);
                        if (_local_1)
                        {
                            _local_4 = _local_1.value;
                            if (_itemArray.indexOf(_local_4) > -1)
                            {
                                _local_1.value = null;
                                _local_4.setParamFlag(3, false);
                            };
                        };
                        _local_3++;
                    };
                    _SafeStr_904.destroy();
                    _SafeStr_904 = null;
                };
                _menuIsOpen = false;
                if (!disposed)
                {
                    _local_5 = getTitleLabel();
                    _local_2 = getItemList();
                    if (_local_2)
                    {
                        while (_local_2.numListItems > 0)
                        {
                            _local_2.removeListItemAt(0);
                        };
                        if (((_SafeStr_903 < numMenuItems) && (_SafeStr_903 > -1)))
                        {
                            _local_4 = _itemArray[_SafeStr_903];
                            _local_4.x = 0;
                            _local_4.y = 0;
                            _local_2.addListItem(_local_4);
                            _local_2.height = _local_4.height;
                            _local_5.visible = false;
                        }
                        else
                        {
                            _local_5.visible = true;
                        };
                    };
                };
            };
        }

        private function getExpandedMenuView():DropBaseController
        {
            var _local_1:Rectangle = new Rectangle();
            getGlobalRectangle(_local_1);
            if (((_SafeStr_904 == null) || (_SafeStr_904.disposed)))
            {
                _SafeStr_904 = (context.create((name + "::subMenu"), "", type, _style, ((0x020000 | ((_SafeStr_901) ? 0x100000 : 0)) | 0x00), _local_1, subMenuEventProc, null, 0, null, "", ["_EXCLUDE"]) as DropBaseController);
            }
            else
            {
                _SafeStr_904.setGlobalRectangle(_local_1);
            };
            _SafeStr_904.activate();
            return (_SafeStr_904);
        }

        protected function populateExpandedMenu(_arg_1:Vector.<IWindow>, _arg_2:DropBaseController, _arg_3:Function):void
        {
            var _local_5:IDropListItemWindow;
            var _local_12:IWindow;
            var _local_7:IItemListWindow = _arg_2.getItemList();
            _local_7.autoArrangeItems = false;
            _arg_2.getRegion().visible = false;
            var _local_10:uint = _arg_1.length;
            var _local_9:int = _local_7.width;
            var _local_6:int = _local_9;
            var _local_8:int;
            var _local_11:uint;
            while (_local_11 < _local_10)
            {
                _local_12 = _arg_1[_local_11];
                _local_5 = (context.create((((name + "::menuItem[") + _local_11) + "]"), _local_12.caption, 106, _style, ((((0x00 | 0x00) | 0x10) | 0x01) | 0x00), null, _arg_3, null, _local_11, null, "", ["_EXCLUDE"]) as DropListItemController);
                _local_12.x = 0;
                _local_12.y = 0;
                _local_12.setParamFlag(3, true);
                _local_5.value = _local_12;
                _local_5.width = _local_5.value.width;
                _local_5.height = _local_5.value.height;
                _local_5.limits.minWidth = _local_9;
                _local_6 = Math.max(_local_6, _local_5.width);
                _local_8 = (_local_8 + _local_5.height);
                _local_7.addListItem(_local_5);
                _local_11++;
            };
            if (_local_6 > _local_9)
            {
                _arg_2.width = (_arg_2.width + (_local_6 - _local_7.width));
                _local_11 = 0;
                while (_local_11 < _local_10)
                {
                    _local_7.getListItemAt(_local_11).limits.minWidth = _local_6;
                    _local_11++;
                };
            };
            var _local_4:IWindow = context.create((name + "::padding"), "", 4, _style, (((0x00 | 0x00) | 0x10) | 0x00), new Rectangle(0, 0, 1, 3), null, null, 0, null, "", ["_EXCLUDE"]);
            _local_7.addListItem(_local_4);
            _local_7.autoArrangeItems = true;
            _local_8 = (_local_8 + _local_4.height);
            _local_8 = (_local_8 + (_local_7.spacing * _local_7.numListItems));
            _arg_2.height = Math.max(_arg_2.height, (_local_8 + 4));
            if ((param & 0x20))
            {
                fitToParent(_arg_2);
            }
            else
            {
                fitToDesktop(_arg_2);
            };
            _arg_2.activate();
            _local_7.height = Math.max(_local_7.height, (_arg_2.height - 4));
            if (((_SafeStr_903 > -1) && (_local_10)))
            {
                _local_7.getListItemAt(_SafeStr_903).setStateFlag(8, true);
            };
        }

        protected function fitToParent(_arg_1:IWindow):void
        {
            var _local_2:Rectangle = new Rectangle();
            _arg_1.getGlobalRectangle(_local_2);
            var _local_3:Rectangle = new Rectangle();
            parent.getGlobalRectangle(_local_3);
            if (_local_2.height > _local_3.height)
            {
                _arg_1.offset(0, (_local_3.top - _local_2.top));
                _arg_1.scale(0, (_local_3.height - _local_2.height));
                _arg_1.getGlobalRectangle(_local_2);
            };
            if (_local_2.bottom > _local_3.bottom)
            {
                _arg_1.offset(0, (_local_3.bottom - _local_2.bottom));
            }
            else
            {
                if (_local_2.top < _local_3.top)
                {
                    _arg_1.offset(0, (_local_2.top - _local_3.top));
                };
            };
            if (_local_2.left < _local_3.left)
            {
                _arg_1.offset((_local_2.left - _local_3.left), 0);
            }
            else
            {
                if (_local_2.right > _local_3.right)
                {
                    _arg_1.offset((_local_3.right - _local_2.right), 0);
                };
            };
        }

        protected function fitToDesktop(_arg_1:IWindow):void
        {
            var _local_2:Rectangle = new Rectangle();
            _arg_1.getGlobalRectangle(_local_2);
            if (_local_2.bottom > desktop.bottom)
            {
                _arg_1.offset(0, (desktop.bottom - _local_2.bottom));
            }
            else
            {
                if (_local_2.top < desktop.top)
                {
                    _arg_1.offset(0, (_local_2.top - desktop.top));
                };
            };
            if (_local_2.left < desktop.left)
            {
                _arg_1.offset((_local_2.left - desktop.left), 0);
            }
            else
            {
                if (_local_2.right > desktop.right)
                {
                    _arg_1.offset((desktop.right - _local_2.right), 0);
                };
            };
            if (_local_2.height > (desktop.height - 30))
            {
                _arg_1.height = (desktop.height - 30);
                _arg_1.y = 30;
            };
        }

        private function menuItemEventHandler(_arg_1:WindowEvent):void
        {
            if (getStateFlag(32))
            {
                return;
            };
            if (((_arg_1.type == "WME_DOWN") || (_arg_1.type == "WTE_TAP")))
            {
                if (!_menuIsOpen)
                {
                    openExpandedMenuView();
                };
            };
        }

        protected function subMenuEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            switch (_arg_1.type)
            {
                case "WTE_END":
                case "WME_UP":
                    if ((_arg_2 is IDropListItemWindow))
                    {
                        if (_arg_2.testStateFlag(4))
                        {
                            selection = resolveSelection(_arg_2);
                        };
                    };
                    return;
                case "WTE_BEGIN":
                case "WME_DOWN":
                    selection = resolveSelection(_arg_2);
                    return;
                case "WE_DEACTIVATED":
                    if (_arg_2 == _SafeStr_904)
                    {
                        if (((_SafeStr_902) && (_menuIsOpen))) break;
                        closeExpandedMenuView();
                    };
                    return;
            };
        }

        protected function resolveSelection(_arg_1:IWindow):int
        {
            var _local_2:int = _itemArray.indexOf(_arg_1);
            if (_local_2 == -1)
            {
                if ((_arg_1 is IDropListItemWindow))
                {
                    _local_2 = _itemArray.indexOf(IDropListItemWindow(_arg_1).value);
                };
            };
            if (_local_2 == -1)
            {
                return (_SafeStr_903);
            };
            return (_local_2);
        }

        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            switch (_arg_2.type)
            {
                case "WTE_BEGIN":
                case "WME_DOWN":
                    if (_menuIsOpen)
                    {
                        if (_SafeStr_902)
                        {
                            closeExpandedMenuView();
                        };
                    }
                    else
                    {
                        openExpandedMenuView();
                    };
                    break;
                case "WE_ENABLED":
                    try
                    {
                        getChildByName("_DROPLIST_REGION").visible = true;
                        getChildByName("_DROPLIST_TITLETEXT").blend = (getChildByName("_DROPLIST_TITLETEXT").blend + 0.5);
                    }
                    catch(e:Error)
                    {
                    };
                    break;
                case "WE_DISABLED":
                    try
                    {
                        getChildByName("_DROPLIST_REGION").visible = false;
                        getChildByName("_DROPLIST_TITLETEXT").blend = (getChildByName("_DROPLIST_TITLETEXT").blend - 0.5);
                    }
                    catch(e:Error)
                    {
                    };
            };
            return (super.update(_arg_1, _arg_2));
        }

        public function open():Boolean
        {
            if (getStateFlag(0))
            {
                return (true);
            };
            var _local_1:WindowEvent = WindowEvent.allocate("WE_OPEN", this, null);
            update(this, _local_1);
            if (_local_1.isDefaultPrevented())
            {
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            visible = true;
            _local_1 = WindowEvent.allocate("WE_OPENED", this, null);
            update(this, _local_1);
            _local_1.recycle();
            return (true);
        }

        public function close():Boolean
        {
            if (!getStateFlag(0))
            {
                return (true);
            };
            var _local_1:WindowEvent = WindowEvent.allocate("WE_CLOSE", this, null);
            update(this, _local_1);
            if (_local_1.isDefaultPrevented())
            {
                _local_1.recycle();
                return (false);
            };
            _local_1.recycle();
            visible = false;
            _local_1 = WindowEvent.allocate("WE_CLOSED", this, null);
            update(this, _local_1);
            _local_1.recycle();
            return (true);
        }

        public function get numMenuItems():int
        {
            return (_itemArray.length);
        }

        override public function get properties():Array
        {
            var _local_1:Array = super.properties;
            _local_1.push(createProperty("open_upward", _SafeStr_901));
            _local_1.push(createProperty("keep_open_on_deactivate", _SafeStr_902));
            return (_local_1);
        }

        override public function set properties(_arg_1:Array):void
        {
            for each (var _local_2:PropertyStruct in _arg_1)
            {
                switch (_local_2.key)
                {
                    case "open_upward":
                        _SafeStr_901 = _local_2.value;
                        break;
                    case "keep_open_on_deactivate":
                        _SafeStr_902 = _local_2.value;
                };
            };
            super.properties = _arg_1;
        }


    }
}

