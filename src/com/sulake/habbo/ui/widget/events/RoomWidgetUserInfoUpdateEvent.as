package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetUserInfoUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const OWN_USER:String = "RWUIUE_OWN_USER";
        public static const BOT:String = "RWUIUE_BOT";
        public static const PEER:String = "RWUIUE_PEER";
        public static const TRADE_REASON_OK:int = 0;
        public static const TRADE_REASON_SHUTDOWN:int = 2;
        public static const TRADE_REASON_NO_TRADINGROOM:int = 3;
        public static const DEFAULT_BOT_BADGE_ID:String = "BOT";

        private var _name:String = "";
        private var _motto:String = "";
        private var _achievementScore:int;
        private var _webID:int = 0;
        private var _xp:int = 0;
        private var _userType:int;
        private var _figure:String = "";
        private var _badges:Array = [];
        private var _groupId:int = 0;
        private var _groupName:String = "";
        private var _groupBadgeId:String = "";
        private var _carryItem:int = 0;
        private var _userRoomId:int = 0;
        private var _isSpectatorMode:Boolean = false;
        private var _realName:String = "";
        private var _allowNameChange:Boolean = false;
        private var _amIOwner:Boolean = false;
        private var _amIAnyRoomController:Boolean = false;
        private var _myRoomControllerLevel:int = 0;
        private var _canBeAskedAsFriend:Boolean = false;
        private var _canBeKicked:Boolean = false;
        private var _canBeBanned:Boolean = false;
        private var _canBeMuted:Boolean = false;
        private var _respectLeft:int = 0;
        private var _isIgnored:Boolean = false;
        private var _isGuildRoom:Boolean = false;
        private var _canTrade:Boolean = false;
        private var _canTradeReason:int = 0;
        private var _targetRoomControllerLevel:int = 0;
        private var _isFriend:Boolean = false;
        private var _amIAnAmbassador:Boolean = false;

        public function RoomWidgetUserInfoUpdateEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        public function set name(_arg_1:String):void
        {
            _name = _arg_1;
        }

        public function get name():String
        {
            return (_name);
        }

        public function set motto(_arg_1:String):void
        {
            _motto = _arg_1;
        }

        public function get motto():String
        {
            return (_motto);
        }

        public function set achievementScore(_arg_1:int):void
        {
            _achievementScore = _arg_1;
        }

        public function get achievementScore():int
        {
            return (_achievementScore);
        }

        public function set webID(_arg_1:int):void
        {
            _webID = _arg_1;
        }

        public function get webID():int
        {
            return (_webID);
        }

        public function set xp(_arg_1:int):void
        {
            _xp = _arg_1;
        }

        public function get xp():int
        {
            return (_xp);
        }

        public function set userType(_arg_1:int):void
        {
            _userType = _arg_1;
        }

        public function get userType():int
        {
            return (_userType);
        }

        public function set figure(_arg_1:String):void
        {
            _figure = _arg_1;
        }

        public function get figure():String
        {
            return (_figure);
        }

        public function set badges(_arg_1:Array):void
        {
            _badges = _arg_1;
        }

        public function get badges():Array
        {
            return (_badges);
        }

        public function set groupId(_arg_1:int):void
        {
            _groupId = _arg_1;
        }

        public function get groupId():int
        {
            return (_groupId);
        }

        public function set groupName(_arg_1:String):void
        {
            _groupName = _arg_1;
        }

        public function get groupName():String
        {
            return (_groupName);
        }

        public function set groupBadgeId(_arg_1:String):void
        {
            _groupBadgeId = _arg_1;
        }

        public function get groupBadgeId():String
        {
            return (_groupBadgeId);
        }

        public function set canBeAskedAsFriend(_arg_1:Boolean):void
        {
            _canBeAskedAsFriend = _arg_1;
        }

        public function get canBeAskedAsFriend():Boolean
        {
            return (_canBeAskedAsFriend);
        }

        public function set respectLeft(_arg_1:int):void
        {
            _respectLeft = _arg_1;
        }

        public function get respectLeft():int
        {
            return (_respectLeft);
        }

        public function set isIgnored(_arg_1:Boolean):void
        {
            _isIgnored = _arg_1;
        }

        public function get isIgnored():Boolean
        {
            return (_isIgnored);
        }

        public function set amIOwner(_arg_1:Boolean):void
        {
            _amIOwner = _arg_1;
        }

        public function get amIOwner():Boolean
        {
            return (_amIOwner);
        }

        public function set isGuildRoom(_arg_1:Boolean):void
        {
            _isGuildRoom = _arg_1;
        }

        public function get isGuildRoom():Boolean
        {
            return (_isGuildRoom);
        }

        public function set myRoomControllerLevel(_arg_1:int):void
        {
            _myRoomControllerLevel = _arg_1;
        }

        public function get myRoomControllerLevel():int
        {
            return (_myRoomControllerLevel);
        }

        public function set amIAnyRoomController(_arg_1:Boolean):void
        {
            _amIAnyRoomController = _arg_1;
        }

        public function get amIAnyRoomController():Boolean
        {
            return (_amIAnyRoomController);
        }

        public function set canTrade(_arg_1:Boolean):void
        {
            _canTrade = _arg_1;
        }

        public function get canTrade():Boolean
        {
            return (_canTrade);
        }

        public function set canTradeReason(_arg_1:int):void
        {
            _canTradeReason = _arg_1;
        }

        public function get canTradeReason():int
        {
            return (_canTradeReason);
        }

        public function set canBeKicked(_arg_1:Boolean):void
        {
            _canBeKicked = _arg_1;
        }

        public function get canBeKicked():Boolean
        {
            return (_canBeKicked);
        }

        public function set canBeBanned(_arg_1:Boolean):void
        {
            _canBeBanned = _arg_1;
        }

        public function get canBeBanned():Boolean
        {
            return (_canBeBanned);
        }

        public function get canBeMuted():Boolean
        {
            return (_canBeMuted);
        }

        public function set canBeMuted(_arg_1:Boolean):void
        {
            _canBeMuted = _arg_1;
        }

        public function set targetRoomControllerLevel(_arg_1:int):void
        {
            _targetRoomControllerLevel = _arg_1;
        }

        public function get targetRoomControllerLevel():int
        {
            return (_targetRoomControllerLevel);
        }

        public function set carryItem(_arg_1:int):void
        {
            _carryItem = _arg_1;
        }

        public function get carryItem():int
        {
            return (_carryItem);
        }

        public function set userRoomId(_arg_1:int):void
        {
            _userRoomId = _arg_1;
        }

        public function get userRoomId():int
        {
            return (_userRoomId);
        }

        public function set isSpectatorMode(_arg_1:Boolean):void
        {
            _isSpectatorMode = _arg_1;
        }

        public function get isSpectatorMode():Boolean
        {
            return (_isSpectatorMode);
        }

        public function set realName(_arg_1:String):void
        {
            _realName = _arg_1;
        }

        public function get realName():String
        {
            return (_realName);
        }

        public function set allowNameChange(_arg_1:Boolean):void
        {
            _allowNameChange = _arg_1;
        }

        public function get allowNameChange():Boolean
        {
            return (_allowNameChange);
        }

        public function get isFriend():Boolean
        {
            return (_isFriend);
        }

        public function set isFriend(_arg_1:Boolean):void
        {
            _isFriend = _arg_1;
        }

        public function get amIAnAmbassador():Boolean
        {
            return (_amIAnAmbassador);
        }

        public function set amIAnAmbassador(_arg_1:Boolean):void
        {
            _amIAnAmbassador = _arg_1;
        }


    }
}