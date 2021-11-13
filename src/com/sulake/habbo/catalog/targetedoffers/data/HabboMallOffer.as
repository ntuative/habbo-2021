package com.sulake.habbo.catalog.targetedoffers.data
{
    public class HabboMallOffer 
    {

        private var _targetedOfferId:int;
        private var _identifier:String;
        private var _title:String;
        private var _highlight:String;
        private var _description:String;
        private var _imageUrl:String;
        private var _smallImageUrl:String;
        private var _trackingState:int;

        public function HabboMallOffer(_arg_1:Object)
        {
            _targetedOfferId = parseInt(_arg_1.targetedOfferId);
            _identifier = _arg_1.identifier;
            _title = _arg_1.header;
            _highlight = _arg_1.highlight;
            _description = _arg_1.description;
            _imageUrl = _arg_1.imageUrl;
            _smallImageUrl = _arg_1.smallImageUrl;
            _trackingState = parseInt(_arg_1.trackingStateCode);
        }

        public function get targetedOfferId():int
        {
            return (_targetedOfferId);
        }

        public function get identifier():String
        {
            return (_identifier);
        }

        public function get title():String
        {
            return (_title);
        }

        public function get highlight():String
        {
            return (_highlight);
        }

        public function get description():String
        {
            return (_description);
        }

        public function get imageUrl():String
        {
            return (_imageUrl);
        }

        public function get smallImageUrl():String
        {
            return (_smallImageUrl);
        }

        public function get trackingState():int
        {
            return (_trackingState);
        }


    }
}