package com.sulake.habbo.ui.widget.contextmenu
{
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.window.utils.IIterator;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class ButtonMenuView extends ContextInfoView 
    {

        protected static const ICON_MARGIN:int = 8;
        protected static const LINK_COLOR_MODERATE_DEFAULT:uint = 16744755;
        protected static const LINK_COLOR_MODERATE_HOVER:uint = 16756591;
        protected static const ICON_VIP:String = "icon_vip";
        protected static const ICON_DUCKET:String = "icon_ducket";
        protected static const ICON_ARROW_LEFT:String = "arrow_left";
        protected static const ICON_ARROW_RIGHT:String = "arrow_right";

        protected var _buttons:IItemListWindow;

        public function ButtonMenuView(_arg_1:IContextMenuParentWidget)
        {
            super(_arg_1);
        }

        override public function dispose():void
        {
            _buttons = null;
            super.dispose();
        }

        protected function showButtonGrid(_arg_1:String, _arg_2:Boolean=true):void
        {
            var _local_6:int;
            var _local_8:IWindowContainer;
            var _local_7:IBitmapWrapperWindow;
            if (!_buttons)
            {
                return;
            };
            var _local_3:IItemGridWindow = (_buttons.getListItemByName(_arg_1) as IItemGridWindow);
            if (!_local_3)
            {
                return;
            };
            _local_3.visible = _arg_2;
            var _local_4:IIterator = _local_3.iterator;
            var _local_5:int = _local_4.length;
            if (_local_5 > 0)
            {
                _local_6 = 0;
                while (_local_6 < _local_5)
                {
                    _local_8 = (_local_4[_local_6] as IWindowContainer);
                    _local_7 = (_local_8.findChildByTag("icon") as IBitmapWrapperWindow);
                    if (_local_7)
                    {
                        setImageAsset(_local_7, _local_7.name, true);
                    };
                    _local_6++;
                };
            };
        }

        protected function showButton(_arg_1:String, _arg_2:Boolean=true, _arg_3:Boolean=true, _arg_4:Boolean=false, _arg_5:Boolean=false):void
        {
            var _local_11:IIconWindow;
            var _local_8:IIconWindow;
            if (!_buttons)
            {
                return;
            };
            var _local_6:IWindowContainer = (_buttons.getListItemByName(_arg_1) as IWindowContainer);
            if (!_local_6)
            {
                return;
            };
            _local_6.visible = _arg_2;
            var _local_7:IWindowContainer = (_local_6.getChildByName("button") as IWindowContainer);
            _arg_3 = ((_arg_3) || (_arg_4));
            ((_arg_3) ? _local_7.enable() : _local_7.disable());
            var _local_10:ITextWindow = (_local_7.getChildByName("label") as ITextWindow);
            _local_10.textColor = (((_arg_3) && (!(_arg_4))) ? 0xFFFFFF : 5789011);
            var _local_9:IIconWindow = (_local_7.getChildByName("icon") as IIconWindow);
            if (_local_9)
            {
                _local_9.color = ((_arg_3) ? 13947341 : 5789011);
                if (_local_9.tags.indexOf("arrow_left") != -1)
                {
                    _local_9.x = (((_local_10.x + ((_local_10.width - _local_10.textWidth) / 2)) - _local_9.width) - 8);
                };
                if (_local_9.tags.indexOf("arrow_right") != -1)
                {
                    _local_9.x = ((_local_10.x + ((_local_10.width + _local_10.textWidth) / 2)) + 8);
                };
                _local_9.visible = ((_arg_4) || (_arg_5));
            };
            if (_arg_4)
            {
                _local_11 = (_local_7.getChildByName("icon_vip") as IIconWindow);
                if (_local_11)
                {
                    _local_11.visible = _arg_4;
                };
            };
            if (_arg_5)
            {
                _local_8 = (_local_7.getChildByName("icon_ducket") as IIconWindow);
                if (_local_8)
                {
                    _local_8.visible = _arg_5;
                };
            };
        }

        protected function buttonEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (disposed)
            {
                return;
            };
            if (((!(_window)) || (_window.disposed)))
            {
                return;
            };
            if (_arg_1.type == "WME_OVER")
            {
                if (_arg_2.name == "button")
                {
                    _arg_2.color = ((_arg_2.tags.indexOf("moderate") > -1) ? 0xFF993300 : 4282950861);
                }
                else
                {
                    if (_arg_2.tags.indexOf("link") > -1)
                    {
                        if (_arg_2.tags.indexOf("actions") > -1)
                        {
                            ITextWindow(IWindowContainer(_arg_2).getChildAt(0)).textColor = 9552639;
                        }
                        else
                        {
                            if (_arg_2.tags.indexOf("moderate") > -1)
                            {
                                ITextWindow(IWindowContainer(_arg_2).getChildAt(0)).textColor = 16756591;
                            };
                        };
                    };
                };
                if (_arg_2.name == "profile_link")
                {
                    ITextWindow(IWindowContainer(_arg_2).findChildByName("name")).textColor = 9552639;
                };
            }
            else
            {
                if (_arg_1.type == "WME_OUT")
                {
                    if (_arg_2.name == "button")
                    {
                        _arg_2.color = 4281149991;
                    }
                    else
                    {
                        if (_arg_2.tags.indexOf("link") > -1)
                        {
                            if (_arg_2.tags.indexOf("actions") > -1)
                            {
                                ITextWindow(IWindowContainer(_arg_2).getChildAt(0)).textColor = 0xFFFFFF;
                            }
                            else
                            {
                                if (_arg_2.tags.indexOf("moderate") > -1)
                                {
                                    ITextWindow(IWindowContainer(_arg_2).getChildAt(0)).textColor = 16744755;
                                };
                            };
                        };
                    };
                    if (_arg_2.name == "profile_link")
                    {
                        ITextWindow(IWindowContainer(_arg_2).findChildByName("name")).textColor = 0xFFFFFF;
                    };
                };
            };
        }


    }
}