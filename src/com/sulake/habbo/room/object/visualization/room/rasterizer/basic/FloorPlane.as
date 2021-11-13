package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import com.sulake.room.utils.Vector3d;
    import flash.geom.Point;
    import flash.display.BitmapData;
    import com.sulake.room.utils.IVector3d;

    public class FloorPlane extends Plane 
    {

        public static const DEFAULT_COLOR:uint = 0xFFFFFF;
        public static const HORIZONTAL_ANGLE_DEFAULT:Number = 45;
        public static const VERTICAL_ANGLE_DEFAULT:Number = 30;


        public function render(_arg_1:BitmapData, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:IVector3d, _arg_6:Boolean, _arg_7:Number, _arg_8:Number):BitmapData
        {
            var _local_14:Number;
            var _local_10:PlaneVisualization = getPlaneVisualization(_arg_4);
            if (((_local_10 == null) || (_local_10.geometry == null)))
            {
                return (null);
            };
            var _local_11:Point = _local_10.geometry.getScreenPoint(new Vector3d(0, 0, 0));
            var _local_12:Point = _local_10.geometry.getScreenPoint(new Vector3d(0, (_arg_3 / _local_10.geometry.scale), 0));
            var _local_13:Point = _local_10.geometry.getScreenPoint(new Vector3d((_arg_2 / _local_10.geometry.scale), 0, 0));
            var _local_9:int;
            var _local_15:int;
            if ((((!(_local_11 == null)) && (!(_local_12 == null))) && (!(_local_13 == null))))
            {
                _arg_2 = Math.round(Math.abs((_local_11.x - _local_13.x)));
                _arg_3 = Math.round(Math.abs((_local_11.x - _local_12.x)));
                _local_14 = (_local_11.x - _local_10.geometry.getScreenPoint(new Vector3d(1, 0, 0)).x);
                _local_9 = (_arg_7 * Math.abs(_local_14));
                _local_15 = (_arg_8 * Math.abs(_local_14));
            };
            return (_local_10.render(_arg_1, _arg_2, _arg_3, _arg_5, _arg_6, _local_9, _local_15));
        }


    }
}