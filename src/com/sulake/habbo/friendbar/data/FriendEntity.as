package com.sulake.habbo.friendbar.data
{
    import __AS3__.vec.Vector;

    public class FriendEntity implements IFriendEntity 
    {

        private static var ROLLING_LOG_EVENT_ID:int = 0;

        private var _id:int;
        private var _name:String;
        private var _gender:int;
        private var _online:Boolean;
        private var _allowFollow:Boolean;
        private var _figure:String;
        private var _categoryId:int;
        private var _motto:String;
        private var _lastAccess:String;
        private var _realName:String;
        private var _notifications:Vector.<IFriendNotification>;
        private var _logEventId:int = -1;

        public function FriendEntity(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:int, _arg_6:Boolean, _arg_7:Boolean, _arg_8:String, _arg_9:int, _arg_10:String)
        {
            _id = _arg_1;
            _name = _arg_2;
            _realName = _arg_3;
            _motto = _arg_4;
            _gender = _arg_5;
            _online = _arg_6;
            _allowFollow = _arg_7;
            _figure = _arg_8;
            _categoryId = _arg_9;
            _lastAccess = _arg_10;
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

        public function get allowFollow():Boolean
        {
            return (_allowFollow);
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

        public function get logEventId():int
        {
            return (_logEventId);
        }

        public function get notifications():Vector.<IFriendNotification>
        {
            if (!_notifications)
            {
                _notifications = new Vector.<IFriendNotification>();
            };
            return (_notifications);
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

        public function set allowFollow(_arg_1:Boolean):void
        {
            _allowFollow = _arg_1;
        }

        public function set figure(_arg_1:String):void
        {
            _figure = _arg_1;
        }

        public function set categoryId(_arg_1:int):void
        {
            _categoryId = _arg_1;
        }

        public function set motto(_arg_1:String):void
        {
            _motto = _arg_1;
        }

        public function set lastAccess(_arg_1:String):void
        {
            _lastAccess = _arg_1;
        }

        public function set realName(_arg_1:String):void
        {
            _realName = _arg_1;
        }

        public function set logEventId(_arg_1:int):void
        {
            _logEventId = _arg_1;
        }

        public function getNextLogEventId():int
        {
            return (++ROLLING_LOG_EVENT_ID);
        }


    }
}