package com.sulake.habbo.room.utils
{
    import com.sulake.room.object.IRoomObject;
    import __AS3__.vec.Vector;
    import com.sulake.room.data.RoomObjectSpriteData;
    import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
    import com.sulake.habbo.room.RoomEngine;
    import flash.geom.Rectangle;
    import com.sulake.room.renderer.IRoomRenderingCanvas;
    import flash.geom.Point;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
    import com.sulake.habbo.room.object.visualization.room.PlaneDrawingData;
    import com.sulake.room.object.visualization.IPlaneDrawingData;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import com.sulake.core.utils.Map;
    import com.sulake.room.object.visualization.IRoomPlane;
    import com.sulake.room.object.visualization.ISortableSprite;
    import com.sulake.room.utils.IRoomGeometry;
    import flash.display.Stage;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.object.visualization.IPlaneVisualization;
    import com.sulake.core.Core;

        public class SpriteDataCollector 
    {

        private static const MANNEQUIN_MAGIC_X_OFFSET:int = 1;
        private static const MANNEQUIN_MAGIC_Y_OFFSET:int = -16;
        private static const AVATAR_WATER_EFFECT_MAGIC_Y_OFFSET:int = -52;
        private static const MAX_EXTERNAL_IMAGE_COUNT:int = 30;

        private var _SafeStr_3615:Number;
        private var spriteCount:int = 0;
        private var externalImageCount:int = 0;


        private static function addMannequinSprites(_arg_1:Vector.<RoomObjectSpriteData>, _arg_2:RoomEngine):Vector.<RoomObjectSpriteData>
        {
            var _local_7:IRoomObject;
            var _local_6:Array;
            var _local_3:Vector.<RoomObjectSpriteData> = new Vector.<RoomObjectSpriteData>();
            for each (var _local_5:RoomObjectSpriteData in _arg_1)
            {
                if (((_local_5.objectType == "boutique_mannequin1") && (_local_5.name.indexOf("mannequin_") == 0)))
                {
                    _local_7 = _arg_2.getRoomObject(_arg_2.activeRoomId, _local_5.objectId, 10);
                    if (_local_7 != null)
                    {
                        _local_6 = IRoomObjectSpriteVisualization(_local_7.getVisualization()).getSpriteList();
                        if (_local_6 != null)
                        {
                            for each (var _local_4:RoomObjectSpriteData in _local_6)
                            {
                                _local_4.x = (_local_4.x + ((_local_5.x + (_local_5.width / 2)) + 1));
                                _local_4.y = (_local_4.y + ((_local_5.y + _local_5.height) + -16));
                                _local_4.z = (_local_4.z + _local_5.z);
                                _local_3.push(_local_4);
                            };
                        };
                    };
                }
                else
                {
                    _local_3.push(_local_5);
                };
            };
            return (_local_3);
        }

        private static function sortSpriteDataObjects(_arg_1:RoomObjectSpriteData, _arg_2:RoomObjectSpriteData):Number
        {
            if (_arg_1.z < _arg_2.z)
            {
                return (1);
            };
            if (_arg_1.z > _arg_2.z)
            {
                return (-1);
            };
            return (-1);
        }

        private static function isSpriteInViewPort(_arg_1:RoomObjectSpriteData, _arg_2:Rectangle, _arg_3:IRoomRenderingCanvas):Boolean
        {
            var _local_4:Rectangle = new Rectangle((_arg_1.x + _arg_3.screenOffsetX), (_arg_1.y + _arg_3.screenOffsetY), _arg_1.width, _arg_1.height);
            return (_local_4.intersects(_arg_2));
        }

        private static function sortQuadPoints(_arg_1:Point, _arg_2:Point, _arg_3:Point, _arg_4:Point):Vector.<Point>
        {
            var _local_5:Point;
            var _local_6:Vector.<Point> = new Vector.<Point>(0);
            if (_arg_1.x == _arg_2.x)
            {
                _local_6.push(_arg_1, _arg_3, _arg_2, _arg_4);
            }
            else
            {
                if (_arg_1.x == _arg_3.x)
                {
                    _local_6.push(_arg_1, _arg_2, _arg_3, _arg_4);
                }
                else
                {
                    if ((((_arg_2.x < _arg_1.x) && (_arg_2.y > _arg_1.y)) || ((_arg_2.x > _arg_1.x) && (_arg_2.y < _arg_1.y))))
                    {
                        _local_6.push(_arg_1, _arg_3, _arg_2, _arg_4);
                    }
                    else
                    {
                        _local_6.push(_arg_1, _arg_2, _arg_3, _arg_4);
                    };
                };
            };
            if (_local_6[0].x < _local_6[1].x)
            {
                _local_5 = _local_6[0];
                _local_6[0] = _local_6[1];
                _local_6[1] = _local_5;
                _local_5 = _local_6[2];
                _local_6[2] = _local_6[3];
                _local_6[3] = _local_5;
            };
            if (_local_6[0].y < _local_6[2].y)
            {
                _local_5 = _local_6[0];
                _local_6[0] = _local_6[2];
                _local_6[2] = _local_5;
                _local_5 = _local_6[1];
                _local_6[1] = _local_6[3];
                _local_6[3] = _local_5;
            };
            return (_local_6);
        }


        public function getFurniData(_arg_1:Rectangle, _arg_2:IRoomRenderingCanvas, _arg_3:RoomEngine, _arg_4:int):String
        {
            var _local_12:Array;
            var _local_7:Number;
            var _local_16:int;
            var _local_13:Point;
            var _local_8:Vector.<Object> = new Vector.<Object>();
            var _local_6:Vector.<RoomObjectSpriteData> = _arg_2.getSortableSpriteList();
            var _local_11:Array = _arg_3.getRoomObjects(_arg_3.activeRoomId, 100);
            for each (var _local_10:IRoomObject in _local_11)
            {
                if (_local_10.getId() != _arg_4)
                {
                    _local_12 = IRoomObjectSpriteVisualization(_local_10.getVisualization()).getSpriteList();
                    if (_local_12)
                    {
                        _local_7 = 0;
                        _local_16 = 0;
                        for each (var _local_14:RoomObjectSpriteData in _local_6)
                        {
                            if (_local_14.name == ("avatar_" + _local_10.getId()))
                            {
                                _local_7 = _local_14.z;
                                _local_16 = int(((_local_14.y + _local_14.height) - (_arg_2.geometry.scale / 4)));
                                break;
                            };
                        };
                        _local_13 = _arg_3.getRoomObjectScreenLocation(_arg_3.activeRoomId, _local_10.getId(), 100, _arg_2.getId());
                        if (_local_13)
                        {
                            if (_local_16 == 0)
                            {
                                _local_16 = _local_13.y;
                            };
                            for each (var _local_15:RoomObjectSpriteData in _local_12)
                            {
                                _local_15.x = (_local_15.x + (_local_13.x - _arg_2.screenOffsetX));
                                _local_15.y = (_local_15.y + _local_16);
                                _local_15.z = (_local_15.z + _local_7);
                                if (((_local_15.name.indexOf("h_std_fx29_") == 0) || (_local_15.name.indexOf("h_std_fx185_") == 0)))
                                {
                                    _local_15.y = (_local_15.y + -52);
                                };
                                _local_6.push(_local_15);
                            };
                        };
                    };
                };
            };
            _local_6 = addMannequinSprites(_local_6, _arg_3);
            _local_6.sort(sortSpriteDataObjects);
            for each (var _local_5:RoomObjectSpriteData in _local_6)
            {
                if ((((((!(_local_5.name == null)) && (_local_5.name.length > 0)) && (!(_local_5.name.indexOf("tile_cursor_") == 0))) && (isSpriteInViewPort(_local_5, _arg_1, _arg_2))) && ((_arg_4 < 0) || (!(_local_5.objectId == _arg_4)))))
                {
                    _local_8.push(getSpriteDataObject(_local_5, _arg_1, _arg_2, _arg_3));
                    if (!_SafeStr_3615)
                    {
                        _SafeStr_3615 = _local_5.z;
                    };
                    spriteCount++;
                };
            };
            var _local_9:String = JSON.stringify(_local_8);
            return (_local_9);
        }

        public function getRoomRenderingModifiers(_arg_1:RoomEngine):String
        {
            var _local_2:Object = {};
            return (JSON.stringify(_local_2));
        }

        private function getSpriteDataObject(_arg_1:RoomObjectSpriteData, _arg_2:Rectangle, _arg_3:IRoomRenderingCanvas, _arg_4:RoomEngine):Object
        {
            var _local_10:String;
            var _local_13:Array;
            var _local_6:IGraphicAssetCollection;
            var _local_11:XML;
            var _local_9:String;
            var _local_8:String;
            var _local_5:Object = {};
            var _local_12:String = _arg_1.name;
            if (_arg_1.name.indexOf("@") != -1)
            {
                _local_13 = _arg_1.name.split("@");
                _local_12 = _local_13[0];
                _local_10 = _local_13[1];
            };
            if (((_local_10) && (_arg_1.objectType)))
            {
                _local_6 = _arg_4.roomContentLoader.getGraphicAssetCollection(_arg_1.objectType);
                if (_local_6 != null)
                {
                    _local_11 = _local_6.getPaletteXML(_local_10);
                    if (((!(_local_11 == null)) && (!(_local_11.@source == null))))
                    {
                        _local_5.paletteSourceName = (_local_11.@source + "");
                    };
                };
            };
            var _local_7:String = _arg_4.configuration.getProperty("image.library.url");
            _local_12 = _local_12.replace("%image.library.url%", _local_7);
            if (_local_12.indexOf("%group.badge.url%") != -1)
            {
                _local_9 = _arg_4.configuration.getProperty("group.badge.url");
                _local_12 = _local_12.replace("%group.badge.url%", "");
                _local_8 = _local_9.replace("%imagerdata%", _local_12);
                _local_12 = _local_8;
            };
            _local_5.name = _local_12;
            _local_5.x = (_arg_1.x - _arg_2.x);
            _local_5.y = (_arg_1.y - _arg_2.y);
            _local_5.x = (_local_5.x + _arg_3.screenOffsetX);
            _local_5.y = (_local_5.y + _arg_3.screenOffsetY);
            _local_5.z = _arg_1.z;
            if (((_arg_1.alpha) && (!(_arg_1.alpha.toString() == "255"))))
            {
                _local_5.alpha = _arg_1.alpha;
            };
            if (_arg_1.flipH)
            {
                _local_5.flipH = _arg_1.flipH;
            };
            if (_arg_1.skew)
            {
                _local_5.skew = _arg_1.skew;
            };
            if (_arg_1.frame)
            {
                _local_5.frame = _arg_1.frame;
            };
            if (((_arg_1.color) && (_arg_1.color.length > 0)))
            {
                _local_5.color = _arg_1.color;
            };
            if (((_arg_1.blendMode) && (!(_arg_1.blendMode == "normal"))))
            {
                _local_5.blendMode = _arg_1.blendMode;
            };
            if (_local_12.indexOf("http") == 0)
            {
                _local_5.width = _arg_1.width;
                _local_5.height = _arg_1.height;
                externalImageCount++;
                if (externalImageCount > 30)
                {
                    _local_5.name = "box";
                };
            };
            if (_arg_1.posture)
            {
                _local_5.posture = _arg_1.posture;
            };
            return (_local_5);
        }

        private function makeBackgroundPlane(_arg_1:Rectangle, _arg_2:uint, _arg_3:Array):IPlaneDrawingData
        {
            var _local_4:Number;
            var _local_6:Point = new Point(0, 0);
            var _local_7:Point = new Point(_arg_1.width, 0);
            var _local_8:Point = new Point(0, _arg_1.height);
            var _local_10:Point = new Point(_arg_1.width, _arg_1.height);
            var _local_9:Vector.<Point> = sortQuadPoints(_local_6, _local_7, _local_8, _local_10);
            if (_arg_3.length > 0)
            {
                _local_4 = _arg_3[0].z;
                if (_SafeStr_3615)
                {
                    _local_4 = Math.max(_SafeStr_3615, _local_4);
                };
            }
            else
            {
                _local_4 = ((_SafeStr_3615) ? _SafeStr_3615 : 0);
            };
            _local_4 = (_local_4 + ((spriteCount * 1.776104) + (_arg_3.length * 2.31743)));
            var _local_5:IPlaneDrawingData = new PlaneDrawingData(null, _arg_2);
            _local_5.cornerPoints = _local_9;
            _local_5.z = _local_4;
            return (_local_5);
        }

        private function sortRoomPlanes(_arg_1:Vector.<IRoomPlane>, _arg_2:IRoomRenderingCanvas, _arg_3:RoomEngine):Array
        {
            var _local_6:Object;
            var _local_7:IRoomObjectSprite;
            var _local_9:Map = new Map();
            var _local_10:Number = 1;
            if (_SafeStr_3615)
            {
                _local_10 = (_local_10 + _SafeStr_3615);
            };
            for each (var _local_4:IRoomPlane in _arg_1)
            {
                _local_6 = {};
                _local_6.plane = _local_4;
                _local_6.z = _local_10;
                _local_9.add(_local_4.uniqueId, _local_6);
            };
            var _local_11:Array = _arg_2.getPlaneSortableSprites();
            _local_11.sortOn("z", 16);
            _local_11.reverse();
            var _local_5:Array = [];
            for each (var _local_8:ISortableSprite in _local_11)
            {
                _local_7 = _local_8.sprite;
                if (_local_7 != null)
                {
                    _local_6 = _local_9.remove(_local_7.planeId);
                    if (_local_6 != null)
                    {
                        _local_6.z = _local_8.z;
                        _local_5.push(_local_6);
                    };
                };
            };
            _local_5 = _local_5.concat(_local_9.getValues());
            return (_local_5);
        }

        public function getRoomPlanes(_arg_1:Rectangle, _arg_2:IRoomRenderingCanvas, _arg_3:RoomEngine, _arg_4:uint):Array
        {
            var _local_20:IRoomGeometry;
            var _local_12:Array;
            var _local_17:Stage;
            var _local_5:IRoomPlane;
            var _local_15:Vector.<Point> = undefined;
            var _local_14:Vector3d;
            var _local_6:Point;
            var _local_8:Point;
            var _local_9:Point;
            var _local_11:Point;
            var _local_22:int;
            var _local_23:int;
            var _local_19:Vector.<Point> = undefined;
            var _local_10:Array = [];
            var _local_18:IRoomObject = _arg_3.getRoomObject(_arg_3.activeRoomId, -1, 0);
            var _local_7:IPlaneVisualization = (_local_18.getVisualization() as IPlaneVisualization);
            if (_local_7)
            {
                _local_20 = _arg_2.geometry;
                _local_12 = sortRoomPlanes(_local_7.planes, _arg_2, _arg_3);
                _local_17 = Core.instance.displayObjectContainer.stage;
                for each (var _local_16:Object in _local_12)
                {
                    _local_5 = _local_16.plane;
                    _local_15 = new Vector.<Point>(0);
                    _local_14 = Vector3d.sum(_local_5.location, _local_5.leftSide);
                    _local_6 = _local_20.getScreenPoint(_local_5.location);
                    _local_8 = _local_20.getScreenPoint(_local_14);
                    _local_9 = _local_20.getScreenPoint(Vector3d.sum(_local_5.location, _local_5.rightSide));
                    _local_11 = _local_20.getScreenPoint(Vector3d.sum(_local_14, _local_5.rightSide));
                    _local_15.push(_local_6, _local_8, _local_9, _local_11);
                    _local_22 = 0;
                    _local_23 = 0;
                    for each (var _local_13:Point in _local_15)
                    {
                        _local_13.offset((_local_17.stageWidth / 2), (_local_17.stageHeight / 2));
                        _local_13.offset(_arg_2.screenOffsetX, _arg_2.screenOffsetY);
                        _local_13.offset(-(_arg_1.x), -(_arg_1.y));
                        if (_local_13.x < 0)
                        {
                            _local_22--;
                        }
                        else
                        {
                            if (_local_13.x >= _arg_1.width)
                            {
                                _local_22++;
                            };
                        };
                        if (_local_13.y < 0)
                        {
                            _local_23--;
                        }
                        else
                        {
                            if (_local_13.y >= _arg_1.height)
                            {
                                _local_23++;
                            };
                        };
                    };
                    if (!((Math.abs(_local_22) == 4) || (Math.abs(_local_23) == 4)))
                    {
                        _local_19 = sortQuadPoints(_local_6, _local_8, _local_9, _local_11);
                        for each (var _local_21:IPlaneDrawingData in _local_5.getDrawingDatas(_local_20))
                        {
                            _local_21.cornerPoints = _local_19;
                            _local_21.z = _local_16.z;
                            _local_10.push(_local_21);
                        };
                    };
                };
                _local_10.unshift(makeBackgroundPlane(_arg_1, _arg_4, _local_10));
            };
            return (_local_10);
        }


    }
}

