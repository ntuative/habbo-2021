package com.sulake.habbo.room.events
{
    import com.sulake.room.events.RoomObjectMouseEvent;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.utils.IVector3d;

    public class RoomObjectWallMouseEvent extends RoomObjectMouseEvent 
    {

        private var _x:Number;
        private var _y:Number;
        private var _direction:Number;
        private var _wallLocation:Vector3d = null;
        private var _wallWidth:Vector3d = null;
        private var _wallHeight:Vector3d = null;

        public function RoomObjectWallMouseEvent(_arg_1:String, _arg_2:IRoomObject, _arg_3:String, _arg_4:IVector3d, _arg_5:IVector3d, _arg_6:IVector3d, _arg_7:Number, _arg_8:Number, _arg_9:Number, _arg_10:Boolean=false, _arg_11:Boolean=false, _arg_12:Boolean=false, _arg_13:Boolean=false, _arg_14:Boolean=false, _arg_15:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_10, _arg_11, _arg_12, _arg_13, _arg_14, _arg_15);
            _wallLocation = new Vector3d();
            _wallLocation.assign(_arg_4);
            _wallWidth = new Vector3d();
            _wallWidth.assign(_arg_5);
            _wallHeight = new Vector3d();
            _wallHeight.assign(_arg_6);
            _x = _arg_7;
            _y = _arg_8;
            _direction = _arg_9;
        }

        public function get wallLocation():IVector3d
        {
            return (_wallLocation);
        }

        public function get wallWidth():IVector3d
        {
            return (_wallWidth);
        }

        public function get wallHeight():IVector3d
        {
            return (_wallHeight);
        }

        public function get x():Number
        {
            return (_x);
        }

        public function get y():Number
        {
            return (_y);
        }

        public function get direction():Number
        {
            return (_direction);
        }


    }
}