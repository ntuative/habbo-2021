package com.sulake.habbo.room.object
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;

    public class RoomPlaneBitmapMaskData 
    {

        public static const MASK_CATEGORY_WINDOW:String = "window";
        public static const MASK_CATEGORY_HOLE:String = "hole";

        private var _loc:Vector3d = null;
        private var _type:String = null;
        private var _category:String = null;

        public function RoomPlaneBitmapMaskData(_arg_1:String, _arg_2:IVector3d, _arg_3:String)
        {
            this.type = _arg_1;
            this.loc = _arg_2;
            this.category = _arg_3;
        }

        public function get loc():IVector3d
        {
            return (_loc);
        }

        public function set loc(_arg_1:IVector3d):void
        {
            if (_loc == null)
            {
                _loc = new Vector3d();
            };
            _loc.assign(_arg_1);
        }

        public function get type():String
        {
            return (_type);
        }

        public function set type(_arg_1:String):void
        {
            _type = _arg_1;
        }

        public function get category():String
        {
            return (_category);
        }

        public function set category(_arg_1:String):void
        {
            _category = _arg_1;
        }

        public function dispose():void
        {
            _loc = null;
        }


    }
}