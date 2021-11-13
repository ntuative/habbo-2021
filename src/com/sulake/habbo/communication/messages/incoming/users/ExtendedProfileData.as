package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ExtendedProfileData 
    {

        private var _userId:int;
        private var _userName:String;
        private var _figure:String;
        private var _motto:String;
        private var _creationDate:String;
        private var _achievementScore:int;
        private var _friendCount:int;
        private var _isFriend:Boolean;
        private var _isFriendRequestSent:Boolean;
        private var _isOnline:Boolean;
        private var _guilds:Array = [];
        private var _lastAccessSinceInSeconds:int;
        private var _openProfileWindow:Boolean;
        private var _SafeStr_1848:Boolean;
        private var _accountLevel:int;
        private var _SafeStr_1849:int;
        private var _starGemCount:int;
        private var _SafeStr_1850:Boolean;
        private var _SafeStr_1851:Boolean;

        public function ExtendedProfileData(_arg_1:IMessageDataWrapper)
        {
            var _local_3:int;
            super();
            _userId = _arg_1.readInteger();
            _userName = _arg_1.readString();
            _figure = _arg_1.readString();
            _motto = _arg_1.readString();
            _creationDate = _arg_1.readString();
            _achievementScore = _arg_1.readInteger();
            _friendCount = _arg_1.readInteger();
            _isFriend = _arg_1.readBoolean();
            _isFriendRequestSent = _arg_1.readBoolean();
            _isOnline = _arg_1.readBoolean();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _guilds.push(new HabboGroupEntryData(_arg_1));
                _local_3++;
            };
            _lastAccessSinceInSeconds = _arg_1.readInteger();
            _openProfileWindow = _arg_1.readBoolean();
            if (_arg_1.bytesAvailable)
            {
                _SafeStr_1848 = _arg_1.readBoolean();
                _accountLevel = _arg_1.readInteger();
                _SafeStr_1849 = _arg_1.readInteger();
                _starGemCount = _arg_1.readInteger();
                _SafeStr_1850 = _arg_1.readBoolean();
                _SafeStr_1851 = _arg_1.readBoolean();
            };
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get userName():String
        {
            return (_userName);
        }

        public function get motto():String
        {
            return (_motto);
        }

        public function get figure():String
        {
            return (_figure);
        }

        public function get creationDate():String
        {
            return (_creationDate);
        }

        public function get achievementScore():int
        {
            return (_achievementScore);
        }

        public function get friendCount():int
        {
            return (_friendCount);
        }

        public function get isFriend():Boolean
        {
            return (_isFriend);
        }

        public function get isFriendRequestSent():Boolean
        {
            return (_isFriendRequestSent);
        }

        public function get isOnline():Boolean
        {
            return (_isOnline);
        }

        public function get guilds():Array
        {
            return (_guilds);
        }

        public function set isFriendRequestSent(_arg_1:Boolean):void
        {
            _isFriendRequestSent = _arg_1;
        }

        public function get lastAccessSinceInSeconds():int
        {
            return (_lastAccessSinceInSeconds);
        }

        public function get openProfileWindow():Boolean
        {
            return (_openProfileWindow);
        }

        public function get accountLevel():int
        {
            return (_accountLevel);
        }

        public function get starGemCount():int
        {
            return (_starGemCount);
        }


    }
}

