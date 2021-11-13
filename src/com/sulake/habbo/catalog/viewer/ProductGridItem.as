package com.sulake.habbo.catalog.viewer
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IInteractiveWindow;
    import com.sulake.core.window.events.WindowEvent;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.IAvatarImageListener;

    public class ProductGridItem implements IGridItem 
    {

        public static const GRID_ITEM_BORDER:String = "bg";

        protected var _SafeStr_570:IWindowContainer;
        private var _SafeStr_1654:IItemGrid;
        protected var _icon:IBitmapWrapperWindow;
        private var _disposed:Boolean = false;
        private var _SafeStr_1616:Object;
        private var _catalog:HabboCatalog;

        public function ProductGridItem(_arg_1:HabboCatalog)
        {
            _catalog = _arg_1;
            super();
        }

        public function get view():IWindowContainer
        {
            return (_SafeStr_570);
        }

        public function set grid(_arg_1:IItemGrid):void
        {
            _SafeStr_1654 = _arg_1;
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _disposed = true;
            _SafeStr_1654 = null;
            _icon = null;
            _catalog = null;
            if (_SafeStr_570 != null)
            {
                _SafeStr_570.dispose();
                _SafeStr_570 = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        protected function get catalog():HabboCatalog
        {
            return (_catalog);
        }

        public function activate():void
        {
            if (!_SafeStr_570)
            {
                return;
            };
            if (_SafeStr_570.findChildByTag("ITEM_HILIGHT"))
            {
                _SafeStr_570.findChildByTag("ITEM_HILIGHT").visible = true;
            }
            else
            {
                _SafeStr_570.getChildByName("bg").style = 0;
            };
        }

        public function deactivate():void
        {
            if (!_SafeStr_570)
            {
                return;
            };
            if (_SafeStr_570.findChildByTag("ITEM_HILIGHT"))
            {
                _SafeStr_570.findChildByTag("ITEM_HILIGHT").visible = false;
            }
            else
            {
                _SafeStr_570.getChildByName("bg").style = 3;
            };
        }

        public function set view(_arg_1:IWindowContainer):void
        {
            if (!_arg_1)
            {
                return;
            };
            _SafeStr_570 = _arg_1;
            _SafeStr_570.procedure = eventProc;
            _icon = (_SafeStr_570.findChildByName("image") as IBitmapWrapperWindow);
            if (_SafeStr_570.findChildByTag("ITEM_HILIGHT"))
            {
                _SafeStr_570.findChildByTag("ITEM_HILIGHT").visible = false;
            };
            var _local_2:IWindow = _SafeStr_570.findChildByName("multiContainer");
            if (_local_2)
            {
                _local_2.visible = false;
            };
        }

        public function setDraggable(_arg_1:Boolean):void
        {
            if (((_SafeStr_570 as IInteractiveWindow) && (_arg_1)))
            {
                (_SafeStr_570 as IInteractiveWindow).setMouseCursorForState(4, 5);
                (_SafeStr_570 as IInteractiveWindow).setMouseCursorForState((0x04 | 0x01), 5);
            };
        }

        private function eventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:Boolean;
            if (_arg_1.type == "WME_UP")
            {
                _SafeStr_1616 = null;
            }
            else
            {
                if (_arg_1.type == "WME_DOWN")
                {
                    if (_arg_2 == null)
                    {
                        return;
                    };
                    _SafeStr_1654.select(this, true);
                    _SafeStr_1616 = _arg_2;
                }
                else
                {
                    if ((((_arg_1.type == "WME_OUT") && (!(_SafeStr_1616 == null))) && (_SafeStr_1616 == _arg_2)))
                    {
                        _local_3 = _SafeStr_1654.startDragAndDrop(this);
                        if (_local_3)
                        {
                            _SafeStr_1616 = null;
                        };
                    }
                    else
                    {
                        if (_arg_1.type == "WME_UP")
                        {
                            _SafeStr_1616 = null;
                        }
                        else
                        {
                            if (_arg_1.type == "WME_CLICK")
                            {
                                _SafeStr_1616 = null;
                            }
                            else
                            {
                                if (_arg_1.type == "WME_DOUBLE_CLICK")
                                {
                                    _SafeStr_1616 = null;
                                };
                            };
                        };
                    };
                };
            };
        }

        public function setIconImage(_arg_1:BitmapData, _arg_2:Boolean):void
        {
            var _local_3:int;
            var _local_4:int;
            if (_arg_1 == null)
            {
                return;
            };
            if (((!(_icon == null)) && (!(_icon.disposed))))
            {
                _local_3 = int(((_icon.width - _arg_1.width) / 2));
                _local_4 = int(((_icon.height - _arg_1.height) / 2));
                if (_icon.bitmap == null)
                {
                    _icon.bitmap = new BitmapData(_icon.width, _icon.height, true, 0xFFFFFF);
                }
                else
                {
                    _icon.bitmap.fillRect(_icon.bitmap.rect, 0xFFFFFF);
                };
                _icon.bitmap.copyPixels(_arg_1, _arg_1.rect, new Point(_local_3, _local_4), null, null, false);
                _icon.invalidate();
            };
            if (_arg_2)
            {
                _arg_1.dispose();
            };
        }

        protected function renderAvatarImage(_arg_1:String, _arg_2:IAvatarImageListener):BitmapData
        {
            var _local_4:IAvatarImage = _catalog.avatarRenderManager.createAvatarImage(_arg_1, "h", null, _arg_2);
            var _local_3:BitmapData = _local_4.getCroppedImage("head", 0.5);
            _local_4.dispose();
            return (_local_3);
        }


    }
}

