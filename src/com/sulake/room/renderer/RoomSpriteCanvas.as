package com.sulake.room.renderer
{
    import flash.geom.Point;
    import com.sulake.room.utils.RoomGeometry;
    import flash.display.Sprite;
    import com.sulake.core.utils.Map;
    import com.sulake.room.renderer.cache.BitmapDataCache;
    import com.sulake.room.renderer.cache.RoomObjectCache;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import com.sulake.room.utils.Vector3d;
    import flash.display.DisplayObject;
    import com.sulake.room.utils.IRoomGeometry;
    import __AS3__.vec.Vector;
    import com.sulake.room.data.RoomObjectSpriteData;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import com.sulake.room.renderer.utils.ExtendedSprite;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.renderer.utils.SortableSprite;
    import com.sulake.room.renderer.cache.RoomObjectCacheItem;
    import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
    import com.sulake.room.renderer.cache.RoomObjectLocationCacheItem;
    import com.sulake.room.renderer.cache.RoomObjectSortableSpriteCacheItem;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import com.sulake.room.object.enum.RoomObjectSpriteType;
    import com.sulake.room.utils.RoomEnterEffect;
    import com.sulake.room.renderer.utils.ExtendedBitmapData;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.renderer.utils.ObjectMouseData;
    import com.sulake.room.object.logic.IRoomObjectMouseHandler;
    import flash.events.MouseEvent;
    import com.sulake.room.utils.*;

        public class RoomSpriteCanvas implements IRoomRenderingCanvas 
    {

        private static const ZERO_POINT:Point = new Point(0, 0);
        private static const SKIP_FRAME_COUNT_FOR_UPDATE_INTERVAL:int = 50;
        private static const FRAME_COUNT_FOR_UPDATE_INTERVAL:int = 50;
        private static const SLOW_FRAME_UPDATE_INTERVAL:Number = 60;
        private static const FAST_FRAME_UPDATE_INTERVAL:Number = 50;
        private static const MAXIMUM_VALID_FRAME_UPDATE_INTERVAL:int = 1000;

        private var _container:IRoomSpriteCanvasContainer;
        private var _geometry:RoomGeometry;
        private var _bgColor:int = 0;
        private var _displayObject:Sprite;
        private var _SafeStr_4484:Sprite;
        private var _display:Sprite;
        private var _SafeStr_4485:Map = new Map();
        private var _mouseLocation:Point = new Point();
        private var _bitmapDataCache:BitmapDataCache;
        private var _roomObjectCache:RoomObjectCache;
        private var _SafeStr_4486:Array = [];
        private var _SafeStr_4487:Array = [];
        private var _SafeStr_4488:IRoomRenderingCanvasMouseListener = null;
        private var _SafeStr_698:int;
        private var _eventCache:Map = null;
        private var _SafeStr_4489:int = 0;
        private var _SafeStr_4490:int;
        private var _SafeStr_4491:int;
        private var _screenOffsetX:int;
        private var _screenOffsetY:int;
        private var _SafeStr_4492:int;
        private var _SafeStr_4493:int;
        private var _SafeStr_4494:int = -1;
        private var _SafeStr_4495:Number = -10000000;
        private var _SafeStr_4496:Number = -10000000;
        private var _SafeStr_4497:int = 0;
        private var _SafeStr_4498:Boolean = false;
        private var _SafeStr_3457:Boolean = false;
        private var _SafeStr_1107:ColorTransform;
        private var _SafeStr_4499:Matrix;
        private var _SafeStr_3825:Number = 0;
        private var _SafeStr_3824:int = 0;
        private var _runningSlow:Boolean = false;
        private var _skipObjectUpdate:Boolean = false;
        private var _SafeStr_4500:int = 0;
        private var _SafeStr_4501:Boolean = false;
        private var _SafeStr_4502:Array = [];
        private var _activeSpriteCount:int = 0;
        private var _SafeStr_4503:Number = 0;
        private var _SafeStr_4504:int = 0;
        private var _SafeStr_4505:int = 0;
        private var _scale:Number = 1;
        private var _SafeStr_4506:Boolean;

        public function RoomSpriteCanvas(_arg_1:IRoomSpriteCanvasContainer, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int)
        {
            _container = _arg_1;
            _SafeStr_698 = _arg_2;
            _displayObject = new Sprite();
            _displayObject.mouseEnabled = false;
            _display = new Sprite();
            _display.name = "canvas";
            _display.mouseEnabled = false;
            _displayObject.addChild(_display);
            _display.mouseEnabled = true;
            _display.doubleClickEnabled = true;
            _display.addEventListener("click", clickHandler);
            _display.addEventListener("doubleClick", clickHandler);
            _geometry = new RoomGeometry(_arg_5, new Vector3d(-135, 30, 0), new Vector3d(11, 11, 5), new Vector3d(-135, 0.5, 0));
            _bitmapDataCache = new BitmapDataCache(16, 32, 1);
            var _local_6:String;
            if (_container != null)
            {
                _local_6 = _container.roomObjectVariableAccurateZ;
            };
            _eventCache = new Map();
            _roomObjectCache = new RoomObjectCache(_local_6);
            _SafeStr_1107 = new ColorTransform();
            _SafeStr_4499 = new Matrix();
            initialize(_arg_3, _arg_4);
        }

        protected function get container():IRoomSpriteCanvasContainer
        {
            return (_container);
        }

        protected function get activeSpriteCount():int
        {
            return (_activeSpriteCount);
        }

        public function get width():int
        {
            return (_SafeStr_4490 * _scale);
        }

        public function get height():int
        {
            return (_SafeStr_4491 * _scale);
        }

        public function set screenOffsetX(_arg_1:int):void
        {
            _mouseLocation.x = (_mouseLocation.x - (_arg_1 - _screenOffsetX));
            _screenOffsetX = _arg_1;
        }

        public function set screenOffsetY(_arg_1:int):void
        {
            _mouseLocation.y = (_mouseLocation.y - (_arg_1 - _screenOffsetY));
            _screenOffsetY = _arg_1;
        }

        public function get screenOffsetX():int
        {
            return (_screenOffsetX);
        }

        public function get screenOffsetY():int
        {
            return (_screenOffsetY);
        }

        public function get displayObject():DisplayObject
        {
            return (_displayObject);
        }

        public function get geometry():IRoomGeometry
        {
            return (_geometry);
        }

        public function set mouseListener(_arg_1:IRoomRenderingCanvasMouseListener):void
        {
            _SafeStr_4488 = _arg_1;
        }

        public function set useMask(_arg_1:Boolean):void
        {
            if (((_arg_1) && (!(_SafeStr_3457))))
            {
                _SafeStr_3457 = true;
                if (((!(_SafeStr_4484 == null)) && (!(_displayObject.contains(_SafeStr_4484)))))
                {
                    _displayObject.addChild(_SafeStr_4484);
                    _display.mask = _SafeStr_4484;
                };
            }
            else
            {
                if (((!(_arg_1)) && (_SafeStr_3457)))
                {
                    _SafeStr_3457 = false;
                    if (((!(_SafeStr_4484 == null)) && (_displayObject.contains(_SafeStr_4484))))
                    {
                        _displayObject.removeChild(_SafeStr_4484);
                        _display.mask = null;
                    };
                };
            };
        }

        public function getSortableSpriteList():Vector.<RoomObjectSpriteData>
        {
            return (_roomObjectCache.getSortableSpriteList());
        }

        public function getPlaneSortableSprites():Array
        {
            return (_roomObjectCache.getPlaneSortableSprites());
        }

        public function setScale(_arg_1:Number, _arg_2:Point=null, _arg_3:Point=null, _arg_4:Boolean=false):void
        {
            if ((((!(_displayObject)) || (!(_displayObject.stage))) || (!(_display))))
            {
                return;
            };
            if (_arg_2 == null)
            {
                _arg_2 = new Point((_displayObject.stage.stageWidth / 2), (_displayObject.stage.stageHeight / 2));
            };
            if (_arg_3 == null)
            {
                _arg_3 = _arg_2;
            };
            _arg_2 = _display.globalToLocal(_arg_2);
            _scale = _arg_1;
            if (_scale < 1)
            {
                if (!_arg_4)
                {
                };
            }
            else
            {
                if (!_arg_4)
                {
                };
            };
            screenOffsetX = (_arg_3.x - (_arg_2.x * _arg_1));
            screenOffsetY = (_arg_3.y - (_arg_2.y * _arg_1));
        }

        public function get scale():Number
        {
            return (_scale);
        }

        public function takeScreenShot():BitmapData
        {
            _SafeStr_4506 = true;
            var _local_5:Number = _scale;
            var _local_2:int = _screenOffsetX;
            var _local_1:int = _screenOffsetY;
            var _local_6:String = _display.stage.quality;
            setScale(1);
            _screenOffsetX = 0;
            _screenOffsetY = 0;
            _display.stage.quality = "low";
            render(-1, true);
            var _local_3:BitmapData = new BitmapData(_display.width, _display.height, true, 0);
            var _local_4:Rectangle = _display.getBounds(_display);
            _local_3.draw(_display, new Matrix(1, 0, 0, 1, -(_local_4.x), -(_local_4.y)));
            _SafeStr_4506 = false;
            setScale(_local_5);
            _screenOffsetX = _local_2;
            _screenOffsetY = _local_1;
            _display.stage.quality = _local_6;
            return (_local_3);
        }

        public function skipSpriteVisibilityChecking():void
        {
            _SafeStr_4506 = true;
            render(-1, true);
        }

        public function resumeSpriteVisibilityChecking():void
        {
            _SafeStr_4506 = false;
        }

        public function dispose():void
        {
            cleanSprites(0, true);
            if (_geometry != null)
            {
                _geometry.dispose();
                _geometry = null;
            };
            if (_SafeStr_4484 != null)
            {
                _SafeStr_4484 = null;
            };
            if (_bitmapDataCache != null)
            {
                _bitmapDataCache.dispose();
                _bitmapDataCache = null;
            };
            if (_roomObjectCache != null)
            {
                _roomObjectCache.dispose();
                _roomObjectCache = null;
            };
            _container = null;
            if (_displayObject != null)
            {
                while (_displayObject.numChildren > 0)
                {
                    _displayObject.removeChildAt(0);
                };
                _displayObject = null;
            };
            _display = null;
            _SafeStr_4484 = null;
            _SafeStr_4486 = [];
            if (_SafeStr_4485 != null)
            {
                _SafeStr_4485.dispose();
                _SafeStr_4485 = null;
            };
            var _local_1:int;
            if (_SafeStr_4487 != null)
            {
                _local_1 = 0;
                while (_local_1 < _SafeStr_4487.length)
                {
                    cleanSprite((_SafeStr_4487[_local_1] as ExtendedSprite), true);
                    _local_1++;
                };
                _SafeStr_4487 = [];
            };
            if (_eventCache != null)
            {
                _eventCache.dispose();
                _eventCache = null;
            };
            _SafeStr_4488 = null;
            _SafeStr_1107 = null;
            _SafeStr_4499 = null;
        }

        public function initialize(_arg_1:int, _arg_2:int):void
        {
            if (_arg_1 < 1)
            {
                _arg_1 = 1;
            };
            if (_arg_2 < 1)
            {
                _arg_2 = 1;
            };
            if (_SafeStr_4484 != null)
            {
                _SafeStr_4484.graphics.clear();
            }
            else
            {
                _SafeStr_4484 = new Sprite();
                _SafeStr_4484.name = "mask";
                if (_SafeStr_3457)
                {
                    _displayObject.addChild(_SafeStr_4484);
                    _display.mask = _SafeStr_4484;
                };
            };
            _SafeStr_4484.graphics.beginFill(0);
            _SafeStr_4484.graphics.drawRect(0, 0, _arg_1, _arg_2);
            _SafeStr_4490 = _arg_1;
            _SafeStr_4491 = _arg_2;
        }

        public function roomObjectRemoved(_arg_1:String):void
        {
            _roomObjectCache.removeObjectCache(_arg_1);
        }

        public function render(_arg_1:int, _arg_2:Boolean=false):void
        {
            if (_arg_1 == -1)
            {
                (_arg_1 == (_SafeStr_4494 + 1));
            };
            _skipObjectUpdate = (!(_skipObjectUpdate));
            var _local_6:int;
            if (((_container == null) || (_geometry == null)))
            {
                return;
            };
            if (_arg_1 == _SafeStr_4494)
            {
                return;
            };
            calculateUpdateInterval(_arg_1);
            _bitmapDataCache.compress();
            var _local_7:int = _container.getRoomObjectCount();
            var _local_4:int;
            var _local_5:int;
            var _local_8:String = "";
            var _local_9:IRoomObject;
            if (((!(_SafeStr_4490 == _SafeStr_4492)) || (!(_SafeStr_4491 == _SafeStr_4493))))
            {
                _arg_2 = true;
            };
            if ((((!(_display.x == _screenOffsetX)) || (!(_display.y == _screenOffsetY))) || (!(_display.scaleX == _scale))))
            {
                _display.x = _screenOffsetX;
                _display.y = _screenOffsetY;
                _display.scaleX = _scale;
                _display.scaleY = _scale;
                _arg_2 = true;
            };
            _local_4 = 0;
            while (_local_4 < _local_7)
            {
                _local_9 = _container.getRoomObjectWithIndex(_local_4);
                if (_local_9 != null)
                {
                    _local_8 = _container.getRoomObjectIdWithIndex(_local_4);
                    _local_5 = (_local_5 + renderObject(_local_9, _local_8, _arg_1, _arg_2, _local_5));
                };
                _local_4++;
            };
            _SafeStr_4486.sortOn("z", 16);
            _SafeStr_4486.reverse();
            if (_local_5 < _SafeStr_4486.length)
            {
                _SafeStr_4486.splice(_local_5);
            };
            var _local_3:SortableSprite;
            _local_4 = 0;
            while (_local_4 < _local_5)
            {
                _local_3 = (_SafeStr_4486[_local_4] as SortableSprite);
                if (_local_3 != null)
                {
                    updateSprite(_local_4, _local_3);
                };
                _local_4++;
            };
            cleanSprites(_local_5);
            _SafeStr_4494 = _arg_1;
            _SafeStr_4492 = _SafeStr_4490;
            _SafeStr_4493 = _SafeStr_4491;
        }

        private function calculateUpdateInterval(_arg_1:int):void
        {
            var _local_3:int;
            var _local_2:Number;
            if (_SafeStr_4494 > 0)
            {
                _local_3 = (_arg_1 - _SafeStr_4494);
                if (_local_3 > (60 * 3))
                {
                    Logger.log((("Really slow frame update " + _local_3) + "ms"));
                    _SafeStr_4505 = _local_3;
                };
                if (_local_3 <= 1000)
                {
                    _SafeStr_3824++;
                    if (_SafeStr_3824 == (50 + 1))
                    {
                        _SafeStr_3825 = _local_3;
                        _SafeStr_4503 = _SafeStr_4504;
                    }
                    else
                    {
                        if (_SafeStr_3824 > (50 + 1))
                        {
                            _local_2 = (_SafeStr_3824 - 50);
                            _SafeStr_3825 = (((_SafeStr_3825 * (_local_2 - 1)) / _local_2) + (_local_3 / _local_2));
                            _SafeStr_4503 = (((_SafeStr_4503 * (_local_2 - 1)) / _local_2) + (_SafeStr_4504 / _local_2));
                            if (_SafeStr_3824 > (50 + 50))
                            {
                                _SafeStr_3824 = 50;
                                if (((!(_runningSlow)) && (_SafeStr_3825 > 60)))
                                {
                                    _runningSlow = true;
                                    Logger.log("Room canvas updating really slow - now entering frame skipping mode...");
                                }
                                else
                                {
                                    if (((_runningSlow) && (_SafeStr_3825 < 50)))
                                    {
                                        _runningSlow = false;
                                        Logger.log("Room canvas updating fast again - now entering normal frame mode...");
                                    };
                                };
                                _SafeStr_4505 = 0;
                            };
                        };
                    };
                };
            };
        }

        protected function getRoomObjectCacheItem(_arg_1:String):RoomObjectCacheItem
        {
            return (_roomObjectCache.getObjectCache(_arg_1));
        }

        private function renderObject(_arg_1:IRoomObject, _arg_2:String, _arg_3:int, _arg_4:Boolean, _arg_5:int):int
        {
            var _local_14:int;
            var _local_11:BitmapData;
            var _local_8:IRoomObjectSpriteVisualization = (_arg_1.getVisualization() as IRoomObjectSpriteVisualization);
            if (_local_8 == null)
            {
                _roomObjectCache.removeObjectCache(_arg_2);
                return (0);
            };
            var _local_9:RoomObjectCacheItem = getRoomObjectCacheItem(_arg_2);
            _local_9.objectId = _arg_1.getId();
            var _local_20:RoomObjectLocationCacheItem = _local_9.location;
            var _local_7:RoomObjectSortableSpriteCacheItem = _local_9.sprites;
            var _local_10:IVector3d = _local_20.getScreenLocation(_arg_1, _geometry);
            if (_local_10 == null)
            {
                _roomObjectCache.removeObjectCache(_arg_2);
                return (0);
            };
            _local_8.update(_geometry, _arg_3, ((!(_local_7.isEmpty)) || (_arg_4)), ((_skipObjectUpdate) && (_runningSlow)));
            var _local_17:Boolean = _local_20.locationChanged;
            if (_local_17)
            {
                _arg_4 = true;
            };
            if (((!(_local_7.needsUpdate(_local_8.getInstanceId(), _local_8.getUpdateID()))) && (!(_arg_4))))
            {
                return (_local_7.spriteCount);
            };
            var _local_12:int = _local_8.spriteCount;
            var _local_16:int = _local_10.x;
            var _local_15:int = _local_10.y;
            var _local_13:Number = _local_10.z;
            if (_local_16 > 0)
            {
                _local_13 = (_local_13 + (_local_16 * 1.2E-7));
            }
            else
            {
                _local_13 = (_local_13 + (-(_local_16) * 1.2E-7));
            };
            _local_16 = int((_local_16 + int((_SafeStr_4490 / 2))));
            _local_15 = int((_local_15 + int((_SafeStr_4491 / 2))));
            var _local_19:int;
            var _local_18:SortableSprite;
            var _local_6:IRoomObjectSprite;
            var _local_21:int;
            var _local_22:int;
            _local_14 = 0;
            while (_local_14 < _local_12)
            {
                _local_6 = _local_8.getSprite(_local_14);
                if (((!(_local_6 == null)) && (_local_6.visible)))
                {
                    _local_11 = _local_6.asset;
                    if (_local_11 != null)
                    {
                        _local_21 = ((_local_16 + _local_6.offsetX) + _screenOffsetX);
                        _local_22 = ((_local_15 + _local_6.offsetY) + _screenOffsetY);
                        if (rectangleVisible(_local_21, _local_22, _local_11.width, _local_11.height))
                        {
                            _local_18 = _local_7.getSprite(_local_19);
                            if (_local_18 == null)
                            {
                                _local_18 = new SortableSprite();
                                _local_7.addSprite(_local_18);
                                _SafeStr_4486.push(_local_18);
                                _local_18.name = _arg_2;
                            };
                            _local_18.sprite = _local_6;
                            if (((_local_6.spriteType == RoomObjectSpriteType.AVATAR) || (_local_6.spriteType == RoomObjectSpriteType._SafeStr_625)))
                            {
                                _local_18.sprite.libraryAssetName = _arg_1.getAvatarLibraryAssetName();
                            };
                            _local_18.x = (_local_21 - _screenOffsetX);
                            _local_18.y = (_local_22 - _screenOffsetY);
                            _local_18.z = ((_local_13 + _local_6.relativeDepth) + (3.7E-11 * _arg_5));
                            _local_19++;
                            _arg_5++;
                        };
                    };
                };
                _local_14++;
            };
            _local_7.setSpriteCount(_local_19);
            return (_local_19);
        }

        private function rectangleVisible(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):Boolean
        {
            if (_SafeStr_4506)
            {
                return (true);
            };
            _arg_1 = (((_arg_1 - _screenOffsetX) * _scale) + _screenOffsetX);
            _arg_2 = (((_arg_2 - _screenOffsetY) * _scale) + _screenOffsetY);
            _arg_3 = (_arg_3 * _scale);
            _arg_4 = (_arg_4 * _scale);
            if ((((_arg_1 < _SafeStr_4490) && ((_arg_1 + _arg_3) >= 0)) && ((_arg_2 < _SafeStr_4491) && ((_arg_2 + _arg_4) >= 0))))
            {
                if (!_SafeStr_4501)
                {
                    return (true);
                };
                return (rectangleVisibleWithExclusion(_arg_1, _arg_2, _arg_3, _arg_4));
            };
            return (false);
        }

        private function rectangleVisibleWithExclusion(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):Boolean
        {
            if (_arg_1 < 0)
            {
                _arg_3 = (_arg_3 + _arg_1);
                _arg_1 = 0;
            };
            if (_arg_2 < 0)
            {
                _arg_4 = (_arg_4 + _arg_2);
                _arg_2 = 0;
            };
            if ((_arg_1 + _arg_3) >= _SafeStr_4490)
            {
                _arg_3 = (_arg_3 - ((_SafeStr_4490 + 1) - (_arg_1 + _arg_3)));
            };
            if ((_arg_2 + _arg_4) >= _SafeStr_4491)
            {
                _arg_4 = (_arg_4 - ((_SafeStr_4491 + 1) - (_arg_2 + _arg_4)));
            };
            for each (var _local_5:Rectangle in _SafeStr_4502)
            {
                if (((((_arg_1 >= _local_5.left) && ((_arg_1 + _arg_3) < _local_5.right)) && (_arg_2 >= _local_5.top)) && ((_arg_2 + _arg_4) < _local_5.bottom)))
                {
                    return (false);
                };
            };
            return (true);
        }

        protected function getSprite(_arg_1:int):ExtendedSprite
        {
            if (((_arg_1 < 0) || (_arg_1 >= _SafeStr_4500)))
            {
                return (null);
            };
            return (_display.getChildAt(_arg_1) as ExtendedSprite);
        }

        private function createSprite(_arg_1:SortableSprite, _arg_2:int=-1):void
        {
            var _local_4:ExtendedSprite;
            var _local_3:IRoomObjectSprite = _arg_1.sprite;
            if (_SafeStr_4487.length > 0)
            {
                _local_4 = (_SafeStr_4487.pop() as ExtendedSprite);
            };
            if (_local_4 == null)
            {
                _local_4 = new ExtendedSprite();
            };
            _local_4.x = _arg_1.x;
            _local_4.y = _arg_1.y;
            _local_4.offsetRefX = _local_3.offsetX;
            _local_4.offsetRefY = _local_3.offsetY;
            _local_4.identifier = _arg_1.name;
            _local_4.alpha = (_local_3.alpha / 0xFF);
            _local_4.tag = _local_3.tag;
            _local_4.blendMode = _local_3.blendMode;
            _local_4.filters = _local_3.filters;
            _local_4.varyingDepth = _local_3.varyingDepth;
            _local_4.clickHandling = _local_3.clickHandling;
            _local_4.smoothing = false;
            _local_4.pixelSnapping = "always";
            _local_4.bitmapData = getBitmapData(_local_3.asset, _local_3.assetName, _local_3.flipH, _local_3.flipV, _local_3.color);
            updateEnterRoomEffect(_local_4, _local_3);
            _local_4.alphaTolerance = _local_3.alphaTolerance;
            if (((_arg_2 < 0) || (_arg_2 >= _SafeStr_4500)))
            {
                _display.addChild(_local_4);
                _SafeStr_4500++;
            }
            else
            {
                _display.addChildAt(_local_4, _arg_2);
            };
            _activeSpriteCount++;
        }

        private function updateSprite(_arg_1:int, _arg_2:SortableSprite):Boolean
        {
            var _local_5:Number;
            var _local_4:BitmapData;
            if (_arg_1 >= _SafeStr_4500)
            {
                createSprite(_arg_2);
                return (true);
            };
            var _local_3:IRoomObjectSprite = _arg_2.sprite;
            var _local_6:ExtendedSprite = getSprite(_arg_1);
            if (_local_6 != null)
            {
                if (_local_6.varyingDepth != _local_3.varyingDepth)
                {
                    if (((_local_6.varyingDepth) && (!(_local_3.varyingDepth))))
                    {
                        _display.removeChildAt(_arg_1);
                        _SafeStr_4487.push(_local_6);
                        return (updateSprite(_arg_1, _arg_2));
                    };
                    createSprite(_arg_2, _arg_1);
                    return (true);
                };
                if (((_local_6.needsUpdate(_local_3.instanceId, _local_3.updateId)) || (RoomEnterEffect.isVisualizationOn())))
                {
                    _local_6.alphaTolerance = _local_3.alphaTolerance;
                    _local_5 = (_local_3.alpha / 0xFF);
                    if (_local_6.alpha != _local_5)
                    {
                        _local_6.alpha = _local_5;
                    };
                    _local_6.identifier = _arg_2.name;
                    _local_6.tag = _local_3.tag;
                    _local_6.varyingDepth = _local_3.varyingDepth;
                    _local_6.blendMode = _local_3.blendMode;
                    _local_6.clickHandling = _local_3.clickHandling;
                    _local_6.filters = _local_3.filters;
                    _local_4 = getBitmapData(_local_3.asset, _local_3.assetName, _local_3.flipH, _local_3.flipV, _local_3.color);
                    if (_local_6.bitmapData != _local_4)
                    {
                        _local_6.bitmapData = _local_4;
                    };
                    updateEnterRoomEffect(_local_6, _local_3);
                };
                if (_local_6.x != _arg_2.x)
                {
                    _local_6.x = _arg_2.x;
                };
                if (_local_6.y != _arg_2.y)
                {
                    _local_6.y = _arg_2.y;
                };
                _local_6.offsetRefX = _local_3.offsetX;
                _local_6.offsetRefY = _local_3.offsetY;
            }
            else
            {
                return (false);
            };
            return (true);
        }

        private function updateEnterRoomEffect(_arg_1:ExtendedSprite, _arg_2:IRoomObjectSprite):void
        {
            if ((((!(RoomEnterEffect.isVisualizationOn())) || (_arg_1.bitmapData == null)) || (_arg_2 == null)))
            {
                return;
            };
            switch (_arg_2.spriteType)
            {
                case RoomObjectSpriteType._SafeStr_625:
                    return;
                case RoomObjectSpriteType.ROOM_PLANE:
                    _arg_1.alpha = RoomEnterEffect.getDelta(0.9);
                    return;
                case RoomObjectSpriteType.AVATAR:
                    _arg_1.alpha = RoomEnterEffect.getDelta(0.5);
                    return;
                default:
                    _arg_1.alpha = RoomEnterEffect.getDelta(0.1);
                    return;
            };
        }

        private function cleanSprites(_arg_1:int, _arg_2:Boolean=false):void
        {
            var _local_4:int;
            if (_display == null)
            {
                return;
            };
            if (_arg_1 < 0)
            {
                _arg_1 = 0;
            };
            var _local_3:ExtendedSprite;
            if (((_arg_1 < _activeSpriteCount) || (_activeSpriteCount == 0)))
            {
                _local_4 = (_SafeStr_4500 - 1);
                while (_local_4 >= _arg_1)
                {
                    _local_3 = getSprite(_local_4);
                    cleanSprite(_local_3, _arg_2);
                    _local_4--;
                };
            };
            _activeSpriteCount = _arg_1;
        }

        private function cleanSprite(_arg_1:ExtendedSprite, _arg_2:Boolean):void
        {
            if (_arg_1 != null)
            {
                if (!_arg_2)
                {
                    _arg_1.bitmapData = null;
                }
                else
                {
                    _arg_1.dispose();
                };
            };
        }

        private function getSortableSprite(_arg_1:int):SortableSprite
        {
            if (((_arg_1 < 0) || (_arg_1 >= _SafeStr_4486.length)))
            {
                return (null);
            };
            return (_SafeStr_4486[_arg_1] as SortableSprite);
        }

        private function getBitmapData(_arg_1:BitmapData, _arg_2:String, _arg_3:Boolean, _arg_4:Boolean, _arg_5:int):BitmapData
        {
            _arg_5 = (_arg_5 & 0xFFFFFF);
            if ((((!(_arg_3)) && (!(_arg_4))) && (_arg_5 == 0xFFFFFF)))
            {
                return (_arg_1);
            };
            var _local_7:ExtendedBitmapData;
            var _local_6:String = "";
            if ((((_arg_3) || (_arg_4)) && (!(_arg_5 == 0xFFFFFF))))
            {
                _local_6 = ((((_arg_2 + " ") + _arg_5) + ((_arg_3) ? " FH" : "")) + ((_arg_4) ? " FV" : ""));
                if (_arg_2.length > 0)
                {
                    _local_7 = _bitmapDataCache.getBitmapData(_local_6);
                };
                if (_local_7 == null)
                {
                    _local_7 = getColoredBitmapData(_arg_1, _arg_2, _arg_5);
                    if (_local_7 != null)
                    {
                        _local_7 = getFlippedBitmapData(_local_7, _arg_2, true, _arg_3, _arg_4);
                        if (_arg_2.length > 0)
                        {
                            _bitmapDataCache.addBitmapData(_local_6, _local_7);
                        };
                        return (_local_7);
                    };
                    _local_7 = getFlippedBitmapData(_arg_1, _arg_2, true, _arg_3, _arg_4);
                    if (_local_7 != null)
                    {
                        _local_7 = getColoredBitmapData(_local_7, "", _arg_5, true);
                        if (_arg_2.length > 0)
                        {
                            _bitmapDataCache.addBitmapData(_local_6, _local_7);
                        };
                        return (_local_7);
                    };
                    _local_7 = getColoredBitmapData(_arg_1, _arg_2, _arg_5, true);
                    _local_7 = getFlippedBitmapData(_local_7, _arg_2, true, _arg_3, _arg_4);
                    if (_arg_2.length > 0)
                    {
                        _bitmapDataCache.addBitmapData(_local_6, _local_7);
                    };
                };
            }
            else
            {
                if (((_arg_3) || (_arg_4)))
                {
                    _local_7 = getFlippedBitmapData(_arg_1, _arg_2, true, _arg_3, _arg_4);
                }
                else
                {
                    if (_arg_5 != 0xFFFFFF)
                    {
                        _local_7 = getColoredBitmapData(_arg_1, _arg_2, _arg_5, true);
                    }
                    else
                    {
                        return (_arg_1);
                    };
                };
            };
            return (_local_7);
        }

        private function getFlippedBitmapData(_arg_1:BitmapData, _arg_2:String, _arg_3:Boolean=false, _arg_4:Boolean=true, _arg_5:Boolean=false):ExtendedBitmapData
        {
            var _local_6:String = ((_arg_2 + ((_arg_4) ? " FH" : "")) + ((_arg_5) ? " FV" : ""));
            var _local_7:ExtendedBitmapData;
            if (_arg_2.length > 0)
            {
                _local_7 = _bitmapDataCache.getBitmapData(_local_6);
                if (!_arg_3)
                {
                    return (_local_7);
                };
            };
            if (_local_7 == null)
            {
                try
                {
                    _local_7 = new ExtendedBitmapData(_arg_1.width, _arg_1.height, true, 0xFFFFFF);
                }
                catch(e:Error)
                {
                    _local_7 = new ExtendedBitmapData(1, 1, true, 0xFFFFFF);
                };
                _SafeStr_4499.identity();
                if (_arg_4)
                {
                    _SafeStr_4499.scale(-1, 1);
                    _SafeStr_4499.translate(_arg_1.width, 0);
                };
                if (_arg_5)
                {
                    _SafeStr_4499.scale(1, -1);
                    _SafeStr_4499.translate(0, _arg_1.height);
                };
                _local_7.draw(_arg_1, _SafeStr_4499);
                if (_arg_2.length > 0)
                {
                    _bitmapDataCache.addBitmapData(_local_6, _local_7);
                };
            };
            return (_local_7);
        }

        private function getColoredBitmapData(_arg_1:BitmapData, _arg_2:String, _arg_3:int, _arg_4:Boolean=false):ExtendedBitmapData
        {
            var _local_5:int;
            var _local_10:int;
            var _local_6:int;
            var _local_11:Number;
            var _local_8:Number;
            var _local_12:Number;
            var _local_7:String = ((_arg_2 + " ") + _arg_3);
            var _local_9:ExtendedBitmapData;
            if (_arg_2.length > 0)
            {
                _local_9 = _bitmapDataCache.getBitmapData(_local_7);
                if (!_arg_4)
                {
                    return (_local_9);
                };
            };
            if (_local_9 == null)
            {
                _local_5 = ((_arg_3 >> 16) & 0xFF);
                _local_10 = ((_arg_3 >> 8) & 0xFF);
                _local_6 = (_arg_3 & 0xFF);
                _local_11 = (_local_5 / 0xFF);
                _local_8 = (_local_10 / 0xFF);
                _local_12 = (_local_6 / 0xFF);
                try
                {
                    _local_9 = new ExtendedBitmapData(_arg_1.width, _arg_1.height, true, 0xFFFFFF);
                    _local_9.copyPixels(_arg_1, _arg_1.rect, ZERO_POINT);
                }
                catch(e:Error)
                {
                    _local_9 = new ExtendedBitmapData(1, 1, true, 0xFFFFFF);
                };
                _SafeStr_1107.redMultiplier = _local_11;
                _SafeStr_1107.greenMultiplier = _local_8;
                _SafeStr_1107.blueMultiplier = _local_12;
                _local_9.colorTransform(_local_9.rect, _SafeStr_1107);
                if (_arg_2.length > 0)
                {
                    _bitmapDataCache.addBitmapData(_local_7, _local_9);
                };
            };
            return (_local_9);
        }

        protected function getObjectId(_arg_1:ExtendedSprite):String
        {
            var _local_2:String;
            if (_arg_1 != null)
            {
                return (_arg_1.identifier);
            };
            return ("");
        }

        public function handleMouseEvent(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Boolean, _arg_5:Boolean, _arg_6:Boolean, _arg_7:Boolean):Boolean
        {
            _arg_1 = (_arg_1 - _screenOffsetX);
            _arg_2 = (_arg_2 - _screenOffsetY);
            _mouseLocation.x = (_arg_1 / _scale);
            _mouseLocation.y = (_arg_2 / _scale);
            if (((_SafeStr_4497 > 0) && (_arg_3 == "mouseMove")))
            {
                return (_SafeStr_4498);
            };
            _SafeStr_4498 = checkMouseHits((_arg_1 / _scale), (_arg_2 / _scale), _arg_3, _arg_4, _arg_5, _arg_6, _arg_7);
            _SafeStr_4497++;
            return (_SafeStr_4498);
        }

        protected function createMouseEvent(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:String, _arg_6:String, _arg_7:Boolean, _arg_8:Boolean, _arg_9:Boolean, _arg_10:Boolean):RoomSpriteMouseEvent
        {
            var _local_13:Number = (_arg_1 - (_SafeStr_4490 / 2));
            var _local_14:Number = (_arg_2 - (_SafeStr_4491 / 2));
            var _local_11:String = ("canvas_" + _SafeStr_698);
            var _local_12:RoomSpriteMouseEvent;
            _local_12 = new RoomSpriteMouseEvent(_arg_5, ((_local_11 + "_") + _SafeStr_4489), _local_11, _arg_6, _local_13, _local_14, _arg_3, _arg_4, _arg_8, _arg_7, _arg_9, _arg_10);
            return (_local_12);
        }

        private function checkMouseClickHits(_arg_1:Number, _arg_2:Number, _arg_3:Boolean, _arg_4:Boolean=false, _arg_5:Boolean=false, _arg_6:Boolean=false, _arg_7:Boolean=false):Boolean
        {
            var _local_10:String;
            var _local_11:Boolean;
            var _local_15:String = "";
            var _local_12:ExtendedSprite;
            var _local_14:RoomSpriteMouseEvent;
            var _local_9:String = "click";
            if (_arg_3)
            {
                _local_9 = "doubleClick";
            };
            var _local_13:Array = [];
            var _local_8:int;
            _local_8 = (activeSpriteCount - 1);
            while (_local_8 >= 0)
            {
                _local_12 = getSprite(_local_8);
                if (((!(_local_12 == null)) && (_local_12.clickHandling)))
                {
                    if (_local_12.hitTest((_arg_1 - _local_12.x), (_arg_2 - _local_12.y)))
                    {
                        _local_15 = getObjectId(_local_12);
                        if (_local_13.indexOf(_local_15) < 0)
                        {
                            _local_10 = _local_12.tag;
                            _local_14 = createMouseEvent(_arg_1, _arg_2, (_arg_1 - _local_12.x), (_arg_2 - _local_12.y), _local_9, _local_10, _arg_4, _arg_5, _arg_6, _arg_7);
                            bufferMouseEvent(_local_14, _local_15);
                            _local_13.push(_local_15);
                        };
                    };
                    _local_11 = true;
                };
                _local_8--;
            };
            processMouseEvents();
            return (_local_11);
        }

        private function checkMouseHits(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Boolean=false, _arg_5:Boolean=false, _arg_6:Boolean=false, _arg_7:Boolean=false):Boolean
        {
            var _local_12:String;
            var _local_16:String;
            var _local_11:int;
            var _local_13:Boolean;
            var _local_18:String = "";
            var _local_14:ExtendedSprite;
            var _local_17:RoomSpriteMouseEvent;
            var _local_15:Array = [];
            var _local_8:ObjectMouseData;
            var _local_10:int;
            _local_10 = (activeSpriteCount - 1);
            while (_local_10 >= 0)
            {
                _local_14 = (getSprite(_local_10) as ExtendedSprite);
                if (((!(_local_14 == null)) && (_local_14.hitTestPoint((_arg_1 - _local_14.x), (_arg_2 - _local_14.y)))))
                {
                    if (!((_local_14.clickHandling) && ((_arg_3 == "click") || (_arg_3 == "doubleClick"))))
                    {
                        _local_18 = getObjectId(_local_14);
                        if (_local_15.indexOf(_local_18) < 0)
                        {
                            _local_12 = _local_14.tag;
                            _local_8 = (_SafeStr_4485.getValue(_local_18) as ObjectMouseData);
                            if (_local_8 != null)
                            {
                                if (_local_8.spriteTag != _local_12)
                                {
                                    _local_17 = createMouseEvent(0, 0, 0, 0, "rollOut", _local_8.spriteTag, _arg_4, _arg_5, _arg_6, _arg_7);
                                    bufferMouseEvent(_local_17, _local_18);
                                };
                            };
                            if (((_arg_3 == "mouseMove") && ((_local_8 == null) || (!(_local_8.spriteTag == _local_12)))))
                            {
                                _local_17 = createMouseEvent(_arg_1, _arg_2, (_arg_1 - _local_14.x), (_arg_2 - _local_14.y), "rollOver", _local_12, _arg_4, _arg_5, _arg_6, _arg_7);
                            }
                            else
                            {
                                _local_17 = createMouseEvent(_arg_1, _arg_2, (_arg_1 - _local_14.x), (_arg_2 - _local_14.y), _arg_3, _local_12, _arg_4, _arg_5, _arg_6, _arg_7);
                                _local_17.spriteOffsetX = _local_14.offsetRefX;
                                _local_17.spriteOffsetY = _local_14.offsetRefY;
                            };
                            if (_local_8 == null)
                            {
                                _local_8 = new ObjectMouseData();
                                _local_8.objectId = _local_18;
                                _SafeStr_4485.add(_local_18, _local_8);
                            };
                            _local_8.spriteTag = _local_12;
                            if ((((!(_arg_3 == "mouseMove")) || (!(_arg_1 == _SafeStr_4495))) || (!(_arg_2 == _SafeStr_4496))))
                            {
                                bufferMouseEvent(_local_17, _local_18);
                            };
                            _local_15.push(_local_18);
                        };
                        _local_13 = true;
                    };
                };
                _local_10--;
            };
            var _local_9:Array = _SafeStr_4485.getKeys();
            _local_10 = 0;
            while (_local_10 < _local_9.length)
            {
                _local_16 = (_local_9[_local_10] as String);
                _local_11 = _local_15.indexOf(_local_16);
                if (_local_11 >= 0)
                {
                    _local_9[_local_10] = null;
                };
                _local_10++;
            };
            _local_10 = 0;
            while (_local_10 < _local_9.length)
            {
                _local_18 = (_local_9[_local_10] as String);
                if (_local_18 != null)
                {
                    _local_8 = (_SafeStr_4485.remove(_local_18) as ObjectMouseData);
                    if (_local_8 != null)
                    {
                        _local_17 = createMouseEvent(0, 0, 0, 0, "rollOut", _local_8.spriteTag, _arg_4, _arg_5, _arg_6, _arg_7);
                        bufferMouseEvent(_local_17, _local_18);
                    };
                };
                _local_10++;
            };
            processMouseEvents();
            _SafeStr_4495 = _arg_1;
            _SafeStr_4496 = _arg_2;
            return (_local_13);
        }

        protected function bufferMouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:String):void
        {
            if (((!(_eventCache == null)) && (!(_arg_1 == null))))
            {
                _eventCache.remove(_arg_2);
                _eventCache.add(_arg_2, _arg_1);
            };
        }

        protected function processMouseEvents():void
        {
            var _local_3:int;
            var _local_5:String;
            var _local_4:RoomSpriteMouseEvent;
            var _local_6:IRoomObject;
            var _local_1:IRoomObjectMouseHandler;
            if (((_container == null) || (_eventCache == null)))
            {
                return;
            };
            var _local_2:int = _eventCache.length;
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                if (_eventCache == null)
                {
                    return;
                };
                _local_5 = _eventCache.getKey(_local_3);
                _local_4 = _eventCache.getWithIndex(_local_3);
                if (((!(_local_5 == null)) && (!(_local_4 == null))))
                {
                    _local_6 = _container.getRoomObject(_local_5);
                    if (_local_6 != null)
                    {
                        if (_SafeStr_4488 != null)
                        {
                            _SafeStr_4488.processRoomCanvasMouseEvent(_local_4, _local_6, geometry);
                        }
                        else
                        {
                            _local_1 = _local_6.getMouseHandler();
                            if (_local_1 != null)
                            {
                                _local_1.mouseEvent(_local_4, _geometry);
                            };
                        };
                    };
                };
                _local_3++;
            };
            if (_eventCache)
            {
                _eventCache.reset();
            };
        }

        public function update():void
        {
            if (_SafeStr_4497 == 0)
            {
                checkMouseHits(_mouseLocation.x, _mouseLocation.y, "mouseMove");
            };
            _SafeStr_4497 = 0;
            _SafeStr_4489++;
        }

        private function clickHandler(_arg_1:MouseEvent):void
        {
            var _local_2:Boolean;
            if (((_arg_1.type == "click") || (_arg_1.type == "doubleClick")))
            {
                _local_2 = (_arg_1.type == "doubleClick");
                checkMouseClickHits(_arg_1.localX, _arg_1.localY, _local_2, _arg_1.altKey, _arg_1.ctrlKey, _arg_1.shiftKey, _arg_1.buttonDown);
            };
        }

        public function getId():int
        {
            return (_SafeStr_698);
        }


    }
}

