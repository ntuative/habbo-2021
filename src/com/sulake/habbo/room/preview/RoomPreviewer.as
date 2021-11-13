package com.sulake.habbo.room.preview
{
    import com.sulake.habbo.room.IRoomEngine;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import com.sulake.room.utils.RoomId;
    import com.sulake.habbo.room.object.RoomPlaneParser;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.room.object.data.LegacyStuffData;
    import com.sulake.room.utils.Vector3d;
    import flash.utils.getTimer;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.room.IStuffData;
    import flash.display.DisplayObject;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.room.events.RoomEngineEvent;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.room._SafeStr_147;
    import com.sulake.room.object.visualization.IRoomObjectVisualization;
    import flash.display.BitmapData;

    public class RoomPreviewer 
    {

        private static const PREVIEW_CANVAS_ID:int = 1;
        private static const PREVIEW_OBJECT_ID:int = 1;
        private static const PREVIEW_OBJECT_LOCATION_X:int = 2;
        private static const PREVIEW_OBJECT_LOCATION_Y:int = 2;
        private static const ALLOWED_IMAGE_CUT:Number = 0.25;
        public static const SCALE_NORMAL:int = 64;
        public static const SCALE_SMALL:int = 32;
        private static const AUTOMATIC_STATE_CHANGE_INTERVAL:int = 2500;

        private var _roomEngine:IRoomEngine;
        private var _previewRoomId:int = 1;
        private var _SafeStr_3599:int = 0;
        private var _SafeStr_3600:int = 0;
        private var _SafeStr_3601:String = "";
        private var _currentPreviewRectangle:Rectangle = null;
        private var _currentPreviewCanvasWidth:int = 0;
        private var _SafeStr_3602:int = 0;
        private var _SafeStr_3603:int = 64;
        private var _SafeStr_3604:Boolean;
        private var _SafeStr_3605:Boolean;
        private var _previousAutomaticStateChangeTime:int;
        private var _addViewOffset:Point = new Point(0, 0);
        private var _disableUpdate:Boolean = false;

        public function RoomPreviewer(_arg_1:IRoomEngine, _arg_2:int=1)
        {
            _roomEngine = _arg_1;
            _previewRoomId = RoomId.makeRoomPreviewerId(_arg_2);
            if (_roomEngine)
            {
                _roomEngine.events.addEventListener("REOE_ADDED", onRoomObjectAdded);
                _roomEngine.events.addEventListener("REOE_CONTENT_UPDATED", onRoomObjectAdded);
                _roomEngine.events.addEventListener("REE_INITIALIZED", onRoomInitialized);
            };
        }

        public function dispose():void
        {
            reset(true);
            if (((_roomEngine) && (!(_roomEngine.events == null))))
            {
                _roomEngine.events.removeEventListener("REOE_ADDED", onRoomObjectAdded);
                _roomEngine.events.removeEventListener("REOE_CONTENT_UPDATED", onRoomObjectAdded);
                _roomEngine.events.removeEventListener("REE_INITIALIZED", onRoomInitialized);
            };
        }

        public function createRoomForPreviews():void
        {
            var _local_1:int;
            var _local_2:RoomPlaneParser;
            var _local_4:int;
            var _local_3:int;
            if (_roomEngine)
            {
                _local_1 = 7;
                _local_2 = new RoomPlaneParser();
                _local_2.initializeTileMap((_local_1 + 2), (_local_1 + 2));
                _local_4 = 1;
                while (_local_4 < (1 + _local_1))
                {
                    _local_3 = 1;
                    while (_local_3 < (1 + _local_1))
                    {
                        _local_2.setTileHeight(_local_3, _local_4, 0);
                        _local_3++;
                    };
                    _local_4++;
                };
                _local_2.initializeFromTileData();
                _roomEngine.initializeRoom(_previewRoomId, _local_2.getXML());
                _local_2.dispose();
            };
        }

        public function reset(_arg_1:Boolean):void
        {
            if (_roomEngine)
            {
                _roomEngine.disposeObjectFurniture(_previewRoomId, 1);
                _roomEngine.disposeObjectWallItem(_previewRoomId, 1);
                _roomEngine.disposeObjectUser(_previewRoomId, 1);
                if (!_arg_1)
                {
                    updatePreviewRoomView();
                };
            };
            _SafeStr_3600 = -2;
        }

        public function addFurnitureIntoRoom(_arg_1:int, _arg_2:IVector3d, _arg_3:IStuffData=null, _arg_4:String=null):int
        {
            var _local_6:IRoomObject;
            var _local_5:int = -1;
            if (_arg_3 == null)
            {
                _arg_3 = new LegacyStuffData();
            };
            if (isRoomEngineReady)
            {
                if (((_SafeStr_3600 == 10) && (_SafeStr_3599 == _arg_1)))
                {
                    return (1);
                };
                reset(false);
                _SafeStr_3599 = _arg_1;
                _SafeStr_3600 = 10;
                _SafeStr_3601 = "";
                if (_roomEngine.addObjectFurniture(_previewRoomId, 1, _arg_1, new Vector3d(2, 2, 0), _arg_2, 0, _arg_3, NaN, -1, 0, 0, "", true, false))
                {
                    _previousAutomaticStateChangeTime = getTimer();
                    _SafeStr_3605 = true;
                    _local_5 = 1;
                    _local_6 = _roomEngine.getRoomObject(_previewRoomId, 1, _SafeStr_3600);
                    if (_local_6)
                    {
                        if (_arg_4 != null)
                        {
                            (_local_6.getModel() as IRoomObjectModelController).setString("furniture_extras", _arg_4);
                        };
                    };
                    updatePreviewRoomView();
                };
            };
            return (_local_5);
        }

        public function addWallItemIntoRoom(_arg_1:int, _arg_2:IVector3d, _arg_3:String):int
        {
            var _local_4:int = -1;
            if (isRoomEngineReady)
            {
                if ((((_SafeStr_3600 == 20) && (_SafeStr_3599 == _arg_1)) && (_SafeStr_3601 == _arg_3)))
                {
                    return (1);
                };
                reset(false);
                _SafeStr_3599 = _arg_1;
                _SafeStr_3600 = 20;
                _SafeStr_3601 = _arg_3;
                if (_roomEngine.addObjectWallItem(_previewRoomId, 1, _arg_1, new Vector3d(0.5, 2.3, 1.8), _arg_2, 0, _arg_3, 0, 0, "", -1, false))
                {
                    _previousAutomaticStateChangeTime = getTimer();
                    _SafeStr_3605 = true;
                    return (1);
                };
            };
            return (_local_4);
        }

        public function addAvatarIntoRoom(_arg_1:String, _arg_2:int):int
        {
            if (isRoomEngineReady)
            {
                reset(false);
                _SafeStr_3599 = 1;
                _SafeStr_3600 = 100;
                _SafeStr_3601 = _arg_1;
                if (_roomEngine.addObjectUser(_previewRoomId, 1, new Vector3d(2, 2, 0), new Vector3d(90, 0, 0), 135, 1, _arg_1))
                {
                    _previousAutomaticStateChangeTime = getTimer();
                    _SafeStr_3605 = true;
                    updateUserGesture(1);
                    updateUserEffect(_arg_2);
                    updateUserPosture("std");
                };
                updatePreviewRoomView();
                return (1);
            };
            return (-1);
        }

        public function updateUserPosture(_arg_1:String, _arg_2:String=""):void
        {
            if (isRoomEngineReady)
            {
                _roomEngine.updateObjectUserPosture(_previewRoomId, 1, _arg_1, _arg_2);
            };
        }

        public function updateUserGesture(_arg_1:int):void
        {
            if (isRoomEngineReady)
            {
                _roomEngine.updateObjectUserGesture(_previewRoomId, 1, _arg_1);
            };
        }

        public function updateUserEffect(_arg_1:int):void
        {
            if (isRoomEngineReady)
            {
                _roomEngine.updateObjectUserEffect(_previewRoomId, 1, _arg_1);
            };
        }

        public function updateObjectUserFigure(_arg_1:String, _arg_2:String=null, _arg_3:String=null, _arg_4:Boolean=false):Boolean
        {
            if (isRoomEngineReady)
            {
                return (_roomEngine.updateObjectUserFigure(_previewRoomId, 1, _arg_1, _arg_2, _arg_3, _arg_4));
            };
            return (false);
        }

        public function updateObjectUserAction(_arg_1:String, _arg_2:int, _arg_3:String=null):void
        {
            if (isRoomEngineReady)
            {
                _roomEngine.updateObjectUserAction(_previewRoomId, 1, _arg_1, _arg_2, _arg_3);
            };
        }

        public function changeRoomObjectState():void
        {
            if (isRoomEngineReady)
            {
                _SafeStr_3605 = false;
                if (_SafeStr_3600 != 100)
                {
                    _roomEngine.changeObjectState(_previewRoomId, 1, _SafeStr_3600);
                };
            };
        }

        private function checkAutomaticRoomObjectStateChange():void
        {
            var _local_1:int;
            if (_SafeStr_3605)
            {
                _local_1 = getTimer();
                if (_local_1 > (_previousAutomaticStateChangeTime + 2500))
                {
                    _previousAutomaticStateChangeTime = _local_1;
                    if (isRoomEngineReady)
                    {
                        _roomEngine.changeObjectState(_previewRoomId, 1, _SafeStr_3600);
                    };
                };
            };
        }

        public function getRoomCanvas(_arg_1:int, _arg_2:int):DisplayObject
        {
            var _local_3:DisplayObject;
            var _local_4:IRoomGeometry;
            if (_roomEngine)
            {
                _local_3 = _roomEngine.createRoomCanvas(_previewRoomId, 1, _arg_1, _arg_2, _SafeStr_3603);
                _roomEngine.setRoomCanvasMask(_previewRoomId, 1, true);
                _local_4 = _roomEngine.getRoomCanvasGeometry(_previewRoomId, 1);
                if (_local_4 != null)
                {
                    _local_4.adjustLocation(new Vector3d(2, 2, 0), 30);
                };
                _currentPreviewCanvasWidth = _arg_1;
                _SafeStr_3602 = _arg_2;
                return (_local_3);
            };
            return (null);
        }

        public function modifyRoomCanvas(_arg_1:int, _arg_2:int):void
        {
            if (_roomEngine)
            {
                _currentPreviewCanvasWidth = _arg_1;
                _SafeStr_3602 = _arg_2;
                _roomEngine.modifyRoomCanvas(_previewRoomId, 1, _arg_1, _arg_2);
            };
        }

        public function set addViewOffset(_arg_1:Point):void
        {
            _addViewOffset = _arg_1;
        }

        public function get addViewOffset():Point
        {
            return (_addViewOffset);
        }

        private function updatePreviewObjectBoundingRectangle(_arg_1:Point):void
        {
            var _local_2:Rectangle;
            var _local_3:Rectangle = _roomEngine.getRoomObjectBoundingRectangle(_previewRoomId, 1, _SafeStr_3600, 1);
            if (((!(_local_3 == null)) && (!(_arg_1 == null))))
            {
                _local_3.offset(-(_currentPreviewCanvasWidth >> 1), -(_SafeStr_3602 >> 1));
                _local_3.offset(-(_arg_1.x), -(_arg_1.y));
                if (_currentPreviewRectangle == null)
                {
                    _currentPreviewRectangle = _local_3;
                }
                else
                {
                    _local_2 = _currentPreviewRectangle.union(_local_3);
                    if ((((((_local_2.width - _currentPreviewRectangle.width) > ((_currentPreviewCanvasWidth - _currentPreviewRectangle.width) >> 1)) || ((_local_2.height - _currentPreviewRectangle.height) > ((_SafeStr_3602 - _currentPreviewRectangle.height) >> 1))) || (_currentPreviewRectangle.width < 1)) || (_currentPreviewRectangle.height < 1)))
                    {
                        _currentPreviewRectangle = _local_2;
                    };
                };
            };
        }

        private function validatePreviewSize(_arg_1:Point):Point
        {
            var _local_2:IRoomGeometry;
            if (((_currentPreviewRectangle.width < 1) || (_currentPreviewRectangle.height < 1)))
            {
                return (_arg_1);
            };
            if (isRoomEngineReady)
            {
                _local_2 = _roomEngine.getRoomCanvasGeometry(_previewRoomId, 1);
                if (((_currentPreviewRectangle.width > (_currentPreviewCanvasWidth * (1 + 0.25))) || (_currentPreviewRectangle.height > (_SafeStr_3602 * (1 + 0.25)))))
                {
                    if ((_roomEngine as Component).getBoolean("zoom.enabled"))
                    {
                        if (_roomEngine.getRoomCanvasScale(_previewRoomId, 1) != 0.5)
                        {
                            _roomEngine.setRoomCanvasScale(_previewRoomId, 1, 0.5, null, null, false, false, true);
                            _SafeStr_3603 = 32;
                            _SafeStr_3604 = true;
                            _arg_1.x = (_arg_1.x >> 1);
                            _arg_1.y = (_arg_1.y >> 1);
                            _currentPreviewRectangle.left = (_currentPreviewRectangle.left >> 2);
                            _currentPreviewRectangle.right = (_currentPreviewRectangle.right >> 2);
                            _currentPreviewRectangle.top = (_currentPreviewRectangle.top >> 2);
                            _currentPreviewRectangle.bottom = (_currentPreviewRectangle.bottom >> 2);
                        };
                    }
                    else
                    {
                        if (_local_2.isZoomedIn())
                        {
                            _local_2.performZoomOut();
                            _SafeStr_3603 = 32;
                            _SafeStr_3604 = true;
                            _arg_1.x = (_arg_1.x >> 1);
                            _arg_1.y = (_arg_1.y >> 1);
                            _currentPreviewRectangle.left = (_currentPreviewRectangle.left >> 2);
                            _currentPreviewRectangle.right = (_currentPreviewRectangle.right >> 2);
                            _currentPreviewRectangle.top = (_currentPreviewRectangle.top >> 2);
                            _currentPreviewRectangle.bottom = (_currentPreviewRectangle.bottom >> 2);
                        };
                    };
                }
                else
                {
                    if ((((_currentPreviewRectangle.width << 1) < ((_currentPreviewCanvasWidth * (1 + 0.25)) - 5)) && ((_currentPreviewRectangle.height << 1) < ((_SafeStr_3602 * (1 + 0.25)) - 5))))
                    {
                        if ((_roomEngine as Component).getBoolean("zoom.enabled"))
                        {
                            if (((!(_roomEngine.getRoomCanvasScale(_previewRoomId, 1) == 1)) && (!(_SafeStr_3604))))
                            {
                                _roomEngine.setRoomCanvasScale(_previewRoomId, 1, 1, null, null, false, false, true);
                                _SafeStr_3603 = 64;
                                _arg_1.x = (_arg_1.x << 1);
                                _arg_1.y = (_arg_1.y << 1);
                            };
                        }
                        else
                        {
                            if (((!(_local_2.isZoomedIn())) && (!(_SafeStr_3604))))
                            {
                                _local_2.performZoomIn();
                                _SafeStr_3603 = 64;
                                _arg_1.x = (_arg_1.x << 1);
                                _arg_1.y = (_arg_1.y << 1);
                            };
                        };
                    };
                };
            };
            return (_arg_1);
        }

        public function zoomIn():void
        {
            var _local_1:IRoomGeometry;
            if (isRoomEngineReady)
            {
                if ((_roomEngine as Component).getBoolean("zoom.enabled"))
                {
                    _roomEngine.setRoomCanvasScale(_previewRoomId, 1, 1);
                };
                _local_1 = _roomEngine.getRoomCanvasGeometry(_previewRoomId, 1);
                if (!_local_1)
                {
                    return;
                };
                _local_1.performZoomIn();
            };
            _SafeStr_3603 = 64;
        }

        public function zoomOut():void
        {
            var _local_1:IRoomGeometry;
            if (isRoomEngineReady)
            {
                if ((_roomEngine as Component).getBoolean("zoom.enabled"))
                {
                    _roomEngine.setRoomCanvasScale(_previewRoomId, 1, 0.5);
                }
                else
                {
                    _local_1 = _roomEngine.getRoomCanvasGeometry(_previewRoomId, 1);
                    if (!_local_1)
                    {
                        return;
                    };
                    _local_1.performZoomOut();
                };
            };
            _SafeStr_3603 = 32;
        }

        public function updateAvatarDirection(_arg_1:int, _arg_2:int):void
        {
            if (isRoomEngineReady)
            {
                _roomEngine.updateObjectUser(_previewRoomId, 1, new Vector3d(2, 2, 0), new Vector3d(2, 2, 0), false, 0, new Vector3d((_arg_1 * 45), 0, 0), (_arg_2 * 45));
            };
        }

        public function updateObjectRoom(_arg_1:String=null, _arg_2:String=null, _arg_3:String=null, _arg_4:Boolean=false):Boolean
        {
            if (isRoomEngineReady)
            {
                return (_roomEngine.updateObjectRoom(_previewRoomId, _arg_1, _arg_2, _arg_3, false));
            };
            return (false);
        }

        public function updateRoomWallsAndFloorVisibility(_arg_1:Boolean, _arg_2:Boolean=true):void
        {
            if (isRoomEngineReady)
            {
                _roomEngine.updateObjectRoomVisibilities(_previewRoomId, _arg_1, _arg_2);
            };
        }

        private function getCanvasOffset(_arg_1:Point):Point
        {
            var _local_7:Number;
            if (((_currentPreviewRectangle.width < 1) || (_currentPreviewRectangle.height < 1)))
            {
                return (_arg_1);
            };
            var _local_4:Number = (-(_currentPreviewRectangle.left + _currentPreviewRectangle.right) >> 1);
            var _local_2:Number = (-(_currentPreviewRectangle.top + _currentPreviewRectangle.bottom) >> 1);
            var _local_3:Number = ((_SafeStr_3602 - _currentPreviewRectangle.height) >> 1);
            if (_local_3 > 10)
            {
                _local_2 = (_local_2 + Math.min(15, (_local_3 - 10)));
            }
            else
            {
                if (_SafeStr_3600 != 100)
                {
                    _local_2 = int((_local_2 + (5 - Math.max(0, (_local_3 / 2)))));
                }
                else
                {
                    _local_2 = int((_local_2 - (5 - Math.min(0, (_local_3 / 2)))));
                };
            };
            _local_2 = (_local_2 + _addViewOffset.y);
            _local_4 = (_local_4 + _addViewOffset.x);
            var _local_5:int = (_local_4 - _arg_1.x);
            var _local_6:int = (_local_2 - _arg_1.y);
            if (((!(_local_5 == 0)) || (!(_local_6 == 0))))
            {
                _local_7 = Math.sqrt(((_local_5 * _local_5) + (_local_6 * _local_6)));
                if (_local_7 > 10)
                {
                    _local_4 = int((_arg_1.x + ((_local_5 * 10) / _local_7)));
                    _local_2 = int((_arg_1.y + ((_local_6 * 10) / _local_7)));
                };
                return (new Point(_local_4, _local_2));
            };
            return (null);
        }

        public function updatePreviewRoomView(_arg_1:Boolean=false):void
        {
            var _local_3:Point;
            var _local_4:int;
            var _local_2:Point;
            if (((_disableUpdate) && (!(_arg_1))))
            {
                return;
            };
            checkAutomaticRoomObjectStateChange();
            if (isRoomEngineReady)
            {
                _local_3 = _roomEngine.getRoomCanvasScreenOffset(_previewRoomId, 1);
                if (_local_3 != null)
                {
                    updatePreviewObjectBoundingRectangle(_local_3);
                    if (_currentPreviewRectangle != null)
                    {
                        _local_4 = _SafeStr_3603;
                        _local_3 = validatePreviewSize(_local_3);
                        _local_2 = getCanvasOffset(_local_3);
                        if (_local_2 != null)
                        {
                            _roomEngine.setRoomCanvasScreenOffset(_previewRoomId, 1, _local_2);
                        };
                        if (_SafeStr_3603 != _local_4)
                        {
                            _currentPreviewRectangle = null;
                        };
                    };
                };
            };
        }

        public function set disableUpdate(_arg_1:Boolean):void
        {
            _disableUpdate = _arg_1;
        }

        public function set disableRoomEngineUpdate(_arg_1:Boolean):void
        {
            if (isRoomEngineReady)
            {
                _roomEngine.disableUpdate = _arg_1;
            };
        }

        public function get previewRoomId():int
        {
            return (_previewRoomId);
        }

        private function onRoomInitialized(_arg_1:RoomEngineEvent):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            switch (_arg_1.type)
            {
                case "REE_INITIALIZED":
                    if (_arg_1.roomId == _previewRoomId)
                    {
                        if (_roomEngine)
                        {
                            _roomEngine.updateObjectRoom(_previewRoomId, "110", "99999");
                        };
                    };
                    return;
            };
        }

        private function onRoomObjectAdded(_arg_1:RoomEngineObjectEvent):void
        {
            var _local_3:IRoomObject;
            var _local_4:Number;
            var _local_2:Number;
            if ((((_arg_1.roomId == _previewRoomId) && (_arg_1.objectId == 1)) && (_arg_1.category == _SafeStr_3600)))
            {
                _currentPreviewRectangle = null;
                _SafeStr_3604 = false;
                _local_3 = _roomEngine.getRoomObject(_arg_1.roomId, _arg_1.objectId, _arg_1.category);
                if ((((!(_local_3 == null)) && (!(_local_3.getModel() == null))) && (_arg_1.category == 20)))
                {
                    _local_4 = _local_3.getModel().getNumber("furniture_size_z");
                    _local_2 = _local_3.getModel().getNumber("furniture_center_z");
                    if (((!(isNaN(_local_4))) && (!(isNaN(_local_2)))))
                    {
                        _roomEngine.updateObjectWallItemLocation(_arg_1.roomId, _arg_1.objectId, new Vector3d(0.5, 2.3, (((3.6 - _local_4) / 2) + _local_2)));
                    };
                };
            };
        }

        public function updateRoomEngine():void
        {
            if (isRoomEngineReady)
            {
                _roomEngine.runUpdate();
            };
        }

        public function getGenericRoomObjectImage(_arg_1:String, _arg_2:String, _arg_3:IVector3d, _arg_4:int, _arg_5:IGetImageListener, _arg_6:uint=0, _arg_7:String=null, _arg_8:IStuffData=null, _arg_9:int=-1, _arg_10:int=-1, _arg_11:String=null):_SafeStr_147
        {
            if (isRoomEngineReady)
            {
                return (_roomEngine.getGenericRoomObjectImage(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11));
            };
            return (null);
        }

        public function getRoomObjectImage(_arg_1:int, _arg_2:IVector3d, _arg_3:int, _arg_4:IGetImageListener, _arg_5:uint=0):_SafeStr_147
        {
            if (isRoomEngineReady)
            {
                return (_roomEngine.getRoomObjectImage(_previewRoomId, 1, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5));
            };
            return (null);
        }

        public function getRoomObjectCurrentImage():BitmapData
        {
            var _local_2:IRoomObject;
            var _local_1:IRoomObjectVisualization;
            if (isRoomEngineReady)
            {
                _local_2 = _roomEngine.getRoomObject(_previewRoomId, 1, 100);
                if (_local_2)
                {
                    _local_1 = _local_2.getVisualization();
                    if (_local_1)
                    {
                        return (_local_1.getImage(0xFFFFFF, -1));
                    };
                };
            };
            return (null);
        }

        public function get isRoomEngineReady():Boolean
        {
            return ((!(_roomEngine == null)) && (_roomEngine.isInitialized));
        }


    }
}

