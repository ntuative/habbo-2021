package com.sulake.habbo.communication.messages.incoming.room.pets
{
        public class PetBreedingResultData 
    {

        private var _stuffId:int;
        private var _classId:int;
        private var _productCode:String;
        private var _userId:int;
        private var _userName:String;
        private var _rarityLevel:int;
        private var _hasMutation:Boolean;

        public function PetBreedingResultData(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:String, _arg_6:int, _arg_7:Boolean)
        {
            _stuffId = _arg_1;
            _classId = _arg_2;
            _productCode = _arg_3;
            _userId = _arg_4;
            _userName = _arg_5;
            _rarityLevel = _arg_6;
            _hasMutation = _arg_7;
        }

        public function get stuffId():int
        {
            return (_stuffId);
        }

        public function get classId():int
        {
            return (_classId);
        }

        public function get productCode():String
        {
            return (_productCode);
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get userName():String
        {
            return (_userName);
        }

        public function get rarityLevel():int
        {
            return (_rarityLevel);
        }

        public function get hasMutation():Boolean
        {
            return (_hasMutation);
        }


    }
}