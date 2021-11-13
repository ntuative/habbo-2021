package com.sulake.habbo.ui.widget.infostand
{
    import flash.display.BitmapData;
    import com.sulake.habbo.room.IStuffData;
    import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;

    public class InfoStandFurniData 
    {

        private var _id:int = 0;
        private var _category:int = 0;
        private var _name:String = "";
        private var _description:String = "";
        private var _image:BitmapData;
        private var _purchaseOfferId:int = -1;
        private var _extraParam:String = "";
        private var _stuffData:IStuffData = null;
        private var _groupId:int;
        private var _ownerId:int = 0;
        private var _ownerName:String = "";
        private var _rentOfferId:int = -1;
        private var _availableForBuildersClub:Boolean = false;


        public function set id(_arg_1:int):void
        {
            _id = _arg_1;
        }

        public function set category(_arg_1:int):void
        {
            _category = _arg_1;
        }

        public function set name(_arg_1:String):void
        {
            _name = _arg_1;
        }

        public function set description(_arg_1:String):void
        {
            _description = _arg_1;
        }

        public function set image(_arg_1:BitmapData):void
        {
            _image = _arg_1;
        }

        public function set purchaseOfferId(_arg_1:int):void
        {
            _purchaseOfferId = _arg_1;
        }

        public function set extraParam(_arg_1:String):void
        {
            _extraParam = _arg_1;
        }

        public function set stuffData(_arg_1:IStuffData):void
        {
            _stuffData = _arg_1;
        }

        public function set groupId(_arg_1:int):void
        {
            _groupId = _arg_1;
        }

        public function set ownerId(_arg_1:int):void
        {
            _ownerId = _arg_1;
        }

        public function set ownerName(_arg_1:String):void
        {
            _ownerName = _arg_1;
        }

        public function get id():int
        {
            return (_id);
        }

        public function get category():int
        {
            return (_category);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get description():String
        {
            return (_description);
        }

        public function get image():BitmapData
        {
            return (_image);
        }

        public function get purchaseOfferId():int
        {
            return (_purchaseOfferId);
        }

        public function get extraParam():String
        {
            return (_extraParam);
        }

        public function get stuffData():IStuffData
        {
            return (_stuffData);
        }

        public function get groupId():int
        {
            return (_groupId);
        }

        public function get ownerId():int
        {
            return (_ownerId);
        }

        public function get ownerName():String
        {
            return (_ownerName);
        }

        public function get rentOfferId():int
        {
            return (_rentOfferId);
        }

        public function set rentOfferId(_arg_1:int):void
        {
            _rentOfferId = _arg_1;
        }

        public function get availableForBuildersClub():Boolean
        {
            return (_availableForBuildersClub);
        }

        public function setData(_arg_1:RoomWidgetFurniInfoUpdateEvent):void
        {
            id = _arg_1.id;
            category = _arg_1.category;
            name = _arg_1.name;
            description = _arg_1.description;
            image = _arg_1.image;
            purchaseOfferId = _arg_1.purchaseOfferId;
            extraParam = _arg_1.extraParam;
            stuffData = _arg_1.stuffData;
            groupId = _arg_1.groupId;
            ownerName = _arg_1.ownerName;
            ownerId = _arg_1.ownerId;
            rentOfferId = _arg_1.rentOfferId;
            _availableForBuildersClub = _arg_1.availableForBuildersClub;
        }


    }
}