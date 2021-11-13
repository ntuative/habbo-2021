package com.sulake.habbo.ui.widget.avatarinfo
{
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;

    public class AvatarInfoData 
    {

        private var _isIgnored:Boolean = false;
        private var _canTrade:Boolean = false;
        private var _canTradeReason:int = 0;
        private var _canBeKicked:Boolean = false;
        private var _canBeBanned:Boolean = false;
        private var _canBeMuted:Boolean = false;
        private var _canBeAskedAsFriend:Boolean = false;
        private var _amIOwner:Boolean = false;
        private var _amIAnyRoomController:Boolean = false;
        private var _respectLeft:int = 0;
        private var _isOwnUser:Boolean = false;
        private var _allowNameChange:Boolean = false;
        private var _isGuildRoom:Boolean = false;
        private var _carryItemType:int = 0;
        private var _myRoomControllerLevel:int = 0;
        private var _targetRoomControllerLevel:int = 0;
        private var _isFriend:Boolean = false;
        private var _isAmbassador:Boolean = false;


        public function get isIgnored():Boolean
        {
            return (_isIgnored);
        }

        public function get canTrade():Boolean
        {
            return (_canTrade);
        }

        public function get canTradeReason():int
        {
            return (_canTradeReason);
        }

        public function get canBeKicked():Boolean
        {
            return (_canBeKicked);
        }

        public function get canBeBanned():Boolean
        {
            return (_canBeBanned);
        }

        public function get canBeAskedAsFriend():Boolean
        {
            return (_canBeAskedAsFriend);
        }

        public function get amIOwner():Boolean
        {
            return (_amIOwner);
        }

        public function get amIAnyRoomController():Boolean
        {
            return (_amIAnyRoomController);
        }

        public function get respectLeft():int
        {
            return (_respectLeft);
        }

        public function get isOwnUser():Boolean
        {
            return (_isOwnUser);
        }

        public function get allowNameChange():Boolean
        {
            return (_allowNameChange);
        }

        public function get isGuildRoom():Boolean
        {
            return (_isGuildRoom);
        }

        public function get carryItemType():int
        {
            return (_carryItemType);
        }

        public function get myRoomControllerLevel():int
        {
            return (_myRoomControllerLevel);
        }

        public function get targetRoomControllerLevel():int
        {
            return (_targetRoomControllerLevel);
        }

        public function set isIgnored(_arg_1:Boolean):void
        {
            _isIgnored = _arg_1;
        }

        public function set canTrade(_arg_1:Boolean):void
        {
            _canTrade = _arg_1;
        }

        public function set canTradeReason(_arg_1:int):void
        {
            _canTradeReason = _arg_1;
        }

        public function set canBeKicked(_arg_1:Boolean):void
        {
            _canBeKicked = _arg_1;
        }

        public function set canBeBanned(_arg_1:Boolean):void
        {
            _canBeBanned = _arg_1;
        }

        public function get canBeMuted():Boolean
        {
            return (_canBeMuted);
        }

        public function set canBeMuted(_arg_1:Boolean):void
        {
            _canBeMuted = _arg_1;
        }

        public function set canBeAskedAsFriend(_arg_1:Boolean):void
        {
            _canBeAskedAsFriend = _arg_1;
        }

        public function set amIOwner(_arg_1:Boolean):void
        {
            _amIOwner = _arg_1;
        }

        public function set amIAnyRoomController(_arg_1:Boolean):void
        {
            _amIAnyRoomController = _arg_1;
        }

        public function set respectLeft(_arg_1:int):void
        {
            _respectLeft = _arg_1;
        }

        public function set isOwnUser(_arg_1:Boolean):void
        {
            _isOwnUser = _arg_1;
        }

        public function set allowNameChange(_arg_1:Boolean):void
        {
            _allowNameChange = _arg_1;
        }

        public function set isGuildRoom(_arg_1:Boolean):void
        {
            _isGuildRoom = _arg_1;
        }

        public function set carryItemType(_arg_1:int):void
        {
            _carryItemType = _arg_1;
        }

        public function set myRoomControllerLevel(_arg_1:int):void
        {
            _myRoomControllerLevel = _arg_1;
        }

        public function set targetRoomControllerLevel(_arg_1:int):void
        {
            _targetRoomControllerLevel = _arg_1;
        }

        public function get isFriend():Boolean
        {
            return (_isFriend);
        }

        public function get isAmbassador():Boolean
        {
            return (_isAmbassador);
        }

        public function populate(_arg_1:RoomWidgetUserInfoUpdateEvent):void
        {
            _amIAnyRoomController = _arg_1.amIAnyRoomController;
            _myRoomControllerLevel = _arg_1.myRoomControllerLevel;
            _amIOwner = _arg_1.amIOwner;
            _canBeAskedAsFriend = _arg_1.canBeAskedAsFriend;
            _canBeKicked = _arg_1.canBeKicked;
            _canBeBanned = _arg_1.canBeBanned;
            _canBeMuted = _arg_1.canBeMuted;
            _canTrade = _arg_1.canTrade;
            _canTradeReason = _arg_1.canTradeReason;
            _isIgnored = _arg_1.isIgnored;
            _respectLeft = _arg_1.respectLeft;
            _isOwnUser = (_arg_1.type == "RWUIUE_OWN_USER");
            _allowNameChange = _arg_1.allowNameChange;
            _isGuildRoom = _arg_1.isGuildRoom;
            _targetRoomControllerLevel = _arg_1.targetRoomControllerLevel;
            _carryItemType = _arg_1.carryItem;
            _isFriend = _arg_1.isFriend;
            _isAmbassador = _arg_1.amIAnAmbassador;
        }


    }
}