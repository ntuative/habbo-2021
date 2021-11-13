package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetSelectOutfitMessage extends RoomWidgetMessage 
    {

        public static const SELECT_OUTFIT:String = "select_outfit";

        private var _outfitId:int;

        public function RoomWidgetSelectOutfitMessage(_arg_1:int)
        {
            super("select_outfit");
            _outfitId = _arg_1;
        }

        public function get outfitId():int
        {
            return (_outfitId);
        }


    }
}