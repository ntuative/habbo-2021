package com.sulake.habbo.room.object.visualization.room.rasterizer.animated
{
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneRasterizer;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneVisualization;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneMaterial;
    import com.sulake.room.utils._SafeStr_93;
    import com.sulake.habbo.room.object.visualization.room.utils.Randomizer;
    import flash.display.BitmapData;
    import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;
    import com.sulake.room.utils.IVector3d;

    public class LandscapeRasterizer extends PlaneRasterizer 
    {

        private static const UPDATE_INTERVAL:int = 500;

        private var _landscapeWidth:int = 0;
        private var _SafeStr_3427:int = 0;


        override public function initializeDimensions(_arg_1:int, _arg_2:int):Boolean
        {
            if (_arg_1 < 0)
            {
                _arg_1 = 0;
            };
            if (_arg_2 < 0)
            {
                _arg_2 = 0;
            };
            _landscapeWidth = _arg_1;
            _SafeStr_3427 = _arg_2;
            return (true);
        }

        override protected function initializePlanes():void
        {
            if (data == null)
            {
                return;
            };
            var _local_1:XMLList = data.landscapes;
            if (_local_1.length() > 0)
            {
                parseLandscapes(_local_1[0]);
            };
        }

        private function parseLandscapes(_arg_1:XML):void
        {
            var _local_23:int;
            var _local_29:XML;
            var _local_14:String;
            var _local_11:XMLList;
            var _local_38:LandscapePlane;
            var _local_24:int;
            var _local_26:XML;
            var _local_32:int;
            var _local_19:String;
            var _local_13:String;
            var _local_12:Number;
            var _local_31:Number;
            var _local_17:int;
            var _local_22:PlaneVisualization;
            var _local_25:int;
            var _local_39:XML;
            var _local_8:XML = null;
            var _local_33:PlaneMaterial;
            var _local_7:int;
            var _local_27:String;
            var _local_36:String;
            var _local_18:int;
            var _local_6:String;
            var _local_3:uint;
            var _local_9:String;
            var _local_37:XMLList;
            var _local_4:XML;
            var _local_28:int;
            var _local_16:XML;
            var _local_30:int;
            var _local_10:String;
            var _local_34:Number;
            var _local_35:Number;
            var _local_21:Number;
            var _local_20:Number;
            if (_arg_1 == null)
            {
                return;
            };
            var _local_5:Array = ["id", "assetId"];
            var _local_2:int = int((Math.random() * 654321));
            var _local_15:XMLList = _arg_1.landscape;
            _local_23 = 0;
            while (_local_23 < _local_15.length())
            {
                _local_29 = _local_15[_local_23];
                if (_SafeStr_93.checkRequiredAttributes(_local_29, ["id"]))
                {
                    _local_14 = _local_29.@id;
                    _local_11 = _local_29.animatedVisualization;
                    _local_38 = new LandscapePlane();
                    _local_24 = 0;
                    while (_local_24 < _local_11.length())
                    {
                        _local_26 = _local_11[_local_24];
                        if (_SafeStr_93.checkRequiredAttributes(_local_26, ["size"]))
                        {
                            _local_32 = parseInt(_local_26.@size);
                            _local_19 = _local_26.@horizontalAngle;
                            _local_13 = _local_26.@verticalAngle;
                            _local_12 = 45;
                            if (_local_19 != "")
                            {
                                _local_12 = parseFloat(_local_19);
                            };
                            _local_31 = 30;
                            if (_local_13 != "")
                            {
                                _local_31 = parseFloat(_local_13);
                            };
                            _local_17 = (_local_26.visualizationLayer.length() + _local_26.animationLayer.length());
                            _local_22 = _local_38.createPlaneVisualization(_local_32, _local_17, getGeometry(_local_32, _local_12, _local_31));
                            if (_local_22 != null)
                            {
                                Randomizer.setSeed(_local_2);
                                _local_25 = 0;
                                while (_local_25 < _local_26.children().length())
                                {
                                    _local_39 = _local_26.children()[_local_25];
                                    if (_local_39.name() == "visualizationLayer")
                                    {
                                        _local_8 = _local_39;
                                        _local_33 = null;
                                        _local_7 = 1;
                                        if (_SafeStr_93.checkRequiredAttributes(_local_8, ["materialId"]))
                                        {
                                            _local_27 = _local_8.@materialId;
                                            _local_33 = getMaterial(_local_27);
                                        };
                                        _local_36 = _local_8.@offset;
                                        _local_18 = 0;
                                        if (_local_36.length > 0)
                                        {
                                            _local_18 = parseInt(_local_36);
                                        };
                                        _local_6 = _local_8.@color;
                                        _local_3 = 0xFFFFFF;
                                        if (_local_6.length > 0)
                                        {
                                            _local_3 = parseInt(_local_6);
                                        };
                                        _local_9 = _local_8.@align;
                                        if (_local_9 == "bottom")
                                        {
                                            _local_7 = 2;
                                        }
                                        else
                                        {
                                            if (_local_9 == "top")
                                            {
                                                _local_7 = 1;
                                            };
                                        };
                                        _local_22.setLayer(_local_25, _local_33, _local_3, _local_7, _local_18);
                                    }
                                    else
                                    {
                                        if (_local_39.name() == "animationLayer")
                                        {
                                            _local_37 = _local_39.animationItem;
                                            _local_4 = <animation />
                                            ;
                                            _local_28 = 0;
                                            while (_local_28 < _local_37.length())
                                            {
                                                _local_16 = (_local_37[_local_28] as XML);
                                                if (_local_16 != null)
                                                {
                                                    if (_SafeStr_93.checkRequiredAttributes(_local_16, _local_5))
                                                    {
                                                        _local_30 = parseInt(_local_16.@id);
                                                        _local_10 = _local_16.@assetId;
                                                        _local_34 = 0;
                                                        _local_35 = 0;
                                                        _local_34 = getCoordinateValue(_local_16.@x, _local_16.@randomX);
                                                        _local_35 = getCoordinateValue(_local_16.@y, _local_16.@randomY);
                                                        _local_21 = 0;
                                                        _local_20 = 0;
                                                        _local_21 = parseFloat(_local_16.@speedX);
                                                        _local_20 = parseFloat(_local_16.@speedY);
                                                        _local_4.appendChild(new XML((((((((((("<item x=" + (('"' + _local_34) + '"')) + " y=") + (('"' + _local_35) + '"')) + " speedX=") + (('"' + _local_21) + '"')) + " speedY=") + (('"' + _local_20) + '"')) + " asset=") + (('"' + _local_10) + '"')) + "/> ")));
                                                    };
                                                };
                                                _local_28++;
                                            };
                                            _local_22.setAnimationLayer(_local_25, _local_4, assetCollection);
                                        };
                                    };
                                    _local_25++;
                                };
                            };
                        };
                        _local_24++;
                    };
                    if (!addPlane(_local_14, _local_38))
                    {
                        _local_38.dispose();
                    };
                };
                _local_23++;
            };
        }

        private function getCoordinateValue(_arg_1:String, _arg_2:String):Number
        {
            var _local_4:Number;
            var _local_3:Array;
            var _local_5:Number;
            var _local_6:Number = 0;
            if (_arg_1.length > 0)
            {
                if (_arg_1.charAt((_arg_1.length - 1)) == "%")
                {
                    _arg_1 = _arg_1.substr(0, (_arg_1.length - 1));
                    _local_6 = (parseFloat(_arg_1) / 100);
                };
            };
            if (_arg_2.length > 0)
            {
                _local_4 = 10000;
                _local_3 = Randomizer.getValues(1, 0, _local_4);
                _local_5 = (_local_3[0] / _local_4);
                if (_arg_2.charAt((_arg_2.length - 1)) == "%")
                {
                    _arg_2 = _arg_2.substr(0, (_arg_2.length - 1));
                    _local_6 = (_local_6 + ((_local_5 * parseFloat(_arg_2)) / 100));
                };
            };
            return (_local_6);
        }

        override public function render(_arg_1:BitmapData, _arg_2:String, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:IVector3d, _arg_7:Boolean, _arg_8:Number=0, _arg_9:Number=0, _arg_10:Number=0, _arg_11:Number=0, _arg_12:int=0):PlaneBitmapData
        {
            var _local_15:LandscapePlane = (getPlane(_arg_2) as LandscapePlane);
            if (_local_15 == null)
            {
                _local_15 = (getPlane("default") as LandscapePlane);
            };
            if (_local_15 == null)
            {
                return (null);
            };
            if (_arg_1 != null)
            {
                _arg_1.fillRect(_arg_1.rect, 0xFFFFFF);
            };
            var _local_14:BitmapData = _local_15.render(_arg_1, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11, _arg_12);
            if (((!(_local_14 == null)) && (!(_local_14 == _arg_1))))
            {
                try
                {
                    _local_14 = _local_14.clone();
                }
                catch(e:Error)
                {
                    _local_14.dispose();
                    return (null);
                };
            };
            var _local_13:PlaneBitmapData;
            if (((!(_local_15.isStatic(_arg_5))) && (true)))
            {
                _local_13 = new PlaneBitmapData(_local_14, ((Math.round((_arg_12 / 500)) * 500) + 500));
            }
            else
            {
                _local_13 = new PlaneBitmapData(_local_14, -1);
            };
            return (_local_13);
        }

        override public function getTextureIdentifier(_arg_1:Number, _arg_2:IVector3d):String
        {
            if (_arg_2 != null)
            {
                if (_arg_2.x < 0)
                {
                    return (_arg_1 + "_0");
                };
                return (_arg_1 + "_1");
            };
            return (super.getTextureIdentifier(_arg_1, _arg_2));
        }


    }
}

