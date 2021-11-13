package com.sulake.habbo.session.furniture
{
    public class FurnitureData implements IFurnitureData 
    {

        public static const _SafeStr_3694:String = "i";
        public static const _SafeStr_3695:String = "s";

        private var _type:String;
        private var _id:int;
        private var _className:String;
        private var _hasIndexedColor:Boolean;
        private var _colourIndex:int;
        private var _revision:int;
        private var _tileSizeX:int;
        private var _tileSizeY:int;
        private var _tileSizeZ:int;
        private var _colours:Array;
        private var _localizedName:String;
        private var _description:String;
        private var _adUrl:String;
        private var _purchaseOfferId:int;
        private var _rentOfferId:int;
        private var _customParams:String;
        private var _category:int;
        private var _purchaseCouldBeUsedForBuyout:Boolean;
        private var _rentCouldBeUsedForBuyout:Boolean;
        private var _availableForBuildersClub:Boolean;
        private var _fullName:String;
        private var _canStandOn:Boolean;
        private var _canSitOn:Boolean;
        private var _canLayOn:Boolean;
        private var _excludedFromDynamic:Boolean;
        private var _furniLine:String;

        public function FurnitureData(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:String, _arg_7:int, _arg_8:int, _arg_9:int, _arg_10:int, _arg_11:Array, _arg_12:Boolean, _arg_13:int, _arg_14:String, _arg_15:int, _arg_16:Boolean, _arg_17:int, _arg_18:Boolean, _arg_19:Boolean, _arg_20:String, _arg_21:int, _arg_22:Boolean, _arg_23:Boolean, _arg_24:Boolean, _arg_25:Boolean, _arg_26:String)
        {
            _type = _arg_1;
            _id = _arg_2;
            _fullName = _arg_3;
            _className = _arg_4;
            _revision = _arg_7;
            _tileSizeX = _arg_8;
            _tileSizeY = _arg_9;
            _tileSizeZ = _arg_10;
            _colours = _arg_11;
            _hasIndexedColor = _arg_12;
            _colourIndex = _arg_13;
            _localizedName = _arg_5;
            _description = _arg_6;
            _adUrl = _arg_14;
            _purchaseOfferId = _arg_15;
            _purchaseCouldBeUsedForBuyout = _arg_16;
            _rentOfferId = _arg_17;
            _rentCouldBeUsedForBuyout = _arg_18;
            _customParams = _arg_20;
            _category = _arg_21;
            _availableForBuildersClub = _arg_19;
            _canStandOn = _arg_22;
            _canSitOn = _arg_23;
            _canLayOn = _arg_24;
            _excludedFromDynamic = _arg_25;
            _furniLine = _arg_26;
        }

        public function get type():String
        {
            return (_type);
        }

        public function get id():int
        {
            return (_id);
        }

        public function get className():String
        {
            return (_className);
        }

        public function get fullName():String
        {
            return (_fullName);
        }

        public function get hasIndexedColor():Boolean
        {
            return (_hasIndexedColor);
        }

        public function get colourIndex():int
        {
            return (_colourIndex);
        }

        public function get revision():int
        {
            return (_revision);
        }

        public function get tileSizeX():int
        {
            return (_tileSizeX);
        }

        public function get tileSizeY():int
        {
            return (_tileSizeY);
        }

        public function get tileSizeZ():int
        {
            return (_tileSizeZ);
        }

        public function get colours():Array
        {
            return (_colours);
        }

        public function get localizedName():String
        {
            return (_localizedName);
        }

        public function get description():String
        {
            return (_description);
        }

        public function get adUrl():String
        {
            return (_adUrl);
        }

        public function get purchaseOfferId():int
        {
            return (_purchaseOfferId);
        }

        public function get customParams():String
        {
            return (_customParams);
        }

        public function get category():int
        {
            return (_category);
        }

        public function set className(_arg_1:String):void
        {
            _className = _arg_1;
        }

        public function get rentOfferId():int
        {
            return (_rentOfferId);
        }

        public function get purchaseCouldBeUsedForBuyout():Boolean
        {
            return (_purchaseCouldBeUsedForBuyout);
        }

        public function get rentCouldBeUsedForBuyout():Boolean
        {
            return (_rentCouldBeUsedForBuyout);
        }

        public function get availableForBuildersClub():Boolean
        {
            return (_availableForBuildersClub);
        }

        public function get canStandOn():Boolean
        {
            return (_canStandOn);
        }

        public function get canSitOn():Boolean
        {
            return (_canSitOn);
        }

        public function get canLayOn():Boolean
        {
            return (_canLayOn);
        }

        public function get isExternalImageType():Boolean
        {
            return (!(_className.indexOf("external_image") == -1));
        }

        public function get excludedFromDynamic():Boolean
        {
            return (_excludedFromDynamic);
        }

        public function get furniLine():String
        {
            return (_furniLine);
        }


    }
}

