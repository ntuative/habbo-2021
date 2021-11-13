package com.sulake.habbo.inventory.items
{
    import com.sulake.habbo.room.IStuffData;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.IFurnitureItemData;
    import flash.utils.getTimer;

    public class FurnitureItem implements IFurnitureItem 
    {

        private var _expirationTimeStamp:int;
        private var _isWallItem:Boolean;
        private var _songId:int;
        private var _locked:Boolean;
        private var _id:int;
        private var _ref:int;
        private var _category:int;
        private var _type:int;
        private var _stuffData:IStuffData;
        private var _extra:Number;
        private var _recyclable:Boolean;
        private var _tradeable:Boolean;
        private var _groupable:Boolean;
        private var _sellable:Boolean;
        private var _secondsToExpiration:int;
        private var _hasRentPeriodStarted:Boolean;
        private var _creationDay:int;
        private var _creationMonth:int;
        private var _creationYear:int;
        private var _slotId:String;
        private var _isRented:Boolean;
        private var _flatId:int;

        public function FurnitureItem(_arg_1:IFurnitureItemData)
        {
            _id = _arg_1.itemId;
            _type = _arg_1.itemTypeId;
            _ref = _arg_1.roomItemId;
            _category = _arg_1.category;
            _groupable = ((_arg_1.isGroupable) && (!(_arg_1.isRented)));
            _tradeable = _arg_1.isTradeable;
            _recyclable = _arg_1.isRecyclable;
            _sellable = _arg_1.isSellable;
            _stuffData = _arg_1.stuffData;
            _extra = _arg_1.extra;
            _secondsToExpiration = _arg_1.secondsToExpiration;
            _expirationTimeStamp = _arg_1.expirationTimeStamp;
            _hasRentPeriodStarted = _arg_1.hasRentPeriodStarted;
            _creationDay = _arg_1.creationDay;
            _creationMonth = _arg_1.creationMonth;
            _creationYear = _arg_1.creationYear;
            _slotId = _arg_1.slotId;
            _songId = _arg_1.songId;
            _flatId = _arg_1.flatId;
            _isRented = _arg_1.isRented;
            _isWallItem = _arg_1.isWallItem;
        }

        public function get isRented():Boolean
        {
            return (_isRented);
        }

        public function get id():int
        {
            return (_id);
        }

        public function get ref():int
        {
            return (_ref);
        }

        public function get category():int
        {
            return (_category);
        }

        public function get type():int
        {
            return (_type);
        }

        public function get stuffData():IStuffData
        {
            return (_stuffData);
        }

        public function set stuffData(_arg_1:IStuffData):void
        {
            _stuffData = _arg_1;
        }

        public function get extra():Number
        {
            return (_extra);
        }

        public function get recyclable():Boolean
        {
            return (_recyclable);
        }

        public function get tradeable():Boolean
        {
            return (_tradeable);
        }

        public function get groupable():Boolean
        {
            return (_groupable);
        }

        public function get sellable():Boolean
        {
            return (_sellable);
        }

        public function get secondsToExpiration():int
        {
            if (_secondsToExpiration == -1)
            {
                return (-1);
            };
            var _local_1:int = -1;
            if (_hasRentPeriodStarted)
            {
                _local_1 = int((_secondsToExpiration - ((getTimer() - _expirationTimeStamp) / 1000)));
                if (_local_1 < 0)
                {
                    _local_1 = 0;
                };
            }
            else
            {
                _local_1 = _secondsToExpiration;
            };
            return (_local_1);
        }

        public function get creationDay():int
        {
            return (_creationDay);
        }

        public function get creationMonth():int
        {
            return (_creationMonth);
        }

        public function get creationYear():int
        {
            return (_creationYear);
        }

        public function get slotId():String
        {
            return (_slotId);
        }

        public function get songId():int
        {
            return (_songId);
        }

        public function get locked():Boolean
        {
            return (_locked);
        }

        public function set locked(_arg_1:Boolean):void
        {
            _locked = _arg_1;
        }

        public function get flatId():int
        {
            return (_flatId);
        }

        public function get isWallItem():Boolean
        {
            return (_isWallItem);
        }

        public function get hasRentPeriodStarted():Boolean
        {
            return (_hasRentPeriodStarted);
        }

        public function get expirationTimeStamp():int
        {
            return (_expirationTimeStamp);
        }

        public function update(_arg_1:IFurnitureItemData):void
        {
            _type = _arg_1.itemTypeId;
            _ref = _arg_1.roomItemId;
            _category = _arg_1.category;
            _groupable = ((_arg_1.isGroupable) && (!(_arg_1.isRented)));
            _tradeable = _arg_1.isTradeable;
            _recyclable = _arg_1.isRecyclable;
            _sellable = _arg_1.isSellable;
            _stuffData = _arg_1.stuffData;
            _extra = _arg_1.extra;
            _secondsToExpiration = _arg_1.secondsToExpiration;
            _expirationTimeStamp = _arg_1.expirationTimeStamp;
            _hasRentPeriodStarted = _arg_1.hasRentPeriodStarted;
            _creationDay = _arg_1.creationDay;
            _creationMonth = _arg_1.creationMonth;
            _creationYear = _arg_1.creationYear;
            _slotId = _arg_1.slotId;
            _songId = _arg_1.songId;
            _flatId = _arg_1.flatId;
            _isRented = _arg_1.isRented;
            _isWallItem = _arg_1.isWallItem;
        }


    }
}