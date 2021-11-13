package com.sulake.habbo.ui.widget.events
{
    import flash.display.BitmapData;
    import com.sulake.habbo.room.IStuffData;

    public class RoomWidgetFurniInfoUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const FURNI:String = "RWFIUE_FURNI";

        private var _id:int = 0;
        private var _category:int = 0;
        private var _name:String = "";
        private var _description:String = "";
        private var _image:BitmapData = null;
        private var _isWallItem:Boolean = false;
        private var _isStickie:Boolean = false;
        private var _isRoomOwner:Boolean = false;
        private var _roomControllerLevel:int = 0;
        private var _isAnyRoomController:Boolean = false;
        private var _expiration:int = -1;
        private var _SafeStr_4035:int = -1;
        private var _purchaseOfferId:int = -1;
        private var _extraParam:String = "";
        private var _isOwner:Boolean = false;
        private var _stuffData:IStuffData = null;
        private var _groupId:int = 0;
        private var _ownerId:int = 0;
        private var _ownerName:String = "";
        private var _usagePolicy:int = 0;
        private var _SafeStr_4036:int = -1;
        private var _rentOfferId:int = -1;
        private var _purchaseCouldBeUsedForBuyout:Boolean;
        private var _rentCouldBeUsedForBuyout:Boolean;
        private var _availableForBuildersClub:Boolean;

        public function RoomWidgetFurniInfoUpdateEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        public function set id(_arg_1:int):void
        {
            _id = _arg_1;
        }

        public function get id():int
        {
            return (_id);
        }

        public function set category(_arg_1:int):void
        {
            _category = _arg_1;
        }

        public function get category():int
        {
            return (_category);
        }

        public function set name(_arg_1:String):void
        {
            _name = _arg_1;
        }

        public function get name():String
        {
            return (_name);
        }

        public function set description(_arg_1:String):void
        {
            _description = _arg_1;
        }

        public function get description():String
        {
            return (_description);
        }

        public function set image(_arg_1:BitmapData):void
        {
            _image = _arg_1;
        }

        public function get image():BitmapData
        {
            return (_image);
        }

        public function set isWallItem(_arg_1:Boolean):void
        {
            _isWallItem = _arg_1;
        }

        public function get isWallItem():Boolean
        {
            return (_isWallItem);
        }

        public function set isStickie(_arg_1:Boolean):void
        {
            _isStickie = _arg_1;
        }

        public function get isStickie():Boolean
        {
            return (_isStickie);
        }

        public function set isRoomOwner(_arg_1:Boolean):void
        {
            _isRoomOwner = _arg_1;
        }

        public function get isRoomOwner():Boolean
        {
            return (_isRoomOwner);
        }

        public function set roomControllerLevel(_arg_1:int):void
        {
            _roomControllerLevel = _arg_1;
        }

        public function get roomControllerLevel():int
        {
            return (_roomControllerLevel);
        }

        public function set isAnyRoomController(_arg_1:Boolean):void
        {
            _isAnyRoomController = _arg_1;
        }

        public function get isAnyRoomController():Boolean
        {
            return (_isAnyRoomController);
        }

        public function set expiration(_arg_1:int):void
        {
            _expiration = _arg_1;
        }

        public function get expiration():int
        {
            return (_expiration);
        }

        public function set purchaseOfferId(_arg_1:int):void
        {
            _purchaseOfferId = _arg_1;
        }

        public function get purchaseOfferId():int
        {
            return (_purchaseOfferId);
        }

        public function set extraParam(_arg_1:String):void
        {
            _extraParam = _arg_1;
        }

        public function get extraParam():String
        {
            return (_extraParam);
        }

        public function set isOwner(_arg_1:Boolean):void
        {
            _isOwner = _arg_1;
        }

        public function get isOwner():Boolean
        {
            return (_isOwner);
        }

        public function set stuffData(_arg_1:IStuffData):void
        {
            _stuffData = _arg_1;
        }

        public function get stuffData():IStuffData
        {
            return (_stuffData);
        }

        public function set groupId(_arg_1:int):void
        {
            _groupId = _arg_1;
        }

        public function get groupId():int
        {
            return (_groupId);
        }

        public function set ownerId(_arg_1:int):void
        {
            _ownerId = _arg_1;
        }

        public function get ownerId():int
        {
            return (_ownerId);
        }

        public function set ownerName(_arg_1:String):void
        {
            _ownerName = _arg_1;
        }

        public function get ownerName():String
        {
            return (_ownerName);
        }

        public function set usagePolicy(_arg_1:int):void
        {
            _usagePolicy = _arg_1;
        }

        public function get usagePolicy():int
        {
            return (_usagePolicy);
        }

        public function set rentOfferId(_arg_1:int):void
        {
            _rentOfferId = _arg_1;
        }

        public function get rentOfferId():int
        {
            return (_rentOfferId);
        }

        public function get purchaseCouldBeUsedForBuyout():Boolean
        {
            return (_purchaseCouldBeUsedForBuyout);
        }

        public function set purchaseCouldBeUsedForBuyout(_arg_1:Boolean):void
        {
            _purchaseCouldBeUsedForBuyout = _arg_1;
        }

        public function get rentCouldBeUsedForBuyout():Boolean
        {
            return (_rentCouldBeUsedForBuyout);
        }

        public function set rentCouldBeUsedForBuyout(_arg_1:Boolean):void
        {
            _rentCouldBeUsedForBuyout = _arg_1;
        }

        public function get availableForBuildersClub():Boolean
        {
            return (_availableForBuildersClub);
        }

        public function set availableForBuildersClub(_arg_1:Boolean):void
        {
            _availableForBuildersClub = _arg_1;
        }


    }
}

