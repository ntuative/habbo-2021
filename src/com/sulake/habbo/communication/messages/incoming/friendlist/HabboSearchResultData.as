package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class HabboSearchResultData 
    {

        private var _SafeStr_1722:int;
        private var _avatarName:String;
        private var _SafeStr_1723:String;
        private var _SafeStr_1724:Boolean;
        private var _SafeStr_1725:Boolean;
        private var _SafeStr_1726:int;
        private var _SafeStr_1727:String;
        private var _SafeStr_1728:String;
        private var _realName:String;

        public function HabboSearchResultData(_arg_1:IMessageDataWrapper)
        {
            this._SafeStr_1722 = _arg_1.readInteger();
            this._avatarName = _arg_1.readString();
            this._SafeStr_1723 = _arg_1.readString();
            this._SafeStr_1724 = _arg_1.readBoolean();
            this._SafeStr_1725 = _arg_1.readBoolean();
            _arg_1.readString();
            this._SafeStr_1726 = _arg_1.readInteger();
            this._SafeStr_1727 = _arg_1.readString();
            this._realName = _arg_1.readString();
        }

        public function get avatarId():int
        {
            return (this._SafeStr_1722);
        }

        public function get avatarName():String
        {
            return (this._avatarName);
        }

        public function get avatarMotto():String
        {
            return (this._SafeStr_1723);
        }

        public function get isAvatarOnline():Boolean
        {
            return (this._SafeStr_1724);
        }

        public function get canFollow():Boolean
        {
            return (this._SafeStr_1725);
        }

        public function get avatarGender():int
        {
            return (this._SafeStr_1726);
        }

        public function get avatarFigure():String
        {
            return (this._SafeStr_1727);
        }

        public function get lastOnlineDate():String
        {
            return (this._SafeStr_1728);
        }

        public function get realName():String
        {
            return (this._realName);
        }


    }
}

