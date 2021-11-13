package com.sulake.habbo.notifications.utils
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.room._SafeStr_147;
    import flash.display.BitmapData;
    import com.sulake.core.runtime.Component;

    public class ProductImageUtility implements IGetImageListener 
    {

        private var _roomEngine:IRoomEngine;
        private var _inventory:IHabboInventory;

        public function ProductImageUtility(_arg_1:IRoomEngine, _arg_2:IHabboInventory)
        {
            _roomEngine = _arg_1;
            _inventory = _arg_2;
        }

        public function dispose():void
        {
            _roomEngine = null;
            _inventory = null;
        }

        public function getProductImage(_arg_1:String, _arg_2:int, _arg_3:String):BitmapData
        {
            var _local_7:BitmapDataAsset;
            var _local_4:_SafeStr_147;
            var _local_6:BitmapData;
            var _local_5:int;
            switch (_arg_1)
            {
                case "s":
                    _local_4 = _roomEngine.getFurnitureIcon(_arg_2, this);
                    break;
                case "i":
                    _local_5 = tempCategoryMapping("I", _arg_2);
                    if (_local_5 == 1)
                    {
                        _local_4 = _roomEngine.getWallItemIcon(_arg_2, this, _arg_3);
                    }
                    else
                    {
                        switch (_local_5)
                        {
                            case 2:
                                _local_7 = ((_inventory as Component).assets.getAssetByName("icon_wallpaper_png") as BitmapDataAsset);
                                if (_local_7 != null)
                                {
                                    _local_6 = (_local_7.content as BitmapData).clone();
                                };
                                break;
                            case 4:
                                _local_7 = ((_inventory as Component).assets.getAssetByName("icon_landscape_png") as BitmapDataAsset);
                                if (_local_7 != null)
                                {
                                    _local_6 = (_local_7.content as BitmapData).clone();
                                };
                                break;
                            case 3:
                                _local_7 = ((_inventory as Component).assets.getAssetByName("icon_floor_png") as BitmapDataAsset);
                                if (_local_7 != null)
                                {
                                    _local_6 = (_local_7.content as BitmapData).clone();
                                };
                            default:
                        };
                        _local_4 = null;
                    };
                    break;
                case "e":
                    _local_7 = ((_inventory as Component).assets.getAssetByName((("fx_icon_" + _arg_2) + "_png")) as BitmapDataAsset);
                    if (_local_7 != null)
                    {
                        _local_6 = (_local_7.content as BitmapData).clone();
                    };
                    break;
                default:
                    Logger.log("[HabboNotifications] Can not yet handle this type of product: ");
            };
            if (_local_4 != null)
            {
                _local_6 = _local_4.data;
            };
            return (_local_6);
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
        }

        public function imageFailed(_arg_1:int):void
        {
        }

        private function tempCategoryMapping(_arg_1:String, _arg_2:int):int
        {
            if (_arg_1 == "S")
            {
                return (1);
            };
            if (_arg_1 == "I")
            {
                if (_arg_2 == 3001)
                {
                    return (2);
                };
                if (_arg_2 == 3002)
                {
                    return (3);
                };
                if (_arg_2 == 4057)
                {
                    return (4);
                };
                return (1);
            };
            return (1);
        }


    }
}

