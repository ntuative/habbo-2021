package com.sulake.habbo.window.utils.floorplaneditor
{
    import flash.geom.Point;
    import com.sulake.habbo.communication.messages.incoming.room.engine.FloorHeightMapMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.layout.RoomOccupiedTilesMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.layout.RoomOccupiedTilesMessageEvent;

    public class FloorPlanCache 
    {

        private const MAX_AREA:uint = 0x0400;
        private const MAX_AXIS_LENGTH:uint = 64;

        private var _bcFloorPlanEditor:BCFloorPlanEditor;
        private var _floorWidth:int;
        private var _floorHeight:int;
        private var _floorPlanCache:Array;
        private var _reservedTiles:Array;
        private var _entryPoint:Point;
        private var _entryPointDir:uint;

        public function FloorPlanCache(_arg_1:BCFloorPlanEditor)
        {
            _bcFloorPlanEditor = _arg_1;
        }

        public function onFloorHeightMap(_arg_1:FloorHeightMapMessageEvent):void
        {
            updateFloorPlanCache(_arg_1.getParser().text);
        }

        public function onOccupiedTiles(_arg_1:RoomOccupiedTilesMessageEvent):void
        {
            var _local_2:RoomOccupiedTilesMessageParser;
            if (_floorPlanCache)
            {
                _local_2 = _arg_1.getParser();
                resetReservedTiles();
                for each (var _local_3:Object in _local_2.occupiedTiles)
                {
                    _reservedTiles[_local_3.y][_local_3.x] = true;
                };
            };
        }

        private function resetReservedTiles():void
        {
            var _local_2:int;
            var _local_1:int;
            _reservedTiles = [];
            _local_2 = 0;
            while (_local_2 < floorHeight)
            {
                _reservedTiles.push([]);
                _local_1 = 0;
                while (_local_1 < floorWidth)
                {
                    _reservedTiles[_local_2].push(false);
                    _local_1++;
                };
                _local_2++;
            };
        }

        private function updateFloorPlanCache(_arg_1:String=""):void
        {
            var _local_2:Array = _arg_1.split("\r");
            _floorPlanCache = [];
            for each (var _local_3:String in _local_2)
            {
                if (_local_3.length > 0)
                {
                    _floorPlanCache.push(_local_3);
                };
            };
            checkDimensions();
        }

        private function checkDimensions():Boolean
        {
            _floorWidth = -1;
            _floorHeight = -1;
            if (_floorPlanCache.length == 0)
            {
                return (false);
            };
            var _local_1:int = _floorPlanCache[0].length;
            var _local_3:int;
            for each (var _local_2:String in _floorPlanCache)
            {
                if (_local_2.length == 0) break;
                _local_3++;
            };
            _floorWidth = _local_1;
            _floorHeight = _local_3;
            return (true);
        }

        private function allowDrawAt(_arg_1:int, _arg_2:int):Boolean
        {
            if ((((((_floorPlanCache == null) || (_arg_1 < 0)) || (_arg_1 > _floorWidth)) || (_arg_2 < 0)) || (_arg_2 > _floorHeight)))
            {
                return (false);
            };
            if (((_arg_1 == 0) || (_arg_2 == 0)))
            {
                return (isDoorTileAllowedAt(_arg_1, _arg_2));
            };
            return (true);
        }

        private function isDoorTileAllowedAt(_arg_1:int, _arg_2:int):Boolean
        {
            return ((isFirstColumnZeroOrHasDoorAt(_arg_1, _arg_2)) && (isFirstRowZeroOrHasDoorAt(_arg_1, _arg_2)));
        }

        private function isFirstColumnZeroOrHasDoorAt(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_3:int;
            _local_3 = 0;
            while (_local_3 < _floorHeight)
            {
                if (((!(_local_3 == _arg_2)) && (!(_floorPlanCache[_local_3].substr(0, 1) == "x"))))
                {
                    return (false);
                };
                _local_3++;
            };
            return (true);
        }

        private function isFirstRowZeroOrHasDoorAt(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_3:int;
            _local_3 = 0;
            while (_local_3 < _floorWidth)
            {
                if (((!(_local_3 == _arg_1)) && (!(_floorPlanCache[0].substr(_local_3, 1) == "x"))))
                {
                    return (false);
                };
                _local_3++;
            };
            return (true);
        }

        public function setHeightAt(_arg_1:int, _arg_2:int, _arg_3:int):Boolean
        {
            if (!allowDrawAt(_arg_1, _arg_2))
            {
                return (false);
            };
            if (_arg_1 == _floorWidth)
            {
                if (!addColumn())
                {
                    return (false);
                };
            };
            if (_arg_2 == _floorHeight)
            {
                if (!addRow())
                {
                    return (false);
                };
            };
            if (isTileReserved(_arg_1, _arg_2))
            {
                return (false);
            };
            _floorPlanCache[_arg_2] = setCharAt(_floorPlanCache[_arg_2], ((_arg_3 < 0) ? "x" : _arg_3.toString(33)), _arg_1);
            return (true);
        }

        public function getHeightAt(_arg_1:int, _arg_2:int):int
        {
            if ((((((_floorPlanCache == null) || (_arg_1 < 0)) || (_arg_1 >= _floorWidth)) || (_arg_2 < 0)) || (_arg_2 >= _floorHeight)))
            {
                return (-1);
            };
            var _local_3:String = _floorPlanCache[_arg_2].charAt(_arg_1);
            return ((_local_3 == "x") ? -1 : parseInt(_local_3, 33));
        }

        private function setCharAt(_arg_1:String, _arg_2:String, _arg_3:int):String
        {
            return ((_arg_1.substr(0, _arg_3) + _arg_2) + _arg_1.substr((_arg_3 + 1)));
        }

        public function get floorWidth():int
        {
            return (_floorWidth);
        }

        public function get floorHeight():int
        {
            return (_floorHeight);
        }

        public function getData():String
        {
            var _local_1:int;
            var _local_2:String = "";
            _local_1 = 0;
            while (_local_1 < _floorPlanCache.length)
            {
                _local_2 = ((_local_2 + _floorPlanCache[_local_1]) + "\r");
                _local_1++;
            };
            return (_local_2);
        }

        public function isTileReserved(_arg_1:int, _arg_2:int):Boolean
        {
            if (!_reservedTiles)
            {
                return (false);
            };
            if (_reservedTiles.length < (_arg_2 + 1))
            {
                return (false);
            };
            if (_reservedTiles[_arg_2].length < (_arg_1 + 1))
            {
                return (false);
            };
            return (_reservedTiles[_arg_2][_arg_1]);
        }

        public function isEntryPoint(_arg_1:int, _arg_2:int):Boolean
        {
            if (!_entryPoint)
            {
                return (false);
            };
            return ((_entryPoint.x == _arg_1) && (_entryPoint.y == _arg_2));
        }

        public function get entryPoint():Point
        {
            return (_entryPoint);
        }

        public function set entryPoint(_arg_1:Point):void
        {
            _entryPoint = _arg_1;
        }

        public function get entryPointDir():int
        {
            return (_entryPointDir);
        }

        public function set entryPointDir(_arg_1:int):void
        {
            if (_arg_1 < 0)
            {
                _arg_1 = 7;
            };
            if (_arg_1 > 7)
            {
                _arg_1 = 0;
            };
            _entryPointDir = _arg_1;
        }

        private function addColumn():Boolean
        {
            var _local_1:int;
            if (!checkSizeLimits((_floorWidth + 1), _floorHeight))
            {
                _bcFloorPlanEditor.windowManager.simpleAlert("${floor.plan.editor.alert}", null, "${floor.plan.editor.size.limit.exceeded}");
                _bcFloorPlanEditor.heightMapEditor.drawing = false;
                return (false);
            };
            _local_1 = 0;
            while (_local_1 < _floorHeight)
            {
                if (_floorPlanCache[_local_1].length > 0)
                {
                    _floorPlanCache[_local_1] = (_floorPlanCache[_local_1] + "x");
                    _reservedTiles[_local_1].push(false);
                };
                _local_1++;
            };
            _floorWidth = (_floorWidth + 1);
            return (true);
        }

        private function addRow():Boolean
        {
            var _local_2:int;
            if (!checkSizeLimits(_floorWidth, (_floorHeight + 1)))
            {
                _bcFloorPlanEditor.windowManager.simpleAlert("${floor.plan.editor.alert}", null, "${floor.plan.editor.size.limit.exceeded}");
                _bcFloorPlanEditor.heightMapEditor.drawing = false;
                return (false);
            };
            var _local_1:String = "";
            _local_2 = 0;
            while (_local_2 < _floorWidth)
            {
                _local_1 = (_local_1 + "x");
                _local_2++;
            };
            _floorPlanCache.push(_local_1);
            var _local_3:Array = [];
            _local_2 = 0;
            while (_local_2 < _floorWidth)
            {
                _local_3.push(false);
                _local_2++;
            };
            _reservedTiles.push(_local_3);
            _floorHeight = (_floorHeight + 1);
            return (true);
        }

        private function checkSizeLimits(_arg_1:uint, _arg_2:uint):Boolean
        {
            return (!((((!(_bcFloorPlanEditor.largeFloorPlansAllowed)) && ((_arg_1 * _arg_2) > 0x0400)) || (_arg_1 > 64)) || (_arg_2 > 64)));
        }


    }
}