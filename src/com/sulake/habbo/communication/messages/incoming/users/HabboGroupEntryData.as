package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class HabboGroupEntryData 
    {

        private var _groupId:int;
        private var _groupName:String;
        private var _badgeCode:String;
        private var _primaryColor:String;
        private var _secondaryColor:String;
        private var _favourite:Boolean;
        private var _ownerId:int;
        private var _hasForum:Boolean;

        public function HabboGroupEntryData(_arg_1:IMessageDataWrapper)
        {
            _groupId = _arg_1.readInteger();
            _groupName = _arg_1.readString();
            _badgeCode = _arg_1.readString();
            _primaryColor = _arg_1.readString();
            _secondaryColor = _arg_1.readString();
            _favourite = _arg_1.readBoolean();
            _ownerId = _arg_1.readInteger();
            _hasForum = _arg_1.readBoolean();
        }

        public function get groupId():int
        {
            return (_groupId);
        }

        public function get groupName():String
        {
            return (_groupName);
        }

        public function get badgeCode():String
        {
            return (_badgeCode);
        }

        public function get primaryColor():String
        {
            return (_primaryColor);
        }

        public function get secondaryColor():String
        {
            return (_secondaryColor);
        }

        public function get favourite():Boolean
        {
            return (_favourite);
        }

        public function get ownerId():int
        {
            return (_ownerId);
        }

        public function get hasForum():Boolean
        {
            return (_hasForum);
        }


    }
}