package com.sulake.habbo.ui.widget.camera
{
    import flash.display.BitmapData;

    public class CameraSlotData 
    {

        public var image:BitmapData;
        private var _SafeStr_3952:Date;
        public var isEmpty:Boolean;


        public function setDate(_arg_1:Date):void
        {
            _SafeStr_3952 = _arg_1;
        }

        public function get dateString():String
        {
            return ((((((((_SafeStr_3952.date + "/") + (_SafeStr_3952.month + 1)) + "/") + _SafeStr_3952.getFullYear()) + " ") + _SafeStr_3952.getHours()) + ":") + addLeadingZero(_SafeStr_3952.getMinutes()));
        }

        private function addLeadingZero(_arg_1:int):String
        {
            var _local_2:String = _arg_1.toString();
            if (_local_2.length == 1)
            {
                _local_2 = ("0" + _local_2);
            };
            return (_local_2);
        }

        public function getDateTimestamp():int
        {
            return (_SafeStr_3952.time);
        }


    }
}

