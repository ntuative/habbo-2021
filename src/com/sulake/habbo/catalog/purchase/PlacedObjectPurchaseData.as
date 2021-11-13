package com.sulake.habbo.catalog.purchase
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.catalog.IPurchasableOffer;

    public class PlacedObjectPurchaseData implements IDisposable 
    {

        private var _disposed:Boolean = false;
        private var _objectId:int;
        private var _category:int;
        private var _roomId:int;
        private var _wallLocation:String = "";
        private var _x:int = 0;
        private var _y:int = 0;
        private var _direction:int = 0;
        private var _offerId:int;
        private var _productClassId:int;
        private var _SafeStr_1476:IProductData;
        private var _furniData:IFurnitureData;
        private var _extraParameter:String;

        public function PlacedObjectPurchaseData(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String, _arg_5:int, _arg_6:int, _arg_7:int, _arg_8:IPurchasableOffer)
        {
            _roomId = _arg_1;
            _objectId = _arg_2;
            _category = _arg_3;
            _wallLocation = _arg_4;
            _x = _arg_5;
            _y = _arg_6;
            _direction = _arg_7;
            setOfferData(_arg_8);
        }

        public function dispose():void
        {
            _disposed = true;
            _SafeStr_1476 = null;
            _furniData = null;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        private function setOfferData(_arg_1:IPurchasableOffer):void
        {
            _offerId = _arg_1.offerId;
            _productClassId = _arg_1.product.productClassId;
            _SafeStr_1476 = _arg_1.product.productData;
            _furniData = _arg_1.product.furnitureData;
            _extraParameter = _arg_1.product.extraParam;
        }

        public function toString():String
        {
            return ([_roomId, _objectId, _category, _wallLocation, _x, _y, _direction, _offerId, _productClassId].toString());
        }

        public function get objectId():int
        {
            return (_objectId);
        }

        public function get category():int
        {
            return (_category);
        }

        public function get roomId():int
        {
            return (_roomId);
        }

        public function get wallLocation():String
        {
            return (_wallLocation);
        }

        public function get x():int
        {
            return (_x);
        }

        public function get y():int
        {
            return (_y);
        }

        public function get direction():int
        {
            return (_direction);
        }

        public function get offerId():int
        {
            return (_offerId);
        }

        public function get productClassId():int
        {
            return (_productClassId);
        }

        public function get extraParameter():String
        {
            return (_extraParameter);
        }

        public function get furniData():IFurnitureData
        {
            return (_furniData);
        }


    }
}

