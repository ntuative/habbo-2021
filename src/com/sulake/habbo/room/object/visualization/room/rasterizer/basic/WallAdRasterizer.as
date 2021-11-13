package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.utils._SafeStr_93;
    import flash.display.BitmapData;
    import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;

    public class WallAdRasterizer extends WallRasterizer 
    {


        override public function getTextureIdentifier(_arg_1:Number, _arg_2:IVector3d):String
        {
            return (String(_arg_1));
        }

        override protected function initializePlanes():void
        {
            if (data == null)
            {
                return;
            };
            var _local_1:XMLList = data.wallAds;
            if (_local_1.length() > 0)
            {
                parseWalls(_local_1[0]);
            };
        }

        override protected function parseWalls(_arg_1:XML):void
        {
            var _local_5:int;
            var _local_6:XML;
            var _local_7:String;
            var _local_2:XMLList;
            var _local_3:WallPlane;
            if (_arg_1 == null)
            {
                return;
            };
            var _local_4:XMLList = _arg_1.wallAd;
            _local_5 = 0;
            while (_local_5 < _local_4.length())
            {
                _local_6 = _local_4[_local_5];
                if (_SafeStr_93.checkRequiredAttributes(_local_6, ["id"]))
                {
                    _local_7 = _local_6.@id;
                    _local_2 = _local_6.visualization;
                    _local_3 = new WallPlane();
                    parseVisualizations(_local_3, _local_2);
                    if (getPlane(_local_7) == null)
                    {
                        addPlane(_local_7, _local_3);
                    }
                    else
                    {
                        _local_3.dispose();
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
                _local_14 = _local_14.clone();
            };
            var _local_13:PlaneBitmapData = new PlaneBitmapData(_local_14, -1);
            return (_local_13);
        }


    }
}

