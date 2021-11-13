package com.sulake.habbo.communication.messages.incoming.catalog
{
    import flash.utils.getTimer;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FrontPageItem 
    {

        public static const _SafeStr_1712:int = 0;
        public static const _SafeStr_1713:int = 1;
        public static const _SafeStr_1714:int = 2;

        private var _type:int;
        private var _position:int;
        private var _itemName:String;
        private var _itemPromoImage:String;
        private var _cataloguePageLocation:String;
        private var _productCode:String;
        private var _productOfferID:int;
        private var _expirationTime:int;

        public function FrontPageItem(_arg_1:IMessageDataWrapper)
        {
            if (!_arg_1)
            {
                return;
            };
            _position = _arg_1.readInteger();
            _itemName = _arg_1.readString();
            _itemPromoImage = _arg_1.readString();
            _type = _arg_1.readInteger();
            switch (_type)
            {
                case 0:
                    _cataloguePageLocation = _arg_1.readString();
                    break;
                case 2:
                    _productCode = _arg_1.readString();
                    break;
                case 1:
                    _productOfferID = _arg_1.readInteger();
                default:
            };
            var _local_2:int = _arg_1.readInteger();
            _expirationTime = ((_local_2 > 0) ? ((_local_2 * 1000) + getTimer()) : 0);
        }

        public function get position():int
        {
            return (_position);
        }

        public function get itemName():String
        {
            return (_itemName);
        }

        public function get itemPromoImage():String
        {
            return (_itemPromoImage);
        }

        public function get cataloguePageLocation():String
        {
            return (_cataloguePageLocation);
        }

        public function get offerExpires():Boolean
        {
            return (_expirationTime > 0);
        }

        public function get secondsToExpiration():int
        {
            return (_expirationTime - getTimer());
        }

        public function get type():int
        {
            return (_type);
        }

        public function get productCode():String
        {
            return (_productCode);
        }

        public function get productOfferID():int
        {
            return (_productOfferID);
        }


    }
}

