package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.catalog.viewer.IDragAndDropDoneReceiver;
    import flash.display.BitmapData;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetInitPurchaseEvent;
    import com.sulake.habbo.room._SafeStr_147;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetUpdateRoomPreviewEvent;
    import flash.geom.Point;

    public class RoomPreviewCatalogWidget extends CatalogWidget implements ICatalogWidget, IGetImageListener, IDragAndDropDoneReceiver 
    {

        private var _imageResultIdRoom:int = -1;
        private var _SafeStr_1613:int = -1;
        private var _SafeStr_1614:BitmapData = null;
        private var _SafeStr_1615:BitmapData = null;
        private var _SafeStr_1616:Object;
        private var _offer:IPurchasableOffer;

        public function RoomPreviewCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }

        override public function dispose():void
        {
            if (_SafeStr_1614 != null)
            {
                _SafeStr_1614.dispose();
                _SafeStr_1614 = null;
            };
            if (_SafeStr_1615 != null)
            {
                _SafeStr_1615.dispose();
                _SafeStr_1615 = null;
            };
            events.removeEventListener("UPDATE_ROOM_PREVIEW", onUpdateRoomPreview);
            super.dispose();
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            var _local_1:IBitmapWrapperWindow = (window.getChildByName("catalog_floor_preview_example") as IBitmapWrapperWindow);
            _local_1.procedure = eventProc;
            events.addEventListener("UPDATE_ROOM_PREVIEW", onUpdateRoomPreview);
            events.addEventListener("SELECT_PRODUCT", onPreviewProduct);
            return (true);
        }

        private function onPreviewProduct(_arg_1:SelectProductEvent):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _offer = _arg_1.offer;
        }

        private function eventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
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
                    _SafeStr_1616 = _arg_2;
                }
                else
                {
                    if ((((_arg_1.type == "WME_OUT") && (!(_SafeStr_1616 == null))) && (_SafeStr_1616 == _arg_2)))
                    {
                        if (_offer)
                        {
                            (page.viewer.catalog as HabboCatalog).requestSelectedItemToMover(this, _offer);
                            _SafeStr_1616 = null;
                        };
                    }
                    else
                    {
                        if (_arg_1.type == "WME_UP")
                        {
                            (_SafeStr_1616 == null);
                        }
                        else
                        {
                            if (_arg_1.type == "WME_CLICK")
                            {
                                (_SafeStr_1616 == null);
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

        public function onDragAndDropDone(_arg_1:Boolean, _arg_2:String):void
        {
            if (disposed)
            {
                return;
            };
            if (_arg_1)
            {
                events.dispatchEvent(new CatalogWidgetInitPurchaseEvent(false, _arg_2));
            };
        }

        public function stopDragAndDrop():void
        {
        }

        private function onUpdateRoomPreview(_arg_1:CatalogWidgetUpdateRoomPreviewEvent):void
        {
            var _local_4:BitmapData;
            var _local_2:BitmapData;
            var _local_6:String = "ads_twi_windw";
            var _local_3:_SafeStr_147 = page.viewer.roomEngine.getRoomImage(_arg_1.floorType, _arg_1.wallType, _arg_1.landscapeType, _arg_1.tileSize, this, _local_6);
            var _local_5:_SafeStr_147 = page.viewer.roomEngine.getGenericRoomObjectImage(_local_6, "", new Vector3d(180, 0, 0), _arg_1.tileSize, this);
            if (((!(_local_3 == null)) && (!(_local_5 == null))))
            {
                _imageResultIdRoom = _local_3.id;
                _SafeStr_1613 = _local_5.id;
                _local_4 = (_local_3.data as BitmapData);
                _local_2 = (_local_5.data as BitmapData);
                if (_SafeStr_1614 != null)
                {
                    _SafeStr_1614.dispose();
                };
                if (_SafeStr_1615 != null)
                {
                    _SafeStr_1615.dispose();
                };
                _SafeStr_1614 = _local_4;
                _SafeStr_1615 = _local_2;
                setRoomImage(_local_4, _local_2);
            };
        }

        private function setRoomImage(_arg_1:BitmapData, _arg_2:BitmapData):void
        {
            var _local_3:IBitmapWrapperWindow;
            var _local_5:int;
            var _local_4:int;
            var _local_6:int;
            var _local_7:int;
            var _local_9:int;
            var _local_8:int;
            if ((((!(_arg_1 == null)) && (!(_arg_2 == null))) && (!(window.disposed))))
            {
                _local_3 = (window.getChildByName("catalog_floor_preview_example") as IBitmapWrapperWindow);
                if (_local_3 != null)
                {
                    if (_local_3.bitmap == null)
                    {
                        _local_3.bitmap = new BitmapData(_local_3.width, _local_3.height, true, 0xFFFFFF);
                    };
                    _local_5 = -45;
                    _local_4 = 20;
                    _local_3.bitmap.fillRect(_local_3.bitmap.rect, 0xFFFFFF);
                    _local_6 = int((((_local_3.width - _arg_1.width) / 2) + _local_5));
                    _local_7 = int((((_local_3.height - _arg_1.height) / 2) + _local_4));
                    _local_3.bitmap.copyPixels(_arg_1, _arg_1.rect, new Point(_local_6, _local_7), null, null, true);
                    _local_9 = int(((_local_3.width / 2) + _local_5));
                    _local_8 = (((_local_3.height / 2) + _local_4) - _arg_2.height);
                    _local_9 = (_local_9 + 1);
                    _local_8 = (_local_8 + 44);
                    _local_3.bitmap.copyPixels(_arg_2, _arg_2.rect, new Point(_local_9, _local_8), null, null, true);
                    _local_3.invalidate();
                };
            };
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            if (disposed)
            {
                return;
            };
            switch (_arg_1)
            {
                case _imageResultIdRoom:
                    _imageResultIdRoom = 0;
                    if (_SafeStr_1614 != null)
                    {
                        _SafeStr_1614.dispose();
                    };
                    _SafeStr_1614 = _arg_2;
                    break;
                case _SafeStr_1613:
                    _SafeStr_1613 = 0;
                    if (_SafeStr_1615 != null)
                    {
                        _SafeStr_1615.dispose();
                    };
                    _SafeStr_1615 = _arg_2;
            };
            if (((!(_SafeStr_1614 == null)) && (!(_SafeStr_1615 == null))))
            {
                setRoomImage(_SafeStr_1614, _SafeStr_1615);
            };
        }

        public function imageFailed(_arg_1:int):void
        {
        }


    }
}

