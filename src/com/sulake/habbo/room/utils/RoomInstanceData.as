package com.sulake.habbo.room.utils
{
    import com.sulake.core.utils.Map;

        public class RoomInstanceData 
    {

        private var _roomId:int = 0;
        private var _furniStackingHeightMap:FurniStackingHeightMap = null;
        private var _legacyGeometry:LegacyWallGeometry = null;
        private var _tileObjectMap:TileObjectMap = null;
        private var _roomCamera:RoomCamera = null;
        private var _selectedObject:SelectedRoomObjectData = null;
        private var _placedObject:SelectedRoomObjectData = null;
        private var _worldType:String = null;
        private var _SafeStr_3613:Map = new Map();
        private var _SafeStr_3614:Map = new Map();
        private var _mouseButtonCursorOwners:Array = [];

        public function RoomInstanceData(_arg_1:int)
        {
            _roomId = _arg_1;
            _legacyGeometry = new LegacyWallGeometry();
            _roomCamera = new RoomCamera();
        }

        public function get roomId():int
        {
            return (_roomId);
        }

        public function get furniStackingHeightMap():FurniStackingHeightMap
        {
            return (_furniStackingHeightMap);
        }

        public function set furniStackingHeightMap(_arg_1:FurniStackingHeightMap):void
        {
            if (_furniStackingHeightMap != null)
            {
                _furniStackingHeightMap.dispose();
            };
            _furniStackingHeightMap = _arg_1;
            if (_tileObjectMap)
            {
                _tileObjectMap.dispose();
            };
            if (_furniStackingHeightMap)
            {
                _tileObjectMap = new TileObjectMap(_furniStackingHeightMap.width, _furniStackingHeightMap.height);
            };
        }

        public function get legacyGeometry():LegacyWallGeometry
        {
            return (_legacyGeometry);
        }

        public function get tileObjectMap():TileObjectMap
        {
            return (_tileObjectMap);
        }

        public function get roomCamera():RoomCamera
        {
            return (_roomCamera);
        }

        public function get worldType():String
        {
            return (_worldType);
        }

        public function set worldType(_arg_1:String):void
        {
            _worldType = _arg_1;
        }

        public function get selectedObject():SelectedRoomObjectData
        {
            return (_selectedObject);
        }

        public function set selectedObject(_arg_1:SelectedRoomObjectData):void
        {
            if (_selectedObject != null)
            {
                _selectedObject.dispose();
            };
            _selectedObject = _arg_1;
        }

        public function get placedObject():SelectedRoomObjectData
        {
            return (_placedObject);
        }

        public function set placedObject(_arg_1:SelectedRoomObjectData):void
        {
            if (_placedObject != null)
            {
                _placedObject.dispose();
            };
            _placedObject = _arg_1;
        }

        public function dispose():void
        {
            if (_furniStackingHeightMap != null)
            {
                _furniStackingHeightMap.dispose();
                _furniStackingHeightMap = null;
            };
            if (_legacyGeometry != null)
            {
                _legacyGeometry.dispose();
                _legacyGeometry = null;
            };
            if (_roomCamera != null)
            {
                _roomCamera.dispose();
                _roomCamera = null;
            };
            if (_selectedObject != null)
            {
                _selectedObject.dispose();
                _selectedObject = null;
            };
            if (_placedObject != null)
            {
                _placedObject.dispose();
                _placedObject = null;
            };
            if (_SafeStr_3613 != null)
            {
                _SafeStr_3613.dispose();
                _SafeStr_3613 = null;
            };
            if (_SafeStr_3614 != null)
            {
                _SafeStr_3614.dispose();
                _SafeStr_3614 = null;
            };
            if (_tileObjectMap != null)
            {
                _tileObjectMap.dispose();
                _tileObjectMap = null;
            };
        }

        public function addFurnitureData(_arg_1:FurnitureData):void
        {
            if (_arg_1 != null)
            {
                _SafeStr_3613.remove(_arg_1.id);
                Logger.log("addFurnitureData::_arg_1: " + JSON.stringify(_arg_1))
                _SafeStr_3613.add(_arg_1.id, _arg_1);
            };
        }

        public function getFurnitureData():FurnitureData
        {
            if (_SafeStr_3613.length > 0)
            {
                return (getFurnitureDataWithId(_SafeStr_3613.getKey(0)));
            };
            return (null);
        }

        public function getFurnitureDataWithId(_arg_1:int):FurnitureData
        {
            return (_SafeStr_3613.remove(_arg_1));
        }

        public function addWallItemData(_arg_1:FurnitureData):void
        {
            if (_arg_1 != null)
            {
                _SafeStr_3614.remove(_arg_1.id);
                _SafeStr_3614.add(_arg_1.id, _arg_1);
            };
        }

        public function getWallItemData():FurnitureData
        {
            if (_SafeStr_3614.length > 0)
            {
                return (getWallItemDataWithId(_SafeStr_3614.getKey(0)));
            };
            return (null);
        }

        public function getWallItemDataWithId(_arg_1:int):FurnitureData
        {
            return (_SafeStr_3614.remove(_arg_1));
        }

        public function addButtonMouseCursorOwner(_arg_1:String):Boolean
        {
            var _local_2:int = _mouseButtonCursorOwners.indexOf(_arg_1);
            if (_local_2 == -1)
            {
                _mouseButtonCursorOwners.push(_arg_1);
                return (true);
            };
            return (false);
        }

        public function removeButtonMouseCursorOwner(_arg_1:String):Boolean
        {
            var _local_2:int = _mouseButtonCursorOwners.indexOf(_arg_1);
            if (_local_2 > -1)
            {
                _mouseButtonCursorOwners.splice(_local_2, 1);
                return (true);
            };
            return (false);
        }

        public function hasButtonMouseCursorOwners():Boolean
        {
            return (_mouseButtonCursorOwners.length > 0);
        }


    }
}

