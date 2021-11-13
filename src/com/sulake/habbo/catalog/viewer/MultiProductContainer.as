package com.sulake.habbo.catalog.viewer
{
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.room.IStuffData;

    public class MultiProductContainer extends SingleProductContainer 
    {

        public function MultiProductContainer(_arg_1:IPurchasableOffer, _arg_2:Vector.<IProduct>, _arg_3:HabboCatalog)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        override public function initProductIcon(_arg_1:IRoomEngine, _arg_2:IStuffData=null):void
        {
            super.initProductIcon(_arg_1);
            var _local_3:IWindow = _SafeStr_570.findChildByName("multiContainer");
            if (_local_3)
            {
                _local_3.visible = true;
            };
            var _local_4:ITextWindow = (_SafeStr_570.findChildByName("multiCounter") as ITextWindow);
            if (_local_4)
            {
                _local_4.text = ("x" + firstProduct.productCount);
            };
            this.setClubIconLevel(offer.clubLevel);
        }


    }
}

