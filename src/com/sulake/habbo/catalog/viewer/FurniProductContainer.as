package com.sulake.habbo.catalog.viewer
{
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.room._SafeStr_147;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.room.IStuffData;

    public class FurniProductContainer extends ProductContainer 
    {

        private var _SafeStr_537:IFurnitureData;

        public function FurniProductContainer(_arg_1:IPurchasableOffer, _arg_2:Vector.<IProduct>, _arg_3:HabboCatalog, _arg_4:IFurnitureData)
        {
            super(_arg_1, _arg_2, _arg_3);
            _SafeStr_537 = _arg_4;
        }

        override public function initProductIcon(_arg_1:IRoomEngine, _arg_2:IStuffData=null):void
        {
            var _local_3:_SafeStr_147;
            switch (_SafeStr_537.type)
            {
                case "s":
                    _local_3 = catalog.roomEngine.getFurnitureIcon(_SafeStr_537.id, this);
                    break;
                case "i":
                    _local_3 = catalog.roomEngine.getWallItemIcon(_SafeStr_537.id, this);
            };
            if (_local_3)
            {
                setIconImage(_local_3.data, true);
            };
        }

        override public function activate():void
        {
            super.activate();
            if (((_SafeStr_537.rentOfferId > -1) && (!(catalog.catalogType == "BUILDERS_CLUB"))))
            {
                catalog.sendGetProductOffer(_SafeStr_537.rentOfferId);
            }
            else
            {
                catalog.sendGetProductOffer(_SafeStr_537.purchaseOfferId);
            };
        }

        override public function get isLazy():Boolean
        {
            return (true);
        }


    }
}

