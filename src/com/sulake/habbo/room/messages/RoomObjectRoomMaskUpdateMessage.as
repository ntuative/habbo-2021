package com.sulake.habbo.room.messages
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;

    public class RoomObjectRoomMaskUpdateMessage extends RoomObjectUpdateMessage 
    {

        public static const ADD_MASK:String = "RORMUM_ADD_MASK";
        public static const REMOVE_MASK:String = "RORMUM_ADD_MASK";
        public static const MASK_TYPE_DOOR:String = "door";
        public static const MASK_CATEGORY_WINDOW:String = "window";
        public static const MASK_CATEGORY_HOLE:String = "hole";

        private var _type:String = "";
        private var _maskId:String = "";
        private var _maskType:String = "";
        private var _maskLocation:Vector3d = null;
        private var _maskCategory:String = "window";

        public function RoomObjectRoomMaskUpdateMessage(_arg_1:String, _arg_2:String, _arg_3:String=null, _arg_4:IVector3d=null, _arg_5:String="window")
        {
            super(null, null);
            _type = _arg_1;
            _maskId = _arg_2;
            _maskType = _arg_3;
            if (_arg_4 != null)
            {
                _maskLocation = new Vector3d(_arg_4.x, _arg_4.y, _arg_4.z);
            };
            _maskCategory = _arg_5;
        }

        public function get type():String
        {
            return (_type);
        }

        public function get maskId():String
        {
            return (_maskId);
        }

        public function get maskType():String
        {
            return (_maskType);
        }

        public function get maskLocation():IVector3d
        {
            return (_maskLocation);
        }

        public function get maskCategory():String
        {
            return (_maskCategory);
        }


    }
}