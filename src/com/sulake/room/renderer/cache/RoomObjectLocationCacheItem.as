package com.sulake.room.renderer.cache
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.utils.IRoomGeometry;

        public class RoomObjectLocationCacheItem 
    {

        private var _SafeStr_4479:String = "";
        private var _SafeStr_3250:int = -1;
        private var _SafeStr_4480:int = -1;
        private var _SafeStr_4481:Vector3d = new Vector3d();
        private var _SafeStr_4482:Vector3d = null;
        private var _locationChanged:Boolean = false;

        public function RoomObjectLocationCacheItem(_arg_1:String)
        {
            _SafeStr_4479 = _arg_1;
            _SafeStr_4482 = new Vector3d();
        }

        public function get locationChanged():Boolean
        {
            return (_locationChanged);
        }

        public function dispose():void
        {
            _SafeStr_4482 = null;
        }

        public function getScreenLocation(_arg_1:IRoomObject, _arg_2:IRoomGeometry):IVector3d
        {
            var _local_8:IVector3d;
            var _local_3:Number;
            var _local_4:Vector3d;
            var _local_6:IVector3d;
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return (null);
            };
            var _local_5:Boolean;
            var _local_7:IVector3d = _arg_1.getLocation();
            if (((!(_arg_2.updateId == _SafeStr_3250)) || (!(_arg_1.getUpdateID() == _SafeStr_4480))))
            {
                _SafeStr_4480 = _arg_1.getUpdateID();
                if (((((!(_arg_2.updateId == _SafeStr_3250)) || (!(_local_7.x == _SafeStr_4481.x))) || (!(_local_7.y == _SafeStr_4481.y))) || (!(_local_7.z == _SafeStr_4481.z))))
                {
                    _SafeStr_3250 = _arg_2.updateId;
                    _SafeStr_4481.assign(_local_7);
                    _local_5 = true;
                };
            };
            _locationChanged = _local_5;
            if (_local_5)
            {
                _local_8 = _arg_2.getScreenPosition(_local_7);
                if (_local_8 == null)
                {
                    return (null);
                };
                _local_3 = _arg_1.getModel().getNumber(_SafeStr_4479);
                if (((isNaN(_local_3)) || (_local_3 == 0)))
                {
                    _local_4 = new Vector3d(Math.round(_local_7.x), Math.round(_local_7.y), _local_7.z);
                    if (((!(_local_4.x == _local_7.x)) || (!(_local_4.y == _local_7.y))))
                    {
                        _local_6 = _arg_2.getScreenPosition(_local_4);
                        _SafeStr_4482.assign(_local_8);
                        if (_local_6 != null)
                        {
                            _SafeStr_4482.z = _local_6.z;
                        };
                    }
                    else
                    {
                        _SafeStr_4482.assign(_local_8);
                    };
                }
                else
                {
                    _SafeStr_4482.assign(_local_8);
                };
                _SafeStr_4482.x = Math.round(_SafeStr_4482.x);
                _SafeStr_4482.y = Math.round(_SafeStr_4482.y);
            };
            return (_SafeStr_4482);
        }


    }
}

