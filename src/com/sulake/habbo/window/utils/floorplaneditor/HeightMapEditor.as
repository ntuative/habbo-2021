package com.sulake.habbo.window.utils.floorplaneditor
{
    import flash.display.BitmapData;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import flash.display.Bitmap;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import flash.geom.ColorTransform;

    public class HeightMapEditor
    {

        public static const LEVELS:int = 30;

        public static var floor_editor_tile_base:Class = HabboHeightMapEditor_Habbofloor_editor_tile_base_png;
        public static var floor_editor_tile_entry:Class = HabboHeightMapEditor_Habbofloor_editor_tile_entry_png;
        public static var floor_editor_tile_base_large:Class = HabboHeightMapEditor_Habbofloor_editor_tile_base_large_png;
        public static var floor_editor_tile_entry_large:Class = HabboHeightMapEditor_Habbofloor_editor_tile_entry_large_png;

        private var _bcFloorPlanEditor:BCFloorPlanEditor;
        private var _drawing:Boolean = false;
        private var _drawingHeight:int = 0;
        private var _tileImageBase:BitmapData;
        private var _tileImageEntry:BitmapData;
        private var _heigthColorMap:Vector.<Array>;
        private var _occupiedHeigthColorMap:Vector.<Array>;
        private var _bitmapElement:IBitmapWrapperWindow;
        private var _lastDrawAddress:Point = new Point(-1000, -1000);
        private var _floorPlan:FloorPlanCache;
        private var _colorPickMode:Boolean = false;
        private var _zoomLevel:int = 1;
        private var firstMove:Boolean = false;

        public function HeightMapEditor(_arg_1:BCFloorPlanEditor)
        {
            var _local_2:int;
            var _local_3:Number;
            super();
            _bcFloorPlanEditor = _arg_1;
            _bcFloorPlanEditor.heightMapBitmapElement.procedure = editorWindowProcedure;
            _floorPlan = _arg_1.floorPlanCache;
            _tileImageBase = Bitmap(new floor_editor_tile_base()).bitmapData;
            _tileImageEntry = Bitmap(new floor_editor_tile_entry()).bitmapData;
            _heigthColorMap = new Vector.<Array>();
            _occupiedHeigthColorMap = new Vector.<Array>();
            _local_2 = 0;
            while (_local_2 < 30)
            {
                _local_3 = (0.6 - ((_local_2 / 30) * 0.85));
                if (_local_3 < 0)
                {
                    _local_3 = (1 + _local_3);
                };
                _heigthColorMap.push(hslToRgb(_local_3, 1, 0.5));
                _occupiedHeigthColorMap.push(hslToRgb(_local_3, 0.33, 0.4));
                _local_2++;
            };
        }

        public static function hslToRgb(_arg_1:Number, _arg_2:Number, _arg_3:Number):Array
        {
            var h:Number = _arg_1;
            var s:Number = _arg_2;
            var l:Number = _arg_3;
            if (s == 0)
            {
                var b:Number = l;
                var g:Number = b;
                var r:Number = g;
            }
            else
            {
                var hue2rgb:Function = function (_arg_1:Number, _arg_2:Number, _arg_3:Number):Number
                {
                    if (_arg_3 < 0)
                    {
                        _arg_3 = (_arg_3 + 1);
                    };
                    if (_arg_3 > 1)
                    {
                        _arg_3 = (_arg_3 - 1);
                    };
                    if (_arg_3 < 0.166666666666667)
                    {
                        return (_arg_1 + (((_arg_2 - _arg_1) * 6) * _arg_3));
                    };
                    if (_arg_3 < 0.5)
                    {
                        return (_arg_2);
                    };
                    if (_arg_3 < 0.666666666666667)
                    {
                        return (_arg_1 + (((_arg_2 - _arg_1) * (0.666666666666667 - _arg_3)) * 6));
                    };
                    return (_arg_1);
                };
                var q:Number = ((l < 0.5) ? (l * (1 + s)) : ((l + s) - (l * s)));
                var p:Number = ((2 * l) - q);
                r = hue2rgb(p, q, (h + 0.333333333333333));
                g = hue2rgb(p, q, h);
                b = hue2rgb(p, q, (h - 0.333333333333333));
            };
            return ([r, g, b]);
        }


        public function get heigthColorMap():Vector.<Array>
        {
            return (_heigthColorMap);
        }

        public function set drawingHeight(_arg_1:int):void
        {
            _drawingHeight = Math.min(30, Math.max(0, _arg_1));
        }

        public function get drawingHeight():int
        {
            return (_drawingHeight);
        }

        public function set drawing(_arg_1:Boolean):void
        {
            _drawing = _arg_1;
        }

        public function refreshFromCache():void
        {
            _bitmapElement = _bcFloorPlanEditor.heightMapBitmapElement;
            _lastDrawAddress = new Point(-1000, -1000);
            updateView();
        }

        private function editorWindowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_5:int;
            var _local_4:int;
            var _local_3:Point;
            var _local_6:Object;
            if (_colorPickMode)
            {
                if (_arg_1.type == "WME_CLICK")
                {
                    _local_5 = int(((_bcFloorPlanEditor.heightMapBitmapElement.width / 2) - (_bcFloorPlanEditor.heightMapBitmapElement.bitmap.width / 2)));
                    _local_4 = int(((_bcFloorPlanEditor.heightMapBitmapElement.height / 2) - (_bcFloorPlanEditor.heightMapBitmapElement.bitmap.height / 2)));
                    _local_3 = transformFromScreenSpace((WindowMouseEvent(_arg_1).localX - _local_5), (WindowMouseEvent(_arg_1).localY - _local_4));
                    _drawingHeight = _bcFloorPlanEditor.floorPlanCache.getHeightAt(_local_3.x, _local_3.y);
                    _bcFloorPlanEditor.updateColorSliderTrack(_drawingHeight);
                };
            }
            else
            {
                if (((_arg_1.type == "WME_UP") || (_arg_1.type == "WME_UP_OUTSIDE")))
                {
                    _drawing = false;
                };
                if (_arg_1.type == "WME_DOWN")
                {
                    _drawing = true;
                    firstMove = true;
                    _lastDrawAddress = new Point(-1000, -1000);
                };
                if (((_arg_1.type == "WME_CLICK") || ((_drawing) && (_arg_1.type == "WME_MOVE"))))
                {
                    _local_5 = int(((_bcFloorPlanEditor.heightMapBitmapElement.width / 2) - (_bcFloorPlanEditor.heightMapBitmapElement.bitmap.width / 2)));
                    _local_4 = int(((_bcFloorPlanEditor.heightMapBitmapElement.height / 2) - (_bcFloorPlanEditor.heightMapBitmapElement.bitmap.height / 2)));
                    _local_3 = transformFromScreenSpace((WindowMouseEvent(_arg_1).localX - _local_5), (WindowMouseEvent(_arg_1).localY - _local_4));
                    if (_arg_1.type == "WME_MOVE")
                    {
                        if ((((firstMove) || (!(_lastDrawAddress.x == _local_3.x))) || (!(_lastDrawAddress.y == _local_3.y))))
                        {
                            applyDraw(_local_3.x, _local_3.y);
                        };
                        _local_6 = interpolateBetweenLastPointAndDrawPoint(_local_3);
                        if ((((firstMove) || (Math.abs(_local_6.x) > 0)) || (Math.abs(_local_6.y) > 0)))
                        {
                            updateView();
                        };
                        firstMove = false;
                    }
                    else
                    {
                        applyDraw(_local_3.x, _local_3.y);
                        updateView();
                    };
                    _lastDrawAddress = _local_3;
                };
            };
        }

        private function interpolateBetweenLastPointAndDrawPoint(_arg_1:Point):Object
        {
            var _local_5:int;
            var _local_6:int;
            var _local_2:int;
            if (((_lastDrawAddress.x == -1000) && (_lastDrawAddress.y == -1000)))
            {
                _lastDrawAddress.x = _arg_1.x;
                _lastDrawAddress.y = _arg_1.y;
            };
            var _local_3:int = (_arg_1.x - _lastDrawAddress.x);
            var _local_4:int = (_arg_1.y - _lastDrawAddress.y);
            _local_2 = 0;
            _local_5 = _lastDrawAddress.x;
            _local_5;
            while (_local_5 != _arg_1.x)
            {
                if (((_local_2 > 0) && (_local_2 < Math.abs(_local_3))))
                {
                    applyDraw(_local_5, _arg_1.y);
                };
                _local_5 = (_local_5 + ((_local_3 > 0) ? 1 : -1));
                _local_2++;
            };
            _local_2 = 0;
            _local_6 = _lastDrawAddress.y;
            _local_6;
            while (_local_6 != _arg_1.y)
            {
                if (((_local_2 > 0) && (_local_2 < Math.abs(_local_4))))
                {
                    applyDraw(_arg_1.x, _local_6);
                };
                _local_6 = (_local_6 + ((_local_4 > 0) ? 1 : -1));
                _local_2++;
            };
            return ({
                "x":_local_3,
                "y":_local_4
            });
        }

        private function applyDraw(_arg_1:int, _arg_2:int):void
        {
            var _local_3:int;
            switch (_bcFloorPlanEditor.drawMode)
            {
                case _bcFloorPlanEditor.drawModes[0]:
                    _bcFloorPlanEditor.floorPlanCache.setHeightAt(_arg_1, _arg_2, _drawingHeight);
                    return;
                case _bcFloorPlanEditor.drawModes[1]:
                    _bcFloorPlanEditor.floorPlanCache.setHeightAt(_arg_1, _arg_2, -1);
                    return;
                case _bcFloorPlanEditor.drawModes[2]:
                    _local_3 = _bcFloorPlanEditor.floorPlanCache.getHeightAt(_arg_1, _arg_2);
                    if (_local_3 >= 0)
                    {
                        _bcFloorPlanEditor.floorPlanCache.setHeightAt(_arg_1, _arg_2, Math.min((30 - 1), (_local_3 + 1)));
                    };
                    return;
                case _bcFloorPlanEditor.drawModes[3]:
                    _local_3 = _bcFloorPlanEditor.floorPlanCache.getHeightAt(_arg_1, _arg_2);
                    if (_local_3 >= 0)
                    {
                        _bcFloorPlanEditor.floorPlanCache.setHeightAt(_arg_1, _arg_2, Math.max(0, (_local_3 - 1)));
                    };
                    return;
                case _bcFloorPlanEditor.drawModes[4]:
                    _local_3 = _bcFloorPlanEditor.floorPlanCache.getHeightAt(_arg_1, _arg_2);
                    if (_local_3 >= 0)
                    {
                        _bcFloorPlanEditor.floorPlanCache.entryPoint = new Point(_arg_1, _arg_2);
                    };
                    return;
            };
        }

        private function updateView():void
        {
            var _local_12:int;
            var _local_13:int;
            var _local_6:Array;
            var _local_5:BitmapData;
            var _local_7:Point;
            var _local_14:int;
            var _local_8:Array = [];
            var _local_10:Number = 2147483647;
            var _local_9:Number = 2147483647;
            var _local_2:Number = -2147483648;
            var _local_1:Number = -2147483648;
            _local_13 = 0;
            while (_local_13 < _floorPlan.floorHeight)
            {
                _local_12 = 0;
                while (_local_12 < _floorPlan.floorWidth)
                {
                    _local_7 = transformToScreenSpace(_local_12, _local_13);
                    _local_10 = Math.min(_local_10, _local_7.x);
                    _local_9 = Math.min(_local_9, _local_7.y);
                    _local_2 = Math.max(_local_2, _local_7.x);
                    _local_1 = Math.max(_local_1, _local_7.y);
                    if (_floorPlan.isEntryPoint(_local_12, _local_13))
                    {
                        _local_5 = _tileImageEntry.clone();
                        _local_8.push({
                            "point":_local_7,
                            "image":_local_5
                        });
                    }
                    else
                    {
                        _local_14 = Math.min(_floorPlan.getHeightAt(_local_12, _local_13), (30 - 1));
                        if (_local_14 >= 0)
                        {
                            _local_6 = ((_floorPlan.isTileReserved(_local_12, _local_13)) ? _occupiedHeigthColorMap[_local_14] : _heigthColorMap[_local_14]);
                            _local_5 = _tileImageBase.clone();
                            _local_5.colorTransform(_tileImageBase.rect, new ColorTransform(_local_6[0], _local_6[1], _local_6[2]));
                            _local_8.push({
                                "point":_local_7,
                                "image":_local_5
                            });
                        };
                    };
                    _local_12++;
                };
                _local_13++;
            };
            var _local_11:BitmapData = new BitmapData(((_local_2 - _local_10) + 18), ((_local_1 - _local_9) + 9), false, 0);
            var _local_3:Point = new Point(-(_local_10), -(_local_9));
            for each (var _local_4:Object in _local_8)
            {
                _local_11.copyPixels(_local_4.image, _local_4.image.rect, _local_4.point.add(_local_3));
            };
            _bcFloorPlanEditor.heightMapBitmapElement.bitmap = _local_11;
        }

        private function transformFromScreenSpace(_arg_1:int, _arg_2:int):Point
        {
            var _local_3:Number = ((_arg_1 / 16) / _zoomLevel);
            var _local_5:Number = ((_arg_2 / 8) / _zoomLevel);
            var _local_7:Number = _floorPlan.floorHeight;
            var _local_4:int = int((_local_5 + (_local_3 - (_local_7 / 2))));
            var _local_6:int = int((_local_5 - (_local_3 - (_local_7 / 2))));
            return (new Point(_local_4, _local_6));
        }

        private function transformToScreenSpace(_arg_1:int, _arg_2:int):Point
        {
            return (new Point(((_zoomLevel * 8) * (_arg_1 - _arg_2)), ((_zoomLevel * 4) * (_arg_1 + _arg_2))));
        }

        public function get colorPickMode():Boolean
        {
            return (_colorPickMode);
        }

        public function set colorPickMode(_arg_1:Boolean):void
        {
            _colorPickMode = _arg_1;
        }

        public function get zoomLevel():int
        {
            return (_zoomLevel);
        }

        public function set zoomLevel(_arg_1:int):void
        {
            if (((_arg_1 < 1) || (_arg_1 > 2)))
            {
                return;
            };
            switch (_arg_1)
            {
                case 1:
                    _tileImageBase = Bitmap(new floor_editor_tile_base()).bitmapData;
                    _tileImageEntry = Bitmap(new floor_editor_tile_entry()).bitmapData;
                    break;
                case 2:
                    _tileImageBase = Bitmap(new floor_editor_tile_base_large()).bitmapData;
                    _tileImageEntry = Bitmap(new floor_editor_tile_entry_large()).bitmapData;
                default:
            };
            _zoomLevel = _arg_1;
        }


    }
}
