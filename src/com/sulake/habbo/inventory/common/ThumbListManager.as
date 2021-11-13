package com.sulake.habbo.inventory.common
{
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.inventory.IThumbListDrawableItem;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class ThumbListManager 
    {

        private var _SafeStr_2731:IThumbListDataProvider;
        private var _SafeStr_2732:int;
        private var _SafeStr_2733:int = 1;
        private var _SafeStr_2734:BitmapData;
        private var _SafeStr_2735:int;
        private var _listItemWidth:int;
        private var _viewWidth:int;
        private var _SafeStr_2730:int;
        private var _thumbWidth:int;
        private var _SafeStr_2736:int;
        private var _SafeStr_2729:BitmapData;
        private var _SafeStr_2737:BitmapData;

        public function ThumbListManager(_arg_1:IAssetLibrary, _arg_2:IThumbListDataProvider, _arg_3:String, _arg_4:String, _arg_5:int, _arg_6:int)
        {
            _SafeStr_2731 = _arg_2;
            var _local_7:BitmapDataAsset = BitmapDataAsset(_arg_1.getAssetByName(_arg_3));
            if (_local_7 != null)
            {
                _SafeStr_2729 = BitmapData(_local_7.content);
            };
            var _local_8:BitmapDataAsset = BitmapDataAsset(_arg_1.getAssetByName(_arg_4));
            if (_local_8 != null)
            {
                _SafeStr_2737 = BitmapData(_local_8.content);
            };
            _thumbWidth = _SafeStr_2729.width;
            _SafeStr_2736 = _SafeStr_2729.height;
            _viewWidth = _arg_5;
            _SafeStr_2730 = _arg_6;
            _SafeStr_2732 = Math.floor((_viewWidth / _thumbWidth));
            _SafeStr_2734 = new BitmapData(_viewWidth, _SafeStr_2730);
        }

        public function dispose():void
        {
            _SafeStr_2731 = null;
            _SafeStr_2734 = null;
        }

        public function updateImageFromList():void
        {
            var _local_5:int;
            var _local_3:int;
            var _local_1:IThumbListDrawableItem;
            var _local_2:BitmapData;
            _SafeStr_2733 = resolveRowCountFromList();
            if (_SafeStr_2733 == 0)
            {
                _SafeStr_2734 = new BitmapData(_viewWidth, _SafeStr_2730);
                return;
            };
            _SafeStr_2734 = new BitmapData(Math.max((_SafeStr_2732 * _thumbWidth), _viewWidth), Math.max((_SafeStr_2733 * _SafeStr_2736), _SafeStr_2730), true, 0xFFFFFF);
            _SafeStr_2734.fillRect(_SafeStr_2734.rect, 0xFFFFFFFF);
            var _local_6:int;
            var _local_4:Array = getList();
            _local_5 = 0;
            while (_local_5 < _SafeStr_2733)
            {
                _local_3 = 0;
                while (_local_3 < _SafeStr_2732)
                {
                    if (_local_6 < _local_4.length)
                    {
                        _local_1 = _local_4[_local_6];
                        if (_local_1 != null)
                        {
                            _local_2 = createThumbImage(_local_1.iconImage, _local_1.isSelected);
                            _SafeStr_2734.copyPixels(_local_2, _local_2.rect, new Point((_local_3 * _thumbWidth), (_local_5 * _SafeStr_2736)), null, null, true);
                        };
                        _local_6++;
                    };
                    _local_3++;
                };
                _local_5++;
            };
        }

        public function addItemAsFirst(_arg_1:IThumbListDrawableItem):void
        {
            var _local_2:BitmapData;
            var _local_4:Rectangle;
            if (_arg_1 == null)
            {
                return;
            };
            var _local_5:Point = resolveLastItemGridLoc();
            if (((_local_5.x == _SafeStr_2732) && (_SafeStr_2734.height < (_local_5.y * _SafeStr_2736))))
            {
                _local_2 = new BitmapData(_SafeStr_2734.width, (_SafeStr_2734.height + _SafeStr_2736));
            }
            else
            {
                _local_2 = new BitmapData(_SafeStr_2734.width, _SafeStr_2734.height);
            };
            var _local_3:BitmapData = createThumbImage(_arg_1.iconImage, _arg_1.isSelected);
            _local_2.copyPixels(_local_3, _local_3.rect, new Point(0, 0), null, null, true);
            _local_4 = new Rectangle(0, 0, (_thumbWidth * (_SafeStr_2732 - 1)), _SafeStr_2736);
            _local_2.copyPixels(_SafeStr_2734, _local_4, new Point(_thumbWidth, 0), null, null, true);
            _local_4 = new Rectangle((_thumbWidth * (_SafeStr_2732 - 1)), 0, _thumbWidth, _SafeStr_2734.height);
            _local_2.copyPixels(_SafeStr_2734, _local_4, new Point(0, _SafeStr_2736), null, null, true);
            _local_4 = new Rectangle(0, _SafeStr_2736, (_thumbWidth * (_SafeStr_2732 - 1)), (_SafeStr_2734.height - _SafeStr_2736));
            _local_2.copyPixels(_SafeStr_2734, _local_4, new Point(_thumbWidth, _SafeStr_2736), null, null, true);
            _SafeStr_2734 = _local_2;
        }

        public function replaceItemImage(_arg_1:int, _arg_2:IThumbListDrawableItem):void
        {
            if (_arg_2 == null)
            {
                return;
            };
            var _local_4:Point = resolveGridLocationFromIndex(_arg_1);
            var _local_5:Point = new Point((_local_4.x * _thumbWidth), (_local_4.y * _SafeStr_2736));
            var _local_3:BitmapData = createThumbImage(_arg_2.iconImage, _arg_2.isSelected);
            _SafeStr_2734.copyPixels(_local_3, _local_3.rect, _local_5, null, null, true);
        }

        public function getListImage():BitmapData
        {
            return (_SafeStr_2734);
        }

        public function removeItemInIndex(_arg_1:int):void
        {
            var _local_2:Point = resolveGridLocationFromIndex(_arg_1);
            removeItemInImage(_local_2);
        }

        public function removeItemInLocation(_arg_1:Point):void
        {
            var _local_2:Point = resolveGridLocationFromImage(_arg_1);
            removeItemInImage(_local_2);
        }

        public function updateListItem(_arg_1:int):void
        {
            var _local_2:IThumbListDrawableItem = getDrawableItem(_arg_1);
            replaceItemImage(_arg_1, _local_2);
        }

        private function getList():Array
        {
            var _local_1:Array;
            if (_SafeStr_2731 != null)
            {
                _local_1 = _SafeStr_2731.getDrawableList();
            };
            return ((_local_1) ? _local_1 : []);
        }

        private function getDrawableItem(_arg_1:int):IThumbListDrawableItem
        {
            var _local_2:Array = getList();
            if (((_arg_1 >= 0) && (_arg_1 < _local_2.length)))
            {
                return (_local_2[_arg_1] as IThumbListDrawableItem);
            };
            return (null);
        }

        private function resolveRowCountFromList():int
        {
            var _local_1:Array = getList();
            return (int(Math.ceil((_local_1.length / _SafeStr_2732))));
        }

        private function resolveLastItemGridLoc():Point
        {
            var _local_2:Array = getList();
            return (resolveGridLocationFromIndex((_local_2.length - 1)));
        }

        public function resolveIndexFromImageLocation(_arg_1:Point):int
        {
            var _local_3:Point = resolveGridLocationFromImage(_arg_1);
            return ((_local_3.y * _SafeStr_2732) + _local_3.x);
        }

        private function resolveGridLocationFromImage(_arg_1:Point):Point
        {
            var _local_2:int = int(Math.floor((_arg_1.y / _SafeStr_2736)));
            var _local_3:int = int(Math.floor((_arg_1.x / _thumbWidth)));
            return (new Point(_local_3, _local_2));
        }

        private function resolveGridLocationFromIndex(_arg_1:int):Point
        {
            var _local_2:int = int(Math.floor((_arg_1 / _SafeStr_2732)));
            var _local_3:int = (_arg_1 % _SafeStr_2732);
            return (new Point(_local_3, _local_2));
        }

        private function removeItemInImage(_arg_1:Point):void
        {
            var _local_7:Rectangle;
            var _local_3:Point;
            var _local_6:int;
            var _local_8:int;
            var _local_2:BitmapData;
            var _local_9:BitmapData;
            var _local_5:BitmapData;
            var _local_12:BitmapData = null;
            if (_arg_1.x >= _SafeStr_2732)
            {
                return;
            };
            if (_arg_1.y >= _SafeStr_2733)
            {
                return;
            };
            var _local_11:int = ((_SafeStr_2732 - _arg_1.x) - 1);
            _local_7 = new Rectangle(((_arg_1.x + 1) * _thumbWidth), (_arg_1.y * _SafeStr_2736), (_local_11 * _thumbWidth), _SafeStr_2736);
            _local_3 = new Point((_arg_1.x * _thumbWidth), (_arg_1.y * _SafeStr_2736));
            var _local_4:BitmapData = new BitmapData((_local_7.width + _thumbWidth), _local_7.height);
            _local_4.fillRect(_local_4.rect, 0xFFFFFFFF);
            _local_4.copyPixels(_SafeStr_2734, _local_7, new Point(0, 0), null, null, true);
            _SafeStr_2734.copyPixels(_local_4, _local_4.rect, _local_3, null, null, true);
            if (_arg_1.y < (_SafeStr_2733 - 1))
            {
                _local_6 = (_SafeStr_2734.width - _thumbWidth);
                _local_8 = (_SafeStr_2734.height - ((_arg_1.y + 1) * _SafeStr_2736));
                _local_2 = new BitmapData(_local_6, _local_8);
                _local_7 = new Rectangle(_thumbWidth, ((_arg_1.y + 1) * _SafeStr_2736), _local_2.width, _local_2.height);
                _local_2.copyPixels(_SafeStr_2734, _local_7, new Point(0, 0), null, null, true);
                _local_9 = new BitmapData(_thumbWidth, _local_7.height);
                _local_7.x = 0;
                _local_7.width = _thumbWidth;
                _local_9.copyPixels(_SafeStr_2734, _local_7, new Point(0, 0), null, null, true);
                _SafeStr_2734.fillRect(new Rectangle(0, (_SafeStr_2734.height - _SafeStr_2736), _SafeStr_2734.width, _SafeStr_2736), 0xFFFFFFFF);
                _local_3 = new Point((_SafeStr_2734.width - _thumbWidth), (_local_7.y - _SafeStr_2736));
                _SafeStr_2734.copyPixels(_local_9, _local_9.rect, _local_3, null, null, true);
                _local_3 = new Point(0, _local_7.y);
                _SafeStr_2734.copyPixels(_local_2, _local_2.rect, _local_3, null, null, true);
            };
            var _local_10:int = (getList().length - 1);
            if (_local_10 > 0)
            {
                _arg_1 = resolveGridLocationFromIndex(_local_10);
                if (_arg_1.x == (_SafeStr_2732 - 1))
                {
                    _local_5 = new BitmapData(_SafeStr_2734.width, (_SafeStr_2734.height - _SafeStr_2736));
                    _local_7 = new Rectangle(0, 0, _SafeStr_2734.width, (_SafeStr_2734.height - _SafeStr_2736));
                    _local_5.copyPixels(_SafeStr_2734, _local_7, new Point(0, 0), null, null, true);
                    _SafeStr_2734 = _local_5;
                    _SafeStr_2733--;
                };
            };
            if (_SafeStr_2734.height < _SafeStr_2730)
            {
                _local_12 = new BitmapData(_SafeStr_2734.width, _SafeStr_2730);
                _local_12.fillRect(_local_12.rect, 0xFFFFFFFF);
                _local_12.copyPixels(_SafeStr_2734, _SafeStr_2734.rect, new Point(0, 0), null, null, true);
                _SafeStr_2734 = _local_12;
            };
        }

        private function createThumbImage(_arg_1:BitmapData=null, _arg_2:Boolean=false):BitmapData
        {
            var _local_3:Point;
            var _local_4:BitmapData = new BitmapData(_SafeStr_2729.width, _SafeStr_2729.height);
            if (_arg_2)
            {
                _local_4.copyPixels(_SafeStr_2737, _SafeStr_2729.rect, new Point(0, 0), null, null, false);
            }
            else
            {
                _local_4.copyPixels(_SafeStr_2729, _SafeStr_2729.rect, new Point(0, 0), null, null, false);
            };
            if (_arg_1 != null)
            {
                _local_3 = new Point(((_local_4.width - _arg_1.width) / 2), ((_local_4.height - _arg_1.height) / 2));
                _local_4.copyPixels(_arg_1, _arg_1.rect, _local_3, null, null, true);
            };
            return (_local_4);
        }


    }
}

