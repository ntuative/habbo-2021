package com.sulake.habbo.communication.messages.incoming.catalog
{
    import __AS3__.vec.Vector;
    import flash.utils.getTimer;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class TargetedOfferData 
    {

        protected var _SafeStr_698:int;
        protected var _SafeStr_1715:String;
        protected var _SafeStr_741:int;
        protected var _SafeStr_906:String;
        protected var _description:String;
        protected var _SafeStr_1716:String;
        protected var _SafeStr_1717:String;
        protected var _SafeStr_1718:String;
        protected var _SafeStr_1719:int;
        protected var _expirationTime:uint;
        protected var _SafeStr_1500:int;
        protected var _SafeStr_1502:int;
        protected var _SafeStr_1501:int;
        protected var _SafeStr_1503:Vector.<String>;
        protected var _SafeStr_1720:int;

        public function TargetedOfferData(_arg_1:TargetedOfferData=null)
        {
            if (_arg_1 != null)
            {
                _SafeStr_698 = _arg_1.id;
                _SafeStr_1715 = _arg_1.identifier;
                _SafeStr_741 = _arg_1.type;
                _SafeStr_906 = _arg_1.title;
                _description = _arg_1.description;
                _SafeStr_1716 = _arg_1.imageUrl;
                _SafeStr_1717 = _arg_1.iconImageUrl;
                _SafeStr_1718 = _arg_1.productCode;
                _SafeStr_1719 = _arg_1.purchaseLimit;
                _expirationTime = _arg_1.expirationTime;
                _SafeStr_1500 = _arg_1.priceInCredits;
                _SafeStr_1502 = _arg_1.priceInActivityPoints;
                _SafeStr_1501 = _arg_1.activityPointType;
                _SafeStr_1503 = _arg_1.subProductCodes;
                _SafeStr_1720 = _arg_1.trackingState;
            };
        }

        public function parse(_arg_1:IMessageDataWrapper):TargetedOfferData
        {
            var _local_3:int;
            _SafeStr_1720 = _arg_1.readInteger();
            _SafeStr_698 = _arg_1.readInteger();
            _SafeStr_1715 = _arg_1.readString();
            _SafeStr_1718 = _arg_1.readString();
            _SafeStr_1500 = _arg_1.readInteger();
            _SafeStr_1502 = _arg_1.readInteger();
            _SafeStr_1501 = _arg_1.readInteger();
            _SafeStr_1719 = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            _expirationTime = ((_local_2 > 0) ? ((_local_2 * 1000) + getTimer()) : 0);
            _SafeStr_906 = _arg_1.readString();
            _description = _arg_1.readString();
            _SafeStr_1716 = _arg_1.readString();
            _SafeStr_1717 = _arg_1.readString();
            _SafeStr_741 = _arg_1.readInteger();
            _SafeStr_1503 = new Vector.<String>(0);
            var _local_4:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_4)
            {
                _SafeStr_1503.push(_arg_1.readString());
                _local_3++;
            };
            return (this);
        }

        public function purchased(_arg_1:int):void
        {
            _SafeStr_1719 = (_SafeStr_1719 - _arg_1);
        }

        public function get id():int
        {
            return (_SafeStr_698);
        }

        public function get identifier():String
        {
            return (_SafeStr_1715);
        }

        public function get type():int
        {
            return (_SafeStr_741);
        }

        public function get title():String
        {
            return (_SafeStr_906);
        }

        public function get description():String
        {
            return (_description);
        }

        public function get imageUrl():String
        {
            return (_SafeStr_1716);
        }

        public function get iconImageUrl():String
        {
            return (_SafeStr_1717);
        }

        public function get productCode():String
        {
            return (_SafeStr_1718);
        }

        public function get purchaseLimit():int
        {
            return (_SafeStr_1719);
        }

        public function get expirationTime():int
        {
            return (_expirationTime);
        }

        public function get priceInCredits():int
        {
            return (_SafeStr_1500);
        }

        public function get priceInActivityPoints():int
        {
            return (_SafeStr_1502);
        }

        public function get activityPointType():int
        {
            return (_SafeStr_1501);
        }

        public function get subProductCodes():Vector.<String>
        {
            return (_SafeStr_1503);
        }

        public function get trackingState():int
        {
            return (_SafeStr_1720);
        }


    }
}

