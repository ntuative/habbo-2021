package com.sulake.habbo.ui.widget.events
{
    import flash.display.BitmapData;

    public class RoomWidgetPetFigureUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const PET_FIGURE_UPDATE:String = "RWPIUE_PET_FIGURE_UPDATE";

        private var _petId:int;
        private var _image:BitmapData;

        public function RoomWidgetPetFigureUpdateEvent(_arg_1:int, _arg_2:BitmapData, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super("RWPIUE_PET_FIGURE_UPDATE", _arg_3, _arg_4);
            _petId = _arg_1;
            _image = _arg_2;
        }

        public function get petId():int
        {
            return (_petId);
        }

        public function get image():BitmapData
        {
            return (_image);
        }


    }
}