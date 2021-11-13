package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionPetFigureUpdateEvent extends RoomSessionEvent 
    {

        public static const PET_FIGURE_UPDATE:String = "RSPFUE_PET_FIGURE_UPDATE";

        private var _petId:int;
        private var _figure:String;

        public function RoomSessionPetFigureUpdateEvent(_arg_1:IRoomSession, _arg_2:int, _arg_3:String, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super("RSPFUE_PET_FIGURE_UPDATE", _arg_1, _arg_4, _arg_5);
            _petId = _arg_2;
            _figure = _arg_3;
        }

        public function get petId():int
        {
            return (_petId);
        }

        public function get figure():String
        {
            return (_figure);
        }


    }
}