package com.sulake.habbo.room.object.visualization.room
{
    import com.sulake.room.object.visualization.IRoomPlane;
    import flash.geom.Point;
    import com.sulake.room.utils.Vector3d;
    import flash.display.BitmapData;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.IPlaneRasterizer;
    import com.sulake.habbo.room.object.visualization.room.mask.PlaneMaskManager;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.utils.Canvas;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.habbo.room.object.visualization.room.mask.PlaneMask;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneVisualizationLayer;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneMaterialCellMatrix;
    import com.sulake.habbo.room.object.visualization.room.utils.Randomizer;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneMaterialCellColumn;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneMaterialCell;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;

    public class RoomPlane implements IRoomPlane 
    {

        private static const ZERO_POINT:Point = new Point(0, 0);
        public static const _SafeStr_3448:int = 0;
        public static const _SafeStr_1458:int = 1;
        public static const _SafeStr_1457:int = 2;
        public static const TYPE_LANDSCAPE:int = 3;

        private static var _SafeStr_3447:int = 1;

        private var _disposed:Boolean = false;
        private var _SafeStr_3449:int = 0;
        private var _origin:Vector3d = null;
        private var _location:Vector3d = null;
        private var _leftSide:Vector3d = null;
        private var _rightSide:Vector3d = null;
        private var _normal:Vector3d = null;
        private var _secondaryNormals:Array = [];
        private var _SafeStr_3250:int = -1;
        private var _type:int = 0;
        private var _SafeStr_3009:Boolean = false;
        private var _bitmapData:BitmapData = null;
        private var _hasTexture:Boolean = true;
        private var _offset:Point = null;
        private var _relativeDepth:Number = 0;
        private var _color:uint = 0;
        private var _SafeStr_3450:IPlaneRasterizer = null;
        private var _SafeStr_3451:PlaneMaskManager = null;
        private var _SafeStr_698:String = null;
        private var _uniqueId:int = 0;
        private var _SafeStr_3452:Number = 0;
        private var _SafeStr_3453:Number = 0;
        private var _SafeStr_3454:Number = 0;
        private var _SafeStr_3455:Number = 0;
        private var _SafeStr_3346:Map = null;
        private var _SafeStr_3456:PlaneBitmapData = null;
        private var _SafeStr_3457:Boolean = false;
        private var _SafeStr_3458:Array = [];
        private var _SafeStr_3459:Array = [];
        private var _SafeStr_3460:Boolean = false;
        private var _SafeStr_3398:BitmapData = null;
        private var _SafeStr_3461:BitmapData = null;
        private var _SafeStr_3462:Array = [];
        private var _SafeStr_3463:Array = [];
        private var _SafeStr_3348:Vector3d = null;
        private var _SafeStr_3349:Vector3d = null;
        private var _SafeStr_3350:Vector3d = null;
        private var _SafeStr_3351:Vector3d = null;
        private var _width:Number = 0;
        private var _SafeStr_1113:Number = 0;
        private var _canBeVisible:Boolean = true;

        public function RoomPlane(_arg_1:IVector3d, _arg_2:IVector3d, _arg_3:IVector3d, _arg_4:IVector3d, _arg_5:int, _arg_6:Boolean, _arg_7:Array, _arg_8:int, _arg_9:Number=0, _arg_10:Number=0, _arg_11:Number=0, _arg_12:Number=0)
        {
            super();
            var _local_14:int;
            var _local_15:IVector3d = null;
            var _local_13:Vector3d = null;
            _SafeStr_3449 = _arg_8;
            _origin = new Vector3d();
            _origin.assign(_arg_1);
            _location = new Vector3d();
            _location.assign(_arg_2);
            _leftSide = new Vector3d();
            _leftSide.assign(_arg_3);
            _rightSide = new Vector3d();
            _rightSide.assign(_arg_4);
            _normal = Vector3d.crossProduct(_leftSide, _rightSide);
            if (_normal.length > 0)
            {
                _normal.mul((1 / _normal.length));
            };
            if (_arg_7 != null)
            {
                _local_14 = 0;
                while (_local_14 < _arg_7.length)
                {
                    _local_15 = (_arg_7[_local_14] as IVector3d);
                    if (_local_15 != null)
                    {
                        _local_13 = new Vector3d();
                        _local_13.assign(_local_15);
                        _secondaryNormals.push(_local_13);
                    };
                    _local_14++;
                };
            };
            _offset = new Point();
            _type = _arg_5;
            _SafeStr_3346 = new Map();
            _SafeStr_3348 = new Vector3d();
            _SafeStr_3349 = new Vector3d();
            _SafeStr_3350 = new Vector3d();
            _SafeStr_3351 = new Vector3d();
            _SafeStr_3452 = _arg_9;
            _SafeStr_3453 = _arg_10;
            _SafeStr_3454 = _arg_11;
            _SafeStr_3455 = _arg_12;
            _SafeStr_3457 = _arg_6;
            _uniqueId = _SafeStr_3447++;
        }

        private static function blend(_arg_1:uint, _arg_2:uint):uint
        {
            return (Canvas.colorize(_arg_2, (_arg_1 | 0xFF000000)) & 0xFFFFFF);
        }


        public function set canBeVisible(_arg_1:Boolean):void
        {
            if (_arg_1 != _canBeVisible)
            {
                if (!_canBeVisible)
                {
                    resetTextureCache();
                };
                _canBeVisible = _arg_1;
            };
        }

        public function get canBeVisible():Boolean
        {
            return (_canBeVisible);
        }

        public function get bitmapData():BitmapData
        {
            var _local_1:BitmapData;
            if (visible)
            {
                if (_bitmapData != null)
                {
                    try
                    {
                        _local_1 = _bitmapData.clone();
                    }
                    catch(e:Error)
                    {
                        return (null);
                    };
                };
            };
            return (_local_1);
        }

        public function get visible():Boolean
        {
            return ((_SafeStr_3009) && (_canBeVisible));
        }

        public function get offset():Point
        {
            return (_offset);
        }

        public function get relativeDepth():Number
        {
            return (_relativeDepth);
        }

        public function get color():uint
        {
            return (_color);
        }

        public function set color(_arg_1:uint):void
        {
            _color = _arg_1;
        }

        public function get type():int
        {
            return (_type);
        }

        public function get leftSide():IVector3d
        {
            return (_leftSide);
        }

        public function get rightSide():IVector3d
        {
            return (_rightSide);
        }

        public function get location():IVector3d
        {
            return (_location);
        }

        public function get normal():IVector3d
        {
            return (_normal);
        }

        public function get hasTexture():Boolean
        {
            return (_hasTexture);
        }

        public function set hasTexture(_arg_1:Boolean):void
        {
            _hasTexture = _arg_1;
        }

        public function set rasterizer(_arg_1:IPlaneRasterizer):void
        {
            _SafeStr_3450 = _arg_1;
        }

        public function set maskManager(_arg_1:PlaneMaskManager):void
        {
            _SafeStr_3451 = _arg_1;
        }

        public function set id(_arg_1:String):void
        {
            if (_arg_1 != _SafeStr_698)
            {
                resetTextureCache();
                _SafeStr_698 = _arg_1;
            };
        }

        public function get uniqueId():int
        {
            return (_uniqueId);
        }

        public function dispose():void
        {
            var _local_2:int;
            var _local_1:PlaneBitmapData;
            if (_bitmapData != null)
            {
                _bitmapData.dispose();
                _bitmapData = null;
            };
            if (_SafeStr_3346 != null)
            {
                _local_2 = 0;
                while (_local_2 < _SafeStr_3346.length)
                {
                    _local_1 = (_SafeStr_3346.getWithIndex(_local_2) as PlaneBitmapData);
                    if (_local_1 != null)
                    {
                        if (_local_1.bitmap != null)
                        {
                            _local_1.bitmap.dispose();
                        };
                        _local_1.dispose();
                    };
                    _local_2++;
                };
                _SafeStr_3346.dispose();
                _SafeStr_3346 = null;
            };
            _SafeStr_3456 = null;
            _location = null;
            _origin = null;
            _leftSide = null;
            _rightSide = null;
            _normal = null;
            _SafeStr_3450 = null;
            _SafeStr_3348 = null;
            _SafeStr_3349 = null;
            _SafeStr_3350 = null;
            _SafeStr_3351 = null;
            _SafeStr_3458 = null;
            _SafeStr_3459 = null;
            if (_SafeStr_3398 != null)
            {
                _SafeStr_3398.dispose();
                _SafeStr_3398 = null;
            };
            if (_SafeStr_3461 != null)
            {
                _SafeStr_3461.dispose();
                _SafeStr_3461 = null;
            };
            _disposed = true;
        }

        public function copyBitmapData(_arg_1:BitmapData):BitmapData
        {
            if (visible)
            {
                if (((!(_bitmapData == null)) && (!(_arg_1 == null))))
                {
                    if (((_bitmapData.width == _arg_1.width) && (_bitmapData.height == _arg_1.height)))
                    {
                        _arg_1.copyPixels(_bitmapData, _bitmapData.rect, ZERO_POINT);
                        return (_arg_1);
                    };
                };
            };
            return (null);
        }

        private function cacheTexture(_arg_1:String, _arg_2:PlaneBitmapData):Boolean
        {
            var _local_3:PlaneBitmapData = (_SafeStr_3346.remove(_arg_1) as PlaneBitmapData);
            if (_local_3 != null)
            {
                if (((!(_arg_2 == null)) && (!(_arg_2.bitmap == _local_3.bitmap))))
                {
                    _local_3.bitmap.dispose();
                };
                _local_3.dispose();
            };
            _SafeStr_3456 = _arg_2;
            _SafeStr_3346.add(_arg_1, _arg_2);
            return (true);
        }

        private function resetTextureCache(_arg_1:BitmapData=null):void
        {
            var _local_3:int;
            var _local_2:PlaneBitmapData;
            if (_SafeStr_3346 != null)
            {
                _local_3 = 0;
                while (_local_3 < _SafeStr_3346.length)
                {
                    _local_2 = (_SafeStr_3346.getWithIndex(_local_3) as PlaneBitmapData);
                    if (_local_2 != null)
                    {
                        if (((!(_local_2.bitmap == null)) && (!(_local_2.bitmap == _arg_1))))
                        {
                            _local_2.bitmap.dispose();
                        };
                        _local_2.dispose();
                    };
                    _local_3++;
                };
                _SafeStr_3346.reset();
            };
            _SafeStr_3456 = null;
        }

        private function getTextureIdentifier(_arg_1:Number):String
        {
            if (_SafeStr_3450 != null)
            {
                return (_SafeStr_3450.getTextureIdentifier(_arg_1, normal));
            };
            return (String(_arg_1));
        }

        private function needsNewTexture(_arg_1:IRoomGeometry, _arg_2:int):Boolean
        {
            var _local_3:String;
            if (_arg_1 == null)
            {
                return (false);
            };
            var _local_4:PlaneBitmapData = _SafeStr_3456;
            if (_local_4 == null)
            {
                _local_3 = getTextureIdentifier(_arg_1.scale);
                _local_4 = (_SafeStr_3346.getValue(_local_3) as PlaneBitmapData);
            };
            updateMaskChangeStatus();
            if (((_canBeVisible) && (((_local_4 == null) || ((_local_4.timeStamp >= 0) && (_arg_2 > _local_4.timeStamp))) || (_SafeStr_3460))))
            {
                return (true);
            };
            return (false);
        }

        private function getTexture(_arg_1:IRoomGeometry, _arg_2:int):BitmapData
        {
            var _local_8:Number;
            var _local_9:Number;
            var _local_4:IVector3d;
            var _local_6:BitmapData;
            var _local_5:BitmapData;
            if (_arg_1 == null)
            {
                return (null);
            };
            var _local_7:PlaneBitmapData;
            var _local_3:String;
            if (needsNewTexture(_arg_1, _arg_2))
            {
                _local_8 = (_leftSide.length * _arg_1.scale);
                _local_9 = (_rightSide.length * _arg_1.scale);
                _local_4 = _arg_1.getCoordinatePosition(_normal);
                _local_3 = getTextureIdentifier(_arg_1.scale);
                if (_SafeStr_3456 != null)
                {
                    _local_7 = _SafeStr_3456;
                }
                else
                {
                    _local_7 = (_SafeStr_3346.getValue(_local_3) as PlaneBitmapData);
                };
                _local_6 = null;
                if (_local_7 != null)
                {
                    _local_6 = _local_7.bitmap;
                };
                if (_SafeStr_3450 != null)
                {
                    _local_7 = _SafeStr_3450.render(_local_6, _SafeStr_698, _local_8, _local_9, _arg_1.scale, _local_4, _hasTexture, _SafeStr_3452, _SafeStr_3453, _SafeStr_3454, _SafeStr_3455, _arg_2);
                    if (_local_7 != null)
                    {
                        if (((!(_local_6 == null)) && (!(_local_7.bitmap == _local_6))))
                        {
                            _local_6.dispose();
                        };
                    };
                }
                else
                {
                    _local_5 = new BitmapData(_local_8, _local_9, true, (0xFF000000 | _color));
                    _local_7 = new PlaneBitmapData(_local_5, -1);
                };
                if (_local_7 != null)
                {
                    updateMask(_local_7.bitmap, _arg_1);
                    cacheTexture(_local_3, _local_7);
                };
            }
            else
            {
                if (_SafeStr_3456 != null)
                {
                    _local_7 = _SafeStr_3456;
                }
                else
                {
                    _local_3 = getTextureIdentifier(_arg_1.scale);
                    _local_7 = (_SafeStr_3346.getValue(_local_3) as PlaneBitmapData);
                };
            };
            if (_local_7 != null)
            {
                _SafeStr_3456 = _local_7;
                return (_local_7.bitmap);
            };
            return (null);
        }

        private function resolveMasks(_arg_1:IRoomGeometry):PlaneDrawingData
        {
            var _local_8:int;
            var _local_10:PlaneMask;
            var _local_5:String;
            var _local_4:IVector3d;
            var _local_11:IGraphicAsset;
            var _local_9:Point;
            if (!_SafeStr_3457)
            {
                return (null);
            };
            var _local_7:RoomPlaneBitmapMask;
            var _local_2:int;
            var _local_3:int;
            var _local_6:PlaneDrawingData = new PlaneDrawingData();
            _local_8 = 0;
            while (_local_8 < _SafeStr_3458.length)
            {
                _local_7 = (_SafeStr_3458[_local_8] as RoomPlaneBitmapMask);
                if (_local_7 != null)
                {
                    _local_10 = _SafeStr_3451.getMask(_local_7.type);
                    if (_local_10 != null)
                    {
                        _local_5 = _local_10.getAssetName(_arg_1.scale);
                        if (_local_5 != null)
                        {
                            _local_4 = _arg_1.getCoordinatePosition(_normal);
                            _local_11 = _local_10.getGraphicAsset(_arg_1.scale, _local_4);
                            if (_local_11 != null)
                            {
                                _local_2 = int((_SafeStr_3398.width * (1 - (_local_7.leftSideLoc / _leftSide.length))));
                                _local_3 = int((_SafeStr_3398.height * (1 - (_local_7.rightSideLoc / _rightSide.length))));
                                _local_9 = new Point((_local_2 + _local_11.offsetX), (_local_3 + _local_11.offsetY));
                                _local_6.addMask(_local_5, _local_9, _local_11.flipH, _local_11.flipV);
                            };
                        };
                    };
                };
                _local_8++;
            };
            return (_local_6);
        }

        private function screenWidth(_arg_1:IRoomGeometry):int
        {
            var _local_2:Point = _arg_1.getScreenPoint(new Vector3d(0, 0, 0));
            var _local_3:Point = _arg_1.getScreenPoint(new Vector3d(0, 1, 0));
            return (Math.round((_leftSide.length * Math.abs((_local_2.x - _local_3.x)))));
        }

        public function getDrawingDatas(_arg_1:IRoomGeometry):Array
        {
            var _local_5:PlaneDrawingData;
            var _local_4:PlaneDrawingData;
            var _local_11:Array;
            var _local_10:PlaneVisualizationLayer;
            var _local_7:int;
            var _local_2:IVector3d;
            var _local_8:PlaneMaterialCellMatrix;
            var _local_3:Array;
            var _local_12:String;
            var _local_13:Array = [];
            if (_SafeStr_3009)
            {
                _local_5 = null;
                try
                {
                    _local_5 = resolveMasks(_arg_1);
                    _local_11 = _SafeStr_3450.getLayers(_SafeStr_698);
                    _local_7 = 0;
                    while (_local_7 < _local_11.length)
                    {
                        _local_10 = (_local_11[_local_7] as PlaneVisualizationLayer);
                        if (_local_10 != null)
                        {
                            if (((_hasTexture) && (!(_local_10.getMaterial() == null))))
                            {
                                _local_2 = _arg_1.getCoordinatePosition(_normal);
                                _local_8 = _local_10.getMaterial().getMaterialCellMatrix(_local_2);
                                _local_4 = new PlaneDrawingData(_local_5, blend(_color, _local_10.getColor()), _local_8.isBottomAligned());
                                Randomizer.setSeed(_SafeStr_3449);
                                for each (var _local_6:PlaneMaterialCellColumn in _local_8.getColumns(screenWidth(_arg_1)))
                                {
                                    _local_3 = [];
                                    for each (var _local_9:PlaneMaterialCell in _local_6.getCells())
                                    {
                                        _local_12 = _local_9.getAssetName(_local_2);
                                        if (_local_12 != null)
                                        {
                                            _local_3.push(_local_12);
                                        };
                                    };
                                    if (_local_3.length > 0)
                                    {
                                        if (!_local_6.isRepeated())
                                        {
                                            _local_3.push("");
                                        };
                                        _local_4.addAssetColumn(_local_3);
                                    };
                                };
                                if (_local_4.assetNameColumns.length > 0)
                                {
                                    _local_13.push(_local_4);
                                };
                            }
                            else
                            {
                                _local_4 = new PlaneDrawingData(_local_5, blend(_color, _local_10.getColor()));
                                _local_13.push(_local_4);
                            };
                        };
                        _local_7++;
                    };
                }
                catch(e:Error)
                {
                    Logger.log("Error in getting RoomPlane drawing data.", e);
                };
                if (_local_13.length == 0)
                {
                    _local_13.push(new PlaneDrawingData(_local_5, _color));
                };
            };
            return (_local_13);
        }

        private function addOutlines(_arg_1:PlaneBitmapData):void
        {
        }

        public function update(_arg_1:IRoomGeometry, _arg_2:int):Boolean
        {
            var _local_3:Number;
            var _local_8:int;
            var _local_4:IVector3d;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:BitmapData;
            if (((_arg_1 == null) || (_disposed)))
            {
                return (false);
            };
            var _local_9:Boolean;
            if (_SafeStr_3250 != _arg_1.updateId)
            {
                _local_9 = true;
            };
            if (((!(_local_9)) || (!(_canBeVisible))))
            {
                if (!visible)
                {
                    return (false);
                };
            };
            if (_local_9)
            {
                _SafeStr_3456 = null;
                _local_3 = 0;
                _local_3 = Vector3d.cosAngle(_arg_1.directionAxis, normal);
                if (_local_3 > -0.001)
                {
                    if (_SafeStr_3009)
                    {
                        _SafeStr_3009 = false;
                        return (true);
                    };
                    return (false);
                };
                _local_8 = 0;
                while (_local_8 < _secondaryNormals.length)
                {
                    _local_3 = Vector3d.cosAngle(_arg_1.directionAxis, _secondaryNormals[_local_8]);
                    if (_local_3 > -0.001)
                    {
                        if (_SafeStr_3009)
                        {
                            _SafeStr_3009 = false;
                            return (true);
                        };
                        return (false);
                    };
                    _local_8++;
                };
                updateCorners(_arg_1);
                _local_4 = _arg_1.getScreenPosition(_origin);
                _local_5 = _local_4.z;
                _local_6 = (Math.max(_SafeStr_3348.z, _SafeStr_3349.z, _SafeStr_3350.z, _SafeStr_3351.z) - _local_5);
                if (_type == 2)
                {
                    _local_6 = (_local_6 - ((_location.z + Math.min(0, _leftSide.z, _rightSide.z)) * 8));
                };
                if (_type == 3)
                {
                    _local_6 = (_local_6 + 0.02);
                };
                _relativeDepth = _local_6;
                _SafeStr_3009 = true;
                _SafeStr_3250 = _arg_1.updateId;
            };
            if (((_local_9) || (needsNewTexture(_arg_1, _arg_2))))
            {
                if ((((_bitmapData == null) || (!(_width == _bitmapData.width))) || (!(_SafeStr_1113 == _bitmapData.height))))
                {
                    if (_bitmapData != null)
                    {
                        _bitmapData.dispose();
                        _bitmapData = null;
                        if (((_width < 1) || (_SafeStr_1113 < 1)))
                        {
                            return (true);
                        };
                    }
                    else
                    {
                        if (((_width < 1) || (_SafeStr_1113 < 1)))
                        {
                            return (false);
                        };
                    };
                    try
                    {
                        _bitmapData = new BitmapData(_width, _SafeStr_1113, true, 0xFFFFFF);
                    }
                    catch(e:Error)
                    {
                        _bitmapData = null;
                        dispose();
                    };
                    if (_bitmapData == null)
                    {
                        return (false);
                    };
                    _bitmapData.lock();
                }
                else
                {
                    _bitmapData.lock();
                    _bitmapData.fillRect(_bitmapData.rect, 0xFFFFFF);
                };
                Randomizer.setSeed(_SafeStr_3449);
                _local_7 = getTexture(_arg_1, _arg_2);
                if (_local_7 != null)
                {
                    renderTexture(_arg_1, _local_7);
                }
                else
                {
                    dispose();
                    return (false);
                };
                _bitmapData.unlock();
                return ((_local_7) || (_local_9));
            };
            return (false);
        }

        private function updateCorners(_arg_1:IRoomGeometry):void
        {
            _SafeStr_3348.assign(_arg_1.getScreenPosition(_location));
            _SafeStr_3349.assign(_arg_1.getScreenPosition(Vector3d.sum(_location, _rightSide)));
            _SafeStr_3350.assign(_arg_1.getScreenPosition(Vector3d.sum(Vector3d.sum(_location, _leftSide), _rightSide)));
            _SafeStr_3351.assign(_arg_1.getScreenPosition(Vector3d.sum(_location, _leftSide)));
            _offset = _arg_1.getScreenPoint(_origin);
            _SafeStr_3348.x = Math.round(_SafeStr_3348.x);
            _SafeStr_3348.y = Math.round(_SafeStr_3348.y);
            _SafeStr_3349.x = Math.round(_SafeStr_3349.x);
            _SafeStr_3349.y = Math.round(_SafeStr_3349.y);
            _SafeStr_3350.x = Math.round(_SafeStr_3350.x);
            _SafeStr_3350.y = Math.round(_SafeStr_3350.y);
            _SafeStr_3351.x = Math.round(_SafeStr_3351.x);
            _SafeStr_3351.y = Math.round(_SafeStr_3351.y);
            _offset.x = Math.round(_offset.x);
            _offset.y = Math.round(_offset.y);
            var _local_3:Number = Math.min(_SafeStr_3348.x, _SafeStr_3349.x, _SafeStr_3350.x, _SafeStr_3351.x);
            var _local_5:Number = Math.max(_SafeStr_3348.x, _SafeStr_3349.x, _SafeStr_3350.x, _SafeStr_3351.x);
            var _local_2:Number = Math.min(_SafeStr_3348.y, _SafeStr_3349.y, _SafeStr_3350.y, _SafeStr_3351.y);
            var _local_4:Number = Math.max(_SafeStr_3348.y, _SafeStr_3349.y, _SafeStr_3350.y, _SafeStr_3351.y);
            _local_5 = (_local_5 - _local_3);
            _offset.x = (_offset.x - _local_3);
            _SafeStr_3348.x = (_SafeStr_3348.x - _local_3);
            _SafeStr_3349.x = (_SafeStr_3349.x - _local_3);
            _SafeStr_3350.x = (_SafeStr_3350.x - _local_3);
            _SafeStr_3351.x = (_SafeStr_3351.x - _local_3);
            _local_4 = (_local_4 - _local_2);
            _offset.y = (_offset.y - _local_2);
            _SafeStr_3348.y = (_SafeStr_3348.y - _local_2);
            _SafeStr_3349.y = (_SafeStr_3349.y - _local_2);
            _SafeStr_3350.y = (_SafeStr_3350.y - _local_2);
            _SafeStr_3351.y = (_SafeStr_3351.y - _local_2);
            _width = _local_5;
            _SafeStr_1113 = _local_4;
        }

        private function renderTexture(_arg_1:IRoomGeometry, _arg_2:BitmapData):void
        {
            if (((((((_SafeStr_3348 == null) || (_SafeStr_3349 == null)) || (_SafeStr_3350 == null)) || (_SafeStr_3351 == null)) || (_arg_2 == null)) || (_bitmapData == null)))
            {
                return;
            };
            var _local_8:Number = (_SafeStr_3351.x - _SafeStr_3350.x);
            var _local_10:Number = (_SafeStr_3351.y - _SafeStr_3350.y);
            var _local_4:Number = (_SafeStr_3349.x - _SafeStr_3350.x);
            var _local_3:Number = (_SafeStr_3349.y - _SafeStr_3350.y);
            if (((_type == 1) || (_type == 3)))
            {
                if (Math.abs((_local_4 - _arg_2.width)) <= 1)
                {
                    _local_4 = _arg_2.width;
                };
                if (Math.abs((_local_3 - _arg_2.width)) <= 1)
                {
                    _local_3 = _arg_2.width;
                };
                if (Math.abs((_local_8 - _arg_2.height)) <= 1)
                {
                    _local_8 = _arg_2.height;
                };
                if (Math.abs((_local_10 - _arg_2.height)) <= 1)
                {
                    _local_10 = _arg_2.height;
                };
            };
            var _local_5:Number = (_local_4 / _arg_2.width);
            var _local_6:Number = (_local_3 / _arg_2.width);
            var _local_7:Number = (_local_8 / _arg_2.height);
            var _local_9:Number = (_local_10 / _arg_2.height);
            var _local_11:Matrix = new Matrix();
            _local_11.a = _local_5;
            _local_11.b = _local_6;
            _local_11.c = _local_7;
            _local_11.d = _local_9;
            _local_11.translate(_SafeStr_3350.x, _SafeStr_3350.y);
            draw(_arg_2, _local_11);
        }

        private function draw(_arg_1:BitmapData, _arg_2:Matrix):void
        {
            var _local_4:int;
            var _local_7:int;
            var _local_3:Number;
            var _local_6:int;
            var _local_5:int;
            if (_bitmapData != null)
            {
                if (((((((_arg_2.a == 1) && (_arg_2.d == 1)) && (_arg_2.c == 0)) && (!(_arg_2.b == 0))) && (Math.abs(_arg_2.b) <= 1)) && ((_type == 1) || (_type == 3))))
                {
                    _local_4 = 0;
                    _local_7 = 0;
                    _local_3 = 0;
                    _local_6 = 0;
                    if (_arg_2.b > 0)
                    {
                        _arg_2.ty++;
                    };
                    _local_5 = 0;
                    while (_local_4 < _arg_1.width)
                    {
                        _local_4++;
                        _local_3 = (_local_3 + Math.abs(_arg_2.b));
                        if (_local_3 >= 1)
                        {
                            _bitmapData.copyPixels(_arg_1, new Rectangle((_local_7 + _local_6), 0, (_local_4 - _local_7), _arg_1.height), new Point((_arg_2.tx + _local_7), (_arg_2.ty + _local_5)), null, null, true);
                            _local_7 = _local_4;
                            if (_arg_2.b > 0)
                            {
                                _local_5++;
                            }
                            else
                            {
                                _local_5--;
                            };
                            _local_3 = 0;
                        };
                    };
                    if (_local_3 > 0)
                    {
                        _bitmapData.copyPixels(_arg_1, new Rectangle(_local_7, 0, (_local_4 - _local_7), _arg_1.height), new Point((_arg_2.tx + _local_7), (_arg_2.ty + _local_5)), null, null, true);
                    };
                    return;
                };
                _bitmapData.draw(_arg_1, _arg_2, null, null, null, false);
            };
        }

        public function resetBitmapMasks():void
        {
            if (_disposed)
            {
                return;
            };
            if (_SafeStr_3457)
            {
                if (_SafeStr_3458.length == 0)
                {
                    return;
                };
                _SafeStr_3460 = true;
                _SafeStr_3458 = [];
            };
        }

        public function addBitmapMask(_arg_1:String, _arg_2:Number, _arg_3:Number):Boolean
        {
            var _local_5:RoomPlaneBitmapMask;
            var _local_4:int;
            if (_SafeStr_3457)
            {
                _local_5 = null;
                _local_4 = 0;
                while (_local_4 < _SafeStr_3458.length)
                {
                    _local_5 = (_SafeStr_3458[_local_4] as RoomPlaneBitmapMask);
                    if (_local_5 != null)
                    {
                        if ((((_local_5.type == _arg_1) && (_local_5.leftSideLoc == _arg_2)) && (_local_5.rightSideLoc == _arg_3)))
                        {
                            return (false);
                        };
                    };
                    _local_4++;
                };
                _local_5 = new RoomPlaneBitmapMask(_arg_1, _arg_2, _arg_3);
                _SafeStr_3458.push(_local_5);
                _SafeStr_3460 = true;
                return (true);
            };
            return (false);
        }

        public function resetRectangleMasks():void
        {
            if (_SafeStr_3457)
            {
                if (_SafeStr_3459.length == 0)
                {
                    return;
                };
                _SafeStr_3460 = true;
                _SafeStr_3459 = [];
            };
        }

        public function addRectangleMask(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):Boolean
        {
            var _local_6:RoomPlaneRectangleMask;
            var _local_5:int;
            if (_SafeStr_3457)
            {
                _local_6 = null;
                _local_5 = 0;
                while (_local_5 < _SafeStr_3459.length)
                {
                    _local_6 = (_SafeStr_3459[_local_5] as RoomPlaneRectangleMask);
                    if (_local_6 != null)
                    {
                        if (((((_local_6.leftSideLoc == _arg_1) && (_local_6.rightSideLoc == _arg_2)) && (_local_6.leftSideLength == _arg_3)) && (_local_6.rightSideLength == _arg_4)))
                        {
                            return (false);
                        };
                    };
                    _local_5++;
                };
                _local_6 = new RoomPlaneRectangleMask(_arg_1, _arg_2, _arg_3, _arg_4);
                _SafeStr_3459.push(_local_6);
                _SafeStr_3460 = true;
                return (true);
            };
            return (false);
        }

        private function updateMaskChangeStatus():void
        {
            var _local_2:Boolean;
            var _local_3:RoomPlaneBitmapMask;
            if (!_SafeStr_3460)
            {
                return;
            };
            var _local_4:int;
            var _local_6:int;
            var _local_5:Boolean = true;
            var _local_7:RoomPlaneBitmapMask;
            var _local_1:RoomPlaneRectangleMask;
            if (_SafeStr_3458.length == _SafeStr_3462.length)
            {
                _local_4;
                while (_local_4 < _SafeStr_3458.length)
                {
                    _local_7 = (_SafeStr_3458[_local_4] as RoomPlaneBitmapMask);
                    if (_local_7 != null)
                    {
                        _local_2 = false;
                        _local_6;
                        while (_local_6 < _SafeStr_3462.length)
                        {
                            _local_3 = (_SafeStr_3462[_local_6] as RoomPlaneBitmapMask);
                            if (_local_3 != null)
                            {
                                if ((((_local_3.type == _local_7.type) && (_local_3.leftSideLoc == _local_7.leftSideLoc)) && (_local_3.rightSideLoc == _local_7.rightSideLoc)))
                                {
                                    _local_2 = true;
                                    break;
                                };
                            };
                            _local_6++;
                        };
                        if (!_local_2)
                        {
                            _local_5 = false;
                            break;
                        };
                    };
                    _local_4++;
                };
            }
            else
            {
                _local_5 = false;
            };
            if (_SafeStr_3459.length > _SafeStr_3463.length)
            {
                _local_5 = false;
            };
            if (_local_5)
            {
                _SafeStr_3460 = false;
            };
        }

        private function updateMask(_arg_1:BitmapData, _arg_2:IRoomGeometry):void
        {
            var _local_3:IVector3d;
            var _local_10:int;
            var _local_11:int;
            var _local_7:String;
            var _local_9:int;
            var _local_8:int;
            if ((((!(_SafeStr_3457)) || (((_SafeStr_3458.length == 0) && (_SafeStr_3459.length == 0)) && (!(_SafeStr_3460)))) || (_SafeStr_3451 == null)))
            {
                return;
            };
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return;
            };
            var _local_13:RoomPlaneBitmapMask;
            var _local_4:RoomPlaneRectangleMask;
            var _local_5:int;
            var _local_6:int;
            updateMaskChangeStatus();
            var _local_12:Number = _arg_1.width;
            var _local_14:Number = _arg_1.height;
            if ((((_SafeStr_3398 == null) || (!(_SafeStr_3398.width == _local_12))) || (!(_SafeStr_3398.height == _local_14))))
            {
                if (_SafeStr_3398 != null)
                {
                    _SafeStr_3398.dispose();
                    _SafeStr_3398 = null;
                };
                try
                {
                    _SafeStr_3398 = new BitmapData(_local_12, _local_14, true, 0xFFFFFF);
                }
                catch(e:Error)
                {
                    _SafeStr_3398 = null;
                    return;
                };
                _SafeStr_3460 = true;
            };
            if (_SafeStr_3460)
            {
                _SafeStr_3462 = [];
                _SafeStr_3463 = [];
                if (_SafeStr_3398 != null)
                {
                    _SafeStr_3398.fillRect(_SafeStr_3398.rect, 0xFFFFFF);
                };
                resetTextureCache(_arg_1);
                _local_3 = _arg_2.getCoordinatePosition(_normal);
                _local_10 = 0;
                _local_11 = 0;
                _local_5 = 0;
                while (_local_5 < _SafeStr_3458.length)
                {
                    _local_13 = (_SafeStr_3458[_local_5] as RoomPlaneBitmapMask);
                    if (_local_13 != null)
                    {
                        _local_10 = int((_SafeStr_3398.width - ((_SafeStr_3398.width * _local_13.leftSideLoc) / _leftSide.length)));
                        _local_11 = int((_SafeStr_3398.height - ((_SafeStr_3398.height * _local_13.rightSideLoc) / _rightSide.length)));
                        _local_7 = _local_13.type;
                        _SafeStr_3451.updateMask(_SafeStr_3398, _local_7, _arg_2.scale, _local_3, _local_10, _local_11);
                        _SafeStr_3462.push(new RoomPlaneBitmapMask(_local_7, _local_13.leftSideLoc, _local_13.rightSideLoc));
                    };
                    _local_5++;
                };
                _local_6 = 0;
                while (_local_6 < _SafeStr_3459.length)
                {
                    _local_4 = (_SafeStr_3459[_local_6] as RoomPlaneRectangleMask);
                    if (_local_4 != null)
                    {
                        _local_10 = int((_SafeStr_3398.width - ((_SafeStr_3398.width * _local_4.leftSideLoc) / _leftSide.length)));
                        _local_11 = int((_SafeStr_3398.height - ((_SafeStr_3398.height * _local_4.rightSideLoc) / _rightSide.length)));
                        _local_9 = int(((_SafeStr_3398.width * _local_4.leftSideLength) / _leftSide.length));
                        _local_8 = int(((_SafeStr_3398.height * _local_4.rightSideLength) / _rightSide.length));
                        _SafeStr_3398.fillRect(new Rectangle((_local_10 - _local_9), (_local_11 - _local_8), _local_9, _local_8), 0xFF000000);
                        _SafeStr_3463.push(new RoomPlaneRectangleMask(_local_4.leftSideLength, _local_4.rightSideLoc, _local_4.leftSideLength, _local_4.rightSideLength));
                    };
                    _local_6++;
                };
                _SafeStr_3460 = false;
            };
            combineTextureMask(_arg_1, _SafeStr_3398);
        }

        private function combineTextureMask(_arg_1:BitmapData, _arg_2:BitmapData):void
        {
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return;
            };
            if (((!(_SafeStr_3461 == null)) && ((!(_SafeStr_3461.width == _arg_1.width)) || (!(_SafeStr_3461.height == _arg_1.height)))))
            {
                _SafeStr_3461.dispose();
                _SafeStr_3461 = null;
            };
            if (_SafeStr_3461 == null)
            {
                try
                {
                    _SafeStr_3461 = new BitmapData(_arg_1.width, _arg_1.height, true, 0xFFFFFFFF);
                }
                catch(e:Error)
                {
                    if (_SafeStr_3461)
                    {
                        _SafeStr_3461.dispose();
                    };
                    _SafeStr_3461 = null;
                    return;
                };
            };
            _SafeStr_3461.copyChannel(_arg_1, _arg_1.rect, ZERO_POINT, 8, 1);
            _SafeStr_3461.draw(_arg_2, null, null, "darken");
            _arg_1.copyChannel(_SafeStr_3461, _SafeStr_3461.rect, ZERO_POINT, 1, 8);
        }


    }
}

