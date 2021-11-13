package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FriendData 
    {

        private var _id:int;
        private var _name:String;
        private var _gender:int;
        private var _online:Boolean;
        private var _followingAllowed:Boolean;
        private var _figure:String;
        private var _categoryId:int;
        private var _motto:String;
        private var _lastAccess:String;
        private var _realName:String;
        private var _facebookId:String;
        private var _persistedMessageUser:Boolean;
        private var _vipMember:Boolean;
        private var _pocketHabboUser:Boolean;
        private var _relationshipStatus:int;

        public function FriendData(_arg_1:IMessageDataWrapper)
        {
            this._id = _arg_1.readInteger();
            this._name = _arg_1.readString();
            this._gender = _arg_1.readInteger();
            this._online = _arg_1.readBoolean();
            this._followingAllowed = _arg_1.readBoolean();
            this._figure = _arg_1.readString();
            this._categoryId = _arg_1.readInteger();
            this._motto = _arg_1.readString();
            this._realName = _arg_1.readString();
            this._facebookId = _arg_1.readString();
            this._persistedMessageUser = _arg_1.readBoolean();
            this._vipMember = _arg_1.readBoolean();
            this._pocketHabboUser = _arg_1.readBoolean();
            this._relationshipStatus = _arg_1.readShort();
        }

        public function get id():int
        {
            return (_id);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get gender():int
        {
            return (_gender);
        }

        public function get online():Boolean
        {
            return (_online);
        }

        public function get followingAllowed():Boolean
        {
            return (_followingAllowed);
        }

        public function get figure():String
        {
            return (_figure);
        }

        public function get categoryId():int
        {
            return (_categoryId);
        }

        public function get motto():String
        {
            return (_motto);
        }

        public function get lastAccess():String
        {
            return (_lastAccess);
        }

        public function get realName():String
        {
            return (_realName);
        }

        public function get facebookId():String
        {
            return (_facebookId);
        }

        public function get persistedMessageUser():Boolean
        {
            return (_persistedMessageUser);
        }

        public function get vipMember():Boolean
        {
            return (_vipMember);
        }

        public function get pocketHabboUser():Boolean
        {
            return (_pocketHabboUser);
        }

        public function get relationshipStatus():int
        {
            return (_relationshipStatus);
        }


    }
}