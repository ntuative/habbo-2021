package com.sulake.habbo.userclassification
{
    public class UserClassificationData 
    {

        public static var _SafeStr_4329:uint = 1;
        public static var _SafeStr_4330:uint = 2;
        public static var _SafeStr_4331:uint = 3;
        public static var PAYING_USER_CLASSIFICATION:uint = 4;

        private var _userId:int;
        private var _username:String;
        private var _classType:String;

        public function UserClassificationData(_arg_1:int, _arg_2:String, _arg_3:String)
        {
            _userId = _arg_1;
            _username = _arg_2;
            _classType = _arg_3;
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get username():String
        {
            return (_username);
        }

        public function get classType():String
        {
            return (_classType);
        }

        public function toString():String
        {
            return (((((("[" + _userId) + ", ") + _username) + "] [") + _classType) + "]");
        }


    }
}

