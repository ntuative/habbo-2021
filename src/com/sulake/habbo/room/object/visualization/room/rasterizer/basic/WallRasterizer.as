package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import com.sulake.room.utils._SafeStr_93;
    import flash.display.BitmapData;
    import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;
    import com.sulake.room.utils.IVector3d;

    public class WallRasterizer extends PlaneRasterizer 
    {


        override protected function initializePlanes():void
        {
            if (data == null)
            {
                return;
            };
            var _local_1:XMLList = data.walls;
            if (_local_1.length() > 0)
            {
                parseWalls(_local_1[0]);
            };
        }

        protected function parseWalls(_arg_1:XML):void
        {
            var _local_5:int;
            var _local_2:XML;
            var _local_6:String;
            var _local_4:XMLList;
            var _local_7:WallPlane;
            if (_arg_1 == null)
            {
                return;
            };
            var _local_3:XMLList = _arg_1.wall;
            _local_5 = 0;
            while (_local_5 < _local_3.length())
            {
                _local_2 = _local_3[_local_5];
                if (_SafeStr_93.checkRequiredAttributes(_local_2, ["id"]))
                {
                    _local_6 = _local_2.@id;
                    _local_4 = _local_2.visualization;
                    _local_7 = new WallPlane();
                    parseVisualizations(_local_7, _local_4);
                    if (!addPlane(_local_6, _local_7))
                    {
                        _local_7.dispose();
                    };
                };
                _local_5++;
            };
        }

        override public function render(_arg_1:BitmapData, _arg_2:String, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:IVector3d, _arg_7:Boolean, _arg_8:Number=0, _arg_9:Number=0, _arg_10:Number=0, _arg_11:Number=0, _arg_12:int=0):PlaneBitmapData
        {
            var _local_15:WallPlane = (getPlane(_arg_2) as WallPlane);
            if (_local_15 == null)
            {
                _local_15 = (getPlane("default") as WallPlane);
            };
            if (_local_15 == null)
            {
                return (null);
            };
            if (_arg_1 != null)
            {
                _arg_1.fillRect(_arg_1.rect, 0xFFFFFF);
            };
            var _local_14:BitmapData = _local_15.render(_arg_1, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7);
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

        override public function getTextureIdentifier(_arg_1:Number, _arg_2:IVector3d):String
        {
            if (_arg_2 != null)
            {
                return ((((((_arg_1 + "_") + _arg_2.x) + "_") + _arg_2.y) + "_") + _arg_2.z);
            };
            return (super.getTextureIdentifier(_arg_1, _arg_2));
        }


    }
}

