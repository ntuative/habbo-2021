package com.sulake.habbo.window.utils.floorplaneditor
{
    import __AS3__.vec.Vector;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
    import flash.geom.Point;

    public class FloorPlanPreviewer 
    {

        public static var tile_preview_0:Class = HabboFloorPlanPreviewer_Habbotile_preview_0_png;
        public static var tile_preview_1:Class = HabboFloorPlanPreviewer_Habbotile_preview_1_png;
        public static var tile_preview_2:Class = HabboFloorPlanPreviewer_Habbotile_preview_2_png;
        public static var tile_preview_3:Class = HabboFloorPlanPreviewer_Habbotile_preview_3_png;
        public static var tile_preview_4:Class = HabboFloorPlanPreviewer_Habbotile_preview_4_png;
        public static var tile_preview_5:Class = HabboFloorPlanPreviewer_Habbotile_preview_5_png;
        public static var tile_preview_6:Class = HabboFloorPlanPreviewer_Habbotile_preview_6_png;
        public static var tile_preview_7:Class = HabboFloorPlanPreviewer_Habbotile_preview_7_png;
        public static var tile_preview_8:Class = HabboFloorPlanPreviewer_Habbotile_preview_8_png;
        public static var tile_preview_9:Class = HabboFloorPlanPreviewer_Habbotile_preview_9_png;
        public static var tile_preview_a:Class = HabboFloorPlanPreviewer_Habbotile_preview_a_png;
        public static var tile_preview_b:Class = HabboFloorPlanPreviewer_Habbotile_preview_b_png;
        public static var tile_preview_c:Class = HabboFloorPlanPreviewer_Habbotile_preview_c_png;
        public static var tile_preview_d:Class = HabboFloorPlanPreviewer_Habbotile_preview_d_png;
        public static var tile_preview_e:Class = HabboFloorPlanPreviewer_Habbotile_preview_e_png;
        public static var tile_preview_f:Class = HabboFloorPlanPreviewer_Habbotile_preview_f_png;
        public static var tile_preview_entry:Class = HabboFloorPlanPreviewer_Habbotile_preview_entry_png;

        private var _bcFloorPlanEditor:BCFloorPlanEditor;
        private var _tileImages:Vector.<BitmapData>;
        private var _floorPlan:FloorPlanCache;

        public function FloorPlanPreviewer(_arg_1:BCFloorPlanEditor)
        {
            _bcFloorPlanEditor = _arg_1;
            _floorPlan = _arg_1.floorPlanCache;
            _tileImages = new Vector.<BitmapData>(0);
            _tileImages.push(Bitmap(new tile_preview_0()).bitmapData);
            _tileImages.push(Bitmap(new tile_preview_1()).bitmapData);
            _tileImages.push(Bitmap(new tile_preview_2()).bitmapData);
            _tileImages.push(Bitmap(new tile_preview_3()).bitmapData);
            _tileImages.push(Bitmap(new tile_preview_4()).bitmapData);
            _tileImages.push(Bitmap(new tile_preview_5()).bitmapData);
            _tileImages.push(Bitmap(new tile_preview_6()).bitmapData);
            _tileImages.push(Bitmap(new tile_preview_7()).bitmapData);
            _tileImages.push(Bitmap(new tile_preview_8()).bitmapData);
            _tileImages.push(Bitmap(new tile_preview_9()).bitmapData);
            _tileImages.push(Bitmap(new tile_preview_a()).bitmapData);
            _tileImages.push(Bitmap(new tile_preview_b()).bitmapData);
            _tileImages.push(Bitmap(new tile_preview_c()).bitmapData);
            _tileImages.push(Bitmap(new tile_preview_d()).bitmapData);
            _tileImages.push(Bitmap(new tile_preview_e()).bitmapData);
            _tileImages.push(Bitmap(new tile_preview_f()).bitmapData);
            _tileImages.push(Bitmap(new tile_preview_entry()).bitmapData);
        }

        private static function getCanvasPoint(_arg_1:int, _arg_2:int, _arg_3:int):Point
        {
            return (new Point((8 * (_arg_1 - _arg_2)), ((4 * (_arg_1 + _arg_2)) - (8 * _arg_3))));
        }


        public function updatePreview():void
        {
            var _local_20:int;
            var _local_22:int;
            var _local_23:int;
            var _local_11:Point;
            var _local_5:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_4:int;
            var _local_16:int;
            var _local_15:Array = [];
            var _local_18:Number = 2147483647;
            var _local_17:Number = 2147483647;
            var _local_2:Number = -2147483648;
            var _local_1:Number = -2147483648;
            _local_22 = 0;
            while (_local_22 < _floorPlan.floorHeight)
            {
                _local_20 = 0;
                while (_local_20 < _floorPlan.floorWidth)
                {
                    _local_23 = _floorPlan.getHeightAt(_local_20, _local_22);
                    if (_local_23 >= 0)
                    {
                        _local_11 = getCanvasPoint(_local_20, _local_22, _local_23);
                        _local_18 = Math.min(_local_18, _local_11.x);
                        _local_17 = Math.min(_local_17, _local_11.y);
                        _local_2 = Math.max(_local_2, _local_11.x);
                        _local_1 = Math.max(_local_1, _local_11.y);
                        _local_5 = _floorPlan.getHeightAt((_local_20 - 1), (_local_22 - 1));
                        _local_7 = _floorPlan.getHeightAt(_local_20, (_local_22 - 1));
                        _local_8 = _floorPlan.getHeightAt((_local_20 + 1), (_local_22 - 1));
                        _local_9 = _floorPlan.getHeightAt((_local_20 - 1), _local_22);
                        _local_10 = _floorPlan.getHeightAt((_local_20 + 1), _local_22);
                        _local_12 = _floorPlan.getHeightAt((_local_20 - 1), (_local_22 + 1));
                        _local_13 = _floorPlan.getHeightAt(_local_20, (_local_22 + 1));
                        _local_14 = _floorPlan.getHeightAt((_local_20 + 1), (_local_22 + 1));
                        _local_4 = (_local_23 + 1);
                        _local_16 = (((((((_local_5 == _local_4) || (_local_7 == _local_4)) || (_local_9 == _local_4)) ? 1 : 0) | ((((_local_8 == _local_4) || (_local_7 == _local_4)) || (_local_10 == _local_4)) ? 2 : 0)) | ((((_local_12 == _local_4) || (_local_13 == _local_4)) || (_local_9 == _local_4)) ? 4 : 0)) | ((((_local_14 == _local_4) || (_local_13 == _local_4)) || (_local_10 == _local_4)) ? 8 : 0));
                        if (_local_16 == 15)
                        {
                            _local_16 = 0;
                        };
                        if (_floorPlan.isEntryPoint(_local_20, _local_22))
                        {
                            _local_16 = (_tileImages.length - 1);
                        };
                        _local_15.push({
                            "point":_local_11,
                            "type":_local_16
                        });
                    };
                    _local_20++;
                };
                _local_22++;
            };
            var _local_21:int = Math.min(((_local_2 - _local_18) + 18), 4095);
            var _local_24:int = Math.min(((_local_1 - _local_17) + 18), 4095);
            var _local_19:BitmapData = new BitmapData(_local_21, _local_24, false, 0xFFFFFFFF);
            var _local_3:Point = new Point(-(_local_18), -(_local_17));
            for each (var _local_6:Object in _local_15)
            {
                _local_19.copyPixels(_tileImages[_local_6.type], _tileImages[_local_6.type].rect, _local_6.point.add(_local_3));
            };
            _bcFloorPlanEditor.updatePreviewBitmap(_local_19);
        }


    }
}