package com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay
{
    public class ExtraInfoItemData 
    {

        public static const TYPE_PROMO:int = 0;
        public static const _SafeStr_1530:int = 1;
        public static const _SafeStr_1531:int = 2;
        public static const TYPE_BONUS_BADGE:int = 3;
        public static const _SafeStr_1532:int = 4;
        public static const TYPE_RESET_MESSAGE:int = 5;

        private var _type:int;
        private var _text:String;
        private var _quantity:int;
        private var _activityPointType:int;
        private var _discountPriceCredits:int;
        private var _discountPriceActivityPoints:int;
        private var _priceCredits:int;
        private var _priceActivityPoints:int;
        private var _badgeCode:String;
        private var _achievementCode:String;

        public function ExtraInfoItemData(_arg_1:int, _arg_2:String="")
        {
            _type = _arg_1;
            _text = _arg_2;
        }

        public function set text(_arg_1:String):void
        {
            _text = _arg_1;
        }

        public function set quantity(_arg_1:int):void
        {
            _quantity = _arg_1;
        }

        public function set activityPointType(_arg_1:int):void
        {
            _activityPointType = _arg_1;
        }

        public function set discountPriceCredits(_arg_1:int):void
        {
            _discountPriceCredits = _arg_1;
        }

        public function set discountPriceActivityPoints(_arg_1:int):void
        {
            _discountPriceActivityPoints = _arg_1;
        }

        public function set priceCredits(_arg_1:int):void
        {
            _priceCredits = _arg_1;
        }

        public function set priceActivityPoints(_arg_1:int):void
        {
            _priceActivityPoints = _arg_1;
        }

        public function set badgeCode(_arg_1:String):void
        {
            _badgeCode = _arg_1;
        }

        public function set achievementCode(_arg_1:String):void
        {
            _achievementCode = _arg_1;
        }

        public function get type():int
        {
            return (_type);
        }

        public function get text():String
        {
            return (_text);
        }

        public function get quantity():int
        {
            return (_quantity);
        }

        public function get priceCredits():int
        {
            return (_priceCredits);
        }

        public function get priceActivityPoints():int
        {
            return (_priceActivityPoints);
        }

        public function get activityPointType():int
        {
            return (_activityPointType);
        }

        public function get badgeCode():String
        {
            return (_badgeCode);
        }

        public function get achievementCode():String
        {
            return (_achievementCode);
        }

        public function get discountPriceCredits():int
        {
            return (_discountPriceCredits);
        }

        public function get discountPriceActivityPoints():int
        {
            return (_discountPriceActivityPoints);
        }


    }
}

