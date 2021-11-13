package com.sulake.habbo.room.utils
{
    import com.sulake.habbo.room.ISelectedRoomObjectData;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.room.IStuffData;
    import com.sulake.room.utils.IVector3d;

        public class SelectedRoomObjectData implements ISelectedRoomObjectData 
    {

        private var _id:int = 0;
        private var _category:int = 0;
        private var _operation:String = "";
        private var _loc:Vector3d = null;
        private var _dir:Vector3d = null;
        private var _typeId:int = 0;
        private var _instanceData:String = null;
        private var _stuffData:IStuffData = null;
        private var _state:int = -1;
        private var _animFrame:int = -1;
        private var _posture:String = null;

        public function SelectedRoomObjectData(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:IVector3d, _arg_5:IVector3d, _arg_6:int=0, _arg_7:String=null, _arg_8:IStuffData=null, _arg_9:int=-1, _arg_10:int=-1, _arg_11:String=null)
        {
            _id = _arg_1;
            _category = _arg_2;
            _operation = _arg_3;
            _loc = new Vector3d();
            _loc.assign(_arg_4);
            _dir = new Vector3d();
            _dir.assign(_arg_5);
            _typeId = _arg_6;
            _instanceData = _arg_7;
            _stuffData = _arg_8;
            _state = _arg_9;
            _animFrame = _arg_10;
            _posture = _arg_11;
        }

        public function get id():int
        {
            return (_id);
        }

        public function get category():int
        {
            return (_category);
        }

        public function get operation():String
        {
            return (_operation);
        }

        public function get loc():Vector3d
        {
            return (_loc);
        }

        public function get dir():Vector3d
        {
            return (_dir);
        }

        public function get typeId():int
        {
            return (_typeId);
        }

        public function get instanceData():String
        {
            return (_instanceData);
        }

        public function get stuffData():IStuffData
        {
            return (_stuffData);
        }

        public function get state():int
        {
            return (_state);
        }

        public function get animFrame():int
        {
            return (_animFrame);
        }

        public function get posture():String
        {
            return (_posture);
        }

        public function dispose():void
        {
            _loc = null;
            _dir = null;
        }


    }
}