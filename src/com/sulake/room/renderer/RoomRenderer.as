package com.sulake.room.renderer
{
    import com.sulake.core.utils.Map;
    import com.sulake.core.runtime.Component;
    import com.sulake.room.object.IRoomObject;
    import flash.utils.getTimer;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.room.utils.RoomGeometry;

        public class RoomRenderer implements IRoomRenderer, IRoomSpriteCanvasContainer
    {

        private var _SafeStr_743:Map;
        private var _SafeStr_1325:Map;
        private var _SafeStr_659:Component;
        private var _disposed:Boolean = false;
        private var _roomObjectVariableAccurateZ:String = null;

        public function RoomRenderer(_arg_1:Component)
        {
            _SafeStr_743 = new Map();
            _SafeStr_1325 = new Map();
            if (_arg_1 != null)
            {
                _SafeStr_659 = _arg_1;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get roomObjectVariableAccurateZ():String
        {
            return (_roomObjectVariableAccurateZ);
        }

        public function set roomObjectVariableAccurateZ(_arg_1:String):void
        {
            _roomObjectVariableAccurateZ = _arg_1;
        }

        public function dispose():void
        {
            var _local_2:int;
            var _local_1:RoomSpriteCanvas;
            if (disposed)
            {
                return;
            };
            if (_SafeStr_1325 != null)
            {
                _local_2 = 0;
                while (_local_2 < _SafeStr_1325.length)
                {
                    _local_1 = (_SafeStr_1325.getWithIndex(_local_2) as RoomSpriteCanvas);
                    if (_local_1 != null)
                    {
                        _local_1.dispose();
                    };
                    _local_2++;
                };
                _SafeStr_1325.dispose();
                _SafeStr_1325 = null;
            };
            if (_SafeStr_743 != null)
            {
                _SafeStr_743.dispose();
                _SafeStr_743 = null;
            };
            if (_SafeStr_659 != null)
            {
                _SafeStr_659 = null;
            };
            _disposed = true;
        }

        public function reset():void
        {
            _SafeStr_743.reset();
        }

        public function getRoomObjectIdentifier(_arg_1:IRoomObject):String
        {
            if (_arg_1 != null)
            {
                return String((_arg_1.getInstanceId()));
            };
            return (null);
        }

        public function feedRoomObject(_arg_1:IRoomObject):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _SafeStr_743.add(getRoomObjectIdentifier(_arg_1), _arg_1);
        }

        public function removeRoomObject(_arg_1:IRoomObject):void
        {
            var _local_3:int;
            var _local_2:RoomSpriteCanvas;
            var _local_4:String = getRoomObjectIdentifier(_arg_1);
            _SafeStr_743.remove(_local_4);
            _local_3 = 0;
            while (_local_3 < _SafeStr_1325.length)
            {
                _local_2 = (_SafeStr_1325.getWithIndex(_local_3) as RoomSpriteCanvas);
                if (_local_2 != null)
                {
                    _local_2.roomObjectRemoved(_local_4);
                };
                _local_3++;
            };
        }

        public function getRoomObject(_arg_1:String):IRoomObject
        {
            return (_SafeStr_743.getValue(_arg_1) as IRoomObject);
        }

        public function getRoomObjectWithIndex(_arg_1:int):IRoomObject
        {
            return (_SafeStr_743.getWithIndex(_arg_1) as IRoomObject);
        }

        public function getRoomObjectIdWithIndex(_arg_1:int):String
        {
            return (_SafeStr_743.getKey(_arg_1) as String);
        }

        public function getRoomObjectCount():int
        {
            return (_SafeStr_743.length);
        }

        public function render():void
        {
            var _local_3:int;
            var _local_2:IRoomRenderingCanvas;
            var _local_1:int = getTimer();
            ErrorReportStorage.addDebugData("Canvas count", String(_SafeStr_1325.length));
            _local_3 = (_SafeStr_1325.length - 1);
            while (_local_3 >= 0)
            {
                _local_2 = (_SafeStr_1325.getWithIndex(_local_3) as IRoomRenderingCanvas);
                if (_local_2 != null)
                {
                    _local_2.render(_local_1);
                };
                _local_3--;
            };
        }

        public function createCanvas(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):IRoomRenderingCanvas
        {
            var _local_6:RoomGeometry;
            var _local_5:IRoomRenderingCanvas = (_SafeStr_1325.getValue(String(_arg_1)) as IRoomRenderingCanvas);
            if (_local_5 != null)
            {
                _local_5.initialize(_arg_2, _arg_3);
                _local_6 = (_local_5.geometry as RoomGeometry);
                if (_local_6)
                {
                    _local_6.scale = _arg_4;
                };
                return (_local_5);
            };
            _local_5 = createCanvasInstance(_arg_1, _arg_2, _arg_3, _arg_4);
            _SafeStr_1325.add(String(_arg_1), _local_5);
            return (_local_5);
        }

        protected function createCanvasInstance(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):IRoomRenderingCanvas
        {
            return (new RotatingRoomSpriteCanvas(this, _arg_1, _arg_2, _arg_3, _arg_4));
        }

        public function getCanvas(_arg_1:int):IRoomRenderingCanvas
        {
            return (_SafeStr_1325.getValue(String(_arg_1)) as IRoomRenderingCanvas);
        }

        public function disposeCanvas(_arg_1:int):Boolean
        {
            var _local_2:RoomSpriteCanvas = (_SafeStr_1325.remove(String(_arg_1)) as RoomSpriteCanvas);
            if (_local_2 != null)
            {
                _local_2.dispose();
            };
            return (false);
        }

        public function update(_arg_1:uint):void
        {
            var _local_3:int;
            var _local_2:RoomSpriteCanvas;
            render();
            _local_3 = (_SafeStr_1325.length - 1);
            while (_local_3 >= 0)
            {
                _local_2 = (_SafeStr_1325.getWithIndex(_local_3) as RoomSpriteCanvas);
                if (_local_2 != null)
                {
                    _local_2.update();
                };
                _local_3--;
            };
        }


    }
}