package com.sulake.habbo.ui.widget.events
{
    import flash.display.BitmapData;

    public class RoomWidgetPetPackageUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const _SafeStr_4040:String = "RWOPPUE_OPEN_PET_PACKAGE_REQUESTED";
        public static const OPEN_PET_PACKAGE_RESULT:String = "RWOPPUE_OPEN_PET_PACKAGE_RESULT";
        public static const OPEN_PET_PACKAGE_UPDATE_PET_IMAGE:String = "RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE";

        private var _objectId:int = -1;
        private var _typeId:int = -1;
        private var _image:BitmapData = null;
        private var _nameValidationStatus:int = 0;
        private var _nameValidationInfo:String = null;

        public function RoomWidgetPetPackageUpdateEvent(_arg_1:String, _arg_2:int, _arg_3:BitmapData, _arg_4:int, _arg_5:String, _arg_6:int, _arg_7:Boolean=false, _arg_8:Boolean=false)
        {
            super(_arg_1, _arg_7, _arg_8);
            _objectId = _arg_2;
            _image = _arg_3;
            _nameValidationStatus = _arg_4;
            _nameValidationInfo = _arg_5;
            _typeId = _arg_6;
        }

        public function get nameValidationStatus():int
        {
            return (_nameValidationStatus);
        }

        public function get nameValidationInfo():String
        {
            return (_nameValidationInfo);
        }

        public function get image():BitmapData
        {
            return (_image);
        }

        public function get objectId():int
        {
            return (_objectId);
        }

        public function get typeId():int
        {
            return (_typeId);
        }


    }
}

