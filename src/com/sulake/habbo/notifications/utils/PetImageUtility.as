package com.sulake.habbo.notifications.utils
{
    import com.sulake.habbo.room.IRoomEngine;
    import flash.display.BitmapData;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.room._SafeStr_147;

    public class PetImageUtility 
    {

        private static var _roomEngine:IRoomEngine;

        public function PetImageUtility(_arg_1:IRoomEngine)
        {
            _roomEngine = _arg_1;
        }

        public function dispose():void
        {
            _roomEngine = null;
        }

        public function getPetImage(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int=3, _arg_5:Boolean=false, _arg_6:int=32, _arg_7:String=null):BitmapData
        {
            if (_roomEngine == null)
            {
                Logger.log("Pet Image Utility; Pet image creation failed: Room engine is not defined");
                return (null);
            };
            var _local_8:BitmapData;
            if (((_arg_1 < 0) || (_arg_2 < 0)))
            {
                return (_local_8);
            };
            var _local_9:uint = parseInt(_arg_3, 16);
            var _local_10:uint;
            var _local_11:_SafeStr_147 = _roomEngine.getPetImage(_arg_1, _arg_2, _local_9, new Vector3d((45 * _arg_4)), _arg_6, null, _arg_5, _local_10, null, _arg_7);
            if (_local_11 != null)
            {
                _local_8 = _local_11.data;
            };
            return (_local_8);
        }


    }
}

