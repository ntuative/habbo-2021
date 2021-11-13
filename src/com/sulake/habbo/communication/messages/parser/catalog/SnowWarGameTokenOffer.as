package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class SnowWarGameTokenOffer 
    {

        private var _offerId:int;
        private var _localizationId:String;
        private var _priceInCredits:int;
        private var _priceInActivityPoints:int;
        private var _activityPointType:int;
        private var _clubLevel:int;
        private var _giftable:Boolean;

        public function SnowWarGameTokenOffer(_arg_1:IMessageDataWrapper)
        {
            _offerId = _arg_1.readInteger();
            _localizationId = _arg_1.readString();
            _priceInCredits = _arg_1.readInteger();
            _priceInActivityPoints = _arg_1.readInteger();
            _activityPointType = _arg_1.readInteger();
            _giftable = false;
        }

        public function get offerId():int
        {
            return (_offerId);
        }

        public function get localizationId():String
        {
            return (_localizationId);
        }

        public function get priceInCredits():int
        {
            return (_priceInCredits);
        }

        public function get priceInActivityPoints():int
        {
            return (_priceInActivityPoints);
        }

        public function get activityPointType():int
        {
            return (_activityPointType);
        }

        public function get clubLevel():int
        {
            return (_clubLevel);
        }

        public function get giftable():Boolean
        {
            return (_giftable);
        }


    }
}