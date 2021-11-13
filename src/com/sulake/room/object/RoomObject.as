package com.sulake.room.object
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.object.visualization.IRoomObjectVisualization;
    import com.sulake.room.object.logic.IRoomObjectEventHandler;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.object.logic.IRoomObjectMouseHandler;
    import com.sulake.room.utils.*;

    public class RoomObject implements IRoomObjectController 
    {

        private static var _SafeStr_4460:int = 0;

        private var _SafeStr_698:int;
        private var _SafeStr_741:String = "";
        private var _SafeStr_3181:Vector3d;
        private var _SafeStr_1925:Vector3d;
        private var _SafeStr_4465:Vector3d;
        private var _SafeStr_4466:Vector3d;
        private var _SafeStr_4464:Array;
        private var _SafeStr_1275:RoomObjectModel;
        private var _visualization:IRoomObjectVisualization;
        private var _SafeStr_4467:IRoomObjectEventHandler;
        private var _SafeStr_4463:int;
        private var _avatarLibraryAssetName:String;
        private var _SafeStr_4462:int = 0;
        private var _SafeStr_573:Boolean = false;

        public function RoomObject(_arg_1:int, _arg_2:int, _arg_3:String)
        {
            var _local_4:Number;
            super();
            _SafeStr_698 = _arg_1;
            _SafeStr_3181 = new Vector3d();
            _SafeStr_1925 = new Vector3d();
            _SafeStr_4465 = new Vector3d();
            _SafeStr_4466 = new Vector3d();
            _SafeStr_4464 = new Array(_arg_2);
            _local_4 = (_arg_2 - 1);
            while (_local_4 >= 0)
            {
                _SafeStr_4464[_local_4] = 0;
                _local_4--;
            };
            _SafeStr_741 = _arg_3;
            _SafeStr_1275 = new RoomObjectModel();
            _visualization = null;
            _SafeStr_4467 = null;
            _SafeStr_4463 = 0;
            _SafeStr_4462 = _SafeStr_4460++;
        }

        public function dispose():void
        {
            _SafeStr_3181 = null;
            _SafeStr_1925 = null;
            _SafeStr_4464 = null;
            _avatarLibraryAssetName = null;
            setVisualization(null);
            setEventHandler(null);
            if (_SafeStr_1275 != null)
            {
                _SafeStr_1275.dispose();
                _SafeStr_1275 = null;
            };
        }

        public function setInitialized(_arg_1:Boolean):void
        {
            _SafeStr_573 = _arg_1;
        }

        public function isInitialized():Boolean
        {
            return (_SafeStr_573);
        }

        public function getId():int
        {
            return (_SafeStr_698);
        }

        public function getInstanceId():int
        {
            return (_SafeStr_4462);
        }

        public function getType():String
        {
            return (_SafeStr_741);
        }

        public function getLocation():IVector3d
        {
            _SafeStr_4465.assign(_SafeStr_3181);
            return (_SafeStr_4465);
        }

        public function getDirection():IVector3d
        {
            _SafeStr_4466.assign(_SafeStr_1925);
            return (_SafeStr_4466);
        }

        public function getModel():IRoomObjectModel
        {
            return (_SafeStr_1275);
        }

        public function getModelController():IRoomObjectModelController
        {
            return (_SafeStr_1275);
        }

        public function getState(_arg_1:int):int
        {
            if (((_arg_1 >= 0) && (_arg_1 < _SafeStr_4464.length)))
            {
                return (_SafeStr_4464[_arg_1]);
            };
            return (-1);
        }

        public function getVisualization():IRoomObjectVisualization
        {
            return (_visualization);
        }

        public function setLocation(_arg_1:IVector3d):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            if ((((!(_SafeStr_3181.x == _arg_1.x)) || (!(_SafeStr_3181.y == _arg_1.y))) || (!(_SafeStr_3181.z == _arg_1.z))))
            {
                _SafeStr_3181.x = _arg_1.x;
                _SafeStr_3181.y = _arg_1.y;
                _SafeStr_3181.z = _arg_1.z;
                _SafeStr_4463++;
            };
        }

        public function setDirection(_arg_1:IVector3d):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            if ((((!(_SafeStr_1925.x == _arg_1.x)) || (!(_SafeStr_1925.y == _arg_1.y))) || (!(_SafeStr_1925.z == _arg_1.z))))
            {
                _SafeStr_1925.x = (((_arg_1.x % 360) + 360) % 360);
                _SafeStr_1925.y = (((_arg_1.y % 360) + 360) % 360);
                _SafeStr_1925.z = (((_arg_1.z % 360) + 360) % 360);
                _SafeStr_4463++;
            };
        }

        public function setState(_arg_1:int, _arg_2:int):Boolean
        {
            if (((_arg_2 >= 0) && (_arg_2 < _SafeStr_4464.length)))
            {
                if (_SafeStr_4464[_arg_2] != _arg_1)
                {
                    _SafeStr_4464[_arg_2] = _arg_1;
                    _SafeStr_4463++;
                };
                return (true);
            };
            return (false);
        }

        public function setVisualization(_arg_1:IRoomObjectVisualization):void
        {
            if (_arg_1 != _visualization)
            {
                if (_visualization != null)
                {
                    _visualization.dispose();
                };
                _visualization = _arg_1;
                if (_visualization != null)
                {
                    _visualization.object = this;
                };
            };
        }

        public function setEventHandler(_arg_1:IRoomObjectEventHandler):void
        {
            if (_arg_1 == _SafeStr_4467)
            {
                return;
            };
            var _local_2:IRoomObjectEventHandler = _SafeStr_4467;
            if (_local_2 != null)
            {
                _SafeStr_4467 = null;
                _local_2.object = null;
            };
            _SafeStr_4467 = _arg_1;
            if (_SafeStr_4467 != null)
            {
                _SafeStr_4467.object = this;
            };
        }

        public function getEventHandler():IRoomObjectEventHandler
        {
            return (_SafeStr_4467);
        }

        public function getUpdateID():int
        {
            return (_SafeStr_4463);
        }

        public function getMouseHandler():IRoomObjectMouseHandler
        {
            return (getEventHandler());
        }

        public function getAvatarLibraryAssetName():String
        {
            if (!_avatarLibraryAssetName)
            {
                _avatarLibraryAssetName = ("avatar_" + getId());
            };
            return (_avatarLibraryAssetName);
        }

        public function tearDown():void
        {
            if (_SafeStr_4467)
            {
                _SafeStr_4467.tearDown();
            };
        }


    }
}

