package com.sulake.habbo.session.events
{
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetFigureData;
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionPetPackageEvent extends RoomSessionEvent 
    {

        public static const ROOM_SESSION_OPEN_PET_PACKAGE_REQUESTED:String = "RSOPPE_OPEN_PET_PACKAGE_REQUESTED";
        public static const ROOM_SESSION_OPEN_PET_PACKAGE_RESULT:String = "RSOPPE_OPEN_PET_PACKAGE_RESULT";

        private var _objectId:int = -1;
        private var _figureData:PetFigureData;
        private var _nameValidationStatus:int = 0;
        private var _nameValidationInfo:String = null;

        public function RoomSessionPetPackageEvent(_arg_1:String, _arg_2:IRoomSession, _arg_3:int, _arg_4:PetFigureData, _arg_5:int, _arg_6:String, _arg_7:Boolean=false, _arg_8:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_7, _arg_8);
            _objectId = _arg_3;
            _figureData = _arg_4;
            _nameValidationStatus = _arg_5;
            _nameValidationInfo = _arg_6;
        }

        public function get objectId():int
        {
            return (_objectId);
        }

        public function get figureData():PetFigureData
        {
            return (_figureData);
        }

        public function get nameValidationStatus():int
        {
            return (_nameValidationStatus);
        }

        public function get nameValidationInfo():String
        {
            return (_nameValidationInfo);
        }


    }
}