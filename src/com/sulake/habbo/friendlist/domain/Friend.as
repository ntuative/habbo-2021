package com.sulake.habbo.friendlist.domain
{
    import com.sulake.habbo.friendlist.IFriend;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;

    public class Friend implements IFriend, IDisposable 
    {

        public static const GENDER_FEMALE:int = "F".charCodeAt(0);
        public static const GENDER_MALE:int = "M".charCodeAt(0);

        private var _id:int;
        private var _name:String;
        private var _gender:int;
        private var _online:Boolean;
        private var _followingAllowed:Boolean;
        private var _figure:String;
        private var _motto:String;
        private var _lastAccess:String;
        private var _categoryId:int;
        private var _selected:Boolean;
        private var _disposed:Boolean;
        private var _view:IWindowContainer;
        private var _face:BitmapData;
        private var _realName:String;
        private var _persistedMessageUser:Boolean;
        private var _pocketHabboUser:Boolean;
        private var _vipMember:Boolean;
        private var _relationshipStatus:int;

        public function Friend(_arg_1:FriendData)
        {
            if (_arg_1 == null)
            {
                return;
            };
            _id = _arg_1.id;
            _name = _arg_1.name;
            _gender = _arg_1.gender;
            _online = _arg_1.online;
            _followingAllowed = ((_arg_1.followingAllowed) && (_arg_1.online));
            _figure = _arg_1.figure;
            _motto = _arg_1.motto;
            _lastAccess = _arg_1.lastAccess;
            _categoryId = _arg_1.categoryId;
            _realName = _arg_1.realName;
            _persistedMessageUser = _arg_1.persistedMessageUser;
            _vipMember = _arg_1.vipMember;
            _pocketHabboUser = _arg_1.pocketHabboUser;
            _relationshipStatus = _arg_1.relationshipStatus;
            Logger.log(((((((((((((("Creating friend: " + id) + ", ") + name) + ", ") + gender) + ", ") + online) + ", ") + followingAllowed) + ", ") + figure) + ", ") + categoryId));
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            if (_face != null)
            {
                _face.dispose();
                _face = null;
            };
            _disposed = true;
            _view = null;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
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

        public function get motto():String
        {
            return (_motto);
        }

        public function get lastAccess():String
        {
            return (_lastAccess);
        }

        public function get categoryId():int
        {
            return (_categoryId);
        }

        public function get selected():Boolean
        {
            return (_selected);
        }

        public function get view():IWindowContainer
        {
            return (_view);
        }

        public function get face():BitmapData
        {
            return (_face);
        }

        public function get realName():String
        {
            return (_realName);
        }

        public function get persistedMessageUser():Boolean
        {
            return (_persistedMessageUser);
        }

        public function get pocketHabboUser():Boolean
        {
            return (_pocketHabboUser);
        }

        public function get relationshipStatus():int
        {
            return (_relationshipStatus);
        }

        public function get vipMember():Boolean
        {
            return (_vipMember);
        }

        public function set id(_arg_1:int):void
        {
            _id = _arg_1;
        }

        public function set name(_arg_1:String):void
        {
            _name = _arg_1;
        }

        public function set gender(_arg_1:int):void
        {
            _gender = _arg_1;
        }

        public function set online(_arg_1:Boolean):void
        {
            _online = _arg_1;
        }

        public function set followingAllowed(_arg_1:Boolean):void
        {
            _followingAllowed = _arg_1;
        }

        public function set figure(_arg_1:String):void
        {
            _figure = _arg_1;
        }

        public function set motto(_arg_1:String):void
        {
            _motto = _arg_1;
        }

        public function set lastAccess(_arg_1:String):void
        {
            _lastAccess = _arg_1;
        }

        public function set categoryId(_arg_1:int):void
        {
            _categoryId = _arg_1;
        }

        public function set selected(_arg_1:Boolean):void
        {
            _selected = _arg_1;
        }

        public function set view(_arg_1:IWindowContainer):void
        {
            _view = _arg_1;
        }

        public function set face(_arg_1:BitmapData):void
        {
            _face = _arg_1;
        }

        public function set realName(_arg_1:String):void
        {
            _realName = _arg_1;
        }

        public function set persistedMessageUser(_arg_1:Boolean):void
        {
            _persistedMessageUser = _arg_1;
        }

        public function set pocketHabboUser(_arg_1:Boolean):void
        {
            _pocketHabboUser = _arg_1;
        }

        public function set vipMember(_arg_1:Boolean):void
        {
            _vipMember = _arg_1;
        }

        public function isGroupFriend():Boolean
        {
            return (_id < 0);
        }


    }
}

