package com.sulake.habbo.window.utils
{
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.assets.IAssetLibrary;

    public class LimitedItemOverlayNumberBitmapGenerator 
    {

        private static const GLYPH_ASSET_PREFIX:String = "unique_item_number_glyph_";


        public static function createBitmap(_arg_1:IAssetLibrary, _arg_2:int, _arg_3:int, _arg_4:int):BitmapData
        {
            var _local_14:BitmapDataAsset;
            var _local_6:int;
            var _local_9:BitmapData = new BitmapData(_arg_3, _arg_4, true, 0);
            var _local_12:int = (_arg_2 % 10);
            var _local_5:int = int(((_arg_2 / 10) % 10));
            var _local_13:int = int(((_arg_2 / 100) % 10));
            var _local_7:int = int(((_arg_2 / 1000) % 10));
            var _local_10:Array = [];
            var _local_11:int;
            if (_local_7 > 0)
            {
                _local_14 = BitmapDataAsset(_arg_1.getAssetByName(("unique_item_number_glyph_" + _local_7)));
                _local_10.push(_local_14);
                _local_11 = (_local_11 + _local_14.rectangle.width);
            };
            if (((_local_7 > 0) || (_local_13 > 0)))
            {
                _local_14 = BitmapDataAsset(_arg_1.getAssetByName(("unique_item_number_glyph_" + _local_13)));
                _local_10.push(_local_14);
                _local_11 = (_local_11 + _local_14.rectangle.width);
            };
            if ((((_local_7 > 0) || (_local_13 > 0)) || (_local_5 > 0)))
            {
                _local_14 = BitmapDataAsset(_arg_1.getAssetByName(("unique_item_number_glyph_" + _local_5)));
                _local_10.push(_local_14);
                _local_11 = (_local_11 + _local_14.rectangle.width);
            };
            _local_14 = BitmapDataAsset(_arg_1.getAssetByName(("unique_item_number_glyph_" + _local_12)));
            _local_10.push(_local_14);
            _local_11 = (_local_11 + _local_14.rectangle.width);
            _local_11 = (_local_11 - 1);
            var _local_8:Point = new Point(((_arg_3 - _local_11) / 2), 0);
            while (_local_6 < _local_10.length)
            {
                _local_14 = _local_10[_local_6];
                _local_9.copyPixels(BitmapData(_local_14.content), _local_14.rectangle, _local_8);
                _local_8.x = (_local_8.x + _local_14.rectangle.width);
                _local_6++;
            };
            return (_local_9);
        }


    }
}