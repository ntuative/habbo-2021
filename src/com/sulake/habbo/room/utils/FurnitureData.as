package com.sulake.habbo.room.utils
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.room.IStuffData;
    import com.sulake.room.utils.IVector3d;

        public class FurnitureData 
    {

        private var _id:int = 0;
        private var _typeId:int = 0;
        private var _type:String = null;
        private var _loc:Vector3d = new Vector3d();
        private var _dir:Vector3d = new Vector3d();
        private var _state:int = 0;
        private var _data:IStuffData = null;
        private var _extra:Number = NaN;
        private var _expiryTime:int = -1;
        private var _usagePolicy:int = 0;
        private var _ownerId:int = 0;
        private var _ownerName:String = "";
        private var _synchronized:Boolean = true;
        private var _realRoomObject:Boolean = true;
        private var _sizeZ:Number;

        public function FurnitureData(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:IVector3d, _arg_5:IVector3d, _arg_6:int, _arg_7:IStuffData, _arg_8:Number=NaN, _arg_9:int=-1, _arg_10:int=0, _arg_11:int=0, _arg_12:String="", _arg_13:Boolean=true, _arg_14:Boolean=true, _arg_15:Number=-1)
        {
            _id = _arg_1;
            _typeId = _arg_2;
            _type = _arg_3;
            _loc.assign(_arg_4);
            _dir.assign(_arg_5);
            _state = _arg_6;
            _data = _arg_7;
            _extra = _arg_8;
            _expiryTime = _arg_9;
            _usagePolicy = _arg_10;
            _ownerId = _arg_11;
            _ownerName = _arg_12;
            _synchronized = _arg_13;
            _realRoomObject = _arg_14;
            _sizeZ = _arg_15;
        }

        public function get id():int
        {
            return (_id);
        }

        public function get typeId():int
        {
            return (_typeId);
        }

        public function get type():String
        {
            return (_type);
        }

        public function get loc():IVector3d
        {
            return (_loc);
        }

        public function get dir():IVector3d
        {
            return (_dir);
        }

        public function get state():int
        {
            return (_state);
        }

        public function get data():IStuffData
        {
            return (_data);
        }

        public function get extra():Number
        {
            return (_extra);
        }

        public function get expiryTime():int
        {
            return (_expiryTime);
        }

        public function get usagePolicy():int
        {
            return (_usagePolicy);
        }

        public function get ownerId():int
        {
            return (_ownerId);
        }

        public function get ownerName():String
        {
            return (_ownerName);
        }

        public function get synchronized():Boolean
        {
            return (_synchronized);
        }

        public function get realRoomObject():Boolean
        {
            return (_realRoomObject);
        }

        public function get sizeZ():Number
        {
            return (_sizeZ);
        }


    }
}