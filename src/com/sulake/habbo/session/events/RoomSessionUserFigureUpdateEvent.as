package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionUserFigureUpdateEvent extends RoomSessionEvent 
    {

        public static const USER_FIGURE:String = "RSUBE_FIGURE";

        private var _userId:int = 0;
        private var _figure:String = "";
        private var _gender:String = "";
        private var _customInfo:String = "";
        private var _achievementScore:int;

        public function RoomSessionUserFigureUpdateEvent(_arg_1:IRoomSession, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:int, _arg_7:Boolean=false, _arg_8:Boolean=false)
        {
            super("RSUBE_FIGURE", _arg_1, _arg_7, _arg_8);
            _userId = _arg_2;
            _figure = _arg_3;
            _gender = _arg_4;
            _customInfo = _arg_5;
            _achievementScore = _arg_6;
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get figure():String
        {
            return (_figure);
        }

        public function get gender():String
        {
            return (_gender);
        }

        public function get customInfo():String
        {
            return (_customInfo);
        }

        public function get achievementScore():int
        {
            return (_achievementScore);
        }


    }
}