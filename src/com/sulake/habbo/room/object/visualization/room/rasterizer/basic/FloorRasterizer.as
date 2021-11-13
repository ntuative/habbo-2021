package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import com.sulake.room.utils._SafeStr_93;
    import flash.display.BitmapData;
    import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;
    import com.sulake.room.utils.IVector3d;

    public class FloorRasterizer extends PlaneRasterizer 
    {


        override protected function initializePlanes():void
        {
            if (data == null)
            {
                return;
            };
            var _local_1:XMLList = data.floors;
            if (_local_1.length() > 0)
            {
                parseFloors(_local_1[0]);
            };
        }

        private function parseFloors(_arg_1:XML):void
        {
            var _local_4:int;
            var _local_7:XML;
            var _local_5:String;
            var _local_3:XMLList;
            var _local_6:FloorPlane;
            if (_arg_1 == null)
            {
                return;
            };
            var _local_2:XMLList = _arg_1.floor;
            _local_4 = 0;
            while (_local_4 < _local_2.length())
            {
                _local_7 = _local_2[_local_4];
                if (_SafeStr_93.checkRequiredAttributes(_local_7, ["id"]))
                {
                    _local_5 = _local_7.@id;
                    _local_3 = _local_7.visualization;
                    _local_6 = new FloorPlane();
                    parseVisualizations(_local_6, _local_3);
                    if (!addPlane(_local_5, _local_6))
                    {
                        _local_6.dispose();
                    };
                };
                _local_4++;
            };
        }

        override public function render(_arg_1:BitmapData, _arg_2:String, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:IVector3d, _arg_7:Boolean, _arg_8:Number=0, _arg_9:Number=0, _arg_10:Number=0, _arg_11:Number=0, _arg_12:int=0):PlaneBitmapData
        {
            var _local_15:FloorPlane = (getPlane(_arg_2) as FloorPlane);
            if (_local_15 == null)
            {
                _local_15 = (getPlane("default") as FloorPlane);
            };
            if (_local_15 == null)
            {
                return (null);
            };
            if (_arg_1 != null)
            {
                _arg_1.fillRect(_arg_1.rect, 0xFFFFFF);
            };
            var _local_14:BitmapData = _local_15.render(_arg_1, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9);
            if (((!(_local_14 == null)) && (!(_local_14 == _arg_1))))
            {
                try
                {
                    _local_14 = _local_14.clone();
                }
                catch(e:Error)
                {
                    if (_local_14)
                    {
                        _local_14.dispose();
                    };
                    return (null);
                };
            };
            var _local_13:PlaneBitmapData = new PlaneBitmapData(_local_14, -1);
            return (_local_13);
        }


    }
}

