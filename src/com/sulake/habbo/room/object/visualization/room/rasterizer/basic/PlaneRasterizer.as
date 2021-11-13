package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import com.sulake.habbo.room.object.visualization.room.rasterizer.IPlaneRasterizer;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
    import com.sulake.core.utils.Map;
    import com.sulake.room.utils.RoomGeometry;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.room.utils._SafeStr_93;
    import com.sulake.room.utils._SafeStr_217;
    import flash.geom.Point;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;

    public class PlaneRasterizer implements IPlaneRasterizer 
    {

        protected static const DEFAULT_TYPE:String = "default";

        private var _assetCollection:IGraphicAssetCollection = null;
        private var _materials:Map = null;
        private var _SafeStr_3346:Map = null;
        private var _SafeStr_3301:Map = null;
        private var _SafeStr_3441:Map = null;
        private var _data:XML = null;

        public function PlaneRasterizer()
        {
            _SafeStr_3346 = new Map();
            _materials = new Map();
            _SafeStr_3301 = new Map();
            _SafeStr_3441 = new Map();
        }

        protected function get data():XML
        {
            return (_data);
        }

        protected function get assetCollection():IGraphicAssetCollection
        {
            return (_assetCollection);
        }

        public function initializeDimensions(_arg_1:int, _arg_2:int):Boolean
        {
            return (true);
        }

        public function dispose():void
        {
            var _local_1:Plane;
            var _local_3:RoomGeometry;
            var _local_2:int;
            if (_SafeStr_3301 != null)
            {
                _local_2 = 0;
                while (_local_2 < _SafeStr_3301.length)
                {
                    _local_1 = (_SafeStr_3301.getWithIndex(_local_2) as Plane);
                    if (_local_1 != null)
                    {
                        _local_1.dispose();
                    };
                    _local_2++;
                };
                _SafeStr_3301.dispose();
                _SafeStr_3301 = null;
            };
            if (_materials != null)
            {
                resetMaterials();
                _materials.dispose();
                _materials = null;
            };
            if (_SafeStr_3346 != null)
            {
                resetTextures();
                _SafeStr_3346.dispose();
                _SafeStr_3346 = null;
            };
            if (_SafeStr_3441 != null)
            {
                _local_2 = 0;
                while (_local_2 < _SafeStr_3441.length)
                {
                    _local_3 = _SafeStr_3441.getWithIndex(_local_2);
                    if (_local_3 != null)
                    {
                        _local_3.dispose();
                    };
                    _local_2++;
                };
                _SafeStr_3441.dispose();
                _SafeStr_3441 = null;
            };
            _data = null;
            _assetCollection = null;
        }

        public function clearCache():void
        {
            var _local_1:Plane;
            var _local_2:PlaneMaterial;
            var _local_3:int;
            _local_3 = 0;
            while (_local_3 < _SafeStr_3301.length)
            {
                _local_1 = (_SafeStr_3301.getWithIndex(_local_3) as Plane);
                if (_local_1 != null)
                {
                    _local_1.clearCache();
                };
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < _materials.length)
            {
                _local_2 = (_materials.getWithIndex(_local_3) as PlaneMaterial);
                if (_local_2 != null)
                {
                    _local_2.clearCache();
                };
                _local_3++;
            };
        }

        public function initialize(_arg_1:XML):void
        {
            _data = _arg_1;
        }

        public function reinitialize():void
        {
            resetTextures();
            resetMaterials();
            initializeAll();
        }

        private function resetMaterials():void
        {
            var _local_2:int;
            var _local_1:PlaneMaterial;
            _local_2 = 0;
            while (_local_2 < _materials.length)
            {
                _local_1 = (_materials.getWithIndex(_local_2) as PlaneMaterial);
                if (_local_1 != null)
                {
                    _local_1.dispose();
                };
                _local_2++;
            };
            _materials.reset();
        }

        private function resetTextures():void
        {
            var _local_2:int;
            var _local_1:PlaneTexture;
            _local_2 = 0;
            while (_local_2 < _SafeStr_3346.length)
            {
                _local_1 = (_SafeStr_3346.getWithIndex(_local_2) as PlaneTexture);
                if (_local_1 != null)
                {
                    _local_1.dispose();
                };
                _local_2++;
            };
            _SafeStr_3346.reset();
        }

        protected function getTexture(_arg_1:String):PlaneTexture
        {
            return (_SafeStr_3346.getValue(_arg_1) as PlaneTexture);
        }

        protected function getMaterial(_arg_1:String):PlaneMaterial
        {
            return (_materials.getValue(_arg_1) as PlaneMaterial);
        }

        protected function getPlane(_arg_1:String):Plane
        {
            return (_SafeStr_3301.getValue(_arg_1));
        }

        protected function addPlane(_arg_1:String, _arg_2:Plane):Boolean
        {
            if (_arg_2 == null)
            {
                return (false);
            };
            if (_SafeStr_3301.getValue(_arg_1) == null)
            {
                _SafeStr_3301.add(_arg_1, _arg_2);
                return (true);
            };
            return (false);
        }

        public function initializeAssetCollection(_arg_1:IGraphicAssetCollection):void
        {
            if (data == null)
            {
                return;
            };
            _assetCollection = _arg_1;
            initializeAll();
        }

        private function initializeAll():void
        {
            if (data == null)
            {
                return;
            };
            initializeTexturesAndMaterials();
            initializePlanes();
        }

        private function initializeTexturesAndMaterials():void
        {
            var _local_2:XMLList = data.textures;
            if (_local_2.length() > 0)
            {
                parseTextures(_local_2[0], assetCollection);
            };
            var _local_1:XMLList = data.materials;
            if (_local_1.length() > 0)
            {
                parsePlaneMaterials(_local_1[0]);
            };
        }

        protected function initializePlanes():void
        {
        }

        private function parseTextures(_arg_1:XML, _arg_2:IGraphicAssetCollection):void
        {
            var _local_7:int;
            var _local_6:XML;
            var _local_16:String;
            var _local_4:PlaneTexture;
            var _local_3:XMLList;
            var _local_9:int;
            var _local_13:XML;
            var _local_8:Number;
            var _local_18:Number;
            var _local_10:Number;
            var _local_14:Number;
            var _local_15:String;
            var _local_17:IGraphicAsset;
            var _local_11:BitmapDataAsset;
            var _local_12:BitmapData;
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return;
            };
            var _local_5:XMLList = _arg_1.texture;
            _local_7 = 0;
            while (_local_7 < _local_5.length())
            {
                _local_6 = _local_5[_local_7];
                if (_SafeStr_93.checkRequiredAttributes(_local_6, ["id"]))
                {
                    _local_16 = _local_6.@id;
                    if (_SafeStr_3346.getValue(_local_16) == null)
                    {
                        _local_4 = new PlaneTexture();
                        _local_3 = _local_6.bitmap;
                        _local_9 = 0;
                        while (_local_9 < _local_3.length())
                        {
                            _local_13 = _local_3[_local_9];
                            if (_SafeStr_93.checkRequiredAttributes(_local_13, ["assetName"]))
                            {
                                _local_8 = -1;
                                _local_18 = 1;
                                _local_10 = -1;
                                _local_14 = 1;
                                if (String(_local_13.@normalMinX) != "")
                                {
                                    _local_8 = parseFloat(_local_13.@normalMinX);
                                };
                                if (String(_local_13.@normalMaxX) != "")
                                {
                                    _local_18 = parseFloat(_local_13.@normalMaxX);
                                };
                                if (String(_local_13.@normalMinY) != "")
                                {
                                    _local_10 = parseFloat(_local_13.@normalMinY);
                                };
                                if (String(_local_13.@normalMaxY) != "")
                                {
                                    _local_14 = parseFloat(_local_13.@normalMaxY);
                                };
                                _local_15 = _local_13.@assetName;
                                _local_17 = _arg_2.getAsset(_local_15);
                                if (_local_17 != null)
                                {
                                    _local_11 = (_local_17.asset as BitmapDataAsset);
                                    if (_local_11 != null)
                                    {
                                        _local_12 = (_local_11.content as BitmapData);
                                        if (_local_12 != null)
                                        {
                                            if (_local_17.flipH)
                                            {
                                                _local_12 = _SafeStr_217.getFlipHBitmapData(_local_12);
                                            }
                                            else
                                            {
                                                _local_12 = _local_12.clone();
                                            };
                                            _local_4.addBitmap(_local_12, _local_8, _local_18, _local_10, _local_14, _local_15);
                                        };
                                    };
                                };
                            };
                            _local_9++;
                        };
                        _SafeStr_3346.add(_local_16, _local_4);
                    };
                };
                _local_7++;
            };
        }

        private function parsePlaneMaterials(_arg_1:XML):void
        {
            var _local_4:int;
            var _local_15:XML;
            var _local_20:String;
            var _local_8:PlaneMaterial;
            var _local_2:XMLList;
            var _local_6:int;
            var _local_11:XML;
            var _local_16:String;
            var _local_12:String;
            var _local_3:int;
            var _local_10:int;
            var _local_5:Number;
            var _local_21:Number;
            var _local_7:Number;
            var _local_19:Number;
            var _local_18:XMLList;
            var _local_13:PlaneMaterialCellMatrix;
            var _local_9:int;
            var _local_14:XML;
            if (_arg_1 == null)
            {
                return;
            };
            var _local_17:XMLList = _arg_1.material;
            _local_4 = 0;
            while (_local_4 < _local_17.length())
            {
                _local_15 = _local_17[_local_4];
                if (_SafeStr_93.checkRequiredAttributes(_local_15, ["id"]))
                {
                    _local_20 = _local_15.@id;
                    _local_8 = new PlaneMaterial();
                    _local_2 = _local_15.materialCellMatrix;
                    _local_6 = 0;
                    while (_local_6 < _local_2.length())
                    {
                        _local_11 = _local_2[_local_6];
                        _local_16 = _local_11.@repeatMode;
                        _local_12 = _local_11.@align;
                        _local_3 = 1;
                        switch (_local_16)
                        {
                            case "borders":
                                _local_3 = 2;
                                break;
                            case "center":
                                _local_3 = 3;
                                break;
                            case "first":
                                _local_3 = 4;
                                break;
                            case "last":
                                _local_3 = 5;
                                break;
                            case "random":
                                _local_3 = 6;
                        };
                        _local_10 = 1;
                        switch (_local_12)
                        {
                            case "top":
                                _local_10 = 1;
                                break;
                            case "bottom":
                                _local_10 = 2;
                        };
                        _local_5 = -1;
                        _local_21 = 1;
                        _local_7 = -1;
                        _local_19 = 1;
                        if (String(_local_11.@normalMinX) != "")
                        {
                            _local_5 = parseFloat(_local_11.@normalMinX);
                        };
                        if (String(_local_11.@normalMaxX) != "")
                        {
                            _local_21 = parseFloat(_local_11.@normalMaxX);
                        };
                        if (String(_local_11.@normalMinY) != "")
                        {
                            _local_7 = parseFloat(_local_11.@normalMinY);
                        };
                        if (String(_local_11.@normalMaxY) != "")
                        {
                            _local_19 = parseFloat(_local_11.@normalMaxY);
                        };
                        _local_18 = _local_11.materialCellColumn;
                        if (_local_18.length() > 0)
                        {
                            _local_13 = null;
                            _local_13 = _local_8.addMaterialCellMatrix(_local_18.length(), _local_3, _local_10, _local_5, _local_21, _local_7, _local_19);
                            _local_9 = 0;
                            while (_local_9 < _local_18.length())
                            {
                                _local_14 = _local_18[_local_9];
                                parsePlaneMaterialCellColumn(_local_14, _local_13, _local_9);
                                _local_9++;
                            };
                        };
                        _materials.add(_local_20, _local_8);
                        _local_6++;
                    };
                };
                _local_4++;
            };
        }

        private function parsePlaneMaterialCellColumn(_arg_1:XML, _arg_2:PlaneMaterialCellMatrix, _arg_3:int):void
        {
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return;
            };
            var _local_5:String = _arg_1.@repeatMode;
            var _local_7:int = parseInt(_arg_1.@width);
            var _local_6:int = 1;
            switch (_local_5)
            {
                case "borders":
                    _local_6 = 2;
                    break;
                case "center":
                    _local_6 = 3;
                    break;
                case "first":
                    _local_6 = 4;
                    break;
                case "last":
                    _local_6 = 5;
                    break;
                case "none":
                    _local_6 = 0;
            };
            var _local_4:Array = parsePlaneMaterialCells(_arg_1);
            _arg_2.createColumn(_arg_3, _local_7, _local_4, _local_6);
        }

        private function parsePlaneMaterialCells(_arg_1:XML):Array
        {
            var _local_6:int;
            var _local_13:XML;
            var _local_8:String;
            var _local_20:Array;
            var _local_21:Array;
            var _local_2:Array;
            var _local_14:int;
            var _local_3:XMLList;
            var _local_10:XML;
            var _local_18:XMLList;
            var _local_4:XMLList;
            var _local_15:XML;
            var _local_12:XML;
            var _local_7:int;
            var _local_16:String;
            var _local_19:IGraphicAsset;
            var _local_5:PlaneTexture;
            var _local_9:PlaneMaterialCell;
            if (_arg_1 == null)
            {
                return (null);
            };
            var _local_11:Array = [];
            var _local_17:XMLList = _arg_1.materialCell;
            _local_6 = 0;
            while (_local_6 < _local_17.length())
            {
                _local_13 = _local_17[_local_6];
                _local_8 = _local_13.@textureId;
                _local_20 = null;
                _local_21 = null;
                _local_2 = null;
                _local_14 = 0;
                _local_3 = _local_13.extraItemData;
                if (_local_3.length() > 0)
                {
                    _local_10 = _local_3[0];
                    _local_18 = _local_10.extraItemTypes;
                    _local_4 = _local_10.offsets;
                    if (((_local_18.length() > 0) && (_local_4.length() > 0)))
                    {
                        _local_15 = _local_18[0];
                        _local_12 = _local_4[0];
                        _local_20 = parseExtraItemTypes(_local_15);
                        _local_2 = parseExtraItemOffsets(_local_12);
                        _local_14 = _local_2.length;
                        if (String(_local_10.@limitMax) != "")
                        {
                            _local_14 = parseInt(_local_10.@limitMax);
                        };
                    };
                };
                if (_local_20 != null)
                {
                    _local_21 = [];
                    _local_7 = 0;
                    while (_local_7 < _local_20.length)
                    {
                        _local_16 = _local_20[_local_6];
                        _local_19 = _assetCollection.getAsset(_local_16);
                        if (_local_19 != null)
                        {
                            _local_21.push(_local_19);
                        };
                        _local_7++;
                    };
                };
                _local_5 = getTexture(_local_8);
                _local_9 = new PlaneMaterialCell(_local_5, _local_21, _local_2, _local_14);
                _local_11.push(_local_9);
                _local_6++;
            };
            if (_local_11.length == 0)
            {
                _local_11 = null;
            };
            return (_local_11);
        }

        private function parseExtraItemTypes(_arg_1:XML):Array
        {
            var _local_3:XMLList;
            var _local_4:int;
            var _local_5:XML;
            var _local_6:String;
            var _local_2:Array = [];
            var _local_7:Array = ["assetName"];
            if (_arg_1 != null)
            {
                _local_3 = _arg_1.extraItemType;
                _local_4 = 0;
                while (_local_4 < _local_3.length())
                {
                    _local_5 = _local_3[_local_4];
                    if (_SafeStr_93.checkRequiredAttributes(_local_5, _local_7))
                    {
                        _local_6 = _local_5.@assetName;
                        _local_2.push(_local_6);
                    };
                    _local_4++;
                };
            };
            return (_local_2);
        }

        private function parseExtraItemOffsets(_arg_1:XML):Array
        {
            var _local_4:XMLList;
            var _local_6:int;
            var _local_3:XML;
            var _local_5:int;
            var _local_7:int;
            var _local_2:Array = [];
            var _local_8:Array = ["x", "y"];
            if (_arg_1 != null)
            {
                _local_4 = _arg_1.offset;
                _local_6 = 0;
                while (_local_6 < _local_4.length())
                {
                    _local_3 = _local_4[_local_6];
                    if (_SafeStr_93.checkRequiredAttributes(_local_3, _local_8))
                    {
                        _local_5 = parseInt(_local_3.@x);
                        _local_7 = parseInt(_local_3.@y);
                        _local_2.push(new Point(_local_5, _local_7));
                    };
                    _local_6++;
                };
            };
            return (_local_2);
        }

        protected function getGeometry(_arg_1:int, _arg_2:Number, _arg_3:Number):IRoomGeometry
        {
            _arg_2 = Math.abs(_arg_2);
            if (_arg_2 > 90)
            {
                _arg_2 = 90;
            };
            _arg_3 = Math.abs(_arg_3);
            if (_arg_3 > 90)
            {
                _arg_3 = 90;
            };
            var _local_5:String = ((((_arg_1 + "_") + Math.round(_arg_2)) + "_") + Math.round(_arg_3));
            var _local_4:IRoomGeometry = _SafeStr_3441.getValue(_local_5);
            if (_local_4 == null)
            {
                _local_4 = new RoomGeometry(_arg_1, new Vector3d(_arg_2, _arg_3), new Vector3d(-10, 0, 0));
                _SafeStr_3441.add(_local_5, _local_4);
            };
            return (_local_4);
        }

        protected function parseVisualizations(_arg_1:Plane, _arg_2:XMLList):void
        {
            var _local_8:int;
            var _local_3:XML;
            var _local_16:int;
            var _local_6:String;
            var _local_20:String;
            var _local_18:Number;
            var _local_14:Number;
            var _local_19:XMLList;
            var _local_7:PlaneVisualization;
            var _local_10:int;
            var _local_13:XML;
            var _local_17:PlaneMaterial;
            var _local_11:int;
            var _local_12:String;
            var _local_21:String;
            var _local_4:int;
            var _local_9:String;
            var _local_5:uint;
            var _local_15:String;
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return;
            };
            _local_8 = 0;
            while (_local_8 < _arg_2.length())
            {
                _local_3 = _arg_2[_local_8];
                if (_SafeStr_93.checkRequiredAttributes(_local_3, ["size"]))
                {
                    _local_16 = parseInt(_local_3.@size);
                    _local_6 = _local_3.@horizontalAngle;
                    _local_20 = _local_3.@verticalAngle;
                    _local_18 = 45;
                    if (_local_6 != "")
                    {
                        _local_18 = parseFloat(_local_6);
                    };
                    _local_14 = 30;
                    if (_local_20 != "")
                    {
                        _local_14 = parseFloat(_local_20);
                    };
                    _local_19 = _local_3.visualizationLayer;
                    _local_7 = _arg_1.createPlaneVisualization(_local_16, _local_19.length(), getGeometry(_local_16, _local_18, _local_14));
                    if (_local_7 != null)
                    {
                        _local_10 = 0;
                        while (_local_10 < _local_19.length())
                        {
                            _local_13 = _local_19[_local_10];
                            _local_17 = null;
                            _local_11 = 1;
                            if (_SafeStr_93.checkRequiredAttributes(_local_13, ["materialId"]))
                            {
                                _local_12 = _local_13.@materialId;
                                _local_17 = getMaterial(_local_12);
                            };
                            _local_21 = _local_13.@offset;
                            _local_4 = 0;
                            if (_local_21.length > 0)
                            {
                                _local_4 = parseInt(_local_21);
                            };
                            _local_9 = _local_13.@color;
                            _local_5 = 0xFFFFFF;
                            if (_local_9.length > 0)
                            {
                                _local_5 = parseInt(_local_9);
                            };
                            _local_15 = _local_13.@align;
                            if (_local_15 == "bottom")
                            {
                                _local_11 = 2;
                            }
                            else
                            {
                                if (_local_15 == "top")
                                {
                                    _local_11 = 1;
                                };
                            };
                            _local_7.setLayer(_local_10, _local_17, _local_5, _local_11, _local_4);
                            _local_10++;
                        };
                    };
                };
                _local_8++;
            };
        }

        public function render(_arg_1:BitmapData, _arg_2:String, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:IVector3d, _arg_7:Boolean, _arg_8:Number=0, _arg_9:Number=0, _arg_10:Number=0, _arg_11:Number=0, _arg_12:int=0):PlaneBitmapData
        {
            return (null);
        }

        public function getTextureIdentifier(_arg_1:Number, _arg_2:IVector3d):String
        {
            return (String(_arg_1));
        }

        public function getLayers(_arg_1:String):Array
        {
            var _local_2:Plane = getPlane(_arg_1);
            if (_local_2 == null)
            {
                _local_2 = getPlane("default");
            };
            return (_local_2.getLayers());
        }


    }
}

