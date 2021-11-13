package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
    import com.sulake.core.assets.AssetLibrary;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import flash.geom.Point;

    public class FurnitureCuboidVisualization extends RoomObjectSpriteVisualization 
    {

        private var _SafeStr_1354:AssetLibrary = null;
        private var _SafeStr_3301:Array = [];
        private var _SafeStr_3302:Boolean = false;
        private var _SafeStr_3303:int = 0;


        override public function dispose():void
        {
            var _local_2:int;
            var _local_1:FurniturePlane;
            super.dispose();
            if (_SafeStr_1354 != null)
            {
                _SafeStr_1354.dispose();
                _SafeStr_1354 = null;
            };
            if (_SafeStr_3301 != null)
            {
                _local_2 = 0;
                while (_local_2 < _SafeStr_3301.length)
                {
                    _local_1 = (_SafeStr_3301[_local_2] as FurniturePlane);
                    if (_local_1 != null)
                    {
                        _local_1.dispose();
                    };
                    _local_2++;
                };
                _SafeStr_3301 = null;
            };
        }

        override public function initialize(_arg_1:IRoomObjectVisualizationData):Boolean
        {
            reset();
            return (true);
        }

        protected function defineSprites():void
        {
            var _local_1:int = 1;
            createSprites(_local_1);
        }

        protected function initializePlanes():void
        {
            var _local_4:IVector3d;
            var _local_1:FurniturePlane;
            if (_SafeStr_3302)
            {
                return;
            };
            var _local_6:IRoomObject = object;
            if (_local_6 == null)
            {
                return;
            };
            var _local_8:int = 1;
            var _local_2:Number = _local_6.getModel().getNumber("furniture_size_x");
            var _local_9:Number = _local_6.getModel().getNumber("furniture_size_y");
            var _local_10:Number = _local_6.getModel().getNumber("furniture_size_z");
            if ((((isNaN(_local_2)) || (isNaN(_local_9))) || (isNaN(_local_10))))
            {
                return;
            };
            var _local_5:Vector3d = new Vector3d(_local_2, 0, 0);
            var _local_7:Vector3d = new Vector3d(0, _local_9, 0);
            var _local_3:Vector3d = new Vector3d(-0.5, -0.5, 0);
            if ((((!(_local_3 == null)) && (!(_local_5 == null))) && (!(_local_7 == null))))
            {
                _local_4 = Vector3d.crossProduct(_local_5, _local_7);
                _local_1 = new FurniturePlane(_local_3, _local_5, _local_7);
                _local_1.color = 0xFFFF00;
                _SafeStr_3301.push(_local_1);
            }
            else
            {
                return;
            };
            _SafeStr_3302 = true;
            defineSprites();
        }

        override public function update(_arg_1:IRoomGeometry, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean):void
        {
            var _local_5:IRoomObject = object;
            if (_local_5 == null)
            {
                return;
            };
            if (_SafeStr_1354 == null)
            {
                _SafeStr_1354 = new AssetLibrary(("furniture cuboid visualization - " + _local_5.getInstanceId()));
            };
            if (_arg_1 == null)
            {
                return;
            };
            initializePlanes();
            updatePlanes(_arg_1, _arg_2);
        }

        protected function updatePlanes(_arg_1:IRoomGeometry, _arg_2:int):void
        {
            var _local_6:int;
            var _local_7:Boolean;
            var _local_13:String;
            var _local_14:BitmapDataAsset;
            var _local_3:FurniturePlane;
            var _local_8:int;
            var _local_11:BitmapData;
            var _local_9:BitmapData;
            var _local_12:IRoomObjectSprite;
            var _local_5:Point;
            var _local_10:IRoomObject = object;
            if (_local_10 == null)
            {
                return;
            };
            if (((_arg_1 == null) || (_SafeStr_1354 == null)))
            {
                return;
            };
            _SafeStr_3303++;
            var _local_4:int = _arg_2;
            _local_6 = 0;
            while (_local_6 < _SafeStr_3301.length)
            {
                _local_7 = false;
                _local_13 = ((("plane " + _local_6) + " ") + _arg_1.scale);
                _local_14 = (_SafeStr_1354.getAssetByName(_local_13) as BitmapDataAsset);
                if (_local_14 == null)
                {
                    _local_14 = new BitmapDataAsset(_SafeStr_1354.getAssetTypeDeclarationByClass(BitmapDataAsset));
                    _SafeStr_1354.setAsset(_local_13, _local_14);
                };
                _local_3 = (_SafeStr_3301[_local_6] as FurniturePlane);
                if (_local_3 != null)
                {
                    _local_8 = _local_10.getDirection().x;
                    if ((((_local_8 / 45) == 2) || ((_local_8 / 45) == 6)))
                    {
                        _local_3.setRotation(true);
                    }
                    else
                    {
                        _local_3.setRotation(false);
                    };
                    if (_local_3.update(_arg_1, _local_4))
                    {
                        _local_11 = _local_3.bitmapData;
                        _local_9 = (_local_14.content as BitmapData);
                        if (_local_11 == null)
                        {
                            _local_14 = null;
                        }
                        else
                        {
                            if (_local_9 != _local_11)
                            {
                                if (_local_9 != null)
                                {
                                    _local_9.dispose();
                                };
                                _local_14.setUnknownContent(_local_11);
                            };
                        };
                        _local_7 = true;
                    };
                }
                else
                {
                    _local_14 = null;
                };
                _local_12 = getSprite(_local_6);
                if (_local_12 != null)
                {
                    if (_local_3 != null)
                    {
                        _local_5 = _local_3.offset;
                        _local_12.offsetX = -(_local_5.x);
                        _local_12.offsetY = -(_local_5.y);
                        _local_12.color = _local_3.color;
                        _local_12.visible = _local_3.visible;
                    }
                    else
                    {
                        _local_12.visible = false;
                    };
                    if (_local_14 != null)
                    {
                        _local_12.asset = (_local_14.content as BitmapData);
                    }
                    else
                    {
                        _local_12.asset = null;
                    };
                    if (_local_7)
                    {
                        _local_12.assetName = ((((_local_13 + "_") + _local_10.getInstanceId()) + "_") + _SafeStr_3303);
                    };
                    _local_12.relativeDepth = _local_3.relativeDepth;
                };
                _local_6++;
            };
        }


    }
}

