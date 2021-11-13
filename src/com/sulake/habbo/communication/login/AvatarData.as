package com.sulake.habbo.communication.login
{
    public class AvatarData 
    {

        private var _id:int;
        private var _uniqueId:String;
        private var _name:String;
        private var _motto:String;
        private var _figure:String;
        private var _gender:String;
        private var _head_figure:String;
        private var _last_access:int;
        private var _SafeStr_1698:Boolean;
        private var _SafeStr_1699:Boolean;
        private var _creationTime:String;

        public function AvatarData(_arg_1:Object)
        {
            if (_arg_1 != null)
            {
                _uniqueId = _arg_1.uniqueId;
                _name = _arg_1.name;
                _motto = _arg_1.motto;
                _figure = _arg_1.figureString;
                _gender = _arg_1.gender;
                _last_access = _arg_1.lastWebAccess;
                _SafeStr_1698 = (_arg_1.habboClubMember == "true");
                _SafeStr_1699 = (_arg_1.buildersClubMember == "true");
                _creationTime = _arg_1.creationTime;
            };
        }

        public function get id():int
        {
            return (_id);
        }

        public function set id(_arg_1:int):void
        {
            _id = _arg_1;
        }

        public function get uniqueId():String
        {
            return (_uniqueId);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get motto():String
        {
            return (_motto);
        }

        public function get figure():String
        {
            return (_figure);
        }

        public function get gender():String
        {
            return (_gender);
        }

        public function get head_figure():String
        {
            return (_head_figure);
        }

        public function get last_access():int
        {
            return (_last_access);
        }

        public function set name(_arg_1:String):void
        {
            _name = _arg_1;
        }


    }
}

