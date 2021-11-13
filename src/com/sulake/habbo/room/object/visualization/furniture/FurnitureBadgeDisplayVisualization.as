package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import com.sulake.room.object.visualization.IRoomObjectSprite;

    public class FurnitureBadgeDisplayVisualization extends AnimatedFurnitureVisualization 
    {

        private static const BADGE_SPRITE_TAG:String = "BADGE";

        private var _SafeStr_3296:String = "";
        private var _SafeStr_3297:String = "";
        private var _SafeStr_3298:int = -1;


        override protected function updateModel(_arg_1:Number):Boolean
        {
            var _local_2:Boolean;
            var _local_3:Boolean = super.updateModel(_arg_1);
            if (!isNaN(object.getModel().getNumber("furniture_badge_image_status")))
            {
                _local_2 = (!(object.getModel().getNumber("furniture_badge_image_status") == 0));
                if (((_local_2) && (_SafeStr_3296 == "")))
                {
                    _SafeStr_3296 = object.getModel().getString("furniture_badge_asset_name");
                    if (_SafeStr_3297 == "")
                    {
                        _SafeStr_3297 = (_SafeStr_3296 + "_32");
                    };
                    if (object.getModel().hasNumber("furniture_badge_visible_in_state"))
                    {
                        _SafeStr_3298 = object.getModel().getNumber("furniture_badge_visible_in_state");
                    };
                    _local_3 = true;
                };
            };
            return (_local_3);
        }

        override protected function getSpriteAssetName(_arg_1:int, _arg_2:int):String
        {
            var _local_3:String = getSpriteTag(_arg_1, direction, _arg_2);
            if (((!(_local_3 == "BADGE")) || ((!(_SafeStr_3298 == -1)) && (!(object.getState(0) == _SafeStr_3298)))))
            {
                return (super.getSpriteAssetName(_arg_1, _arg_2));
            };
            if (_arg_1 == 32)
            {
                return (_SafeStr_3297);
            };
            return (_SafeStr_3296);
        }

        override protected function getSpriteXOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_5:IGraphicAsset;
            var _local_4:int = super.getSpriteXOffset(_arg_1, _arg_2, _arg_3);
            if (getSpriteTag(_arg_1, _arg_2, _arg_3) == "BADGE")
            {
                _local_5 = getAsset(((_arg_1 == 32) ? _SafeStr_3297 : _SafeStr_3296), _arg_3);
                if (_arg_1 == 64)
                {
                    _local_4 = int((_local_4 + ((40 - _local_5.width) / 2)));
                }
                else
                {
                    _local_4 = int((_local_4 + ((20 - _local_5.width) / 2)));
                };
            };
            return (_local_4);
        }

        override protected function getSpriteYOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_5:IGraphicAsset;
            var _local_4:int = super.getSpriteYOffset(_arg_1, _arg_2, _arg_3);
            if (getSpriteTag(_arg_1, _arg_2, _arg_3) == "BADGE")
            {
                _local_5 = getAsset(((_arg_1 == 32) ? _SafeStr_3297 : _SafeStr_3296), _arg_3);
                if (_arg_1 == 64)
                {
                    _local_4 = int((_local_4 + ((40 - _local_5.height) / 2)));
                }
                else
                {
                    _local_4 = int((_local_4 + ((20 - _local_5.height) / 2)));
                };
            };
            return (_local_4);
        }

        override protected function getLibraryAssetNameForSprite(_arg_1:IGraphicAsset, _arg_2:IRoomObjectSprite):String
        {
            if (_arg_2.tag == "BADGE")
            {
                return (("%image.library.url%album1584/" + _arg_2.assetName.replace("badge_", "")) + ".png");
            };
            return (super.getLibraryAssetNameForSprite(_arg_1, _arg_2));
        }


    }
}

